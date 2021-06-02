using NUnit.Framework;
using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;

namespace SQL.Steps
{
    [Binding]
    public class CRUDSteps
    {
        private readonly SqlHelper _sqlHelper;
        private readonly ScenarioContext _scenarioContext;

        public CRUDSteps(ScenarioContext scenarioContext)
        {
            _scenarioContext = scenarioContext;
            _sqlHelper = new SqlHelper(Constants.dataBaseName);
        }

        [Given(@"data base is connected")]
        public void GivenDataBaseIsConnected()
        {
            _sqlHelper.OpenConnection();
        }

        [Given(@"product with parameters Name = (.*), Count = (.*), Id = (.*) exist in table")]
        public void GivenProductWithParametersNameCountIdExistInTable(string name, string count, string id)
        {
            _sqlHelper.Insert(Constants.tableName, new Dictionary<string, string> 
            { { Constants.name, name }, { Constants.count, count }, { Constants.id, id } });
        }


        [Given(@"table Products with parameters Id, Name, Count exist in data base")]
        public void GivenTableShopWithParametersIdNameCountExistInDataBase()
        {
            if (_sqlHelper.IsTableExistInDB() == false)
            {
                _sqlHelper.CreateTableInDB();
            }
        }

        [When(@"update parameters Name to (.*) and Count to (.*) where condition (.*) = (.*)")]
        public void GivenUpdateParametersNameToAppleAndCountToWhereConditionsNameTest(string name, string count, string conditionName, string condition)
        {
            _sqlHelper.Update(Constants.tableName, new Dictionary<string, string> { { Constants.name, name }, { Constants.count, count } }, 
                new Dictionary<string, string> { { conditionName, condition } });
        }

        [Then(@"succesfully updated table with data Name = (.*) and Count = (.*)")]
        public void ThenSuccesfullyUpdatedTableWithDataNameAndCount(string name, string count)
        {
            var res = _sqlHelper.IsRowExistedInTable(Constants.tableName, new Dictionary<string, string> 
            { { Constants.name, name }, { Constants.count, count } });

            Assert.True(res);
        }

        [When(@"add new product with Name (.*), Count (.*) and Id (.*)")]
        public void GivenAddNewProductWithNameCountAndId(string name, string count, string id)
        {
            _sqlHelper.Insert(Constants.tableName, new Dictionary<string, string>
            { { Constants.name, name }, { Constants.count, count }, { Constants.id, id } });
        }

        [Then(@"succesfully added new product with Name (.*), Count (.*) and Id (.*)")]
        public void ThenSuccesfullyAddedNewProductWithNameCountAndId(string name, string count, string id)
        {
            var res = _sqlHelper.IsRowExistedInTable(Constants.tableName, new Dictionary<string, string>
            { { Constants.name, name }, { Constants.count, count }, {Constants.id, id} });

            Assert.True(res);
        }

        [When(@"delete product with conditions Name = (.*), Count = (.*), Id = (.*)")]
        public void GivenDeleteProductWithConditionsNameCountId(string name, string count, string id)
        {
            try
            {
                _sqlHelper.DeleteProduct(Constants.tableName, new Dictionary<string, string>
            { { Constants.name, name }, { Constants.count, count }, { Constants.id, id } });
            }
            catch (Exception exception)
            {
                _scenarioContext.Add(Constants.exception, exception);
            }
        }

        [Then(@"succesfully deleted product with parameters Name = (.*), Count = (.*), Id = (.*) from table")]
        public void ThenSuccesfullyDeletedProductWithParametersNameCountIdFromTable(string name, string count, string id)
        {
            var result = _sqlHelper.IsRowExistedInTable(Constants.tableName, new Dictionary<string, string>
            { { Constants.name, name }, { Constants.count, count }, { Constants.id, id } });

            Assert.IsFalse(result);
        }

        [Then(@"exception message (.*) is displayed")]
        public void ThenExceptionMessageIsDisplayed(string exception)
        {
            Assert.AreEqual(exception, _scenarioContext.Get<Exception>(Constants.exception).Message.ToString());
        }
    }
}

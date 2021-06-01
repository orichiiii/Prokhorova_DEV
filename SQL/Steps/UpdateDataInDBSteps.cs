using NUnit.Framework;
using System.Collections.Generic;
using TechTalk.SpecFlow;

namespace SQL.Tests.Steps
{
    [Binding]
    public class UpdateDataInDBSteps
    {
        private readonly ScenarioContext _scenarioContext;
        private static SqlHelper _sqlHelper;

        public UpdateDataInDBSteps(ScenarioContext scenarioContext)
        {
            _scenarioContext = scenarioContext; ;
        }

        [BeforeScenario("update")]
        public void BeforeScenario()
        {
            _sqlHelper = new SqlHelper("Shop");
        }

        [Given(@"data base is connected")]
        public void GivenDataBaseIsConnected()
        {
            _sqlHelper.OpenConnection();
        }

        [Given(@"table Products with parameters Id, Name, Count exist in data base")]
        public void GivenTableShopWithParametersIdNameCountExistInDataBase()
        {
            ScenarioContext.Current.Pending();
        }

        [Given(@"update parameters Name to (.*) and Count to (.*) where condition (.*) = (.*)")]
        public void GivenUpdateParametersNameToAppleAndCountToWhereConditionsNameTest(string name, string count, string conditionName, string condition)
        {
            _sqlHelper.Update("Products", new Dictionary<string, string> { { "Name", name }, { "Count", count } }, new Dictionary<string, string> { { conditionName, condition } });
        }

        [Then(@"succesfully updated table with data Name = (.*) and Count = (.*)")]
        public void ThenSuccesfullyUpdatedTableWithDataNameAndCount(string name, string count, string conditionName, string condition)
        {
            var res = _sqlHelper.IsRowExistedInTable("Products", new Dictionary<string, string> { { "Name", name }, { "Count", count } });

            Assert.True(res);
        }

    }
}

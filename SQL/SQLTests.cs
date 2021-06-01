using System.Collections.Generic;
using NUnit.Framework;

namespace SQL.Tests
{
    public class Tests
    {
        private SqlHelper _sqlHelper;

        [SetUp]
        public void Setup()
        {
            _sqlHelper = new SqlHelper("Shop");
            _sqlHelper.OpenConnection();
        }

        [TearDown]
        public void TearDown()
        {
            _sqlHelper.ExecuteNonQuery("delete from [Shop].[dbo].[Products] where id = 23");
            _sqlHelper.CloseConnection();
        }

        [Test]
        public void AddProduct()
        {
            _sqlHelper.Insert("Products",
                new Dictionary<string, string> { { "Id", "23" }, { "Name", "'Test23'" }, { "Count", "234" } });
            var res = _sqlHelper.IsRowExistedInTable("Products",
                new Dictionary<string, string> { { "Id", "23" }, { "Name", "'Test23'" }, { "Count", "234" } });

            Assert.True(res);
        }

        [Test]
        public void UpdateData()
        {
            _sqlHelper.Insert("Products",
                new Dictionary<string, string> { { "Id", "23" }, { "Name", "'Test23'" }, { "Count", "234" } });
            _sqlHelper.Update("Products",
                new Dictionary<string, string> { { "Id", "30" }, { "Name", "'Apple'" }, { "Count", "2000" } }, new Dictionary<string, string> { { "Name", "'Test23'" } });
            var res = _sqlHelper.IsRowExistedInTable("Products",
                new Dictionary<string, string> { { "Id", "30" }, { "Name", "'Apple'" }, { "Count", "2000" } });

            Assert.True(res);
        }

        [Test]
        public void DeleteData()
        {
            _sqlHelper.Insert("Products",
                new Dictionary<string, string> { { "Id", "23" }, { "Name", "'Test23'" }, { "Count", "234" } });

            _sqlHelper.DeleteProduct("Products", new Dictionary<string, string> { { "Id", "23" }, { "Name", "'Test23'" }, { "Count", "234" } });

            var res = _sqlHelper.IsRowExistedInTable("Products",
                new Dictionary<string, string> { { "Id", "23" }, { "Name", "'Test23'" }, { "Count", "234" } });

            Assert.False(res);
        }
    }
}
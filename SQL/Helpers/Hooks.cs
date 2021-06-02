using TechTalk.SpecFlow;

namespace SQL
{
    [Binding]
    public class Hooks
    {
        public static SqlHelper _sqlHelper;

        public Hooks(SqlHelper sqlHelper)
        {
            _sqlHelper = sqlHelper;
            _sqlHelper = new SqlHelper(Constants.dataBaseName);
        }

        [AfterFeature("CreateUpdateDelete")]
        public static void AfterFeature()
        {
            _sqlHelper.ExecuteNonQuery($"delete from [{Constants.dataBaseName}].[dbo].[{Constants.tableName}]");
            _sqlHelper.CloseConnection();
        }
    }
}

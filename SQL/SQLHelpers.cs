using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SQL.Tests
{
    public class SqlHelper
    {
        private readonly SqlConnectionStringBuilder _sqlConnectionString;
        private SqlConnection _sqlConnection;

        public SqlHelper(string dbName)
        {
            _sqlConnectionString = new SqlConnectionStringBuilder
            {
                DataSource = "localhost",
                InitialCatalog = dbName,
                IntegratedSecurity = true
            };
        }

        public void OpenConnection()
        {
            _sqlConnection = new SqlConnection(_sqlConnectionString.ConnectionString);
            _sqlConnection.Open();
        }

        public void CloseConnection() => _sqlConnection.Close();

        public void ExecuteNonQuery(string request)
        {
            var command = new SqlCommand(request, _sqlConnection);
            command.ExecuteNonQuery();
        }

        public void Insert(string table, Dictionary<string, string> parameters)
        {
            var columns = string.Empty;
            var values = string.Empty;

            foreach (var (key, value) in parameters)
            {
                columns += $"{key},";
                values += $"{value},";
            }

            var command = new SqlCommand($"insert into {table} ({columns.TrimEnd(',')}) values ({values.TrimEnd(',')})",
                _sqlConnection);
            command.ExecuteNonQuery();
        }

        public bool IsRowExistedInTable(string table, Dictionary<string, string> parameters)
        {
            var whereParameters = string.Empty;

            foreach (var (key, value) in parameters)
                whereParameters += $"{key}={value} and ";

            var sqlDataAdapter = new SqlDataAdapter(
                $"select * from {table} where {whereParameters.Substring(0, whereParameters.Length - 4)}",
                _sqlConnection);
            var dataTable = new DataTable();
            sqlDataAdapter.Fill(dataTable);

            return dataTable.Rows.Count > 0;
        }

        public void Update(string table, Dictionary<string, string> parameters, Dictionary<string, string> conditions)
        {
            var parametersToDelete = $"update {table} set";

            foreach (var (key, value) in parameters)
                parametersToDelete += $" {key}={value},";


            var updateParameters = parametersToDelete.TrimEnd(',');
            updateParameters += " where";

            foreach (var (key, value) in conditions)
                updateParameters += $" {key}={value} and";

            var command = new SqlCommand(updateParameters.Substring(0, updateParameters.Length - 4),
                _sqlConnection);
            command.ExecuteNonQuery();
        }

        public void DeleteProduct(string table, Dictionary<string, string> parameters)
        {
            var parametersToDelete = $"delete from {table} where ";

            foreach (var (key, value) in parameters)
                parametersToDelete += $"{key}={value} and ";


            var command = new SqlCommand(parametersToDelete.Substring(0, parametersToDelete.Length - 5),
                _sqlConnection);
            command.ExecuteNonQuery();
        }
    }
}
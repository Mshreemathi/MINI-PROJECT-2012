using System;
using System.Data;
using System.Configuration;
using System.Data.OleDb;

namespace IPLProject
{
    public static class Db
    {
        public static OleDbConnection GetConnection()
        {
            var setting = ConfigurationManager.ConnectionStrings["IPLDb"];
            if (setting == null) throw new InvalidOperationException("Connection string 'IPLDb' not found.");
            return new OleDbConnection(setting.ConnectionString);
        }

        private static void AddParameters(OleDbCommand cmd, object[] values)
        {
            if (values == null) return;
            for (int i = 0; i < values.Length; i++)
            {
                cmd.Parameters.AddWithValue("?", values[i] ?? DBNull.Value);
            }
        }

        public static DataTable GetTable(string sql, params object[] values)
        {
            using (var con = GetConnection())
            using (var cmd = new OleDbCommand(sql, con))
            {
                AddParameters(cmd, values);
                using (var da = new OleDbDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public static object ExecuteScalar(string sql, params object[] values)
        {
            using (var con = GetConnection())
            using (var cmd = new OleDbCommand(sql, con))
            {
                AddParameters(cmd, values);
                con.Open();
                return cmd.ExecuteScalar();
            }
        }

        public static int ExecuteNonQuery(string sql, params object[] values)
        {
            using (var con = GetConnection())
            using (var cmd = new OleDbCommand(sql, con))
            {
                AddParameters(cmd, values);
                con.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }
}

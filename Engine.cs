using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static PokemonImport.Constant;

namespace PokemonImport
{
    internal class Engine
    {
        string SqlConString { get; set; }

        public Engine()
        {
            SqlConnectionStringBuilder sqlConStringBuilder = new SqlConnectionStringBuilder();
            sqlConStringBuilder["server"] = @"(localdb)\MSSQLLocalDB";
            sqlConStringBuilder["Trusted_Connection"] = true;
            sqlConStringBuilder["Integrated Security"] = "SSPI";
            sqlConStringBuilder["Initial Catalog"] = "PROG260FA22";

            SqlConString = sqlConStringBuilder.ToString();
        }

        /// <summary>
        /// Read all lines from csv - Run insert stored procedure on each line
        /// </summary>
        /// <param name="file"></param>
        /// <returns></returns>
        public List<Error> InsertPokemonData(MyFile file)
        {
            List<Error> errors = new List<Error>();
            List<string[]> lines = new List<string[]>();

            try
            {
                using (StreamReader sr = new StreamReader(file.FilePath))
                {
                    while (!sr.EndOfStream)
                    {
                        var lineItems = sr.ReadLine()?.Split(file.Delimiter) ?? new string[0];
                        lines.Add(lineItems);
                    }
                }

                using (SqlConnection con = new SqlConnection(SqlConString))
                {
                    con.Open();

                    string sproc = @"[dbo].[sp_InsertPokemon]";

                    foreach (var line in lines)
                    {
                        using (var cmd = new SqlCommand(sproc, con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Pokedex_Number", line[0]);
                            cmd.Parameters.AddWithValue("@Name", line[1]);
                            cmd.Parameters.AddWithValue("@Type1", line[2]);
                            cmd.Parameters.AddWithValue("@Type2", line[3]);
                            cmd.Parameters.AddWithValue("@HP", line[4]);
                            cmd.Parameters.AddWithValue("@Attack", line[5]);
                            cmd.Parameters.AddWithValue("@Defense", line[6]);
                            cmd.Parameters.AddWithValue("@SPATK", line[7]);
                            cmd.Parameters.AddWithValue("@SPDEF", line[8]);
                            cmd.Parameters.AddWithValue("@Speed", line[9]);
                            cmd.Parameters.AddWithValue("@Generation", line[10]);

                            cmd.ExecuteNonQuery();
                        }
                    }

                    con.Close();
                }

            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source ?? "Unknown"));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source ?? "Unknown"));
            }

            return errors;
        }

    }
}

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace TranslationsUtility
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool UpdateTranslations(TranslationObject data)
        {
            var count = 0;
            SqlTransaction tran;


            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["TransDB"].ConnectionString;

            con.Open();

            tran = con.BeginTransaction();

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.Transaction = tran;

            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.CommandText = "test.sp_AddUpdateTranslations";

            cmd.Parameters.Add(new SqlParameter("metatag", data.MetaTag));
            cmd.Parameters.Add(new SqlParameter("description", data.Description));
            cmd.Parameters.Add(new SqlParameter("ar", data.AR));
            cmd.Parameters.Add(new SqlParameter("bg", data.BG));
            cmd.Parameters.Add(new SqlParameter("cs", data.CS));
            cmd.Parameters.Add(new SqlParameter("zhCN", data.ZHCN));
            cmd.Parameters.Add(new SqlParameter("zhTW", data.ZHTW));
            cmd.Parameters.Add(new SqlParameter("da", data.DA));
            cmd.Parameters.Add(new SqlParameter("de", data.DE));
            cmd.Parameters.Add(new SqlParameter("es", data.ES));
            cmd.Parameters.Add(new SqlParameter("en", data.EN));
            cmd.Parameters.Add(new SqlParameter("el", data.EL));
            cmd.Parameters.Add(new SqlParameter("fr", data.FR));
            cmd.Parameters.Add(new SqlParameter("hr", data.HR));
            cmd.Parameters.Add(new SqlParameter("it", data.IT));
            cmd.Parameters.Add(new SqlParameter("ja", data.JA));
            cmd.Parameters.Add(new SqlParameter("hu", data.HU));
            cmd.Parameters.Add(new SqlParameter("nl", data.NL));
            cmd.Parameters.Add(new SqlParameter("no", data.NO));
            cmd.Parameters.Add(new SqlParameter("pl", data.PL));
            cmd.Parameters.Add(new SqlParameter("pt", data.PT));
            cmd.Parameters.Add(new SqlParameter("ptBR", data.PTBR));
            cmd.Parameters.Add(new SqlParameter("ro", data.RO));
            cmd.Parameters.Add(new SqlParameter("ru", data.RU));
            cmd.Parameters.Add(new SqlParameter("sk", data.SK));
            cmd.Parameters.Add(new SqlParameter("sl", data.SL));
            cmd.Parameters.Add(new SqlParameter("fi", data.FI));
            cmd.Parameters.Add(new SqlParameter("sv", data.SV));
            cmd.Parameters.Add(new SqlParameter("tr", data.TR));

            try
            {
                count = cmd.ExecuteNonQuery();

                if (count > 0)
                {
                    tran.Commit();
                }
                else
                {
                    tran.Rollback();
                }
            }
            catch (Exception ex)
            {
                con.Close();
                tran.Rollback();
                throw ex;
            }
            finally
            {
                con.Close();
            }


            return count > 0 ? true : false;
        }
    }
}
using Syncfusion.XlsIO;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;

namespace TranslationsUtility
{
    public partial class ImportExport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class InputData
        {
            public string Type { get; set; }
            public string Lang { get; set; }
        }

        [WebMethod]
        public static byte[] Export(InputData data)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["TransDB"].ConnectionString;

            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "test.sp_GetTranslation";

            cmd.Parameters.Add("lang", SqlDbType.NVarChar, 10).Value = data.Lang.ToUpper();

            DataSet ds = new DataSet();
            SqlDataAdapter adpt = new SqlDataAdapter();
            adpt.SelectCommand = cmd;
            adpt.Fill(ds);


            var excelEngine = new ExcelEngine();
            var application = excelEngine.Excel;
            IWorkbook Workbook = application.Workbooks.Create(new[] { data.Lang });
            Workbook.Version = ExcelVersion.Excel2016;

            IWorksheet sheet = Workbook.Worksheets[0];
            sheet.ImportDataTable(ds.Tables[0], true, 1, 1);
            for (var i = 1; i <= sheet.Columns.Length; i++)
            {
                sheet.AutofitColumn(i);
            }

            using (var memorystream = new MemoryStream())
            {
                Workbook.SaveAs(memorystream, ExcelSaveType.SaveAsXLS);
                Workbook.Close();
                return memorystream.ToArray();
            }

        }


        [WebMethod(EnableSession = true)]
        public static void UploadAndSave(HttpPostedFileBase file)
        {
        }
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Lights
{
    public partial class Feed : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache); //Cache-Control : no-cache, Pragma : no-cache
            Response.Cache.SetExpires(DateTime.Now.AddDays(-1)); //Expires : date time
            Response.Cache.SetNoStore(); //Cache-Control :  no-store
            Response.Cache.SetProxyMaxAge(new TimeSpan(0, 0, 0)); //Cache-Control: s-maxage=0
            Response.Cache.SetValidUntilExpires(false);
            Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);//Cache-Control:  must-revalidate
                                                                            }

            protected void FormView1_ItemUpdated(object sender, EventArgs e)
        {
            Response.Clear();
             Response.ContentType = "text/xml";


            SqlConnection objConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Your Connection String"].ConnectionString);
            objConnection.Open();
            string sql = "SELECT [Setting] FROM [Lights] WHERE (ID = 1) FOR JSON PATH, WITHOUT_ARRAY_WRAPPER";
            SqlCommand objCommand = new SqlCommand(sql, objConnection);
            SqlDataReader objReader = objCommand.ExecuteReader();

            while (objReader.Read())
            {
                using (StreamWriter streamWriter = new StreamWriter(Server.MapPath("Lights.txt"), false))
                {
                    streamWriter.WriteLine(objReader.GetString(0));
                    streamWriter.Close();
                }

            }


            objReader.Close();
            objConnection.Close();
            Response.Redirect("Default.aspx");
        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {

        }

    }

}

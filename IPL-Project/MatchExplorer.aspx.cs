using System;

namespace IPLProject
{
    public partial class MatchExplorer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() == "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                gvMatches.DataSource = Db.GetTable("SELECT * FROM MatchDetails WHERE Status='Upcoming' ORDER BY MatchDate");
                gvMatches.DataBind();
            }
        }
    }
}

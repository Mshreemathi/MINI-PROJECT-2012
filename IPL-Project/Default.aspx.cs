using System;

namespace IPLProject
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
            {
                Response.Redirect("Match.aspx");
            }
            else if (Session["Role"] != null)
            {
                Response.Redirect("MatchExplorer.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}

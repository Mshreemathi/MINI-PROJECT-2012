using System;

namespace IPLProject
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                lblUser.Text = Session["FullName"] != null ? Session["FullName"].ToString() : Session["Username"].ToString();
                string role = Session["Role"] != null ? Session["Role"].ToString() : "User";
                lblRole.Text = role;
                
                bool isAdmin = (role == "Admin");
                pnlAdminTabs.Visible = isAdmin;
                pnlUserTabs.Visible = !isAdmin;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}

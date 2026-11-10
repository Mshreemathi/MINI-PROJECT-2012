using System;
using System.Data;

namespace IPLProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();

            DataTable dt = Db.GetTable("SELECT * FROM Users WHERE Username=? AND Password=?", user, pass);
            if (dt.Rows.Count > 0)
            {
                DataRow r = dt.Rows[0];
                Session["UserId"] = r["UserId"];
                Session["Username"] = r["Username"];
                Session["Role"] = r["Role"];
                Session["FullName"] = r["FullName"];

                if (r["Role"].ToString() == "Admin")
                {
                    Response.Redirect("Match.aspx");
                }
                else
                {
                    Response.Redirect("MatchExplorer.aspx");
                }
            }
            else
            {
                lblMsg.Text = "Invalid Username or Password!";
            }
        }
    }
}

using System;
using System.Data;

namespace IPLProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string name = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string user = txtUsername.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            if (pass != confirmPass)
            {
                lblMsg.Text = "Passwords do not match!";
                return;
            }

            DataTable dt = Db.GetTable("SELECT * FROM Users WHERE Username=?", user);
            if (dt.Rows.Count > 0)
            {
                lblMsg.Text = "Username already exists. Please choose another.";
                return;
            }

            Db.ExecuteNonQuery("INSERT INTO Users (Username, Password, Role, FullName, Email, Phone) VALUES (?, ?, 'User', ?, ?, ?)", user, pass, name, email, phone);
            Response.Redirect("Login.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}

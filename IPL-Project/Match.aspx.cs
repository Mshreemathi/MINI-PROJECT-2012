using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class MatchPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin") 
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack) BindGrid();
        }

        void BindGrid()
        {
            gvMatches.DataSource = Db.GetTable("SELECT * FROM MatchDetails ORDER BY MatchId DESC");
            gvMatches.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Parse and format datetime to prevent conversion errors with SQL Server
            DateTime parsedDate;
            if (!DateTime.TryParse(txtDate.Text, out parsedDate))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please enter a valid date and time.";
                return;
            }
            string formattedDate = parsedDate.ToString("yyyy-MM-dd HH:mm:ss");

            if (string.IsNullOrEmpty(hfMatchId.Value))
            {
                Db.ExecuteNonQuery("INSERT INTO MatchDetails (MatchName, TeamA, TeamB, Venue, MatchDate) VALUES (?, ?, ?, ?, ?)",
                    txtMatchName.Text.Trim(), txtTeamA.Text.Trim(), txtTeamB.Text.Trim(), txtVenue.Text.Trim(), formattedDate);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Match added successfully!";
            }
            else
            {
                Db.ExecuteNonQuery("UPDATE MatchDetails SET MatchName=?, TeamA=?, TeamB=?, Venue=?, MatchDate=? WHERE MatchId=?",
                    txtMatchName.Text.Trim(), txtTeamA.Text.Trim(), txtTeamB.Text.Trim(), txtVenue.Text.Trim(), formattedDate, hfMatchId.Value);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Match updated successfully!";
            }
            ClearForm();
            BindGrid();
        }

        protected void gvMatches_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditMatch")
            {
                DataTable dt = Db.GetTable("SELECT * FROM MatchDetails WHERE MatchId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfMatchId.Value = r["MatchId"].ToString();
                    txtMatchName.Text = r["MatchName"].ToString();
                    txtTeamA.Text = r["TeamA"].ToString();
                    txtTeamB.Text = r["TeamB"].ToString();
                    txtVenue.Text = r["Venue"].ToString();
                    txtDate.Text = Convert.ToDateTime(r["MatchDate"]).ToString("yyyy-MM-ddTHH:mm");
                }
            }
            else if (e.CommandName == "DeleteMatch")
            {
                Db.ExecuteNonQuery("DELETE FROM MatchDetails WHERE MatchId=?", id);
                lblMsg.Text = "Match deleted.";
                BindGrid();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        void ClearForm()
        {
            hfMatchId.Value = "";
            txtMatchName.Text = "";
            txtTeamA.Text = "";
            txtTeamB.Text = "";
            txtVenue.Text = "";
            txtDate.Text = "";
        }
    }
}

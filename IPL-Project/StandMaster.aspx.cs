using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class StandMasterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                BindMatches();
                BindGrid();
            }
        }

        void BindMatches()
        {
            ddlMatch.DataSource = Db.GetTable("SELECT MatchId, MatchName FROM MatchDetails");
            ddlMatch.DataTextField = "MatchName";
            ddlMatch.DataValueField = "MatchId";
            ddlMatch.DataBind();
            ddlMatch.Items.Insert(0, new ListItem("-- Select Match --", ""));
        }

        void BindGrid()
        {
            string sql = "SELECT s.StandId, m.MatchName, s.StandName, s.Price, s.TotalSeats FROM StandDetails s INNER JOIN MatchDetails m ON s.MatchId=m.MatchId ORDER BY s.StandId DESC";
            gvStands.DataSource = Db.GetTable(sql);
            gvStands.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (string.IsNullOrEmpty(hfStandId.Value))
            {
                Db.ExecuteNonQuery("INSERT INTO StandDetails (MatchId, StandName, Price, TotalSeats) VALUES (?, ?, ?, ?)",
                    ddlMatch.SelectedValue, txtStandName.Text.Trim(), txtPrice.Text.Trim(), txtSeats.Text.Trim());
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Stand added successfully!";
            }
            else
            {
                Db.ExecuteNonQuery("UPDATE StandDetails SET MatchId=?, StandName=?, Price=?, TotalSeats=? WHERE StandId=?",
                    ddlMatch.SelectedValue, txtStandName.Text.Trim(), txtPrice.Text.Trim(), txtSeats.Text.Trim(), hfStandId.Value);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Stand updated successfully!";
            }
            ClearForm();
            BindGrid();
        }

        protected void gvStands_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditStand")
            {
                DataTable dt = Db.GetTable("SELECT * FROM StandDetails WHERE StandId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfStandId.Value = r["StandId"].ToString();
                    ddlMatch.SelectedValue = r["MatchId"].ToString();
                    txtStandName.Text = r["StandName"].ToString();
                    txtStandNo.Text = "ST-" + r["StandId"].ToString();
                    txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString("0.00");
                    txtSeats.Text = r["TotalSeats"].ToString();
                }
            }
            else if (e.CommandName == "DeleteStand")
            {
                Db.ExecuteNonQuery("DELETE FROM StandDetails WHERE StandId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Stand deleted successfully.";
                BindGrid();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        void ClearForm()
        {
            hfStandId.Value = "";
            ddlMatch.SelectedIndex = 0;
            txtStandName.Text = "";
            txtStandNo.Text = "";
            txtPrice.Text = "";
            txtSeats.Text = "";
        }
    }
}
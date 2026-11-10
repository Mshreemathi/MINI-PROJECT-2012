using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class PriceMasterPage : System.Web.UI.Page
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
                BindStandsDropdown();
                BindGrid();
            }
        }

        void BindStandsDropdown()
        {
            ddlStand.DataSource = Db.GetTable("SELECT s.StandId, (m.MatchName + ' - ' + s.StandName + ' (Rs ' + CAST(s.Price AS VARCHAR) + ')') AS StandText FROM StandDetails s INNER JOIN MatchDetails m ON s.MatchId=m.MatchId");
            ddlStand.DataTextField = "StandText";
            ddlStand.DataValueField = "StandId";
            ddlStand.DataBind();
            ddlStand.Items.Insert(0, new ListItem("-- Select Stand --", ""));
        }

        void BindGrid()
        {
            string sql = "SELECT s.StandId, m.MatchName, s.StandName, s.Price, s.TotalSeats FROM StandDetails s INNER JOIN MatchDetails m ON s.MatchId=m.MatchId ORDER BY s.StandId DESC";
            gvStands.DataSource = Db.GetTable(sql);
            gvStands.DataBind();
        }

        protected void ddlStand_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStand.SelectedValue != "")
            {
                object p = Db.ExecuteScalar("SELECT Price FROM StandDetails WHERE StandId=?", ddlStand.SelectedValue);
                if (p != null) txtNewPrice.Text = p.ToString();
            }
            else
            {
                txtNewPrice.Text = "";
            }
        }

        protected void btnUpdatePrice_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (ddlStand.SelectedValue == "")
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please select a stand.";
                return;
            }

            decimal newPrice;
            if (!decimal.TryParse(txtNewPrice.Text, out newPrice))
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please enter a valid price.";
                return;
            }

            Db.ExecuteNonQuery("UPDATE StandDetails SET Price=? WHERE StandId=?", newPrice, ddlStand.SelectedValue);
            Db.ExecuteNonQuery("UPDATE SeatDetails SET Price=? WHERE StandId=?", newPrice, ddlStand.SelectedValue);

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Price updated successfully for the stand and its seats!";
            BindStandsDropdown();
            BindGrid();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ddlStand.SelectedIndex = 0;
            txtNewPrice.Text = "";
            lblMsg.Text = "";
        }
    }
}

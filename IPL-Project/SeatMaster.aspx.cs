using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class SeatMasterPage : System.Web.UI.Page
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
                BindStands();
                BindGrid();
            }
        }

        void BindStands()
        {
            ddlStand.DataSource = Db.GetTable("SELECT s.StandId, (m.MatchName + ' - ' + s.StandName) AS StandText FROM StandDetails s INNER JOIN MatchDetails m ON s.MatchId=m.MatchId");
            ddlStand.DataTextField = "StandText";
            ddlStand.DataValueField = "StandId";
            ddlStand.DataBind();
            ddlStand.Items.Insert(0, new ListItem("-- Select Stand --", ""));
        }

        void BindGrid()
        {
            string sql = "SELECT s.SeatId, st.StandName, s.RowLabel, s.SeatName, s.SeatNumber, s.IsHospitality, s.HospitalityFeatures, s.Price, CASE WHEN s.IsBooked=1 THEN 'Booked' ELSE 'Available' END AS Status FROM SeatDetails s INNER JOIN StandDetails st ON s.StandId=st.StandId ORDER BY s.SeatId DESC";
            gvSeats.DataSource = Db.GetTable(sql);
            gvSeats.DataBind();
        }

        protected void chkIsHospitality_CheckedChanged(object sender, EventArgs e)
        {
            bool isHosp = chkIsHospitality.Checked;
            pnlHospitalityDetails.Visible = isHosp;
            rfvHospitality.Enabled = isHosp;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            bool isHosp = chkIsHospitality.Checked;
            string features = isHosp ? txtHospitalityFeatures.Text.Trim() : null;

            if (string.IsNullOrEmpty(hfSeatId.Value))
            {
                Db.ExecuteNonQuery("INSERT INTO SeatDetails (StandId, RowLabel, SeatName, SeatNumber, IsHospitality, HospitalityFeatures, Price, IsBooked) VALUES (?, ?, ?, ?, ?, ?, ?, 0)",
                    ddlStand.SelectedValue, txtRow.Text.Trim(), txtSeatName.Text.Trim(), txtSeatNumber.Text.Trim(), isHosp ? 1 : 0, features, txtPrice.Text.Trim());
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Seat added successfully!";
            }
            else
            {
                Db.ExecuteNonQuery("UPDATE SeatDetails SET StandId=?, RowLabel=?, SeatName=?, SeatNumber=?, IsHospitality=?, HospitalityFeatures=?, Price=? WHERE SeatId=?",
                    ddlStand.SelectedValue, txtRow.Text.Trim(), txtSeatName.Text.Trim(), txtSeatNumber.Text.Trim(), isHosp ? 1 : 0, features, txtPrice.Text.Trim(), hfSeatId.Value);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Seat updated successfully!";
            }
            ClearForm();
            BindGrid();
        }

        protected void gvSeats_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditSeat")
            {
                DataTable dt = Db.GetTable("SELECT * FROM SeatDetails WHERE SeatId=?", id);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfSeatId.Value = r["SeatId"].ToString();
                    ddlStand.SelectedValue = r["StandId"].ToString();
                    txtRow.Text = r["RowLabel"] != DBNull.Value ? r["RowLabel"].ToString() : "";
                    txtSeatName.Text = r["SeatName"] != DBNull.Value ? r["SeatName"].ToString() : "";
                    txtSeatNumber.Text = r["SeatNumber"].ToString();
                    txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString("0.00");

                    bool isHosp = r["IsHospitality"] != DBNull.Value && Convert.ToBoolean(r["IsHospitality"]);
                    chkIsHospitality.Checked = isHosp;
                    pnlHospitalityDetails.Visible = isHosp;
                    rfvHospitality.Enabled = isHosp;
                    txtHospitalityFeatures.Text = r["HospitalityFeatures"] != DBNull.Value ? r["HospitalityFeatures"].ToString() : "";
                }
            }
            else if (e.CommandName == "DeleteSeat")
            {
                Db.ExecuteNonQuery("DELETE FROM SeatDetails WHERE SeatId=?", id);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Seat deleted successfully.";
                BindGrid();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        void ClearForm()
        {
            hfSeatId.Value = "";
            ddlStand.SelectedIndex = 0;
            txtRow.Text = "";
            txtSeatName.Text = "";
            txtSeatNumber.Text = "";
            txtPrice.Text = "";
            chkIsHospitality.Checked = false;
            pnlHospitalityDetails.Visible = false;
            rfvHospitality.Enabled = false;
            txtHospitalityFeatures.Text = "";
        }
    }
}
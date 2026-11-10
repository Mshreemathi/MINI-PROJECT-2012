using System;
using System.Data;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class BookingPage : System.Web.UI.Page
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
                BindMatches();
                if (Request.QueryString["MatchId"] != null)
                {
                    ddlMatch.SelectedValue = Request.QueryString["MatchId"];
                }
                BindStands();
                BindSeats();
                UpdatePricing();
            }
        }

        void BindMatches()
        {
            ddlMatch.DataSource = Db.GetTable("SELECT MatchId, MatchName FROM MatchDetails WHERE Status='Upcoming'");
            ddlMatch.DataTextField = "MatchName";
            ddlMatch.DataValueField = "MatchId";
            ddlMatch.DataBind();
            ddlMatch.Items.Insert(0, new ListItem("-- Select Match --", ""));
        }

        void BindStands()
        {
            ddlStand.Items.Clear();
            if (ddlMatch.SelectedValue != "")
            {
                DataTable dt = Db.GetTable("SELECT StandId, (StandName + ' - Base Rs ' + CAST(Price AS VARCHAR)) AS StandText FROM StandDetails WHERE MatchId=?", ddlMatch.SelectedValue);
                ddlStand.DataSource = dt;
                ddlStand.DataTextField = "StandText";
                ddlStand.DataValueField = "StandId";
                ddlStand.DataBind();
            }
            ddlStand.Items.Insert(0, new ListItem("-- Select Stand --", ""));
        }

        void BindSeats()
        {
            cblSeats.Items.Clear();
            if (ddlStand.SelectedValue != "")
            {
                DataTable dt = Db.GetTable("SELECT SeatId, SeatNumber, IsBooked, Price FROM SeatDetails WHERE StandId=?", ddlStand.SelectedValue);
                foreach (DataRow r in dt.Rows)
                {
                    bool isBooked = Convert.ToBoolean(r["IsBooked"]);
                    string text = r["SeatNumber"].ToString() + (isBooked ? " [BOOKED]" : "");
                    ListItem li = new ListItem(text, r["SeatId"].ToString());
                    
                    if (isBooked)
                    {
                        li.Enabled = false;
                    }
                    cblSeats.Items.Add(li);
                }
            }
        }

        void UpdatePricing()
        {
            string ticketType = ddlTicketType.SelectedValue;
            bool includeFood = chkFood.Checked;

            if (ticketType == "Premium" || ticketType == "Hospitality")
            {
                pnlFoodContainer.Visible = true;
            }
            else
            {
                pnlFoodContainer.Visible = false;
                chkFood.Checked = false;
                includeFood = false;
            }

            decimal ticketMultiplier = 1.0m;
            if (ticketType == "Premium") ticketMultiplier = 1.3m;
            else if (ticketType == "Hospitality") ticketMultiplier = 1.6m;

            decimal foodExtraPerSeat = (includeFood ? 500.0m : 0.0m);
            decimal totalBase = 0;
            int count = 0;

            foreach (ListItem li in cblSeats.Items)
            {
                if (li.Selected && li.Enabled)
                {
                    int seatId = Convert.ToInt32(li.Value);
                    object p = Db.ExecuteScalar("SELECT Price FROM SeatDetails WHERE SeatId=?", seatId);
                    if (p != null && p != DBNull.Value)
                    {
                        decimal baseSeatPrice = Convert.ToDecimal(p) * ticketMultiplier + foodExtraPerSeat;
                        totalBase += baseSeatPrice;
                        count++;
                    }
                }
            }

            decimal tax = totalBase * 0.18m;
            decimal totalPayable = totalBase + tax;

            lblCount.Text = count.ToString();
            lblAccruedPrice.Text = totalBase.ToString("N2");
            lblPrice.Text = totalPayable.ToString("N2");
        }

        protected void ddlMatch_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindStands();
            BindSeats();
            UpdatePricing();
        }

        protected void ddlStand_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSeats();
            UpdatePricing();
        }

        protected void ddlTicketType_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdatePricing();
        }

        protected void chkFood_CheckedChanged(object sender, EventArgs e)
        {
            UpdatePricing();
        }

        protected void cblSeats_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdatePricing();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (ddlMatch.SelectedValue == "" || ddlStand.SelectedValue == "")
            {
                lblMsg.Text = "Please select Match and Stand!";
                return;
            }

            decimal totalBase = 0;
            List<int> seatIds = new List<int>();

            string ticketType = ddlTicketType.SelectedValue;
            bool includeFood = chkFood.Checked;
            decimal ticketMultiplier = 1.0m;
            if (ticketType == "Premium") ticketMultiplier = 1.3m;
            else if (ticketType == "Hospitality") ticketMultiplier = 1.6m;
            decimal foodExtraPerSeat = (includeFood ? 500.0m : 0.0m);

            foreach (ListItem li in cblSeats.Items)
            {
                if (li.Selected && li.Enabled)
                {
                    int seatId = Convert.ToInt32(li.Value);
                    seatIds.Add(seatId);
                    object p = Db.ExecuteScalar("SELECT Price FROM SeatDetails WHERE SeatId=?", seatId);
                    if (p != null && p != DBNull.Value)
                    {
                        decimal seatPrice = Convert.ToDecimal(p) * ticketMultiplier + foodExtraPerSeat;
                        totalBase += seatPrice;
                    }
                }
            }

            if (seatIds.Count == 0)
            {
                lblMsg.Text = "Please select at least one available seat to proceed.";
                return;
            }

            Session["Booking_MatchId"] = ddlMatch.SelectedValue;
            Session["Booking_StandId"] = ddlStand.SelectedValue;
            Session["Booking_TicketType"] = ticketType;
            Session["Booking_IncludeFood"] = includeFood;
            Session["Booking_SeatIds"] = seatIds;
            Session["Booking_BasePrice"] = totalBase;

            Response.Redirect("Payment.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("MatchExplorer.aspx");
        }
    }
}

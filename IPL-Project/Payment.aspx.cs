using System;
using System.Collections.Generic;

namespace IPLProject
{
    public partial class PaymentPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() == "Admin" || Session["Booking_SeatIds"] == null)
            {
                Response.Redirect("Booking.aspx");
                return;
            }

            if (!IsPostBack)
            {
                decimal baseP = Convert.ToDecimal(Session["Booking_BasePrice"]);
                decimal tax = baseP * 0.18m;
                decimal total = baseP + tax;

                lblTicketType.Text = Session["Booking_TicketType"]?.ToString() ?? "Normal";
                lblFood.Text = (Convert.ToBoolean(Session["Booking_IncludeFood"]) ? "Yes" : "No");
                lblBase.Text = baseP.ToString("N2");
                lblTax.Text = tax.ToString("N2");
                lblTotal.Text = total.ToString("N2");
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                int matchId = Convert.ToInt32(Session["Booking_MatchId"]);
                int standId = Convert.ToInt32(Session["Booking_StandId"]);
                string ticketType = Session["Booking_TicketType"].ToString();
                bool includeFood = Convert.ToBoolean(Session["Booking_IncludeFood"]);
                List<int> seatIds = (List<int>)Session["Booking_SeatIds"];
                decimal totalBase = Convert.ToDecimal(Session["Booking_BasePrice"]);
                
                int count = seatIds.Count;
                if (count == 0)
                {
                    Response.Redirect("Booking.aspx");
                    return;
                }

                decimal basePerSeat = totalBase / count;
                decimal taxPerSeat = basePerSeat * 0.18m;
                decimal totalPerSeat = basePerSeat + taxPerSeat;

                foreach (int seatId in seatIds)
                {
                    Db.ExecuteNonQuery("UPDATE SeatDetails SET IsBooked=1 WHERE SeatId=?", seatId);

                    string sqlB = "INSERT INTO Booking (UserId, MatchId, StandId, SeatId, TicketType, IncludeFood, BasePrice, TaxAmount, TotalPrice, PaymentStatus, BookingStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Completed', 'Confirmed'); SELECT SCOPE_IDENTITY();";
                    object bIdObj = Db.ExecuteScalar(sqlB, userId, matchId, standId, seatId, ticketType, includeFood, basePerSeat, taxPerSeat, totalPerSeat);
                    int bookingId = Convert.ToInt32(bIdObj);

                    Db.ExecuteNonQuery("INSERT INTO Payment (BookingId, PaymentMode, TransactionRef, AmountPaid) VALUES (?, ?, ?, ?)", bookingId, ddlMode.SelectedValue, txtRef.Text.Trim(), totalPerSeat);
                }

                Session.Remove("Booking_SeatIds");
                Response.Redirect("MyBookings.aspx");
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Payment Processing Failed: " + ex.Message;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Booking.aspx");
        }
    }
}

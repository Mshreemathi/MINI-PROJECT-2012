using System;
using System.Data;
using System.Web.UI.WebControls;

namespace IPLProject
{
    public partial class MyBookingsPage : System.Web.UI.Page
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
                BindBookings();
            }
        }

        void BindBookings()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string sql = "SELECT b.BookingId, b.SeatId, m.MatchName, st.StandName, b.TicketType, s.SeatNumber, b.TotalPrice, b.BookingStatus FROM Booking b INNER JOIN MatchDetails m ON b.MatchId=m.MatchId INNER JOIN StandDetails st ON b.StandId=st.StandId INNER JOIN SeatDetails s ON b.SeatId=s.SeatId WHERE b.UserId=? AND b.BookingStatus != 'Cancelled' ORDER BY b.BookingId DESC";
            gvBookings.DataSource = Db.GetTable(sql, userId);
            gvBookings.DataBind();
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelBooking")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int bookingId = Convert.ToInt32(args[0]);
                int seatId = Convert.ToInt32(args[1]);

                Db.ExecuteNonQuery("UPDATE SeatDetails SET IsBooked=0 WHERE SeatId=?", seatId);
                Db.ExecuteNonQuery("UPDATE Booking SET BookingStatus='Cancelled' WHERE BookingId=?", bookingId);

                lblMsg.Text = "Booking #" + bookingId + " cancelled successfully. Seat is released back to inventory and removed from list.";
                BindBookings();
            }
        }
    }
}

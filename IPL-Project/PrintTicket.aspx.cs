using System;
using System.Data;

namespace IPLProject
{
    public partial class PrintTicketPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["BookingId"] != null)
            {
                string bId = Request.QueryString["BookingId"];
                string sql = "SELECT b.BookingId, u.FullName, m.MatchName, m.Venue, m.MatchDate, st.StandName, b.TicketType, b.IncludeFood, s.SeatNumber, b.TotalPrice FROM Booking b INNER JOIN Users u ON b.UserId=u.UserId INNER JOIN MatchDetails m ON b.MatchId=m.MatchId INNER JOIN StandDetails st ON b.StandId=st.StandId INNER JOIN SeatDetails s ON b.SeatId=s.SeatId WHERE b.BookingId=?";
                DataTable dt = Db.GetTable(sql, bId);
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    lblBookingId.Text = r["BookingId"].ToString();
                    lblName.Text = r["FullName"].ToString();
                    lblMatch.Text = r["MatchName"].ToString();
                    lblVenue.Text = r["Venue"].ToString();
                    lblDate.Text = Convert.ToDateTime(r["MatchDate"]).ToString("dd-MMM-yyyy hh:mm tt");
                    lblTicketType.Text = r["TicketType"].ToString();
                    lblStand.Text = r["StandName"].ToString();
                    lblSeat.Text = r["SeatNumber"].ToString();
                    lblFood.Text = Convert.ToBoolean(r["IncludeFood"]) ? "Included" : "Not Included";
                    lblTotal.Text = Convert.ToDecimal(r["TotalPrice"]).ToString("N2");

                    string qrData = "TICKET:" + r["BookingId"] + "|" + r["MatchName"] + "|" + r["SeatNumber"] + "|" + r["TicketType"];
                    imgQR.ImageUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + Server.UrlEncode(qrData);
                }
            }
        }
    }
}

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintTicket.aspx.cs" Inherits="IPLProject.PrintTicketPage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>IPL Match E-Ticket</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #EFF6FF; padding: 30px; }
        .ticket-box { background: white; border: 2px dashed #1E40AF; max-width: 600px; margin: 0 auto; padding: 25px; border-radius: 10px; }
        .header { text-align: center; border-bottom: 2px solid #1E40AF; padding-bottom: 10px; margin-bottom: 15px; }
        .details-table { width: 100%; font-size: 14px; line-height: 1.8; color: #1E3A8A; }
        .btn-ash { background-color: #6B7280; color: white; border: none; padding: 6px 14px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 12px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="ticket-box">
            <div class="header">
                <h2 style="color: #1E40AF; margin:0;">IPL OFFICIAL E-TICKET</h2>
                <p style="margin: 5px 0 0 0; color:#555;">Indian Premier League Season 2026</p>
            </div>
            
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <table class="details-table">
                    <tr><td><strong>Booking ID:</strong></td><td>#<asp:Label ID="lblBookingId" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Holder Name:</strong></td><td><asp:Label ID="lblName" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Match:</strong></td><td><asp:Label ID="lblMatch" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Venue / Location:</strong></td><td><asp:Label ID="lblVenue" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Date & Time:</strong></td><td><asp:Label ID="lblDate" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Ticket Type:</strong></td><td><asp:Label ID="lblTicketType" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Stand:</strong></td><td><asp:Label ID="lblStand" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Seat Number:</strong></td><td><asp:Label ID="lblSeat" runat="server" Font-Bold="true" Font-Size="16px"></asp:Label></td></tr>
                    <tr><td><strong>Food & Beverages:</strong></td><td><asp:Label ID="lblFood" runat="server"></asp:Label></td></tr>
                    <tr><td><strong>Total Amount Paid:</strong></td><td>Rs : <asp:Label ID="lblTotal" runat="server"></asp:Label></td></tr>
                </table>
                <div>
                    <asp:Image ID="imgQR" runat="server" Width="130" Height="130" style="border:1px solid #CCC; padding:4px;" />
                </div>
            </div>

            <div style="text-align: center; margin-top: 25px;">
                <button type="button" class="btn-ash" onclick="window.print()">Print Ticket</button>
            </div>
        </div>
    </form>
</body>
</html>

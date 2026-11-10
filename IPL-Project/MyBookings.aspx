<%@ Page Title="My Bookings" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="MyBookings.aspx.cs" Inherits="IPLProject.MyBookingsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="color: #1E40AF;">My Ticket Bookings</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
    
    <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvBookings_RowCommand" DataKeyNames="BookingId">
        <Columns>
            <asp:BoundField DataField="BookingId" HeaderText="Booking ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="StandName" HeaderText="Stand" />
            <asp:BoundField DataField="TicketType" HeaderText="Ticket Type" />
            <asp:BoundField DataField="SeatNumber" HeaderText="Seat No" />
            <asp:BoundField DataField="TotalPrice" HeaderText="Amount Paid (incl. Tax)" DataFormatString="Rs : {0:N2}" />
            <asp:BoundField DataField="BookingStatus" HeaderText="Status" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <a href='PrintTicket.aspx?BookingId=<%# Eval("BookingId") %>' target="_blank" class="btn-green" style="text-decoration:none; display:inline-block; margin-right:5px;">Download Ticket</a>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel Booking" CommandName="CancelBooking" CommandArgument='<%# Eval("BookingId") + "|" + Eval("SeatId") %>' CssClass="btn-red" OnClientClick="return confirm('Are you sure you want to cancel this booking?');" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

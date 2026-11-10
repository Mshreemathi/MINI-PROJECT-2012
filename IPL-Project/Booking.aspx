<%@ Page Title="Book Ticket" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="IPLProject.BookingPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 800px; margin: 0 auto; background: #FFFFFF; padding: 30px; border-radius: 12px; box-shadow: 0 6px 20px rgba(30,58,138,0.12); border: 1px solid #BFDBFE;">
        <h2 style="color: #1E40AF; margin-top: 0; border-bottom: 2px solid #DBEAFE; padding-bottom: 10px;">Book IPL Match Tickets</h2>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red" style="display:block; margin-bottom:10px;"></asp:Label>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Select Match 
                <asp:RequiredFieldValidator ID="rfvMatch" runat="server" ControlToValidate="ddlMatch" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
                <asp:DropDownList ID="ddlMatch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMatch_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Ticket Type</label>
                <asp:DropDownList ID="ddlTicketType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTicketType_SelectedIndexChanged">
                    <asp:ListItem Text="Normal" Value="Normal" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Premium" Value="Premium"></asp:ListItem>
                    <asp:ListItem Text="Hospitality" Value="Hospitality"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 10px;">
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Select Stand 
                <asp:RequiredFieldValidator ID="rfvStand" runat="server" ControlToValidate="ddlStand" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
                <asp:DropDownList ID="ddlStand" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStand_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div id="pnlFoodContainer" runat="server" style="display:flex; align-items:center; padding-top:25px;">
                <asp:CheckBox ID="chkFood" runat="server" Text="&nbsp; Include Food & Beverages (+Rs 500 per seat)" AutoPostBack="true" OnCheckedChanged="chkFood_CheckedChanged" style="font-weight:600; color:#1E40AF;" />
            </div>
        </div>

        <div style="margin-top: 15px;">
            <label style="font-weight:600; color:#1E3A8A;">Select Available Seats (Multiple selection allowed. Booked seats are disabled)</label>
            <div style="background: #F8FAFC; border: 1px solid #93C5FD; padding: 15px; border-radius: 6px; max-height: 180px; overflow-y: auto; margin-top: 5px;">
                <asp:CheckBoxList ID="cblSeats" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="cblSeats_SelectedIndexChanged" style="display:flex; flex-wrap:wrap; gap:15px;"></asp:CheckBoxList>
            </div>
        </div>

        <div style="margin: 20px 0; background: #EFF6FF; padding: 15px; border-radius: 8px; border: 1px solid #93C5FD; display: flex; justify-content: space-between; align-items: center;">
            <div>
                <span style="font-size: 14px; color: #1E3A8A;">Selected Seats Count: <strong><asp:Label ID="lblCount" runat="server" Text="0"></asp:Label></strong></span><br />
                <span style="font-size: 14px; color: #1E3A8A;">Accrued Price (Base + Ticket Surcharge + Food): <strong>Rs : <asp:Label ID="lblAccruedPrice" runat="server" Text="0.00"></asp:Label></strong></span>
            </div>
            <div>
                <span style="font-size: 16px; color: #1E40AF;"><strong>Total (incl. 18% GST): Rs : <asp:Label ID="lblPrice" runat="server" Text="0.00"></asp:Label></strong></span>
            </div>
        </div>

        <div style="display:flex; gap:10px; margin-top: 20px;">
            <asp:Button ID="btnAddToCart" runat="server" Text="Proceed to Payment" CssClass="btn-green" OnClick="btnAddToCart_Click" />
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" />
        </div>
    </div>
</asp:Content>

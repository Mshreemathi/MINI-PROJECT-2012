<%@ Page Title="Payment" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="IPLProject.PaymentPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width: 550px; margin: 0 auto; background: #FFFFFF; padding: 30px; border-radius: 12px; box-shadow: 0 6px 20px rgba(30,58,138,0.12); border: 1px solid #BFDBFE;">
        <h2 style="color: #1E40AF; margin-top: 0; border-bottom: 2px solid #DBEAFE; padding-bottom: 10px;">Payment & Order Summary</h2>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red" style="display:block; margin-bottom:10px;"></asp:Label>
        
        <div style="background: #F8FAFC; padding: 15px; border-radius: 8px; border: 1px solid #93C5FD; margin-bottom: 15px;">
            <p style="margin:5px 0;"><strong>Ticket Type:</strong> <asp:Label ID="lblTicketType" runat="server"></asp:Label></p>
            <p style="margin:5px 0;"><strong>Food & Beverages Included:</strong> <asp:Label ID="lblFood" runat="server"></asp:Label></p>
            <p style="margin:5px 0;"><strong>Total Base Price:</strong> Rs : <asp:Label ID="lblBase" runat="server"></asp:Label></p>
            <p style="margin:5px 0;"><strong>GST Tax (18%):</strong> Rs : <asp:Label ID="lblTax" runat="server"></asp:Label></p>
            <hr style="border:0; border-top:1px solid #BFDBFE; margin:10px 0;" />
            <p style="font-size:16px; margin:5px 0; color:#1E40AF;"><strong>Total Payable (incl. Tax):</strong> Rs : <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label></p>
        </div>
        
        <label style="font-weight:600; color:#1E3A8A;">Payment Mode</label>
        <asp:DropDownList ID="ddlMode" runat="server">
            <asp:ListItem Text="UPI / GPay / PhonePe" Value="UPI"></asp:ListItem>
            <asp:ListItem Text="Credit / Debit Card" Value="Card"></asp:ListItem>
            <asp:ListItem Text="Net Banking" Value="NetBanking"></asp:ListItem>
        </asp:DropDownList>
        
        <label style="font-weight:600; color:#1E3A8A;">Transaction / Card Ref Number 
        <asp:RequiredFieldValidator ID="rfvRef" runat="server" ControlToValidate="txtRef" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtRef" runat="server" placeholder="Enter Reference / Card Number"></asp:TextBox>
        
        <div style="display:flex; gap:10px; margin-top:20px;">
            <asp:Button ID="btnConfirm" runat="server" Text="Pay & Confirm Booking" CssClass="btn-green" OnClick="btnConfirm_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-red" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </div>
</asp:Content>

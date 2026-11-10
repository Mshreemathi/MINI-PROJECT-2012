<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="IPLProject.Register" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>IPL Ticket Booking - Register</title>
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #EFF6FF;">
    <form id="form1" runat="server">
        <div style="max-width: 450px; margin: 50px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(30,58,138,0.1);">
            <h2 style="text-align: center; color: #1E40AF; margin-top: 0;">User Registration</h2>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            
            <label>Full Name <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtFullName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name"></asp:TextBox>

            <label>Email <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email format" ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator></label>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email"></asp:TextBox>

            <label>Phone <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Enter 10 digit phone" ValidationExpression="^\d{10}$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator></label>
            <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter 10 digit phone number"></asp:TextBox>

            <label>Username <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUsername" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Choose a username"></asp:TextBox>
            
            <label>Password <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Choose a password"></asp:TextBox>

            <label>Confirm Password <asp:RequiredFieldValidator ID="rfvCPass" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvPass" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" Operator="Equal" Type="String" ErrorMessage="Passwords must match" ForeColor="Red" Display="Dynamic"></asp:CompareValidator></label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
            
            <div style="display:flex; gap:10px; margin-top:10px;">
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-green" OnClick="btnRegister_Click" Width="50%" />
                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn-ash" OnClick="btnBack_Click" CausesValidation="false" Width="50%" />
            </div>
        </div>
    </form>
</body>
</html>

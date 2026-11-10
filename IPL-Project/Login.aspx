<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IPLProject.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>IPL Ticket Booking - Login</title>
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #EFF6FF;">
    <form id="form1" runat="server">
        <div style="max-width: 400px; margin: 80px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(30,58,138,0.1);">
            <h2 style="text-align: center; color: #1E40AF; margin-top: 0;">IPL Web Application Portal</h2>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            
            <label>Username <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUsername" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username (admin / user1)"></asp:TextBox>
            
            <label>Password <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>
            
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-green" OnClick="btnLogin_Click" Width="100%" style="margin-top:10px;" />
            
            <div style="text-align:center; margin-top:15px;">
                <a href="Register.aspx" style="color: #1E40AF; text-decoration:none; font-weight:bold;">New user? Register here</a>
            </div>

            <div style="margin-top: 20px; font-size: 12px; color: #6B7280; border-top: 1px solid #BFDBFE; paddingTop: 10px;">
                <strong>Test Credentials:</strong><br />
                Admin: admin / admin123<br />
                User: user1 / user123
            </div>
        </div>
    </form>
</body>
</html>

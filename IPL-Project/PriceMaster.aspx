<%@ Page Title="Price Master" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="PriceMaster.aspx.cs" Inherits="IPLProject.PriceMasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="color: #1E40AF;">Admin - Price Master (Seat & Stand Pricing)</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
    
    <div style="background:#F8FAFC; padding:15px; border-radius:6px; margin-bottom:20px; border:1px solid #BFDBFE;">
        <h3>Update Stand & Associated Seat Prices</h3>
        <asp:HiddenField ID="hfStandId" runat="server" />
        <label>Select Stand 
        <asp:RequiredFieldValidator ID="rfvStand" runat="server" ControlToValidate="ddlStand" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:DropDownList ID="ddlStand" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStand_SelectedIndexChanged"></asp:DropDownList>
        
        <label>New Price (Rs) <asp:RequiredFieldValidator ID="rfvNewPrice" runat="server" ControlToValidate="txtNewPrice" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revNewPrice" runat="server" ControlToValidate="txtNewPrice" ErrorMessage="Enter valid number" ValidationExpression="^\d+(\.\d{1,2})?$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator></label>
        <asp:TextBox ID="txtNewPrice" runat="server" placeholder="e.g. 3000"></asp:TextBox>
        
        <div style="margin-top:10px;">
            <asp:Button ID="btnUpdatePrice" runat="server" Text="Update Price" CssClass="btn-green" OnClick="btnUpdatePrice_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-red" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvStands" runat="server" AutoGenerateColumns="False" CssClass="grid-table">
        <Columns>
            <asp:BoundField DataField="StandId" HeaderText="Stand ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="StandName" HeaderText="Stand Name" />
            <asp:BoundField DataField="Price" HeaderText="Current Price" DataFormatString="Rs : {0:N2}" />
            <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
        </Columns>
    </asp:GridView>
</asp:Content>

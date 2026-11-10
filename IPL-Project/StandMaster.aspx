<%@ Page Title="Stand Master" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="StandMaster.aspx.cs" Inherits="IPLProject.StandMasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="color: #1E40AF;">Admin - Stand Management</h2>
    <asp:Label ID="lblMsg" runat="server"></asp:Label>
    
    <div style="background:#F8FAFC; padding:20px; border-radius:6px; margin-bottom:20px; border:1px solid #BFDBFE;">
        <h3>Add / Edit Stand</h3>
        <asp:HiddenField ID="hfStandId" runat="server" />
        
        <label style="font-weight:600; color:#1E3A8A;">Select Match 
            <asp:RequiredFieldValidator ID="rfvMatch" runat="server" ControlToValidate="ddlMatch" InitialValue="" ErrorMessage="Match is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </label>
        <asp:DropDownList ID="ddlMatch" runat="server"></asp:DropDownList>
        
        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:15px;">
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Stand Name <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvStandName" runat="server" ControlToValidate="txtStandName" ErrorMessage="Stand Name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtStandName" runat="server" placeholder="e.g. North Pavilion"></asp:TextBox>
            </div>
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Stand Number / Code <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvStandNo" runat="server" ControlToValidate="txtStandNo" ErrorMessage="Stand No is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtStandNo" runat="server" placeholder="e.g. ST-01"></asp:TextBox>
            </div>
        </div>

        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:15px; margin-top:10px;">
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Base Stand Price (Rs) <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Enter a valid positive price" ValidationExpression="^\d+(\.\d{1,2})?$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </label>
                <asp:TextBox ID="txtPrice" runat="server" placeholder="e.g. 2500.00"></asp:TextBox>
            </div>
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Total Capacity / Seats <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvSeats" runat="server" ControlToValidate="txtSeats" ErrorMessage="Total seats is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revSeats" runat="server" ControlToValidate="txtSeats" ErrorMessage="Enter a valid whole number" ValidationExpression="^\d+$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </label>
                <asp:TextBox ID="txtSeats" runat="server" placeholder="e.g. 50"></asp:TextBox>
            </div>
        </div>
        
        <div style="margin-top:15px; display:flex; gap:10px;">
            <asp:Button ID="btnSave" runat="server" Text="Save Stand" CssClass="btn-green" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-red" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvStands" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvStands_RowCommand">
        <Columns>
            <asp:BoundField DataField="StandId" HeaderText="ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="StandName" HeaderText="Stand Name" />
            <asp:BoundField DataField="Price" HeaderText="Base Price" DataFormatString="Rs : {0:N2}" />
            <asp:BoundField DataField="TotalSeats" HeaderText="Total Seats" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditStand" CommandArgument='<%# Eval("StandId") %>' CssClass="btn-green" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteStand" CommandArgument='<%# Eval("StandId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this stand?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
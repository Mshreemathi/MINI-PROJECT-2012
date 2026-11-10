<%@ Page Title="Match Master" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Match.aspx.cs" Inherits="IPLProject.MatchPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="color: #1E40AF;">Admin - Match Management</h2>
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
    
    <div style="background:#F8FAFC; padding:15px; border-radius:6px; margin-bottom:20px; border:1px solid #BFDBFE;">
        <h3>Add / Edit Match</h3>
        <asp:HiddenField ID="hfMatchId" runat="server" />
        <label>Match Name <asp:RequiredFieldValidator ID="rfvMatchName" runat="server" ControlToValidate="txtMatchName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtMatchName" runat="server" placeholder="e.g. CSK vs MI"></asp:TextBox>
        
        <label>Team A <asp:RequiredFieldValidator ID="rfvTeamA" runat="server" ControlToValidate="txtTeamA" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtTeamA" runat="server" placeholder="e.g. Chennai Super Kings"></asp:TextBox>
        
        <label>Team B <asp:RequiredFieldValidator ID="rfvTeamB" runat="server" ControlToValidate="txtTeamB" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtTeamB" runat="server" placeholder="e.g. Mumbai Indians"></asp:TextBox>
        
        <label>Venue <asp:RequiredFieldValidator ID="rfvVenue" runat="server" ControlToValidate="txtVenue" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtVenue" runat="server" placeholder="e.g. MA Chidambaram Stadium"></asp:TextBox>
        
        <label>Date & Time <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator></label>
        <asp:TextBox ID="txtDate" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
        
        <div style="margin-top:10px;">
            <asp:Button ID="btnSave" runat="server" Text="Save Match" CssClass="btn-green" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-red" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvMatches" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvMatches_RowCommand">
        <Columns>
            <asp:BoundField DataField="MatchId" HeaderText="ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="TeamA" HeaderText="Team A" />
            <asp:BoundField DataField="TeamB" HeaderText="Team B" />
            <asp:BoundField DataField="Venue" HeaderText="Venue" />
            <asp:BoundField DataField="MatchDate" HeaderText="Date" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditMatch" CommandArgument='<%# Eval("MatchId") %>' CssClass="btn-green" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteMatch" CommandArgument='<%# Eval("MatchId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete match?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

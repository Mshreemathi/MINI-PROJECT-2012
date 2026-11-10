<%@ Page Title="Explore Matches" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="MatchExplorer.aspx.cs" Inherits="IPLProject.MatchExplorer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="color: #1E40AF;">Upcoming IPL Matches</h2>
    <asp:GridView ID="gvMatches" runat="server" AutoGenerateColumns="False" CssClass="grid-table">
        <Columns>
            <asp:BoundField DataField="MatchId" HeaderText="ID" />
            <asp:BoundField DataField="MatchName" HeaderText="Match" />
            <asp:BoundField DataField="TeamA" HeaderText="Team A" />
            <asp:BoundField DataField="TeamB" HeaderText="Team B" />
            <asp:BoundField DataField="Venue" HeaderText="Venue" />
            <asp:BoundField DataField="MatchDate" HeaderText="Date & Time" DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" />
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <a href='Booking.aspx?MatchId=<%# Eval("MatchId") %>' class="btn-green" style="text-decoration:none; display:inline-block;">Book Now</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

<%@ Page Title="Seat Master" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="SeatMaster.aspx.cs" Inherits="IPLProject.SeatMasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="color: #1E40AF;">Admin - Seat Management</h2>
    <asp:Label ID="lblMsg" runat="server"></asp:Label>
    
    <div style="background:#F8FAFC; padding:20px; border-radius:6px; margin-bottom:20px; border:1px solid #BFDBFE;">
        <h3>Add / Edit Seat</h3>
        <asp:HiddenField ID="hfSeatId" runat="server" />
        
        <label style="font-weight:600; color:#1E3A8A;">Select Stand <span style="color:red;">*</span>
            <asp:RequiredFieldValidator ID="rfvStand" runat="server" ControlToValidate="ddlStand" InitialValue="" ErrorMessage="Stand is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </label>
        <asp:DropDownList ID="ddlStand" runat="server"></asp:DropDownList>
        
        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:15px;">
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Row Label / Number <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvRow" runat="server" ControlToValidate="txtRow" ErrorMessage="Row is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtRow" runat="server" placeholder="e.g. Row A"></asp:TextBox>
            </div>
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Seat Name <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvSeatName" runat="server" ControlToValidate="txtSeatName" ErrorMessage="Seat Name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtSeatName" runat="server" placeholder="e.g. VIP Sofa Seat"></asp:TextBox>
            </div>
        </div>

        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:15px; margin-top:10px;">
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Seat Number <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvSeatNumber" runat="server" ControlToValidate="txtSeatNumber" ErrorMessage="Seat Number is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtSeatNumber" runat="server" placeholder="e.g. N-101"></asp:TextBox>
            </div>
            <div>
                <label style="font-weight:600; color:#1E3A8A;">Seat Price (Rs) <span style="color:red;">*</span>
                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Seat Price is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Enter a valid price" ValidationExpression="^\d+(\.\d{1,2})?$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </label>
                <asp:TextBox ID="txtPrice" runat="server" placeholder="e.g. 3500.00"></asp:TextBox>
            </div>
        </div>

        <div style="margin-top:15px; background:#EFF6FF; padding:12px; border-radius:6px; border:1px solid #93C5FD;">
            <label style="font-weight:600; color:#1E40AF; display:block; margin-bottom:5px;">
                <asp:CheckBox ID="chkIsHospitality" runat="server" AutoPostBack="true" OnCheckedChanged="chkIsHospitality_CheckedChanged" Text="  Mark as Hospitality / VIP Seat" />
            </label>
            <asp:Panel ID="pnlHospitalityDetails" runat="server" Visible="false" style="margin-top:10px;">
                <label style="font-weight:600; color:#1E3A8A;">Hospitality Additional Features & Amenities
                    <asp:RequiredFieldValidator ID="rfvHospitality" runat="server" ControlToValidate="txtHospitalityFeatures" ErrorMessage="Please list hospitality features" ForeColor="Red" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
                </label>
                <asp:TextBox ID="txtHospitalityFeatures" runat="server" TextMode="MultiLine" Rows="2" placeholder="e.g. AC Lounge Access, Unlimited Premium Buffet, Dedicated Steward Service, Souvenir Gift Pack"></asp:TextBox>
            </asp:Panel>
        </div>
        
        <div style="margin-top:15px; display:flex; gap:10px;">
            <asp:Button ID="btnSave" runat="server" Text="Save Seat" CssClass="btn-green" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-red" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </div>

    <asp:GridView ID="gvSeats" runat="server" AutoGenerateColumns="False" CssClass="grid-table" OnRowCommand="gvSeats_RowCommand">
        <Columns>
            <asp:BoundField DataField="SeatId" HeaderText="ID" />
            <asp:BoundField DataField="StandName" HeaderText="Stand" />
            <asp:BoundField DataField="RowLabel" HeaderText="Row" />
            <asp:BoundField DataField="SeatName" HeaderText="Seat Name" />
            <asp:BoundField DataField="SeatNumber" HeaderText="Seat No" />
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="Rs : {0:N2}" />
            <asp:TemplateField HeaderText="Hospitality Features">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsHospitality")) ? "<strong style='color:#16A34A;'>Yes</strong> - " + Eval("HospitalityFeatures") : "<span style='color:#6B7280;'>Standard</span>" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditSeat" CommandArgument='<%# Eval("SeatId") %>' CssClass="btn-green" CausesValidation="false" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteSeat" CommandArgument='<%# Eval("SeatId") %>' CssClass="btn-red" OnClientClick="return confirm('Delete this seat?');" CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
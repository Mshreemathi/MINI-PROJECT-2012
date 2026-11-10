namespace IPLProject
{
    public partial class SeatMasterPage
    {
        protected global::System.Web.UI.WebControls.Label lblMsg;
        protected global::System.Web.UI.WebControls.HiddenField hfSeatId;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvStand;
        protected global::System.Web.UI.WebControls.DropDownList ddlStand;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvRow;
        protected global::System.Web.UI.WebControls.TextBox txtRow;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSeatName;
        protected global::System.Web.UI.WebControls.TextBox txtSeatName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvSeatNumber;
        protected global::System.Web.UI.WebControls.TextBox txtSeatNumber;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPrice;
        protected global::System.Web.UI.WebControls.RegularExpressionValidator revPrice;
        protected global::System.Web.UI.WebControls.TextBox txtPrice;
        protected global::System.Web.UI.WebControls.CheckBox chkIsHospitality;
        protected global::System.Web.UI.WebControls.Panel pnlHospitalityDetails;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvHospitality;
        protected global::System.Web.UI.WebControls.TextBox txtHospitalityFeatures;
        protected global::System.Web.UI.WebControls.Button btnSave;
        protected global::System.Web.UI.WebControls.Button btnCancel;
        protected global::System.Web.UI.WebControls.GridView gvSeats;
    }
}
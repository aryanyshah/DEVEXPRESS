<%@ Page Language="C#" MasterPageFile="~/Site.master" %>
<asp:Content ContentPlaceHolderID="ErrorHolder" runat="server">
    <dx:ErrorMessage runat="server" MainMessage="Internal server error"
        Details="<p>The server encountered an unexpected condition which prevented it from fulfilling the request. Please try to load the page later.</p> 
<p>You can also return to the product's main demo page or take a look at some of the product demos.</p>"></dx:ErrorMessage>
</asp:Content>
<script language="c#" runat="server">
public void Page_Load(object sender, EventArgs e) {
    Response.StatusCode = 500;
}
</script> 

<%@ Page Language="C#" MasterPageFile="~/Site.master" %>
<asp:Content ContentPlaceHolderID="ErrorHolder" runat="server">
    <dx:ErrorMessage runat="server" MainMessage="404 - The page you requested was not found"
        Details="<p>The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
<p>Please review the resource URL and make sure that it is spelled correctly. You can also return to the product's main demo page or take a look at some of the product demos.</p>"></dx:ErrorMessage>
</asp:Content>
<script language="c#" runat="server">
public void Page_Load(object sender, EventArgs e) {
    Response.StatusCode = 404;
}
</script>

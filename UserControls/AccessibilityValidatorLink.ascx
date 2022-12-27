<%@ Control Language="C#" %>
<script runat="server">
    protected void hlValidateWAVE_Init(object sender, EventArgs e) {
        ASPxHyperLink hyperLink = (ASPxHyperLink)sender;
        hyperLink.Visible = Utils.IsSiteMode;
        hyperLink.NavigateUrl = "http://wave.webaim.org/report?url=" + Page.Request.Url.AbsoluteUri;
    }
</script>
<div style="margin-top: 36px; margin-right: 2px; float: right;">
    <dx:ASPxHyperLink ID="hlValidateWAVE" runat="server" Target="_blank" Text="Validate with WAVE"
        ImageUrl="~/Content/WAVE.png" OnInit="hlValidateWAVE_Init">
    </dx:ASPxHyperLink>
</div>

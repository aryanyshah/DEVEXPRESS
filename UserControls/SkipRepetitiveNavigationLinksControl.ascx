<%@ Control Language="C#" %>
<div id="skipLinks" class="skipPanel dxAIFE">
    <dx:ASPxHyperLink ID="skipToMainContentLink" runat="server" Text="Skip to Main Content" Font-Size="350%" Theme="Metropolis"
        onclick="DXDemo.focusMainElement();" onfocus="DXDemo.toggleSkipLinks();" onblur="DXDemo.toggleSkipLinks();" href="javascript:void(0);">
    </dx:ASPxHyperLink>
</div>

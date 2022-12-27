<%@ Control Language="C#" %>
<dx:ASPxStyleSheetManager ID="styleSheetManager" runat="server">
    <Items>
        <dx:ResourceStyleSheet Suite="Icons" IconType="Icons16x16" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="Icons" IconType="Icons16x16office2013" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="Editors" Theme="Default" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="NavigationAndLayout" Theme="Default" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="Editors" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="Editors" Theme="MaterialCompactOrange" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="NavigationAndLayout" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="NavigationAndLayout" Theme="Metropolis" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="NavigationAndLayout" Theme="MaterialCompactOrange" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="TreeList" AccessibilityCompliant="true" />
        <dx:ResourceStyleSheet Suite="Gantt"/>
    </Items>
</dx:ASPxStyleSheetManager>
<dx:ASPxScriptManager ID="scriptManager" runat="server">
    <Items>            
        <dx:ResourceScript Suite="Editors" />
        <dx:ResourceScript Suite="NavigationAndLayout" />
        <dx:ResourceScript Suite="TreeList" />
        <dx:ResourceScript Suite="Gantt" />
    </Items>
</dx:ASPxScriptManager>

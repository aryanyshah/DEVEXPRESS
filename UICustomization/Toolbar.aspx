<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Toolbar.aspx.cs" Inherits="Gantt_Toolbar" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <script type="text/javascript">
        function CustomCommand(s, e) {
            if(e.commandName == "About")
                AboutPopup.Show();
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ControlOptionsTopHolder" runat="Server">
    <div class="options">
        <div class="options-item">
            <dx:ASPxComboBox runat="server" ID="AlignCombo" Caption="Alignment" AutoPostBack="true">
                <Items>
                    <dx:ListEditItem Text="Left" Value="Left" Selected="true" />
                    <dx:ListEditItem Text="Justify" Value="Justify" />
                    <dx:ListEditItem Text="Right" Value="Right" />
                </Items>
            </dx:ASPxComboBox>
        </div>
        <div class="options-item">
            <dx:ASPxCheckBox runat="server" ID="ShowToolbarCheckbox" Text="Show toolbar"
                Checked="true" AutoPostBack="true">
            </dx:ASPxCheckBox>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" EnableViewState="false"
        TasksDataSourceID="TasksDataSource" 
        DependenciesDataSourceID="DependenciesDataSource" 
        ResourcesDataSourceID="ResourcesDataSource" 
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <SettingsToolbar>
            <Items>
                <dx:GanttZoomInToolbarItem Text="Zoom In"></dx:GanttZoomInToolbarItem>
                <dx:GanttZoomOutToolbarItem Text="Zoom Out"></dx:GanttZoomOutToolbarItem>
                <dx:GanttShowResourcesToolbarItem Text="Show Resources"></dx:GanttShowResourcesToolbarItem>
                <dx:GanttShowDependenciesToolbarItem BeginGroup="false" Text="Show Dependencies"></dx:GanttShowDependenciesToolbarItem>
                <dx:GanttCustomToolbarItem Text="About" BeginGroup="true" CommandName="About">
                    <Image Height="16px" Width="16px" Url="../Content/inf.svg" />
                </dx:GanttCustomToolbarItem>
            </Items>
        </SettingsToolbar>
        <ClientSideEvents CustomCommand="CustomCommand" />
        <SettingsEditing Enabled="false" />
        <SettingsGanttView ViewType="Weeks" ShowResources="false" ShowDependencies="false"/>
        <SettingsTaskList Width="40%">
            <Columns>
                <dx:GanttTextColumn FieldName="Subject" Width="360"  />
                <dx:GanttDateTimeColumn FieldName="StartDate" Caption="Start Date" Width="100" DisplayFormat="MM\/dd\/yyyy" />
                <dx:GanttDateTimeColumn FieldName="EndDate" Caption="Due Date" Width="100" DisplayFormat="MM\/dd\/yyyy" />
            </Columns>
        </SettingsTaskList>
        <Mappings>
            <Task Key="ID" ParentKey="ParentID" Title="Subject" Start="StartDate" End="EndDate" Progress="PercentComplete" />
            <Dependency Key="ID" PredecessorKey="ParentID" SuccessorKey="DependentID" DependencyType="Type" />
            <Resource Key="ID" Name="Name" />
            <ResourceAssignment Key="ID" TaskKey="TaskID" ResourceKey="ResourceID" />
        </Mappings>
    </dx:ASPxGantt>
    <dx:ASPxPopupControl ID="AboutPopup" runat="server" ClientInstanceName="AboutPopup" Modal="True" HeaderText="About" Width="500px"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseOnEscape="true">
        <ContentCollection>
            <dx:PopupControlContentControl>
                The DevExpress ASP.NET Gantt (ASPxGantt) is a project management tool that enables you to organize and manage tasks.
                It uses the Microsoft Project-style UI to edit and scale tasks, track a project's progress, and important deadlines.
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle Paddings-PaddingBottom="20px"></ContentStyle>
    </dx:ASPxPopupControl>
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" SelectMethod="GetTasks" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" SelectMethod="GetDependencies" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" SelectMethod="GetResources" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" SelectMethod="GetResourceAssignments" TypeName="GanttDataProvider" />
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ContextMenu.aspx.cs" Inherits="Gantt_ContextMenu" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <script type="text/javascript">
        var showResources = true;
        function ContextMenuCustomization(s, e) {
            if(preventContextMenuCheckbox.GetChecked())
                e.cancel = true;
            if(!showDefaultItemsCheckbox.GetChecked())
                e.menuItems.Clear();
            var customItem = new ASPxClientGanttContextMenuItem();
            customItem.name = 'ToggleResourcesVisibility';
            customItem.text = 'Toggle Resources Visibility';
            customItem.beginGroup = true;
            e.menuItems.Add(customItem);
        }
        function CustomCommand(s, e) {
            if(e.commandName == 'ToggleResourcesVisibility') {
                showResources = !showResources;
                clientGantt.ShowResources(showResources);
            }
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ControlOptionsTopHolder" runat="Server">
    <div class="options">
        <div class="options-item">
            <dx:ASPxCheckBox runat="server" ID="PreventContextMenuCheckbox" ClientInstanceName="preventContextMenuCheckbox"
                Text="Prevent Display of Context Menu" Checked="false">
            </dx:ASPxCheckBox>
        </div>
        <div class="options-item">
            <dx:ASPxCheckBox runat="server" ID="ShowDefaultItemsCheckbox" ClientInstanceName="showDefaultItemsCheckbox"
                Text="Show Default Items" Checked="true">
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
        
        <ClientSideEvents ContextMenuCustomization="ContextMenuCustomization" CustomCommand="CustomCommand" />
        <SettingsEditing Enabled="true" />
        <SettingsGanttView ViewType="Weeks" />
        <SettingsToolbar Visible="false" />
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
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" DataObjectTypeName="Task" TypeName="GanttDataProvider" SelectMethod="GetTasks" UpdateMethod="UpdateTask" InsertMethod="InsertTask" DeleteMethod="DeleteTask" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" DataObjectTypeName="Dependency" TypeName="GanttDataProvider" SelectMethod="GetDependencies" InsertMethod="InsertDependency" DeleteMethod="DeleteDependency" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" DataObjectTypeName="Resource" TypeName="GanttDataProvider" SelectMethod="GetResources" UpdateMethod="UpdateResource" InsertMethod="InsertResource" DeleteMethod="DeleteResource" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" DataObjectTypeName="ResourceAssignment" TypeName="GanttDataProvider" SelectMethod="GetResourceAssignments" InsertMethod="InsertResourceAssignment" DeleteMethod="DeleteResourceAssignment"  />
</asp:Content>

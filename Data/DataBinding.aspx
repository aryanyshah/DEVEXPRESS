<%@ Page Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DataBinding.aspx.cs" Inherits="Gantt_DataBinding" %>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" EnableViewState="false"
        TasksDataSourceID="TasksDataSource" 
        DependenciesDataSourceID="DependenciesDataSource" 
        ResourcesDataSourceID="ResourcesDataSource" 
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <SettingsTaskList Width="40%">
            <Columns>
                <dx:GanttTextColumn FieldName="Subject" Caption="Title" Width="360" />
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
        <SettingsGanttView ViewType="Weeks" />
    </dx:ASPxGantt>
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" DataObjectTypeName="Task" TypeName="GanttDataProvider" SelectMethod="GetTasks" UpdateMethod="UpdateTask" InsertMethod="InsertTask" DeleteMethod="DeleteTask" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" DataObjectTypeName="Dependency" TypeName="GanttDataProvider" SelectMethod="GetDependencies" InsertMethod="InsertDependency" DeleteMethod="DeleteDependency" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" DataObjectTypeName="Resource" TypeName="GanttDataProvider" SelectMethod="GetResources" UpdateMethod="UpdateResource" InsertMethod="InsertResource" DeleteMethod="DeleteResource" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" DataObjectTypeName="ResourceAssignment" TypeName="GanttDataProvider" SelectMethod="GetResourceAssignments" InsertMethod="InsertResourceAssignment" DeleteMethod="DeleteResourceAssignment"  />
</asp:Content>

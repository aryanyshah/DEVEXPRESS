<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="StripLines.aspx.cs" Inherits="Gantt_StripLines" %>
<asp:Content ContentPlaceHolderID="CustomHeadHolder" runat="server">
    <style>
        .current-time {
            border-left: 1px solid red;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" EnableViewState="false"
        TasksDataSourceID="TasksDataSource"
        DependenciesDataSourceID="DependenciesDataSource"
        ResourcesDataSourceID="ResourcesDataSource"
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <SettingsStripLine ShowCurrentTime="true" CurrentTimeUpdateInterval="3000" CurrentTimeTitle="Current Time" CurrentTimeCssClass="current-time">
            <StripLines>
                <dx:StripLine Title="Start" Start="2019-02-21T05:00:00.000Z" />
                <dx:StripLine Title="The Final Period" Start="2019-06-04T12:00:00.000Z" End="2019-07-04T12:00:00.000Z" />
            </StripLines>
        </SettingsStripLine>
        
        <SettingsEditing Enabled="false" />
        <SettingsToolbar Visible="false" />
        <SettingsGanttView ViewType="Months" />
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
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" SelectMethod="GetTasks" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" SelectMethod="GetDependencies" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" SelectMethod="GetResources" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" SelectMethod="GetResourceAssignments" TypeName="GanttDataProvider" />
</asp:Content>

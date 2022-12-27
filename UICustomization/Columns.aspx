<%@ Page Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Columns.aspx.cs" Inherits="Features_Columns" %>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt runat="server" ID="Gantt" ClientInstanceName="clientGantt" Height="800" Width="100%" TasksDataSourceID="FlightsDataSource"  ResourcesDataSourceID="PlanesDataSource" ResourceAssignmentsDataSourceID="AssignmentsDataSource"  DependenciesDataSourceID="DependenciesDataSource" >
        <Mappings>
            <Task Key="FligntNumber" Title="Title" Start="FlightStart" End="FlightEnd" ParentKey="CompositeFLightNumber" Color="State" />
            <Dependency DependencyType="Type" PredecessorKey="PrevFlightId"  SuccessorKey="NexFlightId" />
            <Resource Key="SideNumber" Name="Title" />
            <ResourceAssignment Key="ID" TaskKey="FigntID" ResourceKey="PlaneID" />
        </Mappings>
        <SettingsTaskList Width="55%" >
            <Columns>                
                <dx:GanttTextColumn FieldName="DepartFrom"  />
                <dx:GanttTimeEditColumn FieldName="FlightStart" Caption="Depart At" Width="70" />
                <dx:GanttTextColumn FieldName="ArriveTo"  />
                <dx:GanttTimeEditColumn FieldName="FlightEnd" Caption="Arrive At" Width="70" />
                <dx:GanttCheckColumn FieldName="International" Width="60" />
                <dx:GanttProgressBarColumn FieldName="Progress" Width="80" />
                <dx:GanttTextColumn FieldName="Miles"  Width="50"/>
            </Columns>
        </SettingsTaskList>
        <SettingsEditing Enabled="false" />
        <SettingsToolbar Visible="false" />
        <SettingsGanttView ViewType="Hours" />
        <SettingsValidation AutoUpdateParentTasks="true" />
    </dx:ASPxGantt>
            
    <asp:ObjectDataSource ID="FlightsDataSource" runat="server" SelectMethod="GetFlights" DataObjectTypeName="Flight" TypeName="AirlineDataProvider" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" SelectMethod="GetDependencies" DataObjectTypeName="Plane" TypeName="AirlineDataProvider" />
    <asp:ObjectDataSource ID="PlanesDataSource" runat="server" SelectMethod="GetPlanes" DataObjectTypeName="Plane" TypeName="AirlineDataProvider" />
    <asp:ObjectDataSource ID="AssignmentsDataSource" runat="server" SelectMethod="GetAssignments" DataObjectTypeName="Assignment" TypeName="AirlineDataProvider" />
</asp:Content>

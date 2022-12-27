<%@ Page Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Validation.aspx.cs" Inherits="Gantt_Validation" %>
<asp:Content ContentPlaceHolderID="ControlOptionsTopHolder" runat="Server">
    <div class="options">
        <div class="options-item">
            <dx:ASPxCheckBox runat="server" ID="AutoUpdateParentTasksCheckbox" Text="Auto Update Parent Tasks" Checked="true" AutoPostBack="true" />
        </div>
        <div class="options-item">
            <dx:ASPxCheckBox runat="server" ID="EnableDependencyValidationCheckbox" Text="Enable Dependency Validation" Checked="true" AutoPostBack="true" />
        </div>
        <div class="options-item">
            <dx:ASPxCheckBox runat="server" ID="EnablePredecessorGapCheckbox" Text="Enable Predecessor Gap" Checked="false" AutoPostBack="true"/>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" EnableViewState="false"
        TasksDataSourceID="TasksDataSource" 
        DependenciesDataSourceID="DependenciesDataSource" >
        <SettingsTaskList Width="40%">
            <Columns>
                <dx:GanttTextColumn FieldName="Subject" Width="260"  />
                <dx:GanttDateTimeColumn FieldName="StartDate" Caption="Start Date" Width="100"  />
                <dx:GanttDateTimeColumn FieldName="EndDate" Caption="Due Date" Width="100" />
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
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" DataObjectTypeName="Task" TypeName="ConstructionProjectDataProvider" SelectMethod="GetTasks" UpdateMethod="UpdateTask" InsertMethod="InsertTask" DeleteMethod="DeleteTask" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" DataObjectTypeName="Dependency" TypeName="ConstructionProjectDataProvider" SelectMethod="GetDependencies" InsertMethod="InsertDependency" DeleteMethod="DeleteDependency" />    
</asp:Content>

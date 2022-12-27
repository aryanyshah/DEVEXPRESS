<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="WorkTimeSchedule.aspx.cs" Inherits="Gantt_WorkTimeSchedule" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <script type="text/javascript">
        function ViewTypeCombo_SelectedIndexChanged(s, e) {
            clientGantt.SetViewType(s.GetValue());
            if(s.GetValue() < 3) {
                clientGantt.SetTaskTitlePosition(0);
                lblDailyRules.GetMainElement().classList.remove("workTimeDisabledLabel");
            }
            else {
                clientGantt.SetTaskTitlePosition(1);
                lblDailyRules.GetMainElement().classList.add("workTimeDisabledLabel");
            }
        }
        function OnGanttViewInit(s, e) {
            lblDailyRules.SetText(s.cpDailyRuleInfo)
            lblWeeklyRules.SetText(s.cpWeeklyRuleInfo)
            lblYearlyRules.SetText(s.cpYearlyRuleInfo)
        }
    </script>
    <style>
        .workTimeLabel {
            font-weight: bold;
        }
        .workTimeDisabledLabel {
            text-decoration: line-through;
            color:lightgray;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="ControlOptionsTopHolder" runat="Server">
    <div class="options">
        <div class="options-item">
            <dx:ASPxComboBox runat="server" ID="ViewTypeCombo" SelectedIndex="1" Caption="View Type" ValueType="System.Int32">
                <Items>
                    <dx:ListEditItem Text="Hours" Value="1" />
                    <dx:ListEditItem Text="SixHours" Value="2" />
                    <dx:ListEditItem Text="Days" Value="3" />
                </Items>
                <ClientSideEvents SelectedIndexChanged="ViewTypeCombo_SelectedIndexChanged" />
            </dx:ASPxComboBox>
        </div>
        <div class="options-item">
            <span class="workTimeLabel">Working hours: </span><dx:ASPxLabel runat="server" ID="LabelDailyRules" Text="" ClientInstanceName="lblDailyRules" /><br/>
            <span class="workTimeLabel">Non-working Days: </span><dx:ASPxLabel runat="server" ID="LabelWeeklyRules" Text="" ClientInstanceName="lblWeeklyRules" /><br/>
            <span class="workTimeLabel">Holidays: </span><dx:ASPxLabel runat="server" ID="LabelYearlyRules" Text="" ClientInstanceName="lblYearlyRules" /><br/>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" EnableViewState="false"
        OnCustomJSProperties="Gantt_CustomJSProperties"
        TasksDataSourceID="TasksDataSource"
        DependenciesDataSourceID="DependenciesDataSource"
        ResourcesDataSourceID="ResourcesDataSource"
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <ClientSideEvents Init="OnGanttViewInit" />
        
        <WorkTimeRules> 
            <dx:DailyRule>
                <WorkTimeRanges>
                    <dx:WorkTimeRange Start="08:00" End="11:55" />
                    <dx:WorkTimeRange Start="13:00" End="17:00" />
                </WorkTimeRanges>
            </dx:DailyRule>
            <dx:WeeklyRule IsWorkDay="false">
                <Recurrence DayOfWeek="Saturday" />
            </dx:WeeklyRule>
            <dx:WeeklyRule IsWorkDay="false">
                <Recurrence DayOfWeek="Sunday" />
            </dx:WeeklyRule>
            <dx:YearlyRule IsWorkDay="false">
                <Recurrence Day="27" Month="May" />
            </dx:YearlyRule>
            <dx:YearlyRule IsWorkDay="false">
                <Recurrence Day="14" Month="February" />
            </dx:YearlyRule>
            <dx:YearlyRule IsWorkDay="false">
                <Recurrence Day="8" Month="March" />
            </dx:YearlyRule>
        </WorkTimeRules>
        
        <SettingsGanttView ViewType="Hours" />
        <SettingsEditing Enabled="false" />
        <SettingsToolbar Visible="false" />
        <SettingsTaskList Width="40%">
            <Columns>
                <dx:GanttTextColumn FieldName="Subject" Caption="Title" Width="360" />
                <dx:GanttDateTimeColumn FieldName="StartDate" Caption="Start Date" Width="100" DisplayFormat="MM\/dd\/yyyy" />
                <dx:GanttDateTimeColumn FieldName="EndDate" Caption="Due Date" Width="100" DisplayFormat="MM\/dd\/yyyy" />
            </Columns>
        </SettingsTaskList>
        <SettingsGanttView ViewType="SixHours" />
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

<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChartAppearance.aspx.cs" Inherits="Gantt_ChartAppearance" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <style>
        .custom-task-edit-tooltip {
            background-color: white;
            color: black;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            padding: 10px 12px 12px 12px;
            border-radius: 3px;
        }
        .custom-task-edit-tooltip::before {
            border-top-color: white;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }
        .custom-task-edit-tooltip::after {
            border-bottom-color: white;
        }
        .custom-tooltip-title {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 13px;
            font-weight: 600;
            padding-bottom: 6px;
        }
        .custom-tooltip-row {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 12px;
            font-weight: 600;
        }
    </style>
    <script type="text/javascript">
        function ViewTypeCombo_SelectedIndexChanged(s, e) { 
            clientGantt.SetViewType(s.GetValue());
        }
        function TitlePositionCombo_SelectedIndexChanged(s, e) { 
            clientGantt.SetTaskTitlePosition(s.GetValue());
        }
        function ShowResourcesCheckbox_CheckedChanged(s, e) {
            clientGantt.ShowResources(s.GetValue());
        }
        function ShowDependenciesCheckbox_CheckedChanged(s, e) {
            clientGantt.ShowDependencies(s.GetValue());
        }
        function onShowTooltip(s, e) {
            var timeEstimate = Math.abs(e.task["StartDate"] - e.task["EndDate"]) / 36e5;
            var timeLeft = Math.floor((100 - e.task["PercentComplete"]) / 100 * timeEstimate);
            var customTooltip = document.createElement("div");
            customTooltip.setAttribute("class", "custom-task-edit-tooltip");
            var titleContainer = document.createElement("div");
            titleContainer.setAttribute("class", "custom-tooltip-title");
            titleContainer.textContent = e.task["Subject"];
            customTooltip.appendChild(titleContainer);
            var estimateContainer = document.createElement("div");
            estimateContainer.setAttribute("class", "custom-tooltip-row");
            estimateContainer.textContent = "Estimate: " + timeEstimate + " hours";
            customTooltip.appendChild(estimateContainer);
            var timeLeftConateiner = document.createElement("div");
            timeLeftConateiner.setAttribute("class", "custom-tooltip-row");
            timeLeftConateiner.textContent = "Left: " + timeLeft + "hours";
            customTooltip.appendChild(timeLeftConateiner);
            e.container.appendChild(customTooltip);
        }
        function startChanged(s, e) {
            clientGantt.SetStartDateRange(s.GetValue());
        }
        function endChanged(s, e) {
            clientGantt.SetEndDateRange(s.GetValue());
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ControlOptionsTopHolder" runat="Server">
     <dx:ASPxFormLayout runat="server" ID="OptionsFormLayout" UseDefaultPaddings="false" >
        <Styles>
            <LayoutGroup Cell-Paddings-PaddingBottom ="10"  />
        </Styles>
        <Items>
            <dx:LayoutGroup ShowCaption="False" ColumnCount="2" GroupBoxDecoration="None" >
                <Items>
                    <dx:LayoutItem Caption="View Type" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="ViewTypeCombo" SelectedIndex="4" ValueType="System.Int32">
                                    <Items>
                                        <dx:ListEditItem Text="Ten minutes" Value="0" />
                                        <dx:ListEditItem Text="Hours" Value="1" />
                                        <dx:ListEditItem Text="SixHours" Value="2" />
                                        <dx:ListEditItem Text="Days" Value="3" />
                                        <dx:ListEditItem Text="Weeks" Value="4" />
                                        <dx:ListEditItem Text="Months" Value="5" />
                                    </Items>
                                    <ClientSideEvents SelectedIndexChanged="ViewTypeCombo_SelectedIndexChanged" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Start Date Range">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxDateEdit ID="startDateEdit" ClientInstanceName="startDateEdit" runat="server" EditFormat="Custom" EditFormatString="MM/dd/yyyy">
                                    <ClientSideEvents ValueChanged="startChanged" />
                                    <TimeSectionProperties>
                                        <TimeEditProperties EditFormatString="hh:mm tt" />
                                    </TimeSectionProperties>
                                    <CalendarProperties>
                                        <FastNavProperties DisplayMode="Inline" />
                                    </CalendarProperties>
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Title Position"  VerticalAlign="Middle" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="TitlePositionCombo" SelectedIndex="1" ValueType="System.Int32">
                                    <Items>
                                        <dx:ListEditItem Text="None" Value="2" />
                                        <dx:ListEditItem Text="Inside" Value="0" />
                                        <dx:ListEditItem Text="Outside" Value="1" />
                                    </Items>
                                    <ClientSideEvents SelectedIndexChanged="TitlePositionCombo_SelectedIndexChanged" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="End Date Range">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxDateEdit ID="endDateEdit" ClientInstanceName="startDateEdit" runat="server" EditFormat="Custom" EditFormatString="MM/dd/yyyy">
                                    <ClientSideEvents ValueChanged="endChanged" />
                                    <TimeSectionProperties>
                                        <TimeEditProperties EditFormatString="hh:mm tt" />
                                    </TimeSectionProperties>
                                    <CalendarProperties>
                                        <FastNavProperties DisplayMode="Inline" />
                                    </CalendarProperties>
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Show Resources">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxCheckBox runat="server" ID="ShowResourcesCheckbox" Checked="true">
                                    <ClientSideEvents CheckedChanged="ShowResourcesCheckbox_CheckedChanged" />
                                </dx:ASPxCheckBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Customize Task Tooltip">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxCheckBox runat="server" ID="CustomizeTaskTooltip" Checked="true" AutoPostback = "true">
                                </dx:ASPxCheckBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Show Dependencies">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxCheckBox runat="server" ID="ShowDependenciesCheckbox" Checked="true">
                                    <ClientSideEvents CheckedChanged="ShowDependenciesCheckbox_CheckedChanged" />
                                </dx:ASPxCheckBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" 
        TasksDataSourceID="TasksDataSource" 
        DependenciesDataSourceID="DependenciesDataSource" 
        ResourcesDataSourceID="ResourcesDataSource" 
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <SettingsEditing Enabled="false" />
        <SettingsToolbar Visible="false" />
        <SettingsGanttView ViewType="Weeks" />
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
    </dx:ASPxGantt>
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" SelectMethod="GetTasks" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" SelectMethod="GetDependencies" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" SelectMethod="GetResources" TypeName="GanttDataProvider" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" SelectMethod="GetResourceAssignments" TypeName="GanttDataProvider" />
</asp:Content>

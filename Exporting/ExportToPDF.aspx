<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ExportToPDF.aspx.cs" Inherits="Exporting_ExportToPDF" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <style type="text/css">       
        .buttonsContainer
        {
            max-width: 300px;
            margin: 0 0 0 auto;
            text-align: right;
            padding-top: 12px;
        }
        .submitButton,
        .cancelButton
        {
            margin-bottom: 9px;
        }
        .cancelButton
        {
            margin-left: 8px;
        }
        .clearPaddings
        {
            padding-top: 0 !important;
            padding-bottom: 0 !important;
        }
        .clearMarginTop {
            margin-top: 0 !important;
        }
    </style>
    <script type="text/javascript">
        var exportSettings;
        var dialogState = { };
        window.onload = function() {
            updateExportSettings();
            saveDialogState();
            rangeValueChanged();
        }
        function saveDialogState() {
            dialogState.format = docFormatCombo.GetText();
            dialogState.landscape = cbLandscape.GetValue();
            dialogState.exportMode = exportModeCombo.GetText();
            dialogState.dataRangeMode = rangeCombo.GetText();
            dialogState.startIndex = startTaskEdit.GetValue();
            dialogState.endIndex = endTaskEdit.GetValue();
            dialogState.startDate = startDateEdit.GetValue();
            dialogState.endDate = endDateEdit.GetValue();
        }
        function resetDialogState() {
            docFormatCombo.SetText(dialogState.format);
            cbLandscape.SetValue(dialogState.landscape);
            exportModeCombo.SetText(dialogState.exportMode);
            rangeCombo.SetText(dialogState.dataRangeMode);
            startTaskEdit.SetValue(dialogState.startIndex);
            endTaskEdit.SetValue(dialogState.endIndex);
            startDateEdit.SetValue(dialogState.startDate );
            endDateEdit.SetValue(dialogState.endDate );
        }
        function updateExportSettings() {
            exportSettings = getExportSettings();
        }
        function getExportSettings() {
            var dataRangeMode = rangeCombo.GetText().toLowerCase();
            var dataRange;
            if(dataRangeMode === 'custom') {
                dataRange = { 
                    startIndex: startTaskEdit.GetValue(), 
                    endIndex: endTaskEdit.GetValue(),
                    startDate:  startDateEdit.GetValue(),
                    endDate: endDateEdit.GetValue()
                }
            }
            else {
                dataRange = dataRangeMode
            }
            var exportMode = exportModeCombo.GetText();
            exportMode = exportMode === 'Tree List' ? 'treeList' : exportMode.toLowerCase();
            var options = {
                format: docFormatCombo.GetText().toLowerCase(),
                landscape: cbLandscape.GetValue(),
                exportMode: exportMode, 
                dateRange: dataRange,
                fileName: "test.pdf"
            };
            return options;
        }
        function exportGantt() {
            clientGantt.ExportToPdf(exportSettings);
        }
        function CustomCommand(s, e) {
            if(e.commandName == "ExportToPdf")
                exportGantt();
            if(e.commandName == "Settings") {
                SettingsPopup.ShowAtElement(clientGantt.GetMainElement());
            }
        }
        function applyBtnClick() {
            updateExportSettings();
            saveDialogState();
            SettingsPopup.Hide();
        }
        function cancelBtnClick() {
            SettingsPopup.Hide();
        }
        function popupCLosing() {
            resetDialogState();
        }
        function rangeValueChanged() {
            var isCustomRange = rangeCombo.GetText() === "Custom";
            startTaskEdit.SetEnabled(isCustomRange);
            endTaskEdit.SetEnabled(isCustomRange);
            startDateEdit.SetEnabled(isCustomRange);
            endDateEdit.SetEnabled(isCustomRange);
        }
    </script>
</asp:Content>
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
          <SettingsToolbar>
            <Items>
                <dx:GanttCustomToolbarItem CommandName="ExportToPdf" >
                    <Image Height="16px" Width="16px" Url="../Content/pdf.svg" ToolTip="Export to PDF" />
                </dx:GanttCustomToolbarItem>
                <dx:GanttCustomToolbarItem CommandName="Settings" BeginGroup="true" ToolTip="Export settings" >
                    <Image Height="16px" Width="16px" Url="../Content/swt.svg" />
                </dx:GanttCustomToolbarItem>
            </Items>
        </SettingsToolbar>
        <Mappings>
            <Task Key="ID" ParentKey="ParentID" Title="Subject" Start="StartDate" End="EndDate" Progress="PercentComplete" />
            <Dependency Key="ID" PredecessorKey="ParentID" SuccessorKey="DependentID" DependencyType="Type" />
            <Resource Key="ID" Name="Name" />
            <ResourceAssignment Key="ID" TaskKey="TaskID" ResourceKey="ResourceID" />
        </Mappings>
        <SettingsGanttView ViewType="Days" />
        <ClientSideEvents CustomCommand="CustomCommand" />
    </dx:ASPxGantt>
    <dx:ASPxPopupControl ID="SettingsPopup" runat="server" ClientInstanceName="SettingsPopup" Modal="False" MaxHeight="750px" MinWidth="375px"
        ShowHeader="false" ShowFooter="false" PopupVerticalAlign="TopSides" PopupHorizontalAlign="RightSides" CloseOnEscape="true" ScrollBars="None" ClientSideEvents-Closing="popupCLosing" >
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxFormLayout runat="server" ID="OptionsFormLayout" UseDefaultPaddings="false" >
                    <Styles>
                        <LayoutGroup Cell-Paddings-Padding="0" CssClass="clearPaddings" />
                        <LayoutGroupBox Caption-Paddings-Padding="0" CssClass="clearPaddings"  />
                    </Styles>
                    <Items>            
                        <dx:LayoutGroup ShowCaption="False" VerticalAlign="Top" Paddings-Padding="0" >
                            <Items>            
                                <dx:LayoutGroup Caption="Export Options" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" GroupBoxStyle-Caption-Paddings-PaddingTop="5"  GroupBoxStyle-Caption-OffsetX="0" >
                                    <Items>
                                        <dx:LayoutItem Caption="Document format" >
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox runat="server" ID="docFormatCombo" ClientInstanceName="docFormatCombo" SelectedIndex="4" >
                                                        <Items>
                                                            <dx:ListEditItem Text="A0" />
                                                            <dx:ListEditItem Text="A1" />
                                                            <dx:ListEditItem Text="A2" />
                                                            <dx:ListEditItem Text="A3" />
                                                            <dx:ListEditItem Text="A4" />
                                                            <dx:ListEditItem Text="Auto" />
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Landscape orientation"  VerticalAlign="Middle" >
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox runat="server" ID="cbLandscape" ClientInstanceName="cbLandscape" Checked="true" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Export mode">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxComboBox runat="server" ID="exportModeCombo" ClientInstanceName="exportModeCombo" SelectedIndex="0" >
                                                        <Items>
                                                            <dx:ListEditItem Text="All" />
                                                            <dx:ListEditItem Text="Chart" />
                                                            <dx:ListEditItem Text="Tree List" />
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutGroup Caption="Task Filter Options" GroupBoxDecoration="HeadingLine" Paddings-PaddingBottom="0" Paddings-Padding="0" GroupBoxStyle-Caption-Paddings-PaddingTop="15"  GroupBoxStyle-Caption-OffsetX="0" >
                                            <Items>
                                                <dx:LayoutItem Caption="Date range">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxComboBox runat="server" ID="rangeCombo" ClientInstanceName="rangeCombo" SelectedIndex="1" ClientSideEvents-ValueChanged="rangeValueChanged" >
                                                                <Items>
                                                                    <dx:ListEditItem Text="All" />
                                                                    <dx:ListEditItem Text="Visible" />
                                                                    <dx:ListEditItem Text="Custom" />
                                                                </Items>
                                                            </dx:ASPxComboBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Start task (index)">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxSpinEdit ID="startTaskEdit" ClientInstanceName="startTaskEdit" runat="server" Number="0" NumberType="Integer" />
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="End task (index)">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                            <dx:ASPxSpinEdit ID="endTaskEdit" ClientInstanceName="endTaskEdit" runat="server" Number="10" NumberType="Integer" />
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="Start date">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                              <dx:ASPxDateEdit ID="startDateEdit" ClientInstanceName="startDateEdit" runat="server" EditFormat="Custom" EditFormatString="MM/dd/yyyy">
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
                                                <dx:LayoutItem Caption="End date">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer>
                                                              <dx:ASPxDateEdit ID="endDateEdit" ClientInstanceName="endDateEdit" runat="server" EditFormat="Custom" EditFormatString="MM/dd/yyyy" >
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
                                            </Items>
                                        </dx:LayoutGroup>
                                        <dx:LayoutGroup Caption="" GroupBoxDecoration="HeadingLine" Paddings-Padding="0" >
                                            <GroupBoxStyle CssClass="clearMarginTop" />
                                            <Items>                                        
                                                <dx:LayoutItem CssClass="clearPaddings" ShowCaption="False" HorizontalAlign="Right" >
                                                    <LayoutItemNestedControlCollection> 
                                                        <dx:LayoutItemNestedControlContainer >
                                                            <dx:ASPxButton ID="applyBtn" AutoPostBack="false" runat="server"  Text="Apply" Width="100" CssClass="submitButton" ClientSideEvents-Click="applyBtnClick" />
                                                            <dx:ASPxButton ID="cancelBtn" AutoPostBack="false" runat="server"  Text="Cancel" Width="100" CssClass="cancelButton" ClientSideEvents-Click="cancelBtnClick"  />
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                    </Items>
                                </dx:LayoutGroup>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <br />
    
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" DataObjectTypeName="Task" TypeName="GanttDataProvider" SelectMethod="GetTasks" UpdateMethod="UpdateTask" InsertMethod="InsertTask" DeleteMethod="DeleteTask" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" DataObjectTypeName="Dependency" TypeName="GanttDataProvider" SelectMethod="GetDependencies" InsertMethod="InsertDependency" DeleteMethod="DeleteDependency" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" DataObjectTypeName="Resource" TypeName="GanttDataProvider" SelectMethod="GetResources" UpdateMethod="UpdateResource" InsertMethod="InsertResource" DeleteMethod="DeleteResource" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" DataObjectTypeName="ResourceAssignment" TypeName="GanttDataProvider" SelectMethod="GetResourceAssignments" InsertMethod="InsertResourceAssignment" DeleteMethod="DeleteResourceAssignment"  />
</asp:Content>

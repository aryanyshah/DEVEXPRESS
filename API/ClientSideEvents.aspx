<%@ Page Language="C#" MasterPageFile="~/Site.master"  AutoEventWireup="true" CodeFile="ClientSideEvents.aspx.cs" Inherits="Data_ClientSideEvents" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <script type="text/javascript">
        function onGanttStartEdit(s, e) {
            e.cancel = cbStartCellEditing.GetChecked();
            DXEventMonitor.Trace(s, e, 'StartCellEditing');
        }
        function onGanttEndEdit(s, e) {
            e.cancel = cbEndCellEditing.GetChecked();
            DXEventMonitor.Trace(s, e, 'EndCellEditing');
        }
        function onGanttTaskInsert(s, e) {
            e.cancel = cbTaskInserting.GetChecked();
            if(cbNewTaskText.GetChecked())
                e.values["Subject"] = "Custom text";
            DXEventMonitor.Trace(s, e, 'TaskInserting');
        }
        function onGanttTaskInserted(s, e) {
            DXEventMonitor.Trace(s, e, 'TaskInserted');
        }
        function onGanttTaskDelete(s, e) {
            e.cancel = cbTaskDeleting.GetChecked();
            DXEventMonitor.Trace(s, e, 'TaskDeleting');
        }
        function onGanttTaskDeleted(s, e) {
            DXEventMonitor.Trace(s, e, 'TaskDeleted');
        }
        function onGanttTaskUpdate(s, e) {
            e.cancel = cbTaskUpdating.GetChecked();
            if(cbUpdatedTaskText.GetChecked())
                e.newValues["Subject"] = "Modified text";
            DXEventMonitor.Trace(s, e, 'TaskUpdating');
        }
        function onGanttTaskUpdated(s, e) {
            DXEventMonitor.Trace(s, e, 'TaskUpdated');
        }
        function onGanttTaskMove(s, e) {
            e.cancel = cbTaskMoving.GetChecked();
            DXEventMonitor.Trace(s, e, 'TaskMoving');
        }
        function onGanttTaskFocusing(s, e) {
            e.cancel = cbTaskFocusing.GetChecked();
            DXEventMonitor.Trace(s, e, 'TaskFocusing');
        }
        function onGanttFocusedTaskChanged(s, e) {
            DXEventMonitor.Trace(s, e, 'FocusedTaskChanged');
        }
        function onGanttTaskEditDialog(s, e) {
            e.cancel = cbTaskEditDialog.GetChecked();
            if(cbCustomizeTaskDialog.GetChecked()) {
                e.values["Subject"]= "Custom dialog text";
                e.readOnlyFields.push("Subject");
                e.hiddenFields.push("PercentComplete");
            }
            DXEventMonitor.Trace(s, e, 'TaskEditDialogShowing');
        }
        function onGanttResourceManagerDialogShowing(s, e) {
            e.cancel = cbResourceManagerDialog.GetChecked();
            DXEventMonitor.Trace(s, e, 'ResourceManagerDialogShowing');
        }
        function onGanttTaskClick(s, e) {
            e.cancel = cbTaskClick.GetChecked();
            DXEventMonitor.Trace(s, e, 'TaskClick')
        }
        function onGanttTaskDblClick(s, e) {
            e.cancel = cbTaskDblClick.GetChecked();
            DXEventMonitor.Trace(s, e, 'TaskDblClick')
        }
        function onGanttContextMenu(s, e) {
            e.cancel = cbTaskContextMenu.GetChecked();
            DXEventMonitor.Trace(s, e, 'ContextMenu')
        }
        function onGanttDependencyInsert(s, e) {
            e.cancel = cbDependencyInserting.GetChecked();
            DXEventMonitor.Trace(s, e, 'DependencyInserting')
        }
        function onGanttDependencyInserted(s, e) {
            DXEventMonitor.Trace(s, e, 'DependencyInserted')
        }
        function onGanttDependencyDelete(s, e) {
            e.cancel = cbDependencyDeleting.GetChecked();
            DXEventMonitor.Trace(s, e, 'DependencyDeleting')
        }
        function onGanttDependencyDeleted(s, e) {
            DXEventMonitor.Trace(s, e, 'DependencyDeleted')
        }
        function onGanttResourceInsert(s, e) {
            e.cancel = cbResourceInserting.GetChecked();
            if(cbNewResourceText.GetChecked())
                e.values["Name"] = "Custom resource";
            DXEventMonitor.Trace(s, e, 'ResourceInserting')
        }
        function onGanttResourceInserted(s, e) {
            DXEventMonitor.Trace(s, e, 'ResourceInserted')
        }
        function onGanttResourceDelete(s, e) {
            e.cancel = cbResourceDeleting.GetChecked();
            DXEventMonitor.Trace(s, e, 'ResourceDeleting')
        }        
        function onGanttResourceDeleted(s, e) {
            DXEventMonitor.Trace(s, e, 'ResourceDeleted')
        }
        function onGanttResourceAssign(s, e) {
            e.cancel = cbResourceAssigning.GetChecked();
            DXEventMonitor.Trace(s, e, 'ResourceAssigning')
        }
        function onGanttResourceAssigned(s, e) {
            DXEventMonitor.Trace(s, e, 'ResourceAssigned')
        }
        function onGanttResourceUnassign(s, e) {
            e.cancel = cbResourceUnassigning.GetChecked();
            DXEventMonitor.Trace(s, e, 'ResourceUnassigning')
        }
        function onGanttResourceUnassigned(s, e) {
            DXEventMonitor.Trace(s, e, 'ResourceUnassigned')
        }
        function onSelectAll(s, e) {
            cbStartCellEditing.SetValue(s.GetChecked());
            cbEndCellEditing.SetValue(s.GetChecked());
            cbTaskInserting.SetValue(s.GetChecked());
            cbTaskDeleting.SetValue(s.GetChecked());
            cbTaskUpdating.SetValue(s.GetChecked());
            cbTaskMoving.SetValue(s.GetChecked());
            cbTaskFocusing.SetValue(s.GetChecked());
            cbTaskEditDialog.SetValue(s.GetChecked());
            cbTaskClick.SetValue(s.GetChecked());
            cbTaskDblClick.SetValue(s.GetChecked());
            cbTaskContextMenu.SetValue(s.GetChecked());
            cbNewTaskText.SetValue(s.GetChecked());
            cbUpdatedTaskText.SetValue(s.GetChecked());
            cbCustomizeTaskDialog.SetValue(s.GetChecked());
            cbDependencyInserting.SetValue(s.GetChecked());
            cbDependencyDeleting.SetValue(s.GetChecked());
            cbResourceInserting.SetValue(s.GetChecked());
            cbResourceDeleting.SetValue(s.GetChecked());
            cbResourceAssigning.SetValue(s.GetChecked());
            cbResourceUnassigning.SetValue(s.GetChecked());
            cbNewResourceText.SetValue(s.GetChecked());
            cbResourceManagerDialog.SetValue(s.GetChecked());
        }
        function CustomCommand(s, e) {
            if(e.commandName == "Settings") {
                SettingsPopup.ShowAtElement(clientGantt.GetMainElement());
            }
        }
        window.addEventListener('load', function(e) {
                var ganttMainEl = clientGantt.GetMainElement();
                updateLogAreaWidth(ganttMainEl.clientWidth);
                window.addEventListener('resize', function(e) {
                    updateLogAreaWidth(ganttMainEl.clientWidth);
                });
        });
        function updateLogAreaWidth(ganttWidth) {
            var logElement = document.getElementById("EventLog");
            if(logElement) {
                newWidth = ganttWidth - 12;
                logElement.style.width = newWidth + "px";
            }
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" EnableViewState="false"
        TasksDataSourceID="TasksDataSource" 
        DependenciesDataSourceID="DependenciesDataSource" 
        ResourcesDataSourceID="ResourcesDataSource" 
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <SettingsTaskList Width="45%">
            <Columns>
                <dx:GanttTextColumn FieldName="Subject" Caption="Title" Width="360" />
                <dx:GanttDateTimeColumn FieldName="StartDate" Caption="Start Date" Width="100" />
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
        <ClientSideEvents 
            StartCellEditing="onGanttStartEdit" 
            EndCellEditing="onGanttEndEdit" 
            TaskInserting="onGanttTaskInsert" 
            TaskInserted="onGanttTaskInserted" 
            TaskDeleting="onGanttTaskDelete"
            TaskDeleted="onGanttTaskDeleted"
            TaskUpdating="onGanttTaskUpdate"
            TaskUpdated="onGanttTaskUpdated"
            TaskMoving="onGanttTaskMove"
            TaskEditDialogShowing="onGanttTaskEditDialog"
            ResourceManagerDialogShowing="onGanttResourceManagerDialogShowing"
            FocusedTaskChanging="onGanttTaskFocusing"
            FocusedTaskChanged= "onGanttFocusedTaskChanged"
            DependencyInserting="onGanttDependencyInsert" 
            DependencyInserted="onGanttDependencyInserted" 
            DependencyDeleting="onGanttDependencyDelete"
            DependencyDeleted="onGanttDependencyDeleted"
            ResourceInserting="onGanttResourceInsert" 
            ResourceInserted="onGanttResourceInserted" 
            ResourceDeleting="onGanttResourceDelete"
            ResourceDeleted="onGanttResourceDeleted"
            ResourceAssigning="onGanttResourceAssign"
            ResourceAssigned="onGanttResourceAssigned"
            ResourceUnassigning="onGanttResourceUnassign"
            ResourceUnassigned="onGanttResourceUnassigned"
            TaskClick="onGanttTaskClick"
            TaskDblClick="onGanttTaskDblClick"
            ContextMenu="onGanttContextMenu" 
            CustomCommand="CustomCommand"
            />
            <SettingsToolbar >
                <Items>
                    <dx:GanttUndoToolbarItem />
                    <dx:GanttRedoToolbarItem />
                    <dx:GanttAddTaskToolbarItem />
                    <dx:GanttRemoveTaskToolbarItem />
                    <dx:GanttZoomInToolbarItem />
                    <dx:GanttZoomOutToolbarItem />
                    <dx:GanttCustomToolbarItem CommandName="Settings" BeginGroup="true" >
                        <Image Height="16px" Width="16px" Url="../Content/swt.svg" />
                    </dx:GanttCustomToolbarItem>
                </Items>
            </SettingsToolbar>
    </dx:ASPxGantt>
    
    <dx:ASPxPopupControl ID="SettingsPopup" runat="server" ClientInstanceName="SettingsPopup" Modal="False" MaxHeight="700px"
        ShowHeader="false" ShowFooter="false" PopupVerticalAlign="TopSides" PopupHorizontalAlign="RightSides" CloseOnEscape="true" ScrollBars="Vertical" >
        <ContentCollection>
            <dx:PopupControlContentControl>
                <dx:ASPxFormLayout runat="server" ID="OptionsFormLayout" UseDefaultPaddings="false"  >
                    <Styles>
                        <LayoutGroup Cell-Paddings-Padding="0" />
                        <LayoutGroupBox Caption-Paddings-Padding="0" />
                    </Styles>
                    <Items>            
                        <dx:LayoutGroup ShowCaption="False" VerticalAlign="Top" Paddings-Padding="0" >
                            <Items>            
                                <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="HeadingLine">
                                    <Items>
                                        <dx:LayoutItem Caption="Select All"  >
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbSelectAll" ClientInstanceName="cbSelectAll" runat="server" AutoPostBack="false" ClientSideEvents-CheckedChanged="onSelectAll" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Task events" GroupBoxDecoration="HeadingLine">
                                    <Items>                    
                                        <dx:LayoutItem Caption="Prevent start cell editing" >
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbStartCellEditing" ClientInstanceName="cbStartCellEditing" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent end cell editing">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbEndCellEditing" ClientInstanceName="cbEndCellEditing" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task inserting">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskInserting" ClientInstanceName="cbTaskInserting" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task deleting">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskDeleting" ClientInstanceName="cbTaskDeleting" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task updating">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskUpdating" ClientInstanceName="cbTaskUpdating" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task moving">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskMoving" ClientInstanceName="cbTaskMoving" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task focusing">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskFocusing" ClientInstanceName="cbTaskFocusing" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task edit dialog show">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskEditDialog" ClientInstanceName="cbTaskEditDialog" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task click">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskClick" ClientInstanceName="cbTaskClick" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task double click">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskDblClick" ClientInstanceName="cbTaskDblClick" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent task context menu">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbTaskContextMenu" ClientInstanceName="cbTaskContextMenu" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Modify new task text">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbNewTaskText" ClientInstanceName="cbNewTaskText" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Modify updated task text">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbUpdatedTaskText" ClientInstanceName="cbUpdatedTaskText" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Customize task edit dialog">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbCustomizeTaskDialog" ClientInstanceName="cbCustomizeTaskDialog" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                    
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Dependency events" GroupBoxDecoration="HeadingLine">
                                    <Items>
                                        <dx:LayoutItem Caption="Prevent dependency inserting">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbDependencyInserting" ClientInstanceName="cbDependencyInserting" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent dependency deleting">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbDependencyDeleting" ClientInstanceName="cbDependencyDeleting" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                    </Items>
                                </dx:LayoutGroup>
                                <dx:LayoutGroup Caption="Resource events" GroupBoxDecoration="HeadingLine">
                                    <Items>                    
                                        <dx:LayoutItem Caption="Prevent resource inserting">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbResourceInserting" ClientInstanceName="cbResourceInserting" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent resource deleting">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbResourceDeleting" ClientInstanceName="cbResourceDeleting" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent resource assigning">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbResourceAssigning" ClientInstanceName="cbResourceAssigning" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent resource unassigning">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbResourceUnassigning" ClientInstanceName="cbResourceUnassigning" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Modify new resource text">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbNewResourceText" ClientInstanceName="cbNewResourceText" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
                                        <dx:LayoutItem Caption="Prevent resource manager dialog show">
                                            <LayoutItemNestedControlCollection>
                                                <dx:LayoutItemNestedControlContainer>
                                                    <dx:ASPxCheckBox ID="cbResourceManagerDialog" ClientInstanceName="cbResourceManagerDialog" runat="server" AutoPostBack="false" />
                                                </dx:LayoutItemNestedControlContainer>
                                            </LayoutItemNestedControlCollection>
                                        </dx:LayoutItem>
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
    <dx:EventMonitor runat="server" EnableTheming="true" ID="EventMonitor" EventNames="StartCellEditing, EndCellEditing, TaskInserting, TaskInserted, TaskDeleting, TaskDeleted, TaskMoving, TaskFocusing, FocusedTaskChanged, TaskEditDialogShowing, TaskUpdating, TaskUpdated, TaskClick, TaskDblClick, ContextMenu, DependencyInserting, DependencyInserted, DependencyDeleting, DependencyDeleted, ResourceInserting, ResourceInserted, ResourceDeleting, ResourceDeleted, ResourceAssigning, ResourceAssigned, ResourceUnassigning, ResourceUnassigned, ResourceManagerDialogShowing" EventLogHeight="280" EventLogWidth="280"  ShowEventListPanel="false"/>        
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" DataObjectTypeName="Task" TypeName="GanttDataProvider" SelectMethod="GetTasks" UpdateMethod="UpdateTask" InsertMethod="InsertTask" DeleteMethod="DeleteTask" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" DataObjectTypeName="Dependency" TypeName="GanttDataProvider" SelectMethod="GetDependencies" InsertMethod="InsertDependency" DeleteMethod="DeleteDependency" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" DataObjectTypeName="Resource" TypeName="GanttDataProvider" SelectMethod="GetResources" UpdateMethod="UpdateResource" InsertMethod="InsertResource" DeleteMethod="DeleteResource" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" DataObjectTypeName="ResourceAssignment" TypeName="GanttDataProvider" SelectMethod="GetResourceAssignments" InsertMethod="InsertResourceAssignment" DeleteMethod="DeleteResourceAssignment"  />
</asp:Content>
<asp:Content ContentPlaceHolderID="ControlOptionsHolder" runat="server">
</asp:Content>

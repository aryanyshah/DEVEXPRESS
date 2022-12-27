<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TaskTemplate.aspx.cs" Inherits="Gantt_TaskTemplate" %>
<asp:Content runat="server" ContentPlaceHolderID="CustomHeadHolder">
    <link rel="stylesheet" type="text/css" href="Css/TaskTemplate.css">
    <script type="text/javascript">
        <%--start highlighted block--%>
        function onShowTask(s, e) {
            var resource = e.item.taskResources[0];
            var img = getImagePath(e.item.taskData["ID"]);
            var color = e.item.taskData["ID"] % 6;
            var customContainer = document.createElement("div");
            customContainer.classList.add("custom-task");
            customContainer.setAttribute("style", "width:" + e.item.taskSize.width + "px;");
            customContainer.classList.add("custom-task-color-" + color);
            var imgWrapper = document.createElement("div");
            imgWrapper.setAttribute("class", "custom-task-img-wrapper");
            customContainer.appendChild(imgWrapper);
            var imgContainer = document.createElement("img");
            imgContainer.setAttribute("class", "custom-task-img");
            imgContainer.setAttribute("src", img);
            imgContainer.setAttribute("alt", resource.text);
            imgWrapper.appendChild(imgContainer);
            var wrapper = document.createElement("div");
            wrapper.setAttribute("class", "custom-task-wrapper");
            customContainer.appendChild(wrapper);
            var taskTitle = document.createElement("div");
            taskTitle.setAttribute("class", "custom-task-title");
            taskTitle.textContent = e.item.taskData["Subject"];
            wrapper.appendChild(taskTitle);
            var taskResource = document.createElement("div");
            taskResource.setAttribute("class", "custom-task-row");
            taskResource.textContent = resource.text;
            wrapper.appendChild(taskResource);
            var taskProgress = document.createElement("div");
            taskProgress.setAttribute("class", "custom-task-progress");
            taskProgress.setAttribute("style", "width:" + (parseFloat(e.item.taskData["PercentComplete"])) + "%;");
            customContainer.appendChild(taskProgress);
            e.container.appendChild(customContainer);
        }
        <%--end highlighted block--%>
        function getImagePath(taskId) {
            var imgPath = getBasePath() + "/Content/images/employees/";
            var img = taskId < 10 ? "0" + taskId : taskId;
            img = imgPath + img + ".jpg";
            return img;
        }
        function getBasePath() {
            return window.location.href.split('/').slice(0, -2).join('/');
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentHolder" runat="server">
    <dx:ASPxGantt ID="Gantt" runat="server" Height="700" Width="100%" ClientInstanceName="clientGantt" 
        TasksDataSourceID="TasksDataSource" 
        DependenciesDataSourceID="DependenciesDataSource" 
        ResourcesDataSourceID="ResourcesDataSource" 
        ResourceAssignmentsDataSourceID="ResourceAssignmentsDataSource">
        <ClientSideEvents TaskShowing="onShowTask"/>
        <SettingsEditing Enabled="false" />
        <SettingsToolbar Visible="false" />
        <SettingsGanttView ViewType="Days" />
        <SettingsTaskList Width="40%">
            <Columns>
                <dx:GanttTextColumn FieldName="Subject" Caption="Title" Width="360"/>
                <dx:GanttDateTimeColumn FieldName="StartDate" Caption="Start Date" DisplayFormat="MM\/dd\/yyyy" Width="100"/>
                <dx:GanttDateTimeColumn FieldName="EndDate" Caption="Due Date" DisplayFormat="MM\/dd\/yyyy" Width="100"/>
            </Columns>
        </SettingsTaskList>
        <Mappings>
            <Task Key="ID" ParentKey="ParentID" Title="Subject" Start="StartDate" End="EndDate" Progress="PercentComplete" />
            <Dependency Key="ID" PredecessorKey="ParentID" SuccessorKey="DependentID" DependencyType="Type" />
            <Resource Key="ID" Name="Name" />
            <ResourceAssignment Key="ID" TaskKey="TaskID" ResourceKey="ResourceID" />
        </Mappings>
    </dx:ASPxGantt>
    <asp:ObjectDataSource ID="TasksDataSource" runat="server" SelectMethod="GetTasks" TypeName="RequirementsDataProvider" />
    <asp:ObjectDataSource ID="DependenciesDataSource" runat="server" SelectMethod="GetDependencies" TypeName="RequirementsDataProvider" />
    <asp:ObjectDataSource ID="ResourcesDataSource" runat="server" SelectMethod="GetResources" TypeName="RequirementsDataProvider" />
    <asp:ObjectDataSource ID="ResourceAssignmentsDataSource" runat="server" SelectMethod="GetResourceAssignments" TypeName="RequirementsDataProvider" />
</asp:Content>

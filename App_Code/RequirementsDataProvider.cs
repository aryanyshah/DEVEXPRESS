using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

public static class RequirementsDataProvider {
    const string
        RequirementsTasksSessionKey = "DX_Requirements_Tasks",
        RequirementsDependenciesSessionKey = "DX_Requirements_Dependencies",
        RequirementsResourcesSessionKey = "DX_Requirements_Resources",
        RequirementsResourceAssignmentsSessionKey = "DX_Requirements_ResourceAssignments";

    static HttpSessionState Session { get { return HttpContext.Current.Session; } }

    public static object GetTasks() { return Tasks; }
    public static object GetDependencies() { return Dependencies; }
    public static object GetResources() { return Resources; }
    public static object GetResourceAssignments() { return ResourceAssignments; }


    public static List<Task> Tasks {
        get {
            if(Session[RequirementsTasksSessionKey] == null)
                Session[RequirementsTasksSessionKey] = CreateTasks();
            return (List<Task>)Session[RequirementsTasksSessionKey];
        }
    }
    public static List<Dependency> Dependencies {
        get {
            if(Session[RequirementsDependenciesSessionKey] == null)
                Session[RequirementsDependenciesSessionKey] = CreateDependencies();
            return (List<Dependency>)Session[RequirementsDependenciesSessionKey];
        }
    }
    public static List<Resource> Resources {
        get {
            if(Session[RequirementsResourcesSessionKey] == null)
                Session[RequirementsResourcesSessionKey] = CreateResources();
            return (List<Resource>)Session[RequirementsResourcesSessionKey];
        }
    }
    public static List<ResourceAssignment> ResourceAssignments {
        get {
            if(Session[RequirementsResourceAssignmentsSessionKey] == null)
                Session[RequirementsResourceAssignmentsSessionKey] = CreateResourceAssignments();
            return (List<ResourceAssignment>)Session[RequirementsResourceAssignmentsSessionKey];
        }
    }

    static List<Task> CreateTasks() {
        var result = new List<Task>();
        var currentYear = DateTime.Now.Year;
        var currentMonth = DateTime.Now.Month;

        result.Add(CreateTask("1", "", "Analysis/Software Requirements", new DateTime(currentYear, currentMonth, 1),  new DateTime(currentYear, currentMonth, 28), 31));

        result.Add(CreateTask("2", "1", "Conduct needs analysis", new DateTime(currentYear, currentMonth, 1),  new DateTime(currentYear, currentMonth, 3), 15));
        result.Add(CreateTask("3", "1", "Draft preliminary software specifications", new DateTime(currentYear, currentMonth, 3),  new DateTime(currentYear, currentMonth, 5), 30));
        result.Add(CreateTask("4", "1", "Review software specifications/budget with team", new DateTime(currentYear, currentMonth, 4),  new DateTime(currentYear, currentMonth, 6), 60));
        result.Add(CreateTask("5", "1", "Incorporate feedback on software specifications", new DateTime(currentYear, currentMonth, 6),  new DateTime(currentYear, currentMonth, 8), 45));

        result.Add(CreateTask("6", "1", "Develop delivery timeline", new DateTime(currentYear, currentMonth, 8),  new DateTime(currentYear, currentMonth, 14), 0));
        result.Add(CreateTask("7", "1", "Obtain approvals to proceed (concept, timeline, budget)", new DateTime(currentYear, currentMonth, 14),  new DateTime(currentYear, currentMonth, 20), 0));
        result.Add(CreateTask("8", "1", "Draft preliminary software specifications", new DateTime(currentYear, currentMonth, 20),  new DateTime(currentYear, currentMonth, 25), 0));
        result.Add(CreateTask("9", "1", "Secure required resources", new DateTime(currentYear, currentMonth, 25),  new DateTime(currentYear, currentMonth, 28), 0));


        return result;
    }
    public static Task CreateTask(string id, string parentid, string subject, DateTime start, DateTime end, int progress) {
        var task = new Task();
        task.ID = id;
        task.ParentID = parentid;
        task.Subject = subject;
        task.StartDate = start;
        task.EndDate = end;
        task.PercentComplete = progress;
        return task;
    }
    static List<Dependency> CreateDependencies() {
        var result = new List<Dependency>();
        result.Add(new Dependency() { ID = "1", Type = 0, ParentID = "2", DependentID = "3" });
        result.Add(new Dependency() { ID = "2", Type = 0, ParentID = "3", DependentID = "4" });
        result.Add(new Dependency() { ID = "3", Type = 0, ParentID = "4", DependentID = "5" });
        result.Add(new Dependency() { ID = "4", Type = 0, ParentID = "5", DependentID = "6" });
        result.Add(new Dependency() { ID = "5", Type = 0, ParentID = "6", DependentID = "7" });
        result.Add(new Dependency() { ID = "6", Type = 0, ParentID = "7", DependentID = "8" });
        result.Add(new Dependency() { ID = "7", Type = 0, ParentID = "8", DependentID = "9" });
        return result;
    }

    static List<Resource> CreateResources() {
        var result = new List<Resource>();
        result.Add(new Resource() { ID = "1", Name = "John Heart" });
        result.Add(new Resource() { ID = "2", Name = "Paul Peyton" });
        result.Add(new Resource() { ID = "3", Name = "Robert Reagan" });
        result.Add(new Resource() { ID = "4", Name = "Greta Sims" });
        result.Add(new Resource() { ID = "5", Name = "Brett Wade" });
        result.Add(new Resource() { ID = "6", Name = "Sandra Johnson" });
        result.Add(new Resource() { ID = "7", Name = "Kevin Carter" });
        result.Add(new Resource() { ID = "8", Name = "Cynthia Stanwick" });
        result.Add(new Resource() { ID = "9", Name = "Olivia Samuelson" });

        return result;
    }

    static List<ResourceAssignment> CreateResourceAssignments() {
        var result = new List<ResourceAssignment>();
        result.Add(new ResourceAssignment() { ID = "1", TaskID = "1", ResourceID = "1" });
        result.Add(new ResourceAssignment() { ID = "2", TaskID = "2", ResourceID = "2" });
        result.Add(new ResourceAssignment() { ID = "3", TaskID = "3", ResourceID = "3" });
        result.Add(new ResourceAssignment() { ID = "4", TaskID = "4", ResourceID = "4" });
        result.Add(new ResourceAssignment() { ID = "5", TaskID = "5", ResourceID = "5" });
        result.Add(new ResourceAssignment() { ID = "6", TaskID = "6", ResourceID = "6" });
        result.Add(new ResourceAssignment() { ID = "7", TaskID = "7", ResourceID = "7" });
        result.Add(new ResourceAssignment() { ID = "8", TaskID = "8", ResourceID = "8" });
        result.Add(new ResourceAssignment() { ID = "9", TaskID = "9", ResourceID = "9" });

        return result;

    }
}

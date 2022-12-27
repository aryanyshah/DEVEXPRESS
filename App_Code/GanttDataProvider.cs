using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

public static class GanttDataProvider {
    const string
        TasksSessionKey = "Tasks",
        DependenciesSessionKey = "Dependencies",
        ResourcesSessionKey = "Resources",
        ResourceAssignmentsSessionKey = "ResourceAssignments";

    static HttpSessionState Session { get { return HttpContext.Current.Session; } }

    public static object GetTasks() { return Tasks; }
    public static object GetDependencies() { return Dependencies; }
    public static object GetResources() { return Resources; }
    public static object GetResourceAssignments() { return ResourceAssignments; }

    public static List<Task> Tasks {
        get {
            if(Session[TasksSessionKey] == null)
                Session[TasksSessionKey] = CreateTasks();
            return (List<Task>)Session[TasksSessionKey];
        }
    }
    public static List<Dependency> Dependencies {
        get {
            if(Session[DependenciesSessionKey] == null)
                Session[DependenciesSessionKey] = CreateDependencies();
            return (List<Dependency>)Session[DependenciesSessionKey];
        }
    }
    public static List<Resource> Resources {
        get {
            if(Session[ResourcesSessionKey] == null)
                Session[ResourcesSessionKey] = CreateResources();
            return (List<Resource>)Session[ResourcesSessionKey];
        }
    }
    public static List<ResourceAssignment> ResourceAssignments {
        get {
            if(Session[ResourceAssignmentsSessionKey] == null)
                Session[ResourceAssignmentsSessionKey] = CreateResourceAssignments();
            return (List<ResourceAssignment>)Session[ResourceAssignmentsSessionKey];
        }
    }

    static List<Task> CreateTasks() {
        var result = new List<Task>();
        int year = DateTime.Now.Year;
        result.Add(CreateTask("0", "", "Aryan shah", new DateTime(year, 2, 21, 8, 1, 0), new DateTime(year, 7, 4, 15, 1, 0), 31));
        result.Add(CreateTask("1", "", "Scope", new DateTime(year, 2, 21, 8, 0, 0), new DateTime(year, 2, 26, 12, 0, 0), 60));
        result.Add(CreateTask("2", "1", "Determine project scope", new DateTime(year, 2, 21, 8, 0, 0), new DateTime(year, 2, 21, 12, 0, 0), 100));
        result.Add(CreateTask("3", "1", "Secure project sponsorship", new DateTime(year, 2, 21, 13, 0, 0), new DateTime(year, 2, 22, 12, 0, 0), 100));
        result.Add(CreateTask("4", "1", "Define preliminary resources", new DateTime(year, 2, 22, 13, 0, 0), new DateTime(year, 2, 25, 12, 0, 0), 60));
        result.Add(CreateTask("5", "1", "Secure core resources", new DateTime(year, 2, 25, 13, 0, 0), new DateTime(year, 2, 26, 12, 0, 0), 0));
        result.Add(CreateTask("6", "1", "Scope complete", new DateTime(year, 2, 26, 12, 0, 0), new DateTime(year, 2, 26, 12, 0, 0), 0));
        result.Add(CreateTask("7", "0", "Analysis/Software Requirements", new DateTime(year, 2, 26, 13, 0, 0), new DateTime(year, 3, 18, 12, 0, 0), 80));
        result.Add(CreateTask("8", "7", "Conduct needs analysis", new DateTime(year, 2, 26, 13, 0, 0), new DateTime(year, 3, 5, 12, 0, 0), 100));
        result.Add(CreateTask("9", "7", "Draft preliminary software specifications", new DateTime(year, 3, 5, 13, 0, 0), new DateTime(year, 3, 8, 12, 0, 0), 100));
        result.Add(CreateTask("10", "7", "Develop preliminary budget", new DateTime(year, 3, 8, 13, 0, 0), new DateTime(year, 3, 12, 12, 0, 0), 100));

        return result;
    }
    public static Task CreateTask(string id, string parentid, string subject, DateTime start, DateTime end, int percent) {
        var task = new Task();
        task.ID = id;
        task.ParentID = parentid;
        task.Subject = subject;
        task.StartDate = start;
        task.EndDate = end;
        task.PercentComplete = percent;
        
        return task;
    }
    static List<Dependency> CreateDependencies() {
        var result = new List<Dependency>();
        for(int i = 0; i < Tasks.Count; i++) {
            Task task = Tasks[i];
            if(!string.IsNullOrEmpty(task.ParentID)) {
                result.Add(new Dependency() { ID = CreateUniqueId(), Type = 0, ParentID = Tasks[i - 1].ID, DependentID = task.ID });
            }
        }
        return result;
    }
    static List<Resource> CreateResources()
    {
        var result = new List<Resource>();
        result.Add(new Resource() { ID = "1", Name = "Management" });
        result.Add(new Resource() { ID = "2", Name = "Project Manager" });
        result.Add(new Resource() { ID = "3", Name = "Analyst" });
        result.Add(new Resource() { ID = "4", Name = "Developer" });
        result.Add(new Resource() { ID = "5", Name = "Testers" });
        result.Add(new Resource() { ID = "6", Name = "Trainers" });
        result.Add(new Resource() { ID = "7", Name = "Technical Communicators" });
        result.Add(new Resource() { ID = "8", Name = "Deployment Team" });                 

        return result;
    }
    static List<ResourceAssignment> CreateResourceAssignments() {
        var result = new List<ResourceAssignment>();        
        foreach(Task task in Tasks) {
            if(!string.IsNullOrEmpty(task.Employees)) {
                string[] empIDs = task.Employees.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                for(int i = 0; i < empIDs.Length; i++)
                    result.Add(new ResourceAssignment() { ID = CreateUniqueId(), TaskID = task.ID, ResourceID = empIDs[i] });
            }
        }
        return result;
    }

       public static void UpdateTask(Task task) {
            Task item = Tasks.FirstOrDefault(c => c.ID.Equals(task.ID));
            item.ParentID = task.ParentID;
            item.PercentComplete = task.PercentComplete;
            item.StartDate= task.StartDate;
            item.EndDate= task.EndDate;
            item.Subject = task.Subject;       
        }

        public static string InsertTask(Task task) {
            task.ID = CreateUniqueId();
            Tasks.Add(task);
            return task.ID;            
        }
        public static void DeleteTask(Task task) {
            var taskToDelete = Tasks.FirstOrDefault(t => t.ID.Equals(task.ID));
            if(taskToDelete != null)
                Tasks.Remove(taskToDelete);
        }
        public static void DeleteTaskByKey(string key) {
            var taskToDelete = Tasks.FirstOrDefault(t => t.ID.Equals(key));
            if(taskToDelete != null)
                Tasks.Remove(taskToDelete);
        }

        public static string InsertDependency(Dependency dependency) {
            dependency.ID = CreateUniqueId();
            Dependencies.Add(dependency);
            return dependency.ID;            
        }
        public static void DeleteDependency(Dependency dependency) {
            var dependencyToDelete = Dependencies.FirstOrDefault(t => t.ID.Equals(dependency.ID));
            if(dependencyToDelete != null)
                Dependencies.Remove(dependencyToDelete);
        }
        public static void DeleteDependencyByKey(string key) {
            var dependencyToDelete = Dependencies.FirstOrDefault(t => t.ID.Equals(key));
            if(dependencyToDelete != null)
                Dependencies.Remove(dependencyToDelete);
        }

        public static void UpdateResource(Resource resource) {
            Resource item = Resources.FirstOrDefault(c => c.ID.Equals(resource.ID));
            item.Name = resource.Name;
        }

        public static string InsertResource(Resource resource) {
            resource.ID = CreateUniqueId();
            Resources.Add(resource);
            return resource.ID;            
        }
        public static void DeleteResource(Resource resource) {
            var resourceToDelete = Resources.FirstOrDefault(t => t.ID.Equals(resource.ID));
            if(resourceToDelete != null)
                Resources.Remove(resourceToDelete);
        }

        public static void DeleteResourceByKey(string key) {
            var resourceToDelete = Resources.FirstOrDefault(t => t.ID.Equals(key));
            if(resourceToDelete != null)
                Resources.Remove(resourceToDelete);
        }

        public static string InsertResourceAssignment(ResourceAssignment resourceAssignment) {
            resourceAssignment.ID = CreateUniqueId();
            ResourceAssignments.Add(resourceAssignment);
            return resourceAssignment.ID;            
        }
        public static void DeleteResourceAssignment(ResourceAssignment resourceAssignment) {
            var itemToDelete = ResourceAssignments.FirstOrDefault(t => t.ID.Equals(resourceAssignment.ID));
            if(itemToDelete != null)
                ResourceAssignments.Remove(itemToDelete);
        }

        public static void DeleteResourceAssignmentByKey(string key) {
            var itemToDelete = ResourceAssignments.FirstOrDefault(t => t.ID.Equals(key));
            if(itemToDelete != null)
                ResourceAssignments.Remove(itemToDelete);
        }

        static string CreateUniqueId() { return Guid.NewGuid().ToString(); }
}


public class Task {
    public string ID { get; set; }
    public string ParentID { get; set; }
    public string Subject { get; set; }
    public string Description { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public int PercentComplete { get; set; }
    public string Employees { get; set; }
}
public class Dependency
{
    public string ID { get; set; }
    public string ParentID { get; set; }
    public string DependentID { get; set; }
    public int Type { get; set; }
}
public class Resource {
    public string ID { get; set; }
    public string Name { get; set; }
}
public class ResourceAssignment {
    public string ID { get; set; }
    public string TaskID { get; set; }
    public string ResourceID { get; set; }

}

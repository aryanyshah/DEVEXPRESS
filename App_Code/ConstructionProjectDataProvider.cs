using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

public static class ConstructionProjectDataProvider
{
    const string
        ProjectTasksSessionKey = "DX_Project_Tasks",
        ProjectDependenciesSessionKey = "DX_Project_Dependencies";

    static HttpSessionState Session { get { return HttpContext.Current.Session; } }

    public static object GetTasks() { return Tasks; }
    public static object GetDependencies() { return Dependencies; }
    
    public static List<Task> Tasks {
        get {
            if(Session[ProjectTasksSessionKey] == null)
                Session[ProjectTasksSessionKey] = CreateTasks();
            return (List<Task>)Session[ProjectTasksSessionKey];
        }
    }
    public static List<Dependency> Dependencies {
        get {
            if(Session[ProjectDependenciesSessionKey] == null)
                Session[ProjectDependenciesSessionKey] = CreateDependencies();
            return (List<Dependency>)Session[ProjectDependenciesSessionKey];
        }
    }

    static List<Task> CreateTasks() {
        var result = new List<Task>();
        var currentYear = DateTime.Now.Year;

        result.Add(CreateTask("1", "", "ARYAN SHAH", new DateTime(currentYear, 1, 1),  new DateTime(currentYear, 1, 2), 0));

        result.Add(CreateTask("2", "1", "TASK ID", new DateTime(currentYear, 1, 1),  new DateTime(currentYear, 1, 1), 0));
        result.Add(CreateTask("3", "2", "Architectural Design and Site Planning", new DateTime(currentYear, 1, 1),  new DateTime(currentYear, 1, 15), 0));
        result.Add(CreateTask("4", "2", "Engineering and Final Blueprint", new DateTime(currentYear, 1, 8),  new DateTime(currentYear, 1, 15), 0));
        result.Add(CreateTask("5", "2", "City Permits and Contracts", new DateTime(currentYear, 1, 15),  new DateTime(currentYear, 1, 18), 0));

        result.Add(CreateTask("6", "1", "Construction Phase", new DateTime(currentYear, 1, 18),  new DateTime(currentYear, 1, 18), 0));
        result.Add(CreateTask("7", "6", "Grading and Excavation", new DateTime(currentYear, 1, 18),  new DateTime(currentYear, 1, 22), 0));
        result.Add(CreateTask("8", "6", "Demolition and Removal", new DateTime(currentYear, 1, 19),  new DateTime(currentYear, 1, 23), 0));
        result.Add(CreateTask("9", "6", "Foundation and Concrete", new DateTime(currentYear, 1, 22),  new DateTime(currentYear, 1, 29), 0));
        result.Add(CreateTask("10", "6", "Rough Framing and Carpentery", new DateTime(currentYear, 1, 25),  new DateTime(currentYear, 2, 5), 0));
        result.Add(CreateTask("11", "6", "Inspection (Structure)", new DateTime(currentYear, 2, 5),  new DateTime(currentYear, 2, 5), 0));
        result.Add(CreateTask("12", "6", "Electrical Rough-in", new DateTime(currentYear, 2, 6),  new DateTime(currentYear, 2, 19), 0));
        result.Add(CreateTask("13", "6", "Plumbing Rough-in", new DateTime(currentYear, 2, 19),  new DateTime(currentYear, 2, 19), 0));
        result.Add(CreateTask("14", "6", "Heating and A/C", new DateTime(currentYear, 2, 19),  new DateTime(currentYear, 2, 26), 0));
        result.Add(CreateTask("15", "6", "Drywall", new DateTime(currentYear, 2, 25),  new DateTime(currentYear, 3, 10), 0));
        result.Add(CreateTask("16", "6", "Painting (Exterior)", new DateTime(currentYear, 3, 7),  new DateTime(currentYear, 3, 21), 0));
        result.Add(CreateTask("17", "6", "Interior Carpentery (Interior)", new DateTime(currentYear, 3, 17),  new DateTime(currentYear, 3, 29), 0));
        result.Add(CreateTask("18", "6", "Flooring and Interior Paint", new DateTime(currentYear, 3, 26),  new DateTime(currentYear, 4, 9), 0));

        result.Add(CreateTask("19", "1", "Final Phase", new DateTime(currentYear, 4, 9),  new DateTime(currentYear, 4, 9), 0));
        result.Add(CreateTask("20", "19", "Review-Punch List", new DateTime(currentYear, 4, 9),  new DateTime(currentYear, 4, 23), 0));
        result.Add(CreateTask("21", "19", "Final Inspection", new DateTime(currentYear, 4, 24),  new DateTime(currentYear, 4, 24), 0));
        result.Add(CreateTask("22", "19", "Final Paperwork and Documents", new DateTime(currentYear, 4, 24),  new DateTime(currentYear, 4, 30), 0));

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
    static List<Dependency> CreateDependencies()
    {
        var result = new List<Dependency>();
        result.Add(new Dependency() { ID = "1", Type = 0, ParentID = "4", DependentID = "6" });
        result.Add(new Dependency() { ID = "2", Type = 0, ParentID = "5", DependentID = "7" });
        result.Add(new Dependency() { ID = "3", Type = 0, ParentID = "12", DependentID = "13" });
        result.Add(new Dependency() { ID = "4", Type = 0, ParentID = "13", DependentID = "14" });
        result.Add(new Dependency() { ID = "5", Type = 0, ParentID = "18", DependentID = "20" });
        result.Add(new Dependency() { ID = "6", Type = 0, ParentID = "21", DependentID = "22" });
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
    static string CreateUniqueId() { return Guid.NewGuid().ToString(); }
}

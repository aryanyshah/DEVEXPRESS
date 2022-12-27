using DevExpress.Web.ASPxGantt;
using DevExpress.Web.Demos;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Gantt_StripLines : Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);

        StripLine startStripLine = new StripLine(GanttDataProvider.Tasks.FirstOrDefault().StartDate, "Start");
        Task testingTask = GanttDataProvider.Tasks.Find(t => t.Subject == "Testing");
        StripLine testingInterval = new StripLine(testingTask.StartDate, testingTask.EndDate, "Testing");
        Gantt.SettingsStripLine.StripLines.Add(startStripLine);
        Gantt.SettingsStripLine.StripLines.Add(testingInterval);
    }
}

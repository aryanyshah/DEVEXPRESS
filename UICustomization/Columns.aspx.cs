using DevExpress.Web.ASPxGantt;
using DevExpress.Web.Demos;
using System;
using System.Web.UI.WebControls;

public partial class Features_Columns : System.Web.UI.Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        Gantt.SettingsStripLine.StripLines.Clear();
        Gantt.SettingsStripLine.StripLines.Add(new StripLine() { Start = DateTime.Now });
    }
}

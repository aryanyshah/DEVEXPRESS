using System;
using System.Web.UI.WebControls;
using DevExpress.Web.Demos;

public partial class Exporting_ExportToPDF : System.Web.UI.Page
{
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        DemoHelper.Instance.PrepareControlOptions(OptionsFormLayout, new ControlOptionsSettings {
            ColumnMinWidth = 600,
            ColumnCountMode = RecalculateColumnCountMode.RootGroup
        });
        rangeCombo.Theme = DemoHelper.Instance.Theme;
        exportModeCombo.Theme = DemoHelper.Instance.Theme;
    }
    protected void Page_Load(object sender, EventArgs e) {
        startDateEdit.Date = GanttDataProvider.Tasks[1].StartDate;
        endDateEdit.Date = GanttDataProvider.Tasks[1].EndDate;
    }
    
}

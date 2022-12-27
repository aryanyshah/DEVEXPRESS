using DevExpress.Web.Demos;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Gantt_ChartAppearance : Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        DemoHelper.Instance.PrepareControlOptions(OptionsFormLayout, new ControlOptionsSettings {
            ColumnMinWidth = 600,
            ColumnCountMode = RecalculateColumnCountMode.RootGroup
        });
        ViewTypeCombo.Theme = DemoHelper.Instance.Theme;
        TitlePositionCombo.Theme = DemoHelper.Instance.Theme;
        ShowResourcesCheckbox.Theme = DemoHelper.Instance.Theme;
        ShowDependenciesCheckbox.Theme = DemoHelper.Instance.Theme;
        CustomizeTaskTooltip.Theme = DemoHelper.Instance.Theme;
    }

    protected void Page_Load() {
        Gantt.ClientSideEvents.TooltipShowing = "";
        if(CustomizeTaskTooltip.Checked) {
            Gantt.ClientSideEvents.TooltipShowing = "onShowTooltip";
        }
        if(!IsPostBack) {
            startDateEdit.Date = new System.DateTime(DateTime.Now.Year, 2, 15);
            endDateEdit.Date = new System.DateTime(DateTime.Now.Year, 7, 11);
            Gantt.SettingsGanttView.StartDateRange = startDateEdit.Date;
            Gantt.SettingsGanttView.EndDateRange = endDateEdit.Date;
        }
    }
}

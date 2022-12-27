using DevExpress.Web.ASPxGantt;
using DevExpress.Web.Demos;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Gantt_Toolbar : Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        AlignCombo.Theme = DemoHelper.Instance.Theme;
        ShowToolbarCheckbox.Theme = DemoHelper.Instance.Theme;
    }

    protected void Page_Load() {
        Gantt.SettingsToolbar.Visible = ShowToolbarCheckbox.Checked;
        string align = AlignCombo.Value.ToString();
        switch(align) {
            case "Left":
                Gantt.SettingsToolbar.Alignment = GanttToolbarAlignment.Left;
                break;
            case "Justify":
                Gantt.SettingsToolbar.Alignment = GanttToolbarAlignment.Justify;
                break;
            case "Right":
                Gantt.SettingsToolbar.Alignment = GanttToolbarAlignment.Right;
                break;
        }
    }
}

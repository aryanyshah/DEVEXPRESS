using DevExpress.Web.Demos;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Gantt_ContextMenu : Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        ShowDefaultItemsCheckbox.Theme = DemoHelper.Instance.Theme;
        PreventContextMenuCheckbox.Theme = DemoHelper.Instance.Theme;
    }
}

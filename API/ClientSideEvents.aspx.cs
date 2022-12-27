using DevExpress.Web.Demos;
using System.Web.UI.WebControls;

public partial class Data_ClientSideEvents : System.Web.UI.Page
{
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        DemoHelper.Instance.PrepareControlOptions(OptionsFormLayout, new ControlOptionsSettings {
            ColumnMinWidth = 600,
            ColumnCountMode = RecalculateColumnCountMode.RootGroup
        });
    }
}

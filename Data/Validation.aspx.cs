using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.Demos;

public partial class Gantt_Validation : Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
    }

    protected void Page_Load(object sender, EventArgs e) {
        Gantt.SettingsValidation.AutoUpdateParentTasks = AutoUpdateParentTasksCheckbox.Checked;
        Gantt.SettingsValidation.EnableDependencyValidation = EnableDependencyValidationCheckbox.Checked;
        Gantt.SettingsValidation.EnablePredecessorGap = EnablePredecessorGapCheckbox.Checked;

        Gantt.DataBind();
        AutoUpdateParentTasksCheckbox.Theme = DemoHelper.Instance.Theme;
        EnableDependencyValidationCheckbox.Theme = DemoHelper.Instance.Theme;
        EnablePredecessorGapCheckbox.Theme = DemoHelper.Instance.Theme;
    }
}

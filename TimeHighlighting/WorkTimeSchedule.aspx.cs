using DevExpress.Web.ASPxGantt;
using DevExpress.Web.Demos;
using System.Linq;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Gantt_WorkTimeSchedule : Page {
    protected void Page_Init() {
        DemoHelper.Instance.ControlAreaMaxWidth = Unit.Percentage(100);
        ViewTypeCombo.Theme = DemoHelper.Instance.Theme;
    }

    protected void Gantt_CustomJSProperties(object sender, GanttCustomJSPropertiesEventArgs e) {
        e.Properties.Add("cpDailyRuleInfo", GetDailyRulesDescription());
        e.Properties.Add("cpWeeklyRuleInfo", GetWeeklyRulesDescription());
        e.Properties.Add("cpYearlyRuleInfo", GetYearlyRulesDescription());
    }

    private string GetDailyRulesDescription() {
        string result = "";
        string separator = "";

        List<DailyRule> dailyRules = Gantt.WorkTimeRules.OfType<DailyRule>().ToList();
        foreach(DailyRule rule in dailyRules) {
            foreach(WorkTimeRange range in rule.WorkTimeRanges) {
                if(!string.IsNullOrEmpty(result)) separator = " AND ";
                result += string.Format("{0}from {1} till {2}", separator, range.Start.ToString(@"hh\:mm"), range.End.ToString(@"hh\:mm"));
            }
        }
        return result;
    }

    private string GetWeeklyRulesDescription() {
        string result = "";

        string separator = "";

        List<WeeklyRule> weeklyRules = Gantt.WorkTimeRules.OfType<WeeklyRule>().ToList();

        foreach(WeeklyRule rule in weeklyRules) {
            if(!string.IsNullOrEmpty(result)) separator = " AND ";
            result += string.Format("{0}{1}", separator, rule.Recurrence.DayOfWeek);
        }
        return result;

    }

    private string GetYearlyRulesDescription() {
        string result = "";
        string separator = "";
        List<YearlyRule> yearlyRules = Gantt.WorkTimeRules.OfType<YearlyRule>().ToList();
        foreach(YearlyRule rule in yearlyRules) {
            if(!string.IsNullOrEmpty(result)) separator = " AND ";
            result += string.Format("{0}{1} {2}", separator, rule.Recurrence.Month, rule.Recurrence.Day);
        }
        return result;
    }
}

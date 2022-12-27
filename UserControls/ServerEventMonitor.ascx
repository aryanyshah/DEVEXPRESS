<%@ Control Language="C#" %>
<script runat="server">
    
    string _eventNames;
    int _eventLogWidth;
    public string EventNames {
        get { return _eventNames; }
        set { _eventNames = value; }
    }
    public int EventLogWidth {
        get { return _eventLogWidth; }
        set { _eventLogWidth = value; }
    }
    public void TraceEvent(object sender, EventArgs e, string eventName) {
        if(!IsTraceEnabled(eventName))
            return;
        
        StringBuilder builder = new StringBuilder();
        builder.Append("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\">");
        AppendRow(builder, "Sender", (sender as Control).ID);
        AppendRow(builder, "EventType", eventName);
        int count = 0;
        foreach(System.Reflection.PropertyInfo prop in e.GetType().GetProperties(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public)) {
            try {
                object value = prop.PropertyType.IsValueType ? prop.GetValue(e, null) : "[" + prop.PropertyType.Name + "]"; 
                AppendRow(builder, count > 0 ? "" : "Arguments", prop.Name + " = " + value);
                if(!prop.PropertyType.IsValueType)
                    TryTraceCollectionItemArgument(prop, e, builder);
                count++;
            } catch {
            }
        }
        builder.Append("</table><br />");
        builder.Append(EventLog.InnerHtml);
        EventLog.InnerHtml = builder.ToString();
    }
    void TryTraceCollectionItemArgument(System.Reflection.PropertyInfo prop, EventArgs e, StringBuilder builder) {
        try {
            CollectionItem item = prop.GetValue(e, null) as CollectionItem;
            if (item == null)
                return;
            string[] itemPropNames = new string[] { "Name", "Text" };
            foreach (string itemPropName in itemPropNames) {
                System.Reflection.PropertyInfo itemProp = item.GetType().GetProperty(itemPropName);
                if (itemProp == null)
                    continue;
                string itemPropValue = itemProp.GetValue(item, null) as string;
                if (!string.IsNullOrEmpty(itemPropValue)) {
                    AppendRow(builder, "", prop.Name + "." + itemPropName + " = " + itemPropValue);
                    return;
                }
            }
        } catch { }
    }
    bool IsTraceEnabled(string eventName) {
        foreach(RepeaterItem item in Repeater.Items) {
            foreach(Control control in item.Controls) {
                ASPxCheckBox box = control as ASPxCheckBox;
                if(box != null && box.Text == eventName)
                    return box.Checked;
            }
        }
        return false;
    }
    void AppendRow(StringBuilder builder, string name, string content) {
        builder.Append("<tr valign=\"top\"><td style=\"width: 100px\">");
        if(!String.IsNullOrEmpty(name))
            builder.AppendFormat("<b>{0}:</b>", HttpUtility.HtmlEncode(name));
        builder.AppendFormat("<td>{0}</td></tr>", HttpUtility.HtmlEncode(content));
    }
    protected IEnumerable<string> GetEventNameList() {
        string[] eventNameList = Regex.Split(EventNames, "[^A-Za-z_]+");
        for(int index = 0; index < eventNameList.Length; index++) {
            eventNameList.SetValue(eventNameList[index].Replace("_", " "), index);
        }
        return eventNameList;
    }
    protected void Page_Init(object sender, EventArgs e) {
        Repeater.DataSource = GetEventNameList();
        Repeater.DataBind();
        if(EventLogWidth > 0)
            EventLog.Style.Add("width", EventLogWidth + "px");
    }
    protected void Page_Load(object sender, EventArgs e) {
        ClearButton.Theme = DemoHelper.Instance.Theme;
        foreach(RepeaterItem item in Repeater.Items) {
            foreach(Control control in item.Controls) {
                var checkbox = control as ASPxCheckBox;
                if(checkbox != null)
                    checkbox.Theme = DemoHelper.Instance.Theme;
            }
        }
    }
    protected void ClearButton_Click(object sender, EventArgs e) {
        EventLog.InnerHtml = "";
    }    
    
</script>
    
<div class="EventLogPanel">
    <div runat="server" id="EventLog" class="EventLog"></div>
    <dx:ASPxButton runat="server" ID="ClearButton" Text="Clear" OnClick="ClearButton_Click"/>    
</div>
<div class="EventListPanel">
    <div>Trace Events:</div>
    <asp:Repeater runat="server" ID="Repeater">
        <ItemTemplate>          
            <dx:ASPxCheckBox AutoPostBack="true" ID="CheckBox" runat="server" Text="<%# Container.DataItem %>" Checked="true"/>
        </ItemTemplate>
    </asp:Repeater>
</div>    

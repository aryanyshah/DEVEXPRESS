<%@ Control Language="C#" %>
<script runat="server">
    
    string _eventNames;
    int _scrollContainerHeight;
    int _eventLogHeight;
    int _eventLogWidth;
    bool _showEventListPanel = true;
    public string EventNames {
        get { return _eventNames; }
        set { _eventNames = value; }
    }
    public bool ShowEventListPanel {
        get { return _showEventListPanel; }
        set { _showEventListPanel = value; }
    }
    public int ScrollContainerHeight {
        get { return _scrollContainerHeight; }
        set { _scrollContainerHeight = value; }
    }
    public int EventLogHeight {
        get { return _eventLogHeight; }
        set { _eventLogHeight = value; }
    }
    public int EventLogWidth {
        get { return _eventLogWidth; }
        set { _eventLogWidth = value; }
    }
    protected IEnumerable<string> GetEventNameList() {
        return Regex.Split(EventNames, "[^A-Za-z_]+");
    }
    protected void Page_Load(object sender, EventArgs e) {
        Repeater.DataSource = GetEventNameList();
        Repeater.DataBind();
        ClearButton.Theme = DemoHelper.Instance.Theme;
    }
    protected string GetStyleAttribute() {
        if(EventLogWidth > 0 || EventLogHeight > 0) {
            string heightStr = (EventLogHeight > 0) ? string.Format("height: {0}px", EventLogHeight) : string.Empty;
            string widthStr = (EventLogWidth > 0) ? string.Format("width: {0}px", EventLogWidth) : string.Empty;
            return string.Format("style=\"{0}; {1};\"", widthStr, heightStr);
        }
        return null;
    }
    string GetScrollHeight() {
        if(ScrollContainerHeight > 0)
            return string.Format("style=\"{0}: {1}px;\"", "height", ScrollContainerHeight);
        return "";
    }
</script>
<script type="text/javascript">
        
    function ClearButton_Click() {
        DXEventMonitor.Clear();
    }
</script>
<div class="EventLogPanel">
    <div id="EventLog" <%= GetStyleAttribute() %>></div>
    <dx:ASPxButton runat="server" ID="ClearButton" AutoPostBack="false" Text="Clear">
        <ClientSideEvents Click="ClearButton_Click" />
    </dx:ASPxButton>
</div>
<% if(ShowEventListPanel) { %>
<div id="EventListContainer" class="EventListPanel" <%= GetScrollHeight() %> >
    <div>Trace Events:</div>
    <asp:Repeater runat="server" ID="Repeater">
        <ItemTemplate>            
            <input type="checkbox" id="EventCheck<%# Container.DataItem %>" checked="checked" />
            <label for="EventCheck<%# Container.DataItem %>"><%# Container.DataItem.ToString().Replace("_"," ") %></label>
            <br />
        </ItemTemplate>
    </asp:Repeater>
</div>     
<% } %>       

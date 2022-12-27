<%@ Application Language="C#" %> 

<script runat="server">

    void Application_Start(object sender, EventArgs e) {
        Utils.EnsureRequestValidationMode();
        Utils.PrepareSecurityProtocol();
        DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(CallbackError);
    }

    void CallbackError(object sender, EventArgs e) {
        // Logging exceptions occur on callback events of DevExpress ASP.NET controls. 
        // To learn more, see http://www.devexpress.com/Support/Center/Example/Details/E2398
        
        var exception = HttpContext.Current.Server.GetLastError();
        if(exception is DemoException) {
            DevExpress.Web.ASPxWebControl.SetCallbackErrorMessage(exception.Message);
        }
        if(exception.GetType().FullName == "System.Data.Entity.Core.UpdateException") {
            if(exception.InnerException != null) {
                string errorText = ProcessEntityUpdateExceptionMessage(exception.InnerException.Message);
                DevExpress.Web.ASPxWebControl.SetCallbackErrorMessage(errorText);
            }
        }
    }

    string ProcessEntityUpdateExceptionMessage(string message) {
        string pattern = @"'(?<path>[^']*mdf\.)([^']*)'";
        var match = Regex.Match(message, pattern, RegexOptions.IgnoreCase);
        var group = match.Groups["path"];
        if(group.Success)
            return message.Replace(group.ToString(), String.Empty);
        return message;
    }
    
    void Application_PreRequestHandlerExecute(object sender, EventArgs e) {
        if(CurrentPage != null)
            CurrentPage.PreInit += Page_PreInit;

        if(Utils.IsPageRequest) {
            if(!Utils.IsIntro) {
                DevExpress.Web.ASPxWebControl.GlobalTheme = Utils.CurrentTheme;
                Utils.ResolveThemeParametes();
            }

            if(Utils.IsAccessibilityDemo)
                DevExpress.Web.ASPxWebControl.GlobalAccessibilityCompliant = true;
        }
    }
    
    static Page CurrentPage {
        get { return HttpContext.Current.CurrentHandler as Page; }
    }

    static void Page_PreInit(object sender, EventArgs e) {
        Utils.RegisterCurrentWebFormsDemo(CurrentPage);
        Utils.InjectDescriptionMeta(CurrentPage.Master);
    }

</script>

---
title: Exception when you use Server.Transfer
description: This article provides resolutions for System.Threading.ThreadAbortException error that occurs when you use Server.Transfer in HTTPHandler in an ASP.NET application.
ms.date: 04/09/2020
ms.custom: sap:Performance
---
# System.Threading.ThreadAbortException when you use Server.Transfer in HTTPHandler in an ASP.NET application

This article helps you resolve the problem that an error might be thrown when you use a `Server.Transfer` method in `HTTPHandler` to transfer the control from one page to another in an ASP.NET web application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 817266

## Symptoms

When you use a `Server.Transfer` method in `HTTPHandler` to transfer the control from one page to another in an ASP.NET Web application, you may receive the following error message:

> System.Threading.ThreadAbortException: Thread was being aborted. at  
> System.Threading.Thread.AbortInternal() at System.Threading.Thread.Abort() at  
> System.Threading.Thread.Abort(Object stateInfo) at System.Web.HttpResponse.End() at  
> System.Web.HttpServerUtility.Transfer(String path, Boolean preserveForm)

## Cause

When you call `Server.Transfer`, ASP.NET internally calls the `Server.Execute` method to transfer the control, and calls the `Response.End` method to end the processing of the current page. `Response.End` ends the page execution and calls the `Thread.Abort` method. The `Thread.Abort` method causes the `ThreadAbortException` error message to appear.

## Workaround

To work around this problem, use `Server.Execute` instead of `Server.Transfer` in the `ProcessRequest` method of `HTTPHandler`. The modified `ProcessRequest` method is as follows:

Visual C# .NET sample code

```csharp
public void ProcessRequest(HttpContext context)
{
   try
   {
      context.Server.Execute("WebForm1.aspx");
   }
   catch(System.Exception e)
   {
      context.Response.Write(e.StackTrace);
      context.Response.Write(e.ToString());
   }
}
```

Visual Basic .NET sample code

```vb
Public Sub ProcessRequest(ByVal context As HttpContext) _
       Implements IHttpHandler.ProcessRequest
   Try
       context.Server.Execute("WebForm1.aspx")
   Catch e As Exception
      context.Response.Write(e.StackTrace)
   End Try
End Sub
```

## Status

This behavior is by design.

## Steps to reproduce the behavior

1. In Microsoft Visual Studio .NET, use Visual Basic .NET or Visual C# .NET to create a new ASP.NET Web Application project. By default, *WebForm1.aspx* is created. Name the project *ServerTransferTest*.
2. Right-click **WebForm1.aspx** and then select **View HTML Source**.
3. Replace the existing code with the following sample code:

    ```html
    <%@ Page %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
    <HTML>
       <HEAD>
          <title>WebForm1</title>
       </HEAD>
       <body MS_POSITIONING="GridLayout">
          <form id="Form1" method="post" runat="server">
             <asp:HyperLink id="HyperLink1" style="Z-INDEX: 101; LEFT: 324px; POSITION: absolute; TOP: 181px" runat="server" NavigateUrl="http://localhost/ServerTransferTest/test.ashx"> http://localhost/ServerTransferTest/test.ashx</asp:HyperLink>
             <asp:Label id="Label1" style="Z-INDEX: 102; LEFT: 292px; POSITION: absolute; TOP: 149px" runat="server">On Clicking this URL should not throw any exception</asp:Label>
          </form>
       </body>
    </HTML>
    ```

4. Double-click **Design View** of *WebForm1.aspx*, and then replace the exiting code in the code behind page with the following sample code:

    Visual C# .NET sample code

    ```csharp
    using System;
    using System.Web;
    using System.Web.UI.WebControls;

    namespace ServerTransferTest
    {
        /// <summary>
        /// Summary description for WebForm1.
        /// </summary>
        public class WebForm1 : System.Web.UI.Page
        {
            protected System.Web.UI.WebControls.Label Label1;
            protected System.Web.UI.WebControls.HyperLink HyperLink1;

            private void Page_Load(object sender, System.EventArgs e)
            {
            }

            #region Web Form Designer generated code
            override protected void OnInit(EventArgs e)
            {
               // CODEGEN: ASP.NET Web Form Designer requires this call.
               InitializeComponent();
               base.OnInit(e);
            }

            /// <summary>
            /// Required method for Designer support - do not modify
            /// the contents of this method by using the code editor.
            /// </summary>
            private void InitializeComponent()
            {
               this.Load += new System.EventHandler(this.Page_Load);    
            }
            #endregion
        }
    }
    ```

    Visual Basic .NET sample code

    ```vb
    Public Class WebForm1
       Inherits System.Web.UI.Page
       Protected WithEvents Label1 As System.Web.UI.WebControls.Label
       Protected WithEvents HyperLink1 As System.Web.UI.WebControls.HyperLink

       'Web Form Designer requires this call.
       <System.Diagnostics.DebuggerStepThrough()>
       Private Sub InitializeComponent()
       End Sub

       Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
          'CODEGEN: Web Form Designer requires this method call.
          'Do not modify it by using the code editor.
          InitializeComponent()
       End Sub

       Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
          'Put user code to initialize the page here
       End Sub
    End Class
    ```

5. On the **File** menu, select **Add New Item**.
6. Under **Add New Item**, select **Class**. In the **Name** text box under **Add New Item**, rename the class `HelloWorldHandler`, and then click **Open**.
7. Replace the existing code in the `HelloWorldHandler` class file with the following sample code:

    Visual C# .NET sample code

    ```csharp
    using System.Web;
    namespace ServerTransferTest
    {
       public class HelloWorldHandler : IHttpHandler
       {
          public void ProcessRequest(HttpContext context)
          {
             try
             {
                context.Server.Transfer("WebForm1.aspx", true );
             }
             catch(System.Exception e)
             {
                context.Response.Write(e.StackTrace);
                context.Response.Write(e.ToString());
             }
          }
          public bool IsReusable
          {
             // To enable pooling, return true here.
             // This keeps the handler in memory.
             get { return false; }
          }
       }
    }
    ```

    Visual Basic .NET sample code

    ```vb
    Imports System
    Imports System.Web

    Public Class HelloWorldHandler
       Implements IHttpHandler
       Public Sub ProcessRequest(ByVal context As HttpContext) _
           Implements IHttpHandler.ProcessRequest
          Try
             ' context.Server.Transfer("WebForm1.aspx", True)
             context.Server.Execute("WebForm1.aspx")
          Catch e As Exception
             context.Response.Write(e.StackTrace)
          End Try
       End Sub
       ' Override the IsReusable property.
       Public ReadOnly Property IsReusable() As Boolean _
           Implements IHttpHandler.IsReusable
          Get
             Return True
          End Get
       End Property
    End Class
    ```

8. Repeat steps 5 and 6 to add another class file. Rename the class file `HelloWorldHandlerFactory`.
9. Replace the existing code in the `HelloWorldHandlerFactory` class file with the following sample code:

    Visual C# .NET sample code

    ```csharp
    using System.Web;
    namespace ServerTransferTest
    {
       public class HelloWorldHandlerFactory : IHttpHandlerFactory
       {
          public IHttpHandler GetHandler( HttpContext context, System.String requestType, System.String url, System.String pathTranslated)
          {
             HttpResponse Response = context.Response;
             Response.Write("<html>");
             Response.Write("<body>");
             Response.Write("<h1> Hello from HelloWorldHandlerFactory.GetHandler </h1>");
             Response.Write("</body>");
             Response.Write("</html>");
             return new HelloWorldHandler();
          }
          public void ReleaseHandler( IHttpHandler handler )
          {
          }
       }
    }
    ```

    Visual Basic .NET sample code

    ```vb
    Imports System
    Imports System.Web
    Public Class HelloWorldHandlerFactory
       Implements IHttpHandlerFactory
       Public Overridable Function GetHandler(ByVal context As HttpContext, _
       ByVal requestType As String, ByVal url As String, ByVal pathTranslated As String) _
            As IHttpHandler _
            Implements IHttpHandlerFactory.GetHandler

          Dim Response As HttpResponse = context.Response
          Response.Write("<html>")
          Response.Write("<body>")
          Response.Write("<h1> Hello from HelloWorldHandlerFactory.GetHandler </h1>")
          Response.Write("</body>")
          Response.Write("</html>")
          Return New HelloWorldHandler()
       End Function

       Public Overridable Sub ReleaseHandler(ByVal handler As IHttpHandler) _
           Implements IHttpHandlerFactory.ReleaseHandler
       End Sub
    End Class
    ```

10. Open the `Web.config` file, and then add the `<httpHandlers>` section in the `<system.web>` section as follows:

    ```xml
    <configuration>
        <system.web>
            <httpHandlers>
                <add verb="*" path="*.ashx" type="ServerTransferTest.HelloWorldHandlerFactory,ServerTransferTest" />
            </httpHandlers>
        .....
        </system.web>
    </configuration>
    ```

11. On the **Debug** menu, select **Start**, and then click the following hyperlink on *WebForm1.aspx*:  
    `http://localhost/ServerTransferTest/test.ashx`

## References

- [PRB: ThreadAbortException Occurs If You Use Response.End, Response.Redirect, or Server.Transfer](https://support.microsoft.com/help/312629)

- [PRB: "Error Executing Child Request" Error Message When You Use Server.Transfer or Server.Execute in ASP.NET Page](https://support.microsoft.com/help/320439)

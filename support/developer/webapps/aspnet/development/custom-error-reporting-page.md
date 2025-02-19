---
title: Create custom error reporting pages
description: This article describes how to use Visual Basic .NET code to trap and respond to errors when they occur in ASP.NET.
ms.date: 07/28/2020
ms.topic: how-to
ms.custom: sap:General Development
---
# Create custom error reporting pages in ASP.NET by using Visual Basic .NET

This article describes how to use Microsoft Visual Basic .NET code to trap and respond to errors when they occur in ASP.NET.

_Original product version:_ &nbsp; Visual Basic .NET, ASP.NET  
_Original KB number:_ &nbsp; 308132

## Summary

ASP.NET has improved the error handling options from traditional Active Server Pages (ASP). In ASP.NET, you can handle errors at several different levels in your applications.

## New features in ASP.NET

ASP.NET offers several advances in how you can handle and respond to errors. In traditional ASP, you handle errors with `On Error Resume Next` (or `try-catch` blocks in JScript). Alternately, if you are running Internet Information Services (IIS), you use the `ASPError` object to create a custom error reporting page. However, these approaches have their limitations.

ASP.NET provides several levels at which you can handle and respond to errors that may occur when you run an ASP.NET application. ASP.NET provides three main methods that allow you to trap and respond to errors when they occur: the `Page_Error` event, the `Application_Error` event, and the application configuration file (*Web.config*).

This article demonstrates how to use these new features in your ASP.NET application. Although this article describes how to provide custom error pages and general error reporting as it relates directly to ASP.NET, this article does not describe other error handling approaches such as the `try-catch-finally` block and the Common Language Runtime (CLR) exception system.

## Use the Page_Error event

The `Page_Error` event provides a way to trap errors that occur at the page level. You can display error information (as the sample code to follow does), or you can log the event or perform some other action.

> [!NOTE]
> This example displays detailed error information in the browser only for demonstration purposes. You will want to be cautious when displaying detailed information to the end user of the application, especially when the application is running on the Internet. A more appropriate action would be to display a message to the user notifying them that an error has occurred, and then actually logging the specific error details in the event log.

This example throws a null exception, which forces an error to occur in the `Page_Load` event. Follow these steps to create the initial page that will test the `Page_Error` event.

1. Follow these steps to add a new file named *PageEvent.aspx* to your project:

   1. Open Visual Studio .NET.
   2. In Solution Explorer, right-click the project node, point to **Add**, and then click **Add Web Form**.
   3. In the **Name** text box, type *PageEvent.aspx*, and then click **Open**.
2. Add the following code to *PageEvent.aspx*:

    ```vbscript
    <%@ Page Language="vb"%>
    <script runat=server>
        Sub Page_Load(Sender as object, e as EventArgs)
           throw(new System.ArgumentNullException())
        End Sub
        Sub Page_Error(Sender as object, e as EventArgs)
           Dim objErr as Exception = Server.GetLastError().GetBaseException()
           Dim err as String = "<b>Error Caught in Page_Error event</b><hr><br>" & _
                               "<br><b>Error in: </b>" & Request.Url.ToString() & _
                               "<br><b>Error Message: </b>" & objErr.Message.ToString() & _
                               "<br><b>Stack Trace:</b><br>" & _objErr.StackTrace.ToString()
           Response.Write(err.ToString())
           Server.ClearError()
        End Sub
    </script>
    ```

3. From the **File** menu, click **Save** *PageEvent.aspx*.
4. Right-click the page, and then click **View** in Browser to run the page. Notice that the error is thrown and reported according to the code specifications.

> [!NOTE]
> You may notice that the code issues a call to `Server.ClearError`. This prevents the error from continuing to the `Application_Error` event to be handled.

## Use the Application_Error event

Similar to the `Page_Error` event, you can use the `Application_Error` event to trap errors that occur in your application. Due to the event's application-wide scope, you can log of application error information or handle other application-level errors that may occur.

The sample to follow is based on the preceding `Page_Error` event code sample and would be fired if the error in the `Page_Load` event was not trapped in the `Page_Error` event. The `Application_Error` event is specified in the *Global.asax* file of your application. For simplicity, the steps in this section create a new page in which to throw the exception, trap the error in the `Application_Error` event of the *Global.asax* file, and write the error to the event log. The following steps demonstrate how to use the `Application_Error` event:

1. Add a new file named *AppEvent.aspx* to your project.
2. Add the following code to *AppEvent.aspx*:

    ```vb
    <script language=vb runat="server">
         Sub Page_Load(Sender as object, e as EventArgs)
             throw(new ArgumentNullException())
         End Sub
    </script>
    ```

3. From the **File** menu, click **Save** *AppEvent.aspx*.
4. Add the `Application_Error` event to the *Global.asax* file to trap the error that you throw in the `Page_Load` event of the *AppEvent.aspx* page. Notice that you must add an `Imports` statement for the `System.Diagnostics` namespace to *Global.asax* to use the event log.

   Add the following code to the *Global.asax* file:

    ```vb
    Imports System.Diagnostics
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        Dim objErr As Exception = Server.GetLastError().GetBaseException()
        Dim err As String = "Error Caught in Application_Error event" & _
                                System.Environment.NewLine & _
                                "Error in: " & Request.Url.ToString() & _
                                System.Environment.NewLine & _
                                "Error Message: " & objErr.Message.ToString() & _
                                System.Environment.NewLine & _
                                "Stack Trace:" & objErr.StackTrace.ToString()
        EventLog.WriteEntry("Sample_WebApp", err, EventLogEntryType.Error)
        Server.ClearError()
        additional actions...
    End Sub
    ```

5. Save the *Global.asax* file.
6. In Visual Studio .NET, on the **Build** menu, click **Build**.
7. Right-click the page, and then click **View** in Browser. In this case the page will be blank, however, you should notice that a new entry has been added in the event log. This sample makes an entry in the Application log, which is accessible from the **Event Viewer**. After logging the error you might want to redirect the user to another more user-friendly error page, or perform some additional actions if needed.

## Use the Web.config file

If you do not call `Server.ClearError` or trap the error in the `Page_Error` or `Application_Error` event, the error is handled based on the settings in the `<customErrors>` section of the *Web.config* file. In the `<customErrors>` section, you can specify a redirect page as a default error page (`defaultRedirect`) or specify to a particular page based on the Hypertext Transfer Protocol (HTTP) error code that is raised. You can use this method to customize the error message that the user receives.

If an error occurs that is not trapped at any of the previous levels in your application, this custom page is displayed. This section demonstrates how to modify the *Global.asax* file so that `Server.ClearError` is never called. As a result, the error is handled in the *Web.config* file as the last point to trap the error.

1. Open the *Global.asax* file from the previous example.
2. Comment out the `Server.ClearError` line to ensure that the error surfaces in the *Web.config* file.
3. Save your changes to *Global.asax*. Your code should now appear similar to the following:

    ```vb
     Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
         Dim objErr As Exception = Server.GetLastError().GetBaseException()
         Dim err As String = "Error Caught in Application_Error event" & _
                             System.Environment.NewLine & _
                             "Error in: " & Request.Url.ToString() & _
                             System.Environment.NewLine & _
                             "Error Message: " & objErr.Message.ToString() & _
                             System.Environment.NewLine & _
                             "Stack Trace:" & objErr.StackTrace.ToString()
         EventLog.WriteEntry("Sample_WebApp", err, EventLogEntryType.Error)
         Server.ClearError()
         additional actions...
     End Sub
    ```

4. Add the following code to the `<customErrors>` section to redirect the user to a custom page:

    ```xml
    <customErrors defaultRedirect="http://hostName/applicationName/errorStatus.htm" mode="On">
    </customErrors>
    ```

    > [!NOTE]
    > You must modify the file path in `defaultRedirect` attribute so that it references the relevant Web server and application names.

5. Because the errors that are trapped at this level are sent to a default error page, you must create an error page named *ErrorStatus.htm*. Keep in mind that you are using this method to control what is presented to the user, so this example uses a *.htm* page for the error page. Add the following code to *ErrorStatus.htm*:

    ```html
    <HTML>
        <HEAD>
            <TITLE></TITLE>
            <META NAME="GENERATOR" Content="Microsoft Visual Studio 7.0">
        </HEAD>
        <BODY>
             <b>Custom Error page!</b>
             <br>
             You have been redirected here from the <customErrors> section of the
             Web.config file.
        </BODY>
    </HTML>
    ```

6. To test the code, save the files, build the project, and then view *AppEvent.aspx* in the browser. Notice that when the error is thrown, you are redirected to the *ErrorStatus.htm* page. Although you can reference a default error page in the value of the `defaultRedirect` attribute in the `<customErrors>` section, you can also specify a particular page to redirect to based on the HTTP error code that is raised. The `<error>` child element allows for this option. For example:

    ```xml
    <customErrors defaultRedirect="http://hostName/applicationName/errorStatus.htm" mode="On">
        <error statusCode="404" redirect="filenotfound.htm"/>
    </customErrors>
    ```

> [!NOTE]
> The page that is specified in `defaultRedirect` of the `<customErrors>` section is an *.htm* file. If you intend to use `GetLastError` in an *.aspx* page (which the `Page_Error` and `Application_Error` samples do), you must store the exception in a session variable or some other approach before the redirect takes place.

Notice that the `<customErrors>` section includes a `mode` attribute that is set to `On` . The `mode` attribute is used to control how the error redirection occurs. For example, if you are developing the application, you most likely want to see the actual ASP.NET error messages and do not want to be redirected to the more user-friendly error page. The `mode` attribute includes the following settings:

- `On`: Unhandled exceptions redirect the user to the specified `defaultRedirect` page. This `mode` is used mainly in production.

- `Off`: Users receive the exception information and are not redirected to the `defaultRedirect` page. This `mode` is used mainly in development.

- `RemoteOnly`: Only users who access the site on the local computer (by using localhost) receive the exception information. All other users are redirected to the `defaultRedirect` page. This mode is used mainly for debugging.

## Troubleshooting

In its default installation on Windows, ASP.NET runs Web application code in a worker process. The identity of this process defaults to an unprivileged local account called the *ASPNET* account. In beta releases of ASP.NET, the process identity was System, a powerful administrative account with many privileges on the machine.

In its default installation on Windows Server (IIS), ASP.NET runs Web application code in a worker process. The identity of this process defaults to a limited account called *NetworkService*.

For more information on this change and how it can effect running the code in this article, as well as other code that might need to additional access rights, see [patterns & practices](/previous-versions/msp-n-p/ff921345(v=pandp.10))

## References

- [Handling and Throwing Exceptions](/previous-versions/dotnet/netframework-1.1/5b2yeyab(v=vs.71))

- [HttpServerUtility.ClearError Method](/dotnet/api/system.web.httpserverutility.clearerror?view=netframework-4.8&preserve-view=true#System_Web_HttpServerUtility_ClearError)

- [.NET Home Page](https://dotnet.microsoft.com/)

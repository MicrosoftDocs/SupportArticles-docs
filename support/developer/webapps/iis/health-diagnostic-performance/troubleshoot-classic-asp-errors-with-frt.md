---
title: Use Failed Request Tracing to troubleshoot Classic ASP errors
description: Describes how to use Failed Request Tracing to troubleshoot Classic ASP errors
ms.date: 12/18/2024
ms.author: aartigoyle
author: aartig13
ms.reviewer: johnhart, robmcm, zixie

ms.custom: sap:Health, Diagnostic, and Performance Features\Failed Request Tracing
---
# Use Failed Request Tracing to troubleshoot Classic ASP errors

_Applies to:_ &nbsp; Internet Information Services

One of the great troubleshooting features that is built in to Internet Information Services (IIS) is Failed Request Tracing. The feature enables you to configure tracing rules on your server, which create detailed troubleshooting log files for custom failure conditions that you define. For example, you can capture the details for authentication failures by creating tracing rules that create log files for HTTP 401 errors.

Failed Request Tracing in IIS can be configured to passively trace failures. This means that you can add tracing rules to IIS that will create log files when errors occur, even if you aren't actively monitoring your server. For example, the steps in this article show you how to create a tracing rule that will create trace logs whenever an HTTP 500 error occurs. This method of passive tracing is known as "no-repro" tracing, which means that you can periodically examine your server's logs to check if any failures have occurred, and then take action only when IIS has created logs.

## Work with User Access Control

To make sure that you follow the steps in this article by using an account that has full administrative permissions, use one of the following methods:

- Sign in to your computer by using the local administrator account.
- If you're signed in using an account with administrative permissions instead of the local administrator account, open all applications and all command prompt sessions by using the **Run as Administrator** option.

These conditions are required because the User Account Control (UAC) security component in Windows prevents administrative access to the IIS configuration settings. For more information about UAC, see [User Account Control](/windows/security/application-security/application-control/user-account-control/).

## Install Failed Request Tracing

Failed Request Tracing isn't installed by default on IIS. Install Failed Request Tracing according to your version of Windows.

### Windows client operating system

1. Select **Start** > **Control Panel**.
1. In **Control Panel**, select **Programs and Features** > **Turn Windows Features on or off**.
1. Expand **Internet Information Services** > **World Wide Web Services** > **Health and Diagnostics**.
1. Select **Tracing**, and then select **OK**.

### Windows server operating system

1. Select **Start**, point to **Administrative Tools**, and then select **Server Manager**.
1. In the **Server Manager** hierarchy pane, expand **Roles**, and then select **Web Server (IIS)**.
1. In the **Web Server (IIS)** pane, scroll to the **Role Services** section, and then select **Add Role Services**.
1. On the **Select Role Services** page of the **Add Role Services Wizard**, select **Tracing**, and then select **Next**.
1. On the **Confirm Installation Selections** page, select **Install**.
1. On the **Results** page, select **Close**.

For more information about installing Failed Request Tracing for IIS, see the [Tracing \<tracing\>](/iis/configuration/system.webServer/tracing/).

## How to enable Failed Request Tracing

1. Select **Start**, point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
1. In the **Connections** pane, select the server connection, site, application, or directory for which you want to configure Failed Request Tracing.
1. In the **Actions** pane, select **Failed Request Tracing...**
1. Configure the following options In the **Edit Web Site Failed Request Tracing Settings** dialog box:
    - Select the **Enable** checkbox to enable tracing.
    - Leave the default value or enter a new directory where you want to store failed request log files in the **Directory** box.
    - Enter the number of failed request trace files you want to store in the **Maximum number of trace files** box.
1. Select **OK**.

> [!NOTE]
> You could customize the setting for classic ASP, ASP.NET, or for other specific conditions, but a generic rule for HTTP 500 errors is useful for discovering a variety of error conditions on your Web server.

You can also enable Failed Request Tracing from a command prompt by using the _AppCmd.exe_ utility with the following syntax:

```cmd
appcmd.exe set config -section:system.applicationHost/sites /[name='Default Web Site'].traceFailedRequestsLogging.enabled:"True" /commit:apphost

appcmd.exe set config -section:system.applicationHost/sites /[name='Default Web Site'].traceFailedRequestsLogging.directory:"%SystemDrive%\inetpub\logs\FailedReqLogFiles" /commit:apphost

appcmd.exe set config -section:system.applicationHost/sites /[name='Default Web Site'].traceFailedRequestsLogging.maxLogFiles:"50" /commit:apphost
```

## Troubleshoot classic ASP errors

In this section, we generate a few errors using classic ASP in order to examine how Failed Request Tracing helps identify potential problems. Even though these examples target specific circumstances where you know the cause of the failure, you can use the techniques that are presented to troubleshoot situations where the cause of the failure is unknown.

### Troubleshoot HTTP 500 errors

IIS returns HTTP 500 errors when ASP pages fail to execute, and without the Failed Request Tracing feature of IIS these HTTP 500 errors can be difficult to troubleshoot. This is because the ASP errors typically occur when you aren't actively troubleshooting your system, so that sometimes your only option is to search your IIS activity logs and hope that the ASP module returns additional information in the log entries for failed requests. In the following example that uses Failed Request Tracing, you have a detailed record of the failure that you can use to troubleshoot the situation.

#### How to add a tracing rule for HTTP 500 errors

The following steps configure a Failed Request Tracing rule for HTTP 500 errors, which you use later to troubleshoot classic ASP error messages:

1. Select **Start**, point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In the **Connections** pane, go to the connection, site, application, or directory for which you want to configure Failed Request Tracing.
3. In the **Home** pane, double-click **Failed Request Tracing Rules**.
4. In the **Actions** pane, select **Add...**
5. On the **Specify Content to Trace** page of the **Add Failed Request Tracing Rule** Wizard, you would ordinarily select the content type you want to trace. In this case, accept the default for all content, and then select **Next**.
6. On the **Define Trace Conditions** page, enter 500 in the **Status code(s)** text box in order to trace HTTP 500 errors, and then select **Next**.
7. On the **Select Trace Providers** page, accept the defaults, and then select **Finish**.

#### Create a page that invokes an invalid COM class

In this section, you examine an ASP page that attempts to create an instance of an invalid COM class, and this situation is most often produced by misspelling a valid COM class. To test this issue, save the following ASP code as _Bad\_class.asp_ in the _wwwroot_ folder of a website where you have enabled Failed Request Tracing for HTTP 500 errors:

```html
<html>
<body>
<h1>Bad Class</h1>
<%
   Set objObject = CreateObject("Bad.Class.Name")
%>
</body>
</html>
```

When you use a Web browser to browse to this file, IIS should return an HTTP 500 error message, and IIS will create a failed request trace log that is created in your _%SystemDrive%\\Inetpub\\FailedRequestLogFiles\\W3SVCnnn_ folder by default, where _W3SVCnnn_ contains the unique identifier for your website that is listed in IIS Manager. Failed request trace logs are XML files, and IIS creates an XSL file that transforms the XML into a presentation format that you can open in Internet Explorer.

#### Read the trace log in Internet Explorer

When you use Internet Explorer or IE mode in Edge browser to open a Failed Request Tracing log file, various information is displayed in a **Request Summary**. This summary contains the general environment information for the failure condition such as the executing URL, the application pool, the authentication type and user name, and other information. You notice that the reason for the failure is the status code, and that the status is an HTTP 500 error.

In the **Errors and Warning** section of summary, you see a **view trace** link, as shown in the following illustration:

:::image type="content" source="media/troubleshoot-classic-asp-errors-with-frt/browser-request-summary-ft-log-error.png" alt-text="Screenshot of a browser window displaying the Request Summary of a failed trace log error.":::

When you select the **view trace** link, the browser jumps to the section of the trace where the ASP script failure occurred. If you expand the individual trace events, you can view the specific details for the event, such as the physical file path, the line number, the ASP error code and description, and the ASP code excerpt that caused the failure, which in this case was the attempt to instantiate an invalid COM class.

An example is shown in the following illustration:

:::image type="content" source="media/troubleshoot-classic-asp-errors-with-frt/browser-trace-error.png" alt-text="Screenshot of a browser window displaying the section of the trace where the error occurred.":::

### Troubleshoot slow pages

You can configure Failed Request Tracing to generate log files for pages that exceed a time interval that you specify, not just for HTTP errors. In a practical example, if your Web users are complaining that parts of the website seem slow sometimes but they don't know which pages seem to be affected, you can create a tracing rule for a time interval to create a log file when any pages exceed that interval. This lets you narrow your troubleshooting scope down to any affected pages by waiting for IIS to create log files that list the page. Without Failed Request Tracing, you could query your IIS activity logs for pages that take a long time to execute, but that only narrows your scope to the list of pages where a problem is occurring, not to the problem itself. In the following example, you locate the source of the failure in the slow page.

#### How to add a tracing rule for slow content

The following steps configure a Failed Request Tracing rule for requests that exceed a specific period of time, which you use later to troubleshoot slow ASP pages.

1. Select **Start**, point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
1. In the **Connections** pane, go to the connection, site, application, or directory for which you want to configure Failed Request Tracing.
1. In the **Home** pane, double-click **Failed Request Tracing Rules**.
1. Highlight the rule that you created in the previous example, and then select **Remove** in the **Actions** pane.
1. In the **Actions** pane, select **Add...**
1. On the **Specify Content to Trace** page of the **Add Failed Request Tracing Rule** Wizard, you would ordinarily select the content type you want to trace. In this case, accept the default for all content, and then select **Next**.
1. On the **Define Trace Conditions** page:
    - Clear **Status code(s)**.
    - Select **Time taken (in seconds)**.
    - Enter _5_ for the number of seconds.
    - Select **Next**.
1. On the **Select Trace Providers** page, accept the defaults, and then select **Finish**.

#### Create a page that loops endlessly

In this error condition, you examine a page that loops endlessly. This problem is frequently caused when a user session fails to exit a loop correctly, such as when your code is looping through the list records in a database table. To test this issue, save the following ASP code as _Slow\_page.asp_ in the _wwwroot_ folder of a website where you have enabled Failed Request Tracing:

```html
<html>
<body>
<h1>Slow Page</h1>
<%
   Do
      If Response.IsClientConnected = False Then
         Exit Do
      End If
   Loop
%>
</body>
</html>
```

When you use a Web browser to browse to this file, you should see no error in your Web browser, but your browser might never return a page and eventually time out.

> [!NOTE]
> This page is written to exit the loop after you close your Web browser. If you want to exit the loop before the script timeout is reached, you should manually close your browser after ten seconds.

After five seconds, IIS will create a failed request trace log in your _%*SystemDrive*%\\Inetpub\\FailedRequestLogFiles\\W3SVCnnn_ folder by default, where _W3SVCnnn_ contains the unique identifier, as listed in IIS Manager, for your website.

#### Read the trace log in Internet Explorer

As shown in the previous example, when you use Internet Explorer or IE mode in Microsoft Edge browser to open a Failed Request Tracing log file, important information is displayed in a **Request Summary**. This summary contains the general environment information for the failure condition such as the executing URL, the application pool, the authentication type and user name, and other information. Notice that the reason for the failure was the amount of time taken, and that the time was slightly over five seconds, which was the time that you entered in the Failed Request Tracing rule.

> [!NOTE]
> You also notice that the HTTP status code for the response was HTTP 200, which is a successful response. This is one of the factors that often makes it more difficult to diagnose slow pages-the responses succeed, which make them more difficult to locate.

In the **Errors and Warning** section of summary, you see a **view trace** link, as shown in the following illustration:

:::image type="content" source="media/troubleshoot-classic-asp-errors-with-frt/browser-request-summary-ft-log-warning.png" alt-text="Screenshot of a browser window displaying the Request Summary of a failed trace log warning.":::

When you select the view **trace link**, the browser goes to the section of the trace where the ASP script failure occurred. If you expand the individual trace events, you can view the specific details for the event, such as the physical file path, the line number, the ASP error code and description, and the ASP code excerpt that was executing when the log file was created. By using this information, you could examine your ASP page and locate the line of code that was executing inside a never-ending loop.

An example is shown in the following illustration:

:::image type="content" source="media/troubleshoot-classic-asp-errors-with-frt/browser-trace-warning.png" alt-text="Screenshot of a browser window displaying the section of the trace where the warning occurred.":::

## More information

For more information about Failed Request Tracing in IIS, see the following articles:

- [Walkthrough: Troubleshooting Failed Requests Using Tracing in IIS](troubleshoot-failed-requests-using-tracing-in-iis-85.md)
- [Configuration Reference: Trace Failed Requests](/iis/configuration/system.webServer/tracing/traceFailedRequests)

---
title: Troubleshoot failed requests using tracing in IIS 8.5
description: Describes request-based tracing and how to troubleshoot failed requests with tracing in IIS 8.5.
ms.date: 10/05/2023
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart, riande,
---
# Troubleshoot failed requests using tracing in IIS 8.5

_Applies to:_ &nbsp; Internet Information Services 8.5

## Introduction

Request-based tracing is available both in stand-alone IIS Servers and on Microsoft Azure Web Sites (WAWS). If you can reproduce the problem that you're experiencing, Request-based tracing provides a way to determine what exactly is happening with your requests and why it's happening. Problems such as poor performance on some requests, authentication-related failures on other requests, or the server 500 error from ASP or ASP.NET can often be difficult to troubleshoot, unless you have captured the trace of the problem when it occurs. This article discusses Failed Request Tracing on IIS Server. For information about doing this with Microsoft Azure Web Sites, see [Troubleshoot an app in Azure App Service using Visual Studio](/azure/app-service/troubleshoot-dotnet-visual-studio).

Failed Request Tracing is designed to buffer the trace events for a request and only flush them to disk if the request fails, where you provide the definition of _failure_. If you want to know why your requests are returning a specific HTTP status code, for example, 401 or 404, or if a request is taking a while to process or isn't responding, then you can use Failed Request Tracing.

The tasks that are explained in this article include:

- Enabling the Failed Request Tracing module.
- Configuring Failed Request Tracing log-file semantics.
- Defining the URL for which to keep failed request traces, including failure definitions and areas to trace.
- Generating the failure condition and viewing the resulting trace.

## Prerequisites

### Install IIS

Install IIS 8.5 before you can perform the tasks described in this article. Browse to `http://localhost/` and verify that the Internet Information Services splash screen is displayed. If IIS isn't installed, see [Installing IIS 8.5 on Windows Server 2012 R2](/iis//install/installing-iis-85/installing-iis-85-on-windows-server-2012-r2) for installation instructions. When installing IIS, make sure that you also install the following features:

- ASP.NET 3.5 (under **Web Server (IIS)**/**Web Server**/**Application Development Features**/**ASP.NET 3.5**)
- ASP.NET 4.5 (under **Web Server (IIS)**/**Web Server**/**Application Development Features**/**ASP.NET 4.5**)
- Tracing (under **Web Server (IIS)**/**Web Server**/**Health and Diagnostics - Tracing**)

### Sign in as administrator

Ensure that the account that you use to sign in is the administrator account or is in the administrators group.

> [!NOTE]
> Being in the administrators group doesn't grant you complete administrator user rights by default. You must run applications as administrator by right-clicking on the application icon and selecting **Run as administrator**.

### Make a backup

Make a backup of the configuration files before performing the following tasks:

1. Select the Windows logo key and the **X** key simultaneously, select **Command Prompt (Admin)**, and then select **Yes**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/cmd-admin-in-task-bar.png" alt-text="Screenshot of Command Prompt Admin in Windows task bar.":::

1. In the command prompt, run the following command:

    ```console
    %windir%\system32\inetsrv\appcmd add backup cleanInstall
    ```

    This command creates a _cleanInstall_ folder containing backup configuration files in _%windir%\\system32\\inetsrv\\backup_.

### Create sample content

1. Navigate to _%systemdrive%\inetpub\wwwroot_.
1. Move the content to a secure location (in case you want to restore the existing content) or delete it.
1. Create a blank file and name it _test.asp_.
1. In the command prompt, navigate to the _test.asp_ file in _\\inetpub\\wwwroot_.
1. In the _test.asp_ file, paste the following content:

    ```html
    <h2>Failed Request Tracing Lab</h2><br>
    <br>Today's date is <% response.write(Date()) %>
    ```

### Disable ASP

ASP must be disabled for this task. ASP is disabled only as an example and for the purposes of the tasks in this article.

To disable ASP, follow these steps:

1. Open IIS Manager and select the server.
1. Double-click **ISAPI and CGI Restrictions**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/iis-manager-pane-isapi-cgi-selected.png" alt-text="Screenshot of I I S Manager pane displaying I S A P I and C G I Restrictions selected.":::

1. In the **ISAPI and CGI Restrictions** pane, select **Active Server Pages**. In the **Actions** pane, select **Deny** to disable ASP. Active Server Pages will show as **Not Allowed**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/isapi-cgi-restriction-pane.png" alt-text="Screenshot of I S A P I and C G I Restrictions pane displaying Active Server Pages selected. Deny option is selected in Actions pane.":::

## Enable Failed Request Tracing

After you enable Failed Request Tracing, you need to configure the path of the log files. In this section, you will enable Failed Request Tracing for the default web site and specify where to store the log files, and then configure the failure for which to generate failure logs.

### Step 1: Enable Failed Request Tracing for the site and configure the log file directory

1. Open a command prompt with administrator user rights, and navigate to _%systemdrive%\\windows\\system32\\inetsrv_.
1. Run `inetmgr` to open IIS Manager.
1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
1. In the **Actions** pane, under **Configure**, select **Failed Request Tracing…**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/actions-frt-option-under-configure.png" alt-text="Screenshot of Actions pane showing Failed Request Tracing option is highlighted under Configure tab.":::

1. In the **Edit Website Failed Request Tracing Settings** dialog box, configure the following:

    - Select the **Enable** checkbox.
    - Keep the defaults for the other settings.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/edit-web-site-frt-settings-dialog.png" alt-text="Screenshot displays Edit Web Site Failed Request Tracing Settings dialog box with command populating Directory field and Enable checkbox selected.":::

1. Select **OK**.

    Failed Request Tracing logging is now enabled for the Default Web Site. Check the _%windir%\\system32\\inetsrv\\config\\applicationHost.config_ file to confirm that the configuration looks as follows:

    ```xml
    <system.applicationHost>
       <!-- other system configuration --> 
       <sites> 
          <site name="Default Web Site" id="1"> 
             <!-- other site configuration --> 
             <traceFailedRequestsLogging  enabled="true" /> 
          </site> 
          <!-- site & app defaults --> 
          <!-- other sites configuration --> 
       </sites> 
       <!-- other system configuration --> 
    </system.applicationHost>
    ```

### Step 2: Configure your failure definitions

In this step, configure the failure definitions for your URL, including what areas to trace. You will troubleshoot a 404.2 status code that's returned by IIS for any requests to extensions that haven't yet been enabled. It helps you determine which particular extensions you need to enable. For more information, see [HTTP status codes in IIS](../www-administration-management/http-status-code.md).

1. Open a command prompt with administrator user rights, and navigate to _%systemdrive%\\windows\\system32\\inetsrv_.
1. Run `inetmgr` to open IIS Manager.
1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
1. Double-click **Failed Request Tracing Rules**.  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/defalut-web-site-home-pane-frt-rules.png" alt-text="Screenshot of Default Web Site Home pane showing Failed Request Tracing Rules feature selected.":::

1. In the **Actions** pane, select **Add...**.
1. In the **Add Failed Request Tracing Rule** wizard, on the **Specify Content to Trace** page, select **All content (\*)** and then select **Next**.  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/add-frtr-wizard-all-selected.png" alt-text="Screenshot shows Add Failed Request Tracing Rule Wizard. All content option is selected on the Specify Content to Trace page.":::
1. On the **Define Trace Conditions** page, select the **Status code(s)** checkbox and enter _404.2_ as the status code to trace.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/add-frtr-define-trace-conditions.png" alt-text="Screenshot of Add Failed Request Tracing Rule showing Define Trace Conditions page and 404 point 2 entered as the status code.":::
1. Select **Next**.
1. On the **Select Trace Providers** page, under **Providers**, select the **WWW Server** checkbox and clear all other checkboxes. Under **Areas**, select the **Security** checkbox and clear all other checkboxes.

    The problem that you're generating causes a security error trace event to be thrown. In general, authentication and authorization (including ISAPI restriction list issues) problems can be diagnosed by using the WWW Server - Security area configuration for tracing. However, because the _FREB.xsl_ style sheet helps highlight errors and warnings, you can still use the default configuration to log all events in all areas and providers.
1. Under **Verbosity**, select **Verbose**.

    > [!NOTE]
    > When you install the Tracing role service, IIS installs the WWW Server, ASP, and ISAPI Extension trace providers by default. If you install ASP.NET 2.0 or above, IIS automatically adds the ASPNET trace provider. Additional providers are installed by the Application Request Routing (ARR) installer package, which also installs the URL Rewrite module, Web Farm Management, and External Cache. You can add more trace providers by using the `<add>` element within the `<traceProviderDefinitions>` element.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/add-frtr-www-server-security-selected.png" alt-text="Screenshot of Add Failed Request Tracing Rule Wizard showing WWW Server selected from Providers list and Security being selected from the Areas menu.":::
1. Select **Finish**.

1. You see the following definition for the **Default Web Site**:

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/frtr-www-server-404-2.png" alt-text="Screenshot of Failed Request Tracing Rules page showing WWW Server entered as Associated Provider and 404 point 2 as Status Code.":::

    IIS Manager writes the configuration to the `%systemdrive%\inetpub\wwwroot\web.config` file by using a `<location>` tag. The configuration should resemeble the following:
    
    ```xml
    <configuration> 
        <system.webServer> 
            <tracing> 
                <traceFailedRequests> 
                    <add path="*"> 
                        <traceAreas> 
                            <add provider="WWW Server" areas="Security" verbosity="Verbose" /> 
                        </traceAreas> 
                        <failureDefinitions statusCodes="404.2" /> 
                    </add> 
                </traceFailedRequests> 
            </tracing> 
        </system.webServer> 
    </configuration>
    ```

## Test and view the failure request log file

This section helps you to generate a failed request and view the resulting trace log. You already configured IIS to capture trace logs for `http://localhost/*.asp` requests that fail with an HTTP response code of 404.2. Now verify that it works.

### Step 1: Generate an error and the failure request log file

1. Open a new Internet Explorer window.
1. Enter the `http://localhost/test.asp` and press <kbd>ENTER</kbd>.
   The "HTTP Error 404.2 - Not Found" error message is displayed.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/ie-http-404-2-error.png" alt-text="Screenshot of Internet Explorer window displaying H T T P Error 404 point 2 dash Not Found message page.":::

### Step 2: View the failure request log file

1. Now that you have generated a failed request, open Windows Explorer and navigate to _%systemdrive%\\inetpub\\logs\\FailedReqLogFiles\\W3SVC1_.  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/w3svc1-fr-log.png" alt-text="Screenshot of W 3 S V C 1 folder in failed Req Log Files directory.":::

    > [!NOTE]
    > When IIS writes the failed request log file, it writes one file per failed request. A _freb.xsl_ style sheet is also written, one per directory. This helps when you view the resulting failure request log files (such as _fr000001.xml_ in this sample).

1. Right-click the log file for the 404.2 error, and select **Open With** -> **Internet Explorer**. If this is the first time that you're opening a Failed Request Tracing file, you must add **about:internet** to the list of trusted sites, since Internet Explorer's Enhanced Security Configuration is enabled by default. If so, you see the following:  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/ie-blocked-dialog.png" alt-text="Screenshot of Internet Explorer dialog box with Continue to prompt when website content is blocked option selected.":::

1. In the **Internet Explorer** dialog box, add **about:internet** to the list of trusted sites by the following steps:
    1. Select the **Tools** menu, and then select **Internet Options**.
    1. Select the **Security** tab.
    1. Select **Trusted Zone**, and then select **Sites**.
    1. This allows the XSL to work.
1. You see a Request Summary page after adding **about:internet** to the list of trusted sites:  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/request-summary-with-errors-warnings.png" alt-text="Screenshot of Request Summary page with the Errors and Warnings table displaying columns for Severity, Event and module Name.":::

    A summary of the failed request is logged at the top, with the **Errors & Warnings** table identifying any events that are `WARNING`, `ERROR`, or `CRITICAL ERROR` in severity. In this example, the `WARNING` severity level is due to ISAPI RESTRICTION. The image that you tried to load was _%windir%\\system32\\inetsrv\\asp.dll_.
1. Open the raw XML file directly by using a text editor, and look at the contents of the event.

## Summary

You have completed two tasks: configuring Failed Request Tracing to capture traces for any request that IIS returns with a 404.2 status code, and verifying that IIS captured the trace for your request. You also verified that the _freb.xml_ log file didn't contain any requests other than those with a 404.2 return code. When you consulted the failure log file, you determined that the cause of the failure was that the extension was disabled for that request. You can try other non-HTML pages (like .gif or .jpg files) and note that the log file doesn't add these traces. You can also easily change this event to be 404, or capture the failure if the request takes longer than 30 seconds by setting the _timeTaken_ field in your failureDefinitions.

## Restore your backup

Now that you have completed the tasks in this article, you can restore the backup of the configuration. Run the following command with administrator user rights:

```console
%windir%\system32\inetsrv\appcmd restore backup cleanInstall
```

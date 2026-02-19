---
title: Troubleshoot failed requests using tracing in IIS
description: Describes request-based tracing and how to troubleshoot failed requests with tracing in IIS.
ms.date: 02/19/2026
ms.reviewer: johnhart, riande, v-shaywood
ms.custom: sap:Health, Diagnostic, and Performance Features\Failed Request Tracing
---
# Troubleshoot failed requests by using tracing in IIS

_Applies to:_ &nbsp; Internet Information Services 8.5 and later

## Introduction

Request-based tracing is available both on standalone servers that run Internet Information Services (IIS) and in Azure App Service. If you can reproduce a problem that you're experiencing, request-based tracing provides a method to diagnose the problem and determine why it's occurring. Problems such as poor performance on some requests, authentication-related failures on other requests, or the server "500" error from ASP or ASP.NET can often be difficult to troubleshoot. You can make the job easier by capturing a trace of the problem when it occurs. This article discusses Failed Request Tracing on an IIS server.

Failed Request Tracing is designed to buffer the trace events for a request, and flush them to disk only if the request fails. You provide the definition of _failure_. You can use Failed Request Tracing for the following reasons:

- You want to know why your requests return a specific HTTP status code (for example, "401" or "404").
- A request takes a long time to process or isn't responding.

This article explains how to:

- Enable the Failed Request Tracing module.
- Configure Failed Request Tracing log file semantics.
- Designate the URL to process failed request traces for, including failure definitions and areas to trace.
- Generate the failure condition, and view the resulting trace.

## Prerequisites

### Install tracing feature for IIS

Install the following IIS features:

- ASP.NET 3.5
  - **Web Server (IIS)** > **Web Server** > **Application Development Features** > **ASP.NET 3.5**
- ASP.NET 4.5
  - **Web Server (IIS)** > **Web Server** > **Application Development Features** > **ASP.NET 4.5**
- Tracing
  - **Web Server (IIS)** > **Web Server** > **Health and Diagnostics - Tracing**

### Sign in as administrator

Make sure that the account that you use to sign in is the administrator account or is in the administrators group.

> [!NOTE]
> Being in the administrators group doesn't grant you complete administrator user rights by default. In order to run applications as an administrator, right-click the application icon, and then select **Run as administrator**.

### Make a backup

Before you begin, back up the configuration files:

1. Press the Windows logo key + X, select **Terminal (Admin)**, if the User Account Control (UAC) dialog appears select **Yes**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/cmd-admin-in-task-bar.png" alt-text="Terminal Admin icon on the Quick Link menu.":::

1. At the command prompt, run the following command:

    ```console
    %windir%\system32\inetsrv\appcmd add backup cleanInstall
    ```

    This command creates a _cleanInstall_ folder that contains backup configuration files in _%windir%\\system32\\inetsrv\\backup_.

### Create sample content

1. Go to _%systemdrive%\inetpub\wwwroot_.
1. Move the content to a secure location (in case you want to restore the existing content) or delete it.
1. Create a blank file, and name it _test.asp_.
1. At the command prompt, go to the _test.asp_ file in _\\inetpub\\wwwroot_.
1. In the _test.asp_ file, paste the following content:

    ```html
    <h2>Failed Request Tracing Lab</h2><br>
    <br>Today's date is <% response.write(Date()) %>
    ```

### Disable ASP

In order to perform this task, you must disable ASP. Follow these steps:

1. Open IIS Manager, and select the server.
1. Double-click **ISAPI and CGI Restrictions**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/iis-manager-pane-isapi-cgi-selected.png" alt-text="The IIS Manager pane showing ISAPI and CGI Restrictions selected.":::

1. In the **ISAPI and CGI Restrictions** pane, select **Active Server Pages**. In the **Actions** pane, select **Deny** to disable ASP. Active Server Pages shows as **Not Allowed**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/isapi-cgi-restriction-pane.png" alt-text="The ISAPI and CGI Restrictions pane showing Active Server Pages selected. The Deny option is selected in the Actions pane.":::

## Enable Failed Request Tracing

After you enable Failed Request Tracing, you have to configure the path of the log files. In this section, you enable Failed Request Tracing for the default web site and specify where to store the log files. Then, you configure the failure to generate failure logs for.

### Step 1: Enable failed request tracing for the site and configure the log file directory

1. Open an administrative Command Prompt window, and go to _%systemdrive%\\windows\\system32\\inetsrv_.
1. Run `inetmgr` to open IIS Manager.
1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
1. In the **Actions** pane, go to **Configure**, and then select **Failed Request Tracing…**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/actions-frt-option-under-configure.png" alt-text="Screenshot of Actions pane showing Failed Request Tracing option is highlighted under Configure tab.":::

1. In the **Edit Website Failed Request Tracing Settings** dialog box, configure the following settings:

    - Select the **Enable** checkbox.
    - Keep the defaults for the other settings.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/edit-web-site-frt-settings-dialog.png" alt-text="The Edit Web Site Failed Request Tracing Settings dialog box showing a command populating the Directory field and the Enable checkbox selected.":::

1. Select **OK**.

    Failed Request Tracing logging is now enabled for the Default Web Site selection. Check the _%windir%\\system32\\inetsrv\\config\\applicationHost.config_ file to verify that the configuration resembles the following example:

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

In this step, you configure the failure definitions for your URL, including which areas to trace. You troubleshoot a "404.2" status code that IIS returns for any requests to extensions that you didn't enable. This step helps you determine which particular extensions you have to enable:

1. Open an administrative Command Prompt window, and go to _%systemdrive%\\windows\\system32\\inetsrv_.
1. Run `inetmgr` to open IIS Manager.
1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
1. Double-click **Failed Request Tracing Rules**.  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/defalut-web-site-home-pane-frt-rules.png" alt-text="The Default Web Site Home pane showing the Failed Request Tracing Rules feature selected.":::

1. In the **Actions** pane, select **Add**.
1. In the **Add Failed Request Tracing Rule** wizard, on the **Specify Content to Trace** page, select **All content (\*)**, and then select **Next**.  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/add-frtr-wizard-all-selected.png" alt-text="The Add Failed Request Tracing Rule Wizard. All content option is selected on the Specify Content to Trace page.":::
1. On the **Define Trace Conditions** page, select the **Status code(s)** checkbox, and then enter _404.2_ as the status code to trace.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/add-frtr-define-trace-conditions.png" alt-text="The Add Failed Request Tracing Rule showing Define Trace Conditions page and 404 point 2 entered as the status code.":::
1. Select **Next**.
1. On the **Select Trace Providers** page, under **Providers**, select the **WWW Server** checkbox and clear all other checkboxes. Under **Areas**, select the **Security** checkbox and clear all other checkboxes.

    The problem that you generate causes a security error trace event to be thrown. In general, you can diagnose authentication and authorization problems (including ISAPI restriction list issues) by using the WWW Server - Security area configuration for tracing. However, because the _FREB.xsl_ style sheet helps highlight errors and warnings, you can still use the default configuration to log all events in all areas and providers.
1. Under **Verbosity**, select **Verbose**.

    > [!NOTE]
    > By default, when you install the Tracing role service, IIS installs the WWW Server, ASP, and ISAPI Extension trace providers. If you install ASP.NET 2.0 or a later version, IIS automatically adds the ASPNET trace provider. Additional providers are installed by the Application Request Routing (ARR) installer package that also installs the URL Rewrite module, Web Farm Management, and External Cache. You can add more trace providers by using the `<add>` element within the `<traceProviderDefinitions>` element.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/add-frtr-www-server-security-selected.png" alt-text="The Add Failed Request Tracing Rule Wizard showing WWW Server selected on the Providers list and Security selected in the Areas menu.":::
1. Select **Finish**.

You see the following definition for **Default Web Site**.

:::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/frtr-www-server-404-2.png" alt-text="The Failed Request Tracing Rules page showing WWW Server entered as Associated Provider and 404 point 2 as Status Code.":::

IIS Manager writes the configuration to the `%systemdrive%\inetpub\wwwroot\web.config` file by using a `<location>` tag. The configuration should resemble the following example:

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

This section shows you how to generate a failed request and view the resulting trace log. You already configured IIS to capture trace logs for `http://localhost/*.asp` requests that fail and return an HTTP response code of "404.2." Now, you want to verify that the configuration works.

### Step 1: Generate an error and the failure request log file

1. Open a new Internet Explorer window.
1. Enter `http://localhost/test.asp`, and press <kbd>Enter</kbd>. The "HTTP Error 404.2 - Not Found" error message is displayed.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/ie-http-404-2-error.png" alt-text="The Internet Explorer window displaying H T T P Error 404 point 2 dash Not Found message page.":::

### Step 2: View the failure request log file

1. After you generate a failed request, open File Explorer, and go to _%systemdrive%\\inetpub\\logs\\FailedReqLogFiles\\W3SVC1_.  

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/w3svc1-fr-log.png" alt-text="The W 3 S V C 1 folder in the failed Req Log Files folder.":::

    > [!NOTE]
    > When IIS writes the failed request log file, it writes one file per failed request. It also writes one _freb.xsl_ style sheet per directory. This style sheet helps you to view the resulting failure request log files (such as _fr000001.xml_ in this sample).

1. Right-click the log file for the "404.2" error, and then select **Open With** > **Internet Explorer**. If you're opening a Failed Request Tracing file for the first time, you must add **about:internet** to the list of trusted sites. This step is necessary because the Internet Explorer Enhanced Security Configuration is enabled by default. In this situation, you see a dialog box that contains a **Continue to prompt when website content is blocked** option.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/ie-blocked-dialog.png" alt-text="The Internet Explorer dialog box showing the Continue to prompt when website content is blocked option selected.":::

1. In the **Internet Explorer** dialog box, add **about:internet** to the list of trusted sites. Follow these steps:
    1. Select the **Tools** menu, then select **Internet Options**.
    1. Select the **Security** tab.
    1. Select **Trusted Zone**, then select **Sites**. This step enables the XSL to work.
1. After you add **about:internet** to the list of trusted sites, you see a Request Summary page.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-85/request-summary-with-errors-warnings.png" alt-text="Request Summary page showing the Errors and Warnings table that displays columns for Severity, Event, and module Name.":::

    A summary of the failed request is logged at the top. The **Errors & Warnings** table identifies any events that are labeled as `WARNING`, `ERROR`, or `CRITICAL ERROR` in severity. In this example, the `WARNING` severity level is assigned because of the ISAPI RESTRICTION. The image that you tried to load is _%windir%\\system32\\inetsrv\\asp.dll_.
1. Open the raw XML file directly by using a text editor, and examine the contents of the event.

## Summary

You completed two tasks:

- Configuring Failed Request Tracing to capture traces for any request that IIS returns and that has a "404.2" status code
- Verifying that IIS captured the trace for your request

You also verified that the _freb.xml_ log file doesn't contain any requests other than those requests that show a "404.2" return code. When you consulted the failure log file, you determined that the cause of the failure was that the extension is disabled for that request. You can try other non-HTML pages (such as .gif or .jpg files), and see that the log file doesn't add these traces. You can also easily change this event to be a "404" event. If the request takes longer than 30 seconds, you can capture the failure by setting the _timeTaken_ field as a _failureDefinitions_ value.

## Restore your backup

After you complete the tasks in this article, restore the configuration backup. Run the following command by having administrator user rights:

```console
%windir%\system32\inetsrv\appcmd restore backup cleanInstall
```

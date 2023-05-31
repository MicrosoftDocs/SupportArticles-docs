---
title: Troubleshoot failed requests using tracing in IIS 7
description: Request-based tracing provides a way to determine what exactly is happening with your requests and why if you can reproduce the problem.
ms.date: 12/12/2007
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart, riande
---
# Troubleshoot failed requests using tracing in IIS 7

Request-based tracing is available both in stand-alone IIS servers and on Azure web apps and provides a way to determine what exactly is happening with your requests and why, if you can reproduce the problem that you're experiencing. Problems like poor performance on some requests, or authentication-related failures on other requests, or the server 500 error from ASP or ASP.NET can often be difficult to troubleshoot--unless you have captured the trace of the problem when it occurs. This article discusses failed-request tracing on IIS Server. For information about doing this with Azure web apps, see [Troubleshoot an app in Azure App Service using Visual Studio](/azure/app-service/troubleshoot-dotnet-visual-studio).

Failed-request tracing is designed to buffer the trace events for a request and only flush them to disk if the request fails, where you provide the definition of "failure". If you want to know why you're getting 404.2 error messages or request start hanging, use failed-request tracing.

The tasks that are illustrated in this article include:

- Enabling the failed-request tracing module
- Configuring failed-request tracing log-file semantics
- Defining the URL for which to keep failed request traces, including failure definitions and areas to trace
- Generating the failure condition and viewing the resulting trace

## Prerequisites

### Install IIS

You must install IIS 7 or above before you can perform the tasks in this article. Browse to `http://localhost/` to see if IIS is installed. If IIS isn't installed, see [Installing IIS on Windows Server 2008](/iis/install/installing-iis-7/installing-iis-7-and-above-on-windows-server-2008-or-windows-server-2008-r2) for installation instructions. When installing IIS, make sure that you also install the following features:

- ASP.NET (under World Wide Web Services - Application Development Features - ASP.NET)
- Tracing (under World Wide Web Services - Health and Diagnostics - Tracing)

### Log in as administrator

Ensure that the account that you use to log in is the administrator account or is in the Administrators group.

> [!NOTE]
> Being in the Administrators group doesn't grant you complete administrator user rights by default. You must run applications as administrator, which you can do by right-clicking on the application icon and selecting **Run as administrator**.

### Make a backup

You must make a backup of the configuration before doing the following tasks.

#### To make a backup of the configuration

1. Select **Start** > **All Programs** > **Accessories**.
1. Right-click **Command Prompt**, and then Select **Run as administrator**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/command-prompt-run-as-admin.jpg" alt-text="Screenshot that shows the context menu for Command Prompt, with Run as administrator selected.":::

1. In a command prompt, run the following command:

    ```console
    %windir%\system32\inetsrv\appcmd add backup cleanInstall
    ```

### Create sample content

1. Navigate to `%systemdrive%\inetpub\wwwroot`.
1. Move the content to a secure location (in case you want to restore the existing content) or delete it.
1. Create a blank file and name it _test.asp_.
1. In the command prompt, navigate to the _test.asp_ file in _\inetpub\wwwroot_.
1. In the _test.asp_ file, paste the following content:

    ```html
    <h2>Failed Request Tracing Lab</h2><br>
    <br>Today's date is <% response.write(Date()) %>
    ```

### Disable ASP

ASP must be disabled for this task. ASP is disabled only as an example and for the purposes of the tasks in this article.

#### To disable ASP

1. Open Internet Information Services (IIS) Manager.
1. Double-click **ISAPI and CGI Restrictions**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/iis-with-isapi-cgi-restriction-selected.jpg" alt-text="Screenshot that shows the I I S Manager with I S A P I and C G I Restrictions selected.":::

1. Select **Active Server Pages**. In the **Actions** pane, select **Deny** to disable ASP.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/isapi-cgi-restriction-actions-pane.jpg" alt-text="Screenshot that shows the I S A P I and C G I Restrictions and Actions pane open.":::

## Enable Failed-Request Tracing

After you enable failed-request tracing, you need to configure where the log files will reside. In this task, you'll enable failed-request tracing for the default web site and specify where to put the log files. You'll then configure the failure for which to generate failure logs.

### Step 1: Enable Failed-Request Tracing for the Site and Configure the Log File Directory

1. Open a command prompt with administrator user rights.
1. Launch **inetmgr**.
1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
1. In the **Actions** pane, under **Configure**, select **Failed Request Tracing**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/show-failed-request-tracing.jpg" alt-text="Screenshot that shows Failed Request Tracing under Configure.":::

1. In the **Edit Web Site Failed Request Tracing Settings** dialog box, configure the following:
   - Select the **Enable** check box.
   - Keep the defaults for the other settings.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/edit-web-site-failed-request-tracing-settings-dialog.jpg" alt-text="Screenshot that shows the Edit Web Site Failed Request Tracing Settings dialog box, with Enable selected.":::

1. Select **OK**.

Failed-request tracing logging is now enabled for the Default Web Site. Check the _%windir%\system32\inetsrv\config\applicationHost_.config file to confirm that the configuration looks as follows:

```xml
<system.applicationHost>
   <sites> 
      <!-- site & app defaults --> 
      <site name="Default Web Site" id="1"> 
         <!-- other site configuration --> 
         <traceFailedRequestsLogging  enabled="true" /> 
      </site> 
   </sites> 
</system.applicationHost>
```

### Step 2: Configure your failure definitions

In this step, you'll configure the failure definitions for your URL, including what areas to trace. You'll troubleshoot a 404.2 that is returned by IIS for any requests to extensions that haven't yet been enabled. This helps you determine which particular extensions you'll need to enable.

1. Open a command prompt with administrator user rights.
1. Launch **inetmgr**.
1. In the **Connections** pane, expand the machine name, expand **Sites**, and then select **Default Web Site**.
1. Double-click **Failed Request Tracing Rules**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/failed-request-tracing-rules-selected.jpg" alt-text="Screenshot that shows Default Web Site Home pane, and Failed Request Tracing Rules is selected.":::

1. Select **Finish**.
1. In the **Actions** pane, select **Add**.
1. In the **Add Failed Request Tracing Rule** wizard, on the **Specify Content to Trace** page, select **All content (\*)**. Select **Next**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/add-failed-request-tracing-rule-wizard.jpg" alt-text="Screenshot that shows the Add Failed Request Tracing Rule wizard, with All content selected.":::

1. On the **Define Trace Conditions** page, select the **Status code(s)** check box and enter **404.2** as the status code to trace.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/define-trace-conditions.jpg" alt-text="Screenshot that shows the Define Trace Conditions page. Status code is selected with 404 dot 2 in the Status code field.":::

1. Select **Next**.
1. On the **Select Trace Providers** page, under **Providers**, select the **WWW Server** check box. Under **Areas**, select the **Security** check box and clear all other check boxes. The problem that you're generating causes a security error trace event to be thrown. In general, authentication and authorization (including ISAPI restriction list issues) problems can be diagnosed by using the WWW Server - Security area configuration for tracing. However, because the _FREB.xsl_ style sheet helps highlight errors and warnings, you can still use the default configuration to log all events in all areas and providers. Under **Verbosity**, select **Verbose**.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/select-trace-providers.jpg" alt-text="Screenshot that shows the Select Trace Providers page. W W W Server is selected under Providers, and Security is selected under Verbose.":::

1. Select **Finish**. You should see the following definition for the **Default Web Site**:

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/failed-request-tracing-rules-pane.jpg" alt-text="Screenshot that shows the Failed Request Tracing Rules pane. W W W Server is listed under Associated Providers.":::

IIS Manager writes the configuration to the `%windir%\system32\inetsrv\config\applicationHost.config` file by using a `<location>` tag. The configuration should look as follows:

```xml
<location path="Default Web Site"> 
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
</location>
```

## Test and view the failure request log file

In this task, you'll generate a failed request and view the resulting trace log. You already configured IIS to capture trace logs for `http://localhost/\*.asp` requests that fail with an HTTP response code of 404.2. Now verify that it works.

### Step 1: Generate an error and the failure request log file

1. Open a new Internet Explorer window.
1. Type in the following address: `http://localhost/test.asp`.
1. You should see the following:

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/web-page-titled-server-error.png" alt-text="Screenshot that shows a web page titled Server Error in Application Default Web Site. Under Error Summary, it says H T T P Error 404 dot 2 Not Found.":::

### Step 2: View the failure request log file

1. Now that you have generated a failed request, open a command prompt with administrator user rights and navigate to `%systemdrive%\inetpub\logs\FailedReqLogFiles\W3SVC1`.
1. Run **start** to start an Internet Explorer window from the directory.

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/ie-to-w3svc1.jpg" alt-text="Screenshot that shows Internet Explorer navigating to the W 3 S V C 1 path. Two files are listed, freb and f r 0 0 0 0 0 1.":::

1. Notice a few things here: When IIS writes the failed request log file, it writes one file *per failed request*. A *freb.xsl* style sheet is also written, one per directory. This helps when you view the resulting failure request log files (such as *fr000001.xml* above).
1. Right-click the log file for the 404.2 error, and select **Open With > Internet Explorer**. If this is the first time that you're opening a failed request tracing file, you must add **about:internet** to the list of trusted sites, since Internet Explorer's Enhanced Security Configuration is enabled by default. If so, you see the following:

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/ie-enhanced-security-configuration-dialog.png" alt-text="Screenshot that shows a dialog box for Internet Explorer Enhanced Security Configuration. About colon internet is blocked.":::

1. In the **Internet Explorer** dialog box, select **Add…** to add **about:internet** to the list of trusted sites. This allows the XSL to work. You'll see the following after adding **about:internet** to the list of trusted sites:

    :::image type="content" source="media/troubleshoot-failed-requests-using-tracing-in-iis-7/ie-request-summary-selected.png" alt-text="Screenshot that shows Internet Explorer. The Request Summary tab is selected, and two warnings are listed.":::

    A summary of the failed request is logged at the top, with the **Errors &amp; Warnings** table identifying any events that are **WARNING**, **ERROR**, or **CRITICAL ERROR** in **Severity**. In this example, the **WARNING** severity level is due to ISAPI RESTRICTION. The image that you tried to load was `%windir%\system32\inetsrv\asp.dll`.
1. Open the raw XML file directly by using a text editor, and look at the contents of each event.

## Summary

You have completed two tasks: configured failed request tracing to capture traces for \* if IIS returns it with a 404.2 status code; and verified that IIS captured the trace for your request. You also verified that the _freb\*.xml_ log file didn't contain any other requests for the requests that you made because the requests didn't have a 404.2 return code. When you consult the failure log file, you determined that the cause of the failure was that the extension was disabled for that request. You can try other non-HTML pages (like _.gif_ or _.jpg_ files) and note that the log file does NOT add these traces. You can also easily change this to be 404, or capture the failure if the request takes longer than 30 seconds by setting the _timeTaken_ field in your failureDefinitions.

## Restore your backup

Now that you have completed the tasks in this article, you can restore the backup of the configuration. Run the following command with administrator user rights:

```console
%windir%\system32\inetsrv\appcmd restore backup cleanInstall
```

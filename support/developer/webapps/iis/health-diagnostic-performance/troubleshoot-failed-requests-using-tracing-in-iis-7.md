---
title: "Troubleshooting Failed Requests Using Tracing in IIS 7"
author: rick-anderson
description: "Request-based tracing provides a way to determine what exactly is happening with your requests and why, provided that you can reproduce the problem that you..."
ms.date: 12/12/2007
ms.assetid: a0e48aad-f184-4459-b059-d5e7ba58883e
msc.legacyurl: /learn/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis
msc.type: authoredcontent
---
# Troubleshooting Failed Requests Using Tracing in IIS 7

Request-based tracing is available both in stand-alone IIS Servers and on Azure web apps and provides a way to determine what exactly is happening with your requests and why, provided that you can reproduce the problem that you are experiencing. Problems like poor performance on some requests, or authentication-related failures on other requests, or the server 500 error from ASP or ASP.NET can often be difficult to troubleshoot--unless you have captured the trace of the problem when it occurs. the following article discusses failed request tracing on IIS Server. For information about doing this with Azure web apps, see [Troubleshoot an app in Azure App Service using Visual Studio](/azure/app-service/troubleshoot-dotnet-visual-studio).

Failed-request tracing is designed to buffer the trace events for a request and only flush them to disk if the request "fails," where you provide the definition of "failure". If you want to know why you're getting 404.2 error messages or request start hanging, use failed-request tracing.

The tasks that are illustrated in this article include:

- Enabling the failed-request tracing module
- Configuring failed-request tracing log-file semantics
- Defining the URL for which to keep failed request traces, including failure definitions and areas to trace
- Generating the failure condition and viewing the resulting trace

## Prerequisites

### Install IIS

You must install IIS 7 or above before you can perform the tasks in this article. Browse to `http://localhost/` to see if IIS is installed. If IIS is not installed, see [Installing IIS on Windows Server 2008](../../install/installing-iis-7/installing-iis-7-and-above-on-windows-server-2008-or-windows-server-2008-r2.md) for installation instructions. When installing IIS, make sure that you also install the following:

- ASP.NET (under World Wide Web Services - Application Development Features - ASP.NET)
- Tracing (under World Wide Web Services - Health and Diagnostics - Tracing)

### Log In as Administrator

Ensure that the account that you use to log in is the administrator account or is in the Administrators group.

> [!NOTE]
> Being in the Administrators group does not grant you complete administrator user rights by default. You must run applications as Administrator, which you can do by right-clicking on the application icon and selecting **Run as administrator**.

### Make a Backup

You must make a backup of the configuration before doing the following tasks.

#### To make a backup of the configuration

1. Click **Start** > **All Programs** > **Accessories**.
2. Right-click **Command Prompt**, and then click **Run as administrator**.

    ![Screenshot that shows the context menu for Command Prompt, with Run as administrator selected.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image1.jpg)

3. In a command prompt, run the following command:

    [!code-console[Main](troubleshooting-failed-requests-using-tracing-in-iis/samples/sample1.cmd)]

### Create Sample Content

1. Navigate to `%systemdrive%\inetpub\wwwroot`.
2. Move the content to a secure location (in case you want to restore the existing content) or delete it.
3. Create a blank file and name it test.asp.
4. In the command prompt, navigate to the test.asp file in \inetpub\wwwroot.
5. In the test.asp file, paste the following content:

    [!code-html[Main](troubleshooting-failed-requests-using-tracing-in-iis/samples/sample2.html)]

### Disable ASP

ASP must be disabled for this task. ASP is disabled only as an example and for the purposes of the tasks in this article.

#### To disable ASP

1. Open IIS Manager.
2. Double-click **ISAPI and CGI Restrictions**.

    ![Screenshot that shows the I I S Manager with I S A P I and C G I Restrictions selected.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image3.jpg)

3. Select **Active Server Pages**. In the **Actions** pane, click **Deny** to disable ASP.

    ![Screenshot that shows the I S A P I and C G I Restrictions and Actions pane open.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image5.jpg)

## Enable Failed-Request Tracing

After you enable failed-request tracing, you need to configure where the log files will reside. In this task, you will enable failed-request tracing for the Default Web Site and specify where to put the log files. You will then configure the failure for which to generate failure logs.

### Step 1 : Enable Failed-Request Tracing for the Site and Configure the Log File Directory

1. Open a command prompt with administrator user rights.
2. Launch **inetmgr**.
3. In the **Connections** pane, expand the machine name, expand **Sites**, and then click **Default Web Site**.
4. In the **Actions** pane, under **Configure**, click **Failed Request Tracing**.

    ![Screenshot that shows Failed Request Tracing under Configure.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image7.jpg)

5. In the **Edit Web Site Failed Request Tracing Settings** dialog box, configure the following:
   - Select the **Enable** check box.
   - Keep the defaults for the other settings.

     ![Screenshot that shows the Edit Web Site Failed Request Tracing Settings dialog box, with Enable selected.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image10.jpg)

6. Click **OK**.

Failed-request tracing logging is now enabled for the Default Web Site. Check the %*windir*%\system32\inetsrv\config\applicationHost.config file to confirm that the configuration looks as follows:

[!code-xml[Main](troubleshooting-failed-requests-using-tracing-in-iis/samples/sample3.xml)]

### Step 2 : Configure Your Failure Definitions

In this step, you will configure the failure definitions for your URL, including what areas to trace. You will troubleshoot a 404.2 that is returned by IIS for any requests to extensions that have not yet been enabled. This will help you determine which particular extensions you will need to enable.

1. Open a command prompt with administrator user rights.
2. Launch **inetmgr**.
3. In the **Connections** pane, expand the machine name, expand **Sites**, and then click **Default Web Site**.
4. Double-click **Failed Request Tracing Rules**.

    ![Screenshot that shows Default Web Site Home pane, and Failed Request Tracing Rules is selected.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image12.jpg)

5. Click **Finish**.
6. In the **Actions** pane, click **Add**.
7. In the **Add Failed Request Tracing Rule** wizard, on the **Specify Content to Trace** page, select **All content (\*)**. Click **Next**.

    ![Screenshot that shows the Add Failed Request Tracing Rule wizard, with All content selected.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image15.jpg)

8. On the **Define Trace Conditions** page, select the **Status code(s)** check box and enter **404.2** as the status code to trace.

    ![Screenshot that shows the Define Trace Conditions page. Status code is selected with 404 dot 2 in the Status code field.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image18.jpg)

9. Click **Next**.
10. On the **Select Trace Providers** page, under **Providers**, select the **WWW Server** check box. Under **Areas**, select the **Security** check box and clear all other check boxes. The problem that you are generating causes a security error trace event to be thrown. In general, authentication and authorization (including ISAPI restriction list issues) problems can be diagnosed by using the WWW Server – Security area configuration for tracing. However, because the FREB.xsl style sheet helps highlight errors and warnings, you can still use the default configuration to log all events in all areas and providers. Under **Verbosity**, select **Verbose**.

    ![Screenshot that shows the Select Trace Providers page. W W W Server is selected under Providers, and Security is selected under Verbose.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image21.jpg)

11. Click **Finish**. You should see the following definition for the **Default Web Site**:

    ![Screenshot that shows the Failed Request Tracing Rules pane. W W W Server is listed under Associated Providers.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image23.jpg)

IIS Manager writes the configuration to the `%windir%\system32\inetsrv\config\applicationHost.config` file by using a `<location>` tag. The configuration should look as follows:

[!code-xml[Main](troubleshooting-failed-requests-using-tracing-in-iis/samples/sample4.xml)]

## Test and View the Failure Request Log File

In this task, you will generate a failed request and view the resulting trace log. You already configured IIS to capture trace logs for `http://localhost/\*.asp` requests that fail with an HTTP response code of 404.2. Now verify that it works.

### Step 1 : Generate an Error and the Failure Request Log File

1. Open a new Internet Explorer window.
2. Type in the following address: `http://localhost/test.asp`.
3. You should see the following:

    ![Screenshot that shows a web page titled Server Error in Application Default Web Site. Under Error Summary, it says H T T P Error 404 dot 2 Not Found.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image1.png)

### Step 2 : View the Failure Request Log File

1. Now that you have generated a failed request, open a command prompt with administrator user rights and navigate to `%systemdrive%\inetpub\logs\FailedReqLogFiles\W3SVC1`.
2. Run **start** to start an Internet Explorer window from the directory.

    ![Screenshot that shows Internet Explorer navigating to the W 3 S V C 1 path. Two files are listed, freb and f r 0 0 0 0 0 1.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image25.jpg)

3. Notice a few things here: When IIS writes the failed request log file, it writes one file *per failed request*. A *freb.xsl* style sheet is also written, one per directory. This helps when you view the resulting failure request log files (such as *fr000001.xml* above).
4. Right-click the log file for the 404.2 error, and click **Open With > Internet Explorer**. If this is the first time that you are opening a Failed Request Tracing file, you must add **about:internet** to the list of trusted sites, since Internet Explorer's Enhanced Security Configuration is enabled by default. If this is the case, you will see the following:

    ![Screenshot that shows a dialog box for Internet Explorer Enhanced Security Configuration. About colon internet is blocked.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image3.png)

5. In the **Internet Explorer** dialog box, click **Add…** to add **about:internet** to the list of trusted sites. This allows the XSL to work. You will see the following after adding **about:internet** to the list of trusted sites:

    ![Screenshot that shows Internet Explorer. The Request Summary tab is selected, and two warnings are listed.](troubleshooting-failed-requests-using-tracing-in-iis/_static/image5.png)

    A summary of the failed request is logged at the top, with the **Errors &amp; Warnings** table identifying any events that are WARNING, ERROR, or CRITICAL ERROR in severity. In this example, the WARNING severity level is due to ISAPI RESTRICTION. The image that you tried to load was `%windir%\system32\inetsrv\asp.dll`.
6. Open the raw XML file directly by using a text editor, and look at the contents of each event.

## Summary

You have completed two tasks: configured failed request tracing to capture traces for \* if IIS returns it with a 404.2 status code; and verified that IIS captured the trace for your request. You also verified that the freb\*.xml log file did not contain any other requests for the requests that you made because the requests did not have a 404.2 return code. When you consult the failure log file, you determined that the cause of the failure was that the extension was disabled for that request. You can try other non-HTML pages (like gifs or jpgs) and note that the log file does NOT add these traces. You can also easily change this to be 404, or capture the failure if the request takes longer than 30 seconds by setting the *timeTaken* field in your failureDefinitions.

## Restore Your Backup

Now that you have completed the tasks in this article, you can restore the backup of the configuration. Run the following command with administrator user rights:

[!code-console[Main](troubleshooting-failed-requests-using-tracing-in-iis/samples/sample5.cmd)]
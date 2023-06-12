---
title: "Troubleshooting Failed Requests Using Tracing in IIS 8.5"
author: rick-anderson
description: "Request-based tracing is available both in stand-alone IIS Servers and on Windows Azure Web Sites (WAWS) and provides a way to determine what exactly is happ..."
ms.date: 02/20/2014
ms.assetid: d8b90f33-0d56-49a6-99d8-df8d4e34f2b0
msc.legacyurl: /learn/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis-85
msc.type: authoredcontent
---
# Troubleshooting Failed Requests Using Tracing in IIS 8.5

by [Jim van de Erve](https://twitter.com/jimvde)

## Introduction

Request-based tracing is available both in stand-alone IIS Servers and on Windows Azure Web Sites (WAWS) and provides a way to determine what exactly is happening with your requests and why it is happening, provided that you can reproduce the problem that you are experiencing. Problems like poor performance on some requests, or authentication-related failures on other requests, or the server 500 error from ASP or ASP.NET can often be difficult to troubleshoot--unless you have captured the trace of the problem when it occurs. the following article discusses failed request tracing on IIS Server. For information about doing this with Windows Azure Web Sites [, click here](https://www.windowsazure.com/develop/net/tutorials/troubleshoot-web-sites-in-visual-studio/).

Failed-request tracing is designed to buffer the trace events for a request and only flush them to disk if the request "fails," where you provide the definition of "failure". If you want to know why your requests are returning a specific HTTP status code, e.g., 401 or 404, or if a request is taking a while to process or is not responding, then you can use failed request tracing.

The tasks that are illustrated in this article include:

- Enabling the failed-request tracing module
- Configuring failed-request tracing log-file semantics
- Defining the URL for which to keep failed request traces, including failure definitions and areas to trace
- Generating the failure condition and viewing the resulting trace

## Prerequisites

### Install IIS

You must install IIS 8.5 before you can perform the tasks in this article. Browse to `http://localhost/` and verify that the Internet Information Services splash screen is displayed. If IIS is not installed, see [Installing IIS 8.5 on Windows Server 2012 R2](../../install/installing-iis-85/installing-iis-85-on-windows-server-2012-r2.md) for installation instructions. When installing IIS, make sure that you also install the following:

- ASP.NET 3.5 (under Web Server (IIS)/Web Server/Application Development Features/ASP.NET 3.5)
- ASP.NET 4.5 (under Web Server (IIS)/Web Server/Application Development Features/ASP.NET 4.5)
- Tracing (under Web Server (IIS)/Web Server/Health and Diagnostics - Tracing)

### Log In as Administrator

Ensure that the account that you use to log in is the administrator account or is in the Administrators group.

> [!NOTE]
> Being in the Administrators group does not grant you complete administrator user rights by default. You must run applications as Administrator, which you can do by right-clicking on the application icon and selecting **Run as administrator**.

### Make a Backup

You must make a backup of the configuration before doing the following tasks.

**To make a backup of the configuration:** 

1. Click the Windows logo key and the **X** key simultaneously, click **Command Prompt (Admin)**, and then click **Yes**.

[![Screenshot of Command Prompt Admin in Windows task bar.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image2.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image1.jpg)

1. In the command prompt, run the following command:

[!code-console[Main](troubleshooting-failed-requests-using-tracing-in-iis-85/samples/sample1.cmd)]

The above command creates a cleanInstall folder containing backup configuration files in `%windir%\system32\inetsrv\backup`.

### Create Sample Content

1. Navigate to `%systemdrive%\inetpub\wwwroot`.
2. Move the content to a secure location (in case you want to restore the existing content) or delete it.
3. Create a blank file and name it test.asp.
4. In the command prompt, navigate to the test.asp file in \inetpub\wwwroot.
5. In the test.asp file, paste the following content:

[!code-html[Main](troubleshooting-failed-requests-using-tracing-in-iis-85/samples/sample2.html)]

### Disable ASP

ASP must be disabled for this task. ASP is disabled only as an example and for the purposes of the tasks in this article.

**To disable ASP:** 

1. Open IIS Manager and select the server.
2. Double-click **ISAPI and CGI Restrictions**.

[![Screenshot of I I S Manager pane displaying I S A P I and C G I Restrictions selected.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image4.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image3.jpg)

1. In the **ISAPI and CGI Restrictions** pane, select **Active Server Pages**. In the **Actions** pane, click **Deny** to disable ASP ***.*** Active Server Pages will show as &quot;Not Allowed&quot;.

[![Screenshot of I S A P I and C G I Restrictions pane displaying Active Server Pages selected. Deny option is selected in Actions pane.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image6.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image5.jpg)

## Enable Failed-Request Tracing

After you enable failed-request tracing, you need to configure where the log files will reside. In this task, you will enable failed-request tracing for the Default Web Site and specify where to put the log files. You will then configure the failure for which to generate failure logs.

### Step 1: Enable Failed-Request Tracing for the Site and Configure the Log File Directory

1. Open a command prompt with administrator user rights, and navigate to `%systemdrive%\windows\system32\inetsrv`.
2. Launch **inetmgr**.
3. In the **Connections** pane, expand the machine name, expand **Sites**, and then click **Default Web Site**.
4. In the **Actions** pane, under **Configure**, click **Failed Request Tracing…**.

[![Screenshot of Actions pane showing Failed Request Tracing option is highlighted under Configure tab.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image8.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image7.jpg)

1. In the **Edit Website Failed Request Tracing Settings** dialog box, configure the following:

- Select the **Enable** check box.
- Keep the defaults for the other settings.

[![Screenshot displays Edit Web Site Failed Request Tracing Settings dialog box with command populating Directory field and Enable check box selected.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image11.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image10.jpg)

1. Click **OK**.

Failed-request tracing logging is now enabled for the Default Web Site. Check the %*windir*%\system32\inetsrv\config\applicationHost.config file to confirm that the configuration looks as follows:

[!code-xml[Main](troubleshooting-failed-requests-using-tracing-in-iis-85/samples/sample3.xml)]

### Step 2 : Configure Your Failure Definitions

In this step, you will configure the failure definitions for your URL, including what areas to trace. You will troubleshoot a 404.2 that is returned by IIS for any requests to extensions that have not yet been enabled. This will help you determine which particular extensions you will need to enable. For more information, see [The HTTP status code in IIS 7.0, IIS 7.5, and IIS 8.0](https://support.microsoft.com/kb/943891).

1. Open a command prompt with administrator user rights.
2. Launch **inetmgr**.
3. In the **Connections** pane, expand the machine name, expand **Sites**, and then click **Default Web Site**.
4. Double-click **Failed Request Tracing Rules**.  

    [![Screenshot of Default Web Site Home pane showing Failed Request Tracing Rules feature selected.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image13.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image12.jpg)
5. In the **Actions** pane, click **Add...**.
6. In the **Add Failed Request Tracing Rule** wizard, on the **Specify Content to Trace** page, select **All content (\*)**. Click **Next**.  

    [![Screenshot shows Add Failed Request Tracing Rule Wizard. All content option is selected on the Specify Content to Trace page.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image15.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image14.jpg)
7. On the **Define Trace Conditions** page, select the **Status code(s)** check box and enter **404.2** as the status code to trace.  

    [![Screenshot of Add Failed Request Tracing Rule showing Define Trace  Conditions page and 404 point 2 entered as the status code.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image17.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image16.jpg)
8. Click **Next**.
9. On the **Select Trace Providers** page, under **Providers**, select the **WWW Server** check box and clear all other check boxes. Under **Areas**, select the **Security** check box and clear all other check boxes. The problem that you are generating causes a security error trace event to be thrown. In general, authentication and authorization (including ISAPI restriction list issues) problems can be diagnosed by using the WWW Server – Security area configuration for tracing. However, because the FREB.xsl style sheet helps highlight errors and warnings, you can still use the default configuration to log all events in all areas and providers.

    Under **Verbosity**, select **Verbose**.

    > [!NOTE]
    > When you install the Tracing role service, IIS installs the WWW Server, ASP, and ISAPI Extension trace providers by default. For more information on these providers, see [IIS Providers](https://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/8a746865-32b1-4390-bce3-b85e54241cff.mspx?mfr=true) and [How to Create a Provider File for Request-Based Tracing](https://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/991e07c3-4143-48cc-ab39-8d49065a8388.mspx?mfr=true). If you install ASP.NET 2.0 or above, IIS automatically adds the ASPNET trace provider. Additional providers are installed by the Application Request Routing (ARR) installer package, which also installs the URL Rewrite module, Web Farm Management, and External Cache. You can add more trace providers by using the `<add>` element within the `<traceProviderDefinitions>` element.

    [![Screenshot of Add Failed Request Tracing Rule Wizard showing W W W Server selected from Providers list and Security being selected from the Areas menu.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image19.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image18.jpg)
10. Click **Finish**.

You should see the following definition for the **Default Web Site**:

[![Screenshot of Failed Request Tracing Rules page showing W W W Server entered as Associated Provider and 404 point 2 as Status Code.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image21.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image20.jpg)

IIS Manager writes the configuration to the `%systemdrive%\config inetpub\wwwroot\web.config` file by using a `<location>` tag. The configuration should look as follows:

[!code-xml[Main](troubleshooting-failed-requests-using-tracing-in-iis-85/samples/sample4.xml)]

## Test and View the Failure Request Log File

In this task, you will generate a failed request and view the resulting trace log. You already configured IIS to capture trace logs for http://localhost/\*.asp` requests that fail with an HTTP response code of 404.2. Now verify that it works.

### Step 1: Generate an Error and the Failure Request Log File

1. Open a new Internet Explorer window.
2. Type in the following address: `http://localhost/test.asp`.
3. You should see the following:

[![Screenshot of Internet Explorer window displaying H T T P Error 404 point 2 dash Not Found message page.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image23.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image22.jpg)

### Step 2: View the Failure Request Log File

1. Now that you have generated a failed request, open Windows Explorer and navigate to `%systemdrive%\inetpub\logs\FailedReqLogFiles\W3SVC1`.  

    [![Screenshot of W 3 S V C 1 in failed Req Log Files directory.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image25.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image24.jpg)

    Notice a few things here: When IIS writes the failed request log file, it writes one file *per failed request*. A *freb.xsl* style sheet is also written, one per directory. This helps when you view the resulting failure request log files (such as *fr000001.xml* above).
2. Right-click the log file for the 404.2 error, and click **Open With -&gt; Internet Explorer**. If this is the first time that you are opening a Failed Request Tracing file, you must add **about:internet** to the list of trusted sites, since Internet Explorer's Enhanced Security Configuration is enabled by default. If this is the case, you will see the following:  

    [![Screenshot of Internet Explorer dialog box with Continue to prompt when website content is blocked option selected.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image27.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image26.jpg)
3. In the **Internet Explorer** dialog box, add **about:internet** to the list of trusted sites by selecting the **Tools** menu, selecting **Internet Options**, clicking the **Security** tab, selecting **Trusted Zone**, and then selecting **Sites**. This allows the XSL to work. You will see the following after adding **about:internet** to the list of trusted sites:  

    [![Screenshot of Request Summary page with the Errors and Warnings table displaying columns for Severity, Event and module Name.](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image29.jpg)](troubleshooting-failed-requests-using-tracing-in-iis-85/_static/image28.jpg)

    A summary of the failed request is logged at the top, with the **Errors &amp; Warnings** table identifying any events that are WARNING, ERROR, or CRITICAL ERROR in severity. In this example, the WARNING severity level is due to ISAPI RESTRICTION. The image that you tried to load was `%windir%\system32\inetsrv\asp.dll`.
4. Open the raw XML file directly by using a text editor, and look at the contents of the event.

## Summary

You have completed two tasks: configuring failed request tracing to capture traces for any request that IIS returns with a 404.2 status code; and verifying that IIS captured the trace for your request. You also verified that the freb\*.xml log file did not contain any requests other than those with a 404.2 return code. When you consulted the failure log file, you determined that the cause of the failure was that the extension was disabled for that request. You can try other non-HTML pages (like gifs or jpgs) and note that the log file does NOT add these traces. You can also easily change this event to be 404, or capture the failure if the request takes longer than 30 seconds by setting the *timeTaken* field in your failureDefinitions.

## Restore Your Backup

Now that you have completed the tasks in this article, you can restore the backup of the configuration. Run the following command with administrator user rights:

[!code-console[Main](troubleshooting-failed-requests-using-tracing-in-iis-85/samples/sample5.cmd)]

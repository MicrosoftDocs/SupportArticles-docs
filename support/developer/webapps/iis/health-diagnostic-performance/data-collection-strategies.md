---
title: Data collection strategies of common IIS Web Server-related issues
description: This article describes the data collection strategies to troubleshoot common IIS Web Server-related issues in Windows Server.
ms.date: 10/28/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.reviewer: paulboc
ms.subservice: health-diagnostic-performance
---
# Data collection strategies to troubleshoot common IIS Web Server-related issues in Windows Server
The IIS web-server allows administrators, site owners and web-application owners a rich set of possibilities to generate telemetry and metrics on how hosted web applications are performing: from the IIS request logs, to failed request log tracing, event viewer entries and many more. These pieces of telemetry can be scattered in various places on the Windows Server that is running IIS and collecting all of them when troubleshooting problems may prove time consuming, especially if the number of hosted applications is large. The IIS support team has constructed a tool to help with this specific task: LogCather is a tool that allows the collection of IIS telemetry and configuration related data to one centralized location, allowing administrators to target the entire server or only a subset of the hosted applications, and to define a time period for which the data will be collected.
## Symptoms

Connection issues occur when you run ASP.NET, ASP.NET Core, or other kinds of websites and web applications on an IIS web server that's running on Windows Server.

> [!NOTE]
> The currently supported versions of Windows Server are Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012.

This article describes data collection strategies to troubleshoot common IIS web server-related issues.

### SSL and SSL server certificate issues

When you connect to an IIS-hosted website through HTTPS, the server and client (web browser) negotiate a Transport Layer Security (TLS) connection between them.

> [!NOTE]
> TLS is the updated version of the Secure Sockets Layer (SSL) technology, although "SSL" currently remains the more common term for security certificates.

During negotiation, IIS delivers a server certificate to the connecting client. The returned certificate may not be the expected certificate, and it may not be trusted by the client. This prevents the client from being able to complete the connection to the web server through TLS.

### Runtime exceptions and errors, including HTTP 4*xx* and 5*xx* status codes

When you access certain resources on IIS-hosted web applications or do certain actions while you browse these sites, the IIS web applications or websites randomly or consistently throw errors. You may receive "500"  status code error messages ("internal server" error) that report various error exceptions in the execution of server-side code for the website. You may also receive "400" status code error messages ("bad request") that are returned when you access web services such as ASP.NET Web API and you are trying to send data to a web service endpoint. Unexpected authentication prompts or "access denied" requests that are represented by the "401" and "403" status codes may also occur.

### Handler-mapping problems

Requests that are sent to the web server are mapped to a specific handler (for example: Managed .NET handler) and are registered by using a web application that's deployed to the server. The handler processes the requests and returns an HTTP response. Some requests may be routed to the unexpected handler. For example, the requests end up being run by the incorrect handler (such as the Static File handler), and this triggers a 403.14 status code ("a directory listing request isn't allowed").

### HTTP redirection problem

A website or web application does not redirect users who are accessing the website over a nonsecure connection to an encrypted channel (over TLS). Or, redirections of certain requests or resources to newer URLs do not return the expected content. This problem occurs either because the client is constantly redirected between two pages until the browser displays an error message or because the client was redirected incorrectly by the IIS server.

### Errors in IIS management console

When you access website or web application settings through the IIS Manager console, you receive error messages that indicate an incorrect or invalid configuration. You can't access certain parts of the website configuration (for example: authentication settings, registered modules, or handlers). Additionally, IIS Manager stops responding when you try to start it or when you try to connect to a specific website.

### IIS extensions, tools, and add-in issues

When you add an IIS extension, such as Application Request and Routing (ARR), to a web server to convert your web server to a load balancer or a reverse proxy, requests that are sent to the server that is running IIS causes unexpected behavior. For example, a "500" or "400" status code is returned or responses contain incorrect content.

### FTP service issues

The FTP service is an important part of the IIS web server. It enables users to upload or download large files over FTP (file transfer protocol) connections or FTPS (secure) connections. When you use an FTP server for IIS to list, download, or upload files, you receive "5*xx*" status codes (for example: an FTP "550" status code that indicates that a particular command that was sent to the server wasn't run).

### Server farm configuration issues

When you run a web application or a website on a farm that consists of several IIS services, issues occur when subsequent requests from the same user (client) are routed to different servers of the server farm. These errors range from requests that are rejected and generate "4*xx*" status codes to server errors such as the "5*xx*" status codes. These errors might be caused by inconsistencies in the configuration of the servers in the farm.

## Resolution

When you report these kinds of issues to Microsoft Support, you must provide all the telemetry data that is required to diagnose the issue. If an issue occurs on a production server, a complete and timely data collection strategy will enable a faster resolution time. Use the [Microsoft LogCatcher](https://github.com/crnegule/LogCatcher) tool for automated data collection for faster and more consistent telemetry data gathering of all necessary data from the web server. Microsoft Support agents will ask you to download the tool from its GitHub repository () and install it.

The welcome screen in LogCatcher provides instructions for its use. The UI resembles the following screenshot.

:::image type="content" source="media/data-collection-strategies/collect-data-in-logcatcher.png" alt-text="Screenshot of collecting data in log catcher.":::

At the bottom of the main window, LogCatcher displays a list of websites that are hosted on the server that the tool is running on, and also the corresponding application pools and content location of each website.

To filter the data that is collected from your system, collect data from only a subset of websites from the list, and only for a given duration (expressed in number of days counting backward from today). You can use the **Site IDs** and **Logs Age** filter text boxes, respectively.

Determine the filters that you want to apply, which websites to apply them to, and during what time period the data should be collected. Then, press the **GENERATE ZIP** button, and begin the log collection process. The status bar turns green when data collection is completed to confirm that all required logs were collected and compressed into a .zip file. The status bar also provides the file location.

:::image type="content" source="media/data-collection-strategies/generate-zip-in-logcatcher.png" alt-text="Screenshot of generating data in log catcher.":::

Windows File Explorer automatically opens the folder where the compressed log file was saved.

LogCatcher collects the following information:

- The IIS configuration files (located at **C:\WINDOWS\system32\inetsrv\config**)
- The HTTP.sys logs (located at **C:\Windows\System32\LogFiles\HTTPERR**)
- The System, Application, Security, Setup, Microsoft-IIS-Configuration, and CAPI2 event logs.
- The IIS log files for the selected sites.
- The **Failed Request** traces for the selected sites.

LogCatcher doesn't automatically upload any of the generated archive files to the Microsoft servers. The tool only automates data collection. You can inspect the content of the .zip archive that is generated by the tool to see what data was collected, or you can upload the file to Microsoft for analysis.

If you have to collect logs from multiple servers, and you don't want to click through the data generation UI every time, or if you're more comfortable using the command line, run the tool directly from PowerShell. For more information about how to do this, run the **Get-Help** command.

The following are examples of how to run the tool from the PowerShell CLI, including possible parameters.

```powershell
-------------------------- EXAMPLE 1 --------------------------
PS C:\>     .\LogCatcher.ps1
```

This command starts LogCatcher with UI.

```powershell
-------------------------- EXAMPLE 2 --------------------------
PS C:\> .\LogCatcher.ps1 -Quiet $true -ZipLocation "C:\Temp"
```

This command starts LogCatcher with CLI, and sets a custom .zip location for the archive generation.

```powershell
-------------------------- EXAMPLE 3 --------------------------
PS C:\> .\LogCatcher.ps1 -Quiet $true -LogAge 45 -SiteIds "1,2,3,4"
```

This command indicates the maximum age of all logs to be collected and the IIS Identifiers for each site for which logs should be collected.

## More information

For more information about the LogCatcher tool, see [this LogCatcher Blog article](https://github.com/crnegule/LogCatcher/blob/master/Docs/RunFirstTime.md).

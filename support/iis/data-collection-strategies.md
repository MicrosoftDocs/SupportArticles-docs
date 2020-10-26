---
title: Data collection strategies of common IIS Web Server related issues
description: This article describes the data collection strategies to troubleshoot common IIS Web Server related issues in Windows Server.
ms.date: 10/19/2020
ms.prod-support-area-path: Health, diagnostic, and performance features
ms.reviewer: paulboc
---
# Data collection strategies to troubleshoot common IIS Web Server related issues in Windows Server

## Symptoms

Connection issues may occur when running ASP.NET, ASP.NET Core, or other kinds of websites and web applications on a IIS web server on Windows Server (Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019 are the currently supported versions). This article describes Data collection strategies to troubleshoot common IIS web-server related issues:

### SSL and SSL Server Certificate Issues

When connecting to an IIS hosted website via Https, a TLS (Transport Layer Security) connection is negotiated between client and server using a server certificate which IIS delivers to the connecting client (browser). The returned certificate may not be the expected certificate and may not be trusted by the browser (client) which will result in the client's inability to negotiate the connection to the web-server through SSL (TLS).

### Runtime exceptions and errors, including HTTP 4xx and 50x status codes

When accessing certain resources on IIS hosted web-applications or performing certain actions while navigating these sites, the IIS web applications or websites randomly or consistently throw errors. You may receive the 500 (Internal Server error) status code errors in your browser reporting various errors exceptions in the execution of server-side code for the website or 400 status code (bad request) status code which is sent back when accessing web services such as ASP.NET Web API and trying to send data to a web service endpoint. Unexpected authentication prompts or access denied requests represented by 401 and 403 status codes may also occur.

### Handler-Mapping Problems

Requests sent to the web server are mapped to a specific handler (for example: Managed .NET handler registered using a web application deployed to the server) aren't routed to the expected handler. The requests end up being executed by the incorrect handler (like the Static File handler) resulting in a 403.14 status code (a directory listing request isn't allowed).

### Http Redirection Problem

A website or web application fails to redirect users accessing the website over a nonsecure connection to an encrypted channel (over TLS), or redirections of certain requests or resources to newer URLs fail to return the expected content. This happens either because the client is constantly redirected between two pages until the browser displays an error message or because the client was redirected incorrectly by the IIS server.

### Errors in IIS management console

When accessing a website's or web application's configuration settings through the IIS Manager console, you receive error messages indicating an incorrect or invalid configuration. You can't access certain parts of the website configuration (for example: authentication settings, registered modules, or handlers). Additionally, the IIS Manager crashes when you try to start it or when you try to connect to a specific website.

### IIS Extensions, Tools, and Add-In Issues

When adding an IIS extension to a web server, such as an Application Request and Routing (ARR) to convert your web server into a load balancer or a reverse proxy, requests sent to the Server Running IIS result in unexpected behavior.

### FTP Service Issues

The FTP service is an important part of the IIS web-server. It allows users to upload or download large files over FTP (file transfer protocol) connections or FTPS (secure) connections. When using FTP server for IIS to list, download or upload files, you receive 5xx status codes (for example: FTP 550 status code that indicates that a particular command sent to the server wasn't executed).

### Server Farm Configuration Issues

When running a web application or a website on a farm consisting of several IIS services, issues occur when subsequent requests from the same user (client) are routed to different servers of the server farm. These errors may range from requests being rejected with 4xx status codes to server errors like 50x status codes. These errors could be caused by inconsistencies in the configuration of the servers in the farm.

## Resolution

When reporting the types of issues described above to Microsoft Support, you must provide all the telemetry data required to diagnose the issue. If an issue occurs on an production server, a complete and timely data collection strategy will allow for a faster resolution time. Use the Microsoft LogCatcher tool for automated data collection to allow faster and more consistent telemetry data gathering of all needed data from the web-server in an automated fashion.

When Microsoft support professionals take your call about issues you may be facing with either the IIS web-server or ASP.NET Runtime, they will ask you to download the tool and to collect data. Download the tool from the GitHub repository ([LogCatcher](https://github.com/crnegule/LogCatcher)).

The welcome screen of the tool provides instructions about how to use the tool and describes the functionality exposed by the user interface buttons. After installing the tool and running it, you will be presented with a user interface like the one shown below. At the bottom of the tool's main Window, LogCatcher will display a list of websites hosted on the server where the tool is run, as well as the corresponding application pools, and the content location of each website

To filter the data collected from your system, collect data only from a subset of websites from the list and only for a given duration (expressed in number of days counting back in the past from the present day). You can use the Site IDs and Logs Age filter text boxes respectively.

:::image type="content" source="media/data-collection-strategies/collect-data-in-logcatcher.jpg" alt-text="screenshot of collecting data in log catcher":::

Once you've determined the filters you want to apply (for which websites and during what time period the data should be collected), press the **GENERATE ZIP** button and begin the log collection process. The status bar will turn green when data collection is completed confirming all required logs were collected and compressed in a (.zip) file and will provide the file location.

:::image type="content" source="media/data-collection-strategies/generate-zip-in-logcatcher.jpg" alt-text="screenshot of generating data in log catcher":::

The Windows File Explorer will automatically open the folder where the logs (compressed (.zip)) file was saved following the generation of the archive by the LogCatcher tool.

LogCatcher collects this information:

- The IIS configuration files located in **C:\WINDOWS\system32\inetsrv\config**
- The HTTP.sys logs located in **C:\Windows\System32\LogFiles\HTTPERR**
- The System, Application, Security, Setup, Microsoft-IIS-Configuration, and CAPI2 Event logs.
- The IIS log files for the selected sites.
- The Failed Request traces for the selected sites.

LogCatcher doesn't automatically upload any of the generated archive files to the Microsoft servers. The tool is meant to automate data-collection. You can inspect the content of the zip archive generated by the tool to see what data was collected or upload it to Microsoft for analysis.

If you need to collect logs from multiple servers and you don't want to click through the data generation UI every time, or if you're more familiar with the command line, run the tool directly from the PowerShell command line. For more information about how to do this, run the **Get-Help** command. Here are examples showing how to run the tool from the PowerShell CLI, and possible parameters:

```powershell
-------------------------- EXAMPLE 1 --------------------------
PS C:\>     .\LogCatcher.ps1
```

This command starts LogCatcher with UI.

```powershell
-------------------------- EXAMPLE 2 --------------------------
PS C:\> .\LogCatcher.ps1 -Quiet $true -ZipLocation "C:\Temp"
```

This command starts LogCatcher with CLI and sets a custom ZIP location for the archive generation.

```powershell
-------------------------- EXAMPLE 3 --------------------------
PS C:\> .\LogCatcher.ps1 -Quiet $true -LogAge 45 -SiteIds "1,2,3,4"
```

This command indicates the maximum age of all logs to be collected and the IIS Identifiers for each site for which logs should be collected.

## More information

Click [here](https://github.com/crnegule/LogCatcher/blob/master/Docs/RunFirstTime.md) for more documentation about this tool.

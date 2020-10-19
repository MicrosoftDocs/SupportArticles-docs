---
title: Data collection strategies of common IIS Web Server related issues
description: This article describes the data collection strategies to troubleshoot common IIS Web Server related issues in Windows Server.
ms.date: 10/19/2020
ms.prod-support-area-path: Health, diagnostic, and performance features
ms.reviewer: paulboc
---
# Data collection strategies to troubleshoot common IIS Web Server related issues in Windows Server

## Symptoms

Connection issues may occur when running ASP.NET, ASP.NET Core, or other kinds of websites and web applications on a IIS web server in Windows Server (Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019 are the currently supported versions). Here are Data collection strategies to troubleshoot common IIS web-server related issues:

### SSL and SSL Server Certificate Issues

When a TLS connection is initiated, a server certificate is returned. The returned certificate may not be the expected certificate and may not be trusted by the browser (client) which will result in the client's inability to connect to the web-server through SSL (TLS).

### Runtime exceptions and errors, including HTTP 4xx and 50x status codes

When accessing certain resources or performing certain actions, web applications or websites randomly or consistently throw errors. You may receive the 500 (Internal Server error) status code on your browser reporting various errors in the execution of server-side code for the website or 400 (bad request) status code sent back when accessing web services such as ASP.NET Web API and trying to send data to a web service endpoint. Unexpected authentication prompts or access denied requests represented by 401 and 403 status codes may also occur.

### Handler-Mapping Problems

Requests sent to the web server are mapped to a specific handler (for example: Managed .NET handler registered using a web application deployed to the server) aren't routed to the expected handler. The requests are handled by the Static File handler resulting in a 403.14 status code (a directory listing request isn't allowed).

### Http Redirection Problem

A website or web application fails to redirect users accessing the website over a nonsecure connection to an encrypted channel (over TLS), or redirects of certain requests or resources to newer URLs do not return the expected content. This happens either because the client is constantly redirected between two pages until the browser displays an error message or because the client was redirected incorrectly.

### Errors in IIS management console

When accessing a website's or web application's configuration settings through the IIS Manager console, you receive error messages indicating an incorrect or invalid configuration. You can't access certain parts of the website configuration (for example: authentication settings, registered modules, or handlers). Additionally, the IIS Manager crashes when you try to start it or when you try to connect to a specific website.

### IIS Extensions, Tools, and Add-In Issues

When adding an IIS extension to a web server, such as an Application Request and Routing (ARR) to convert your web server into a load balancer or a reverse proxy, requests sent to the Server Running IIS result in unexpected behavior.

### FTP Service Issues

The FTP server is an important part of the Server Running IIS. It allows users to upload or download large files over HTTP connections or HTTPS (secure) connections. When using FTP server for IIS to list, download or upload files, you receive 5xx status codes (for example: FTP 550 status code that indicates that a particular command sent to the server wasn't executed).

### Server Farm Configuration Issues

When running a web application or a website on a farm consisting of several IIS services, issues occur when subsequent requests from the same user (client) are routed to different servers of the server farm. These errors may range from requests being rejected with 4xx status codes to server errors like 50x status codes. These errors could be caused by inconsistencies in the configuration of the servers in the farm.

## Resolution

When reporting that type of issue to Microsoft Support, you must provide all the telemetry data required to diagnose the issue. If an issue occurs on an operational server, a complete and timely data collection strategy will allow for a faster resolution time. Use the Microsoft LogCatcher tool for automated data collection.

When Microsoft support professionals take your call about IIS or ASP.NET related issues, they will ask you to download the tool and to collect data. Download the tool from the GitHub repository ([LogCatcher](https://github.com/crnegule/LogCatcher)).

The welcome screen of the tool provides instructions about how to use the tool and describes the function of the user interface buttons. At the bottom of the screen, there's a list of websites hosted on the server where the tool runs, corresponding application pools, and the content location of each website.

To filter the data collected from your system, collect data only from a subset of websites from the list and only for a given duration (expressed in number of days counting back in the past from the present day).

:::image type="content" source="media/data-collection-strategies/collect-data-in-logcatcher.jpg" alt-text="screenshot of collecting data in log catcher":::

Once you've determined the filters you want to apply (for which websites and during what time period the data should be collected), press the **GENERATE ZIP** button and begin the log collection process. The status bar will confirm all required logs were collected and compressed in a (.zip) file and will provide the file location.

:::image type="content" source="media/data-collection-strategies/generate-zip-in-logcatcher.jpg" alt-text="screenshot of generating data in log catcher":::

The Windows File Explorer will automatically open the folder where the logs.compressed (.zip) file was saved following the generation of the archive by the LogCatcher tool.

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

---
title: An application pool exceeds time limits
description: An application pool takes longer time and exceeds time limits during shutdown in Internet Information Services (IIS). This article provides resolutions for this problem.
ms.date: 04/03/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.subservice: health-diagnostic-performance
---
# An application pool exceeds time limits during shutdown in IIS

An unexpected runtime error may be thrown when an application pool exceeds time limits during shutdown in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2634635

## Symptoms

On a computer that's running IIS 7.0 or 7.5, the message will look similar to the following example:

```output
Log Name: System
Source: Microsoft-Windows-WAS
Date: 1/1/2011 12:00:00 AM
Event ID: 5013
Task Category: None
Level: Warning
Keywords: Classic
User: N/A
Computer: SERVER
Description:
A process serving application pool DefaultAppPool exceeded time limits during shut down. The process id was 1111.
```

## Cause

This message is logged to the event log when an application pool takes longer than the configured `ShutdownTimeLimit` property to shut down. When this time limit is exceeded, the worker process will be forcibly shut down and recycled. And the event log message will be created.

It's possible this message will appear in the event log without any negative observed behavior to end users browsing the web sites hosted in that application pool. However, the presence of the event suggests one of the following conditions is true:

- The `ShutdownTimeLimit` is set to too low of a number.
- A problem has occurred in the web application that is hindering it from shutting down in a timely manner.

> [!NOTE]
> The default value of the `ShutdownTimeLimit` configuration property in IIS is 90 seconds.

To resolve this problem, choose one of the following methods.

## Resolution 1: Increase the ShutdownTimeLimit value

It's possible that the default `ShutdownTimeLimit` value was modified from its default value of 90 seconds. An application pool needs time to fully shut down, as any requests currently processing when the shutdown is started and needs to be given a certain amount of time to complete. Setting the `ShutdownTimeLimit` value too low may cause these erroneous event log warnings in high traffic web applications or in web applications that have requests that are expected to take some time to complete.

To modify the `ShutdownTimeLimit` value in IIS 7.0 and IIS 7.5, see [Process Model Settings for an Application Pool \<processModel>](/iis/configuration/system.applicationHost/applicationPools/add/processModel).

## Resolution 2: Troubleshoot why the application pool isn't shutting down in a timely manner

As mentioned earlier, it's possible that something is going on in the application pool. So it can't shut down in a timely manner. One of the more common problems is when existing HyperText Transfer Protocol (HTTP) requests aren't able to complete. To troubleshoot why the application pool is taking too long to shut down, capture a memory dump of the w3wp.exe process in which the application pool is running, when the shutdown problem is occurring.

For more information on capturing memory dumps of IIS processes, see [Debug Diagnostics Tool v1.2 is now available](https://support.microsoft.com/help/2580960).

## More information

[Configuring Recycling Settings for an Application Pool (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753179(v=ws.10))

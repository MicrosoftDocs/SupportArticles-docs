---
title: Advanced Secure Sockets Layer data capture
description: Describes the steps for advanced Secure Sockets Layer data capture.
ms.date: 04/26/2024
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
ms.topic: how-to
---

# Advanced Secure Sockets Layer data capture

> [!NOTE]
> - This article is for Windows only.
> - Consistent authentication errors are usually due to incorrect settings, while intermittent failures are usually due to a dropped connection, poor performance, or time-out issues.
> - We recommend that you turn file extensions on in Windows File Explorer.

## Capture Windows settings using SQLCHECK

Run SQLCHECK on client machines, server machines, and any other related systems, such as a web server or SQL Server linked server intermediate machine.

1.	Download the latest version of [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK) and unzip it into a folder, such as *C:\MSDATA*.
1.	Double-click the executable file in Windows File Explorer. A report will be written to the folder where *SQLCheck.exe* is located.

## Configure the driver Built-In Diagnostic (BID) trace

1. Download the latest version of [SQLTRACE](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLTRACE) and extract it into a folder, such as *C:\MSDATA*.

   There will be two files, *SQLTrace.ps1* and *SQLTrace.ini*. The INI file is used to configure what to capture.

1. Open *SQLTrace.ini* in Notepad and go to the **BID Trace** section.
1. Make sure that `BIDTrace=yes` is set.
1. Make sure that `BIDProviderList` conforms to the driver your application is using.

   The built-in System.Data.SqlClient .NET drivers are automatically enabled. If these aren't the drivers your application is using, comment this line using the `#` character and uncomment one of the others, such as the ODBC section or the OLEDB section. If you aren't sure, ask the DBA or application developer, or use the fourth `BIDProviderList`, which contains all drivers currently in use.

1. Save the file.

## Configure the network trace

The networking section is automatically configured with `Network=yes` and `NETSH=yes`. These shouldn't be changed without good reason.

If you're tracing a local connection, make sure the application uses TCP/IP rather than Shared Memory or Named Pipes. Install and use [WireShark](https://www.wireshark.org/download.html) for the network capture, as it supports LoopBack captures. WireShark also captures VPN traffic quite well.

## Configure the authentication trace

The Auth section is automatically configured with `Auth=yes` and many other settings.

You might also need to set `FlushTickets=yes` in the MISC section. This will flush Kerberos tickets for all users and services on the machine.

## Enable BID traces

Once all the changes to the *SQLTrace.ini* file have been saved, BID Traces must be enabled before tracing can begin.

1. Open PowerShell as an administrator.
1. Change the directory to the folder containing *SQLTrace.ps1*.

   ```powershell
   CD C:\MSDATA
   ```

1. Initialize the BID Tracing registry.

   ```powershell
   .\SQLTrace.ps1 -setup
   ```

1. Restart the service or application you wish to trace. Otherwise, the application won't be traced.

## Collect the trace data

> [!NOTE]
> Make sure the previous steps have been completed on all machines before continuing.

1. Open PowerShell on all machines being traced as an administrator. Complete the starting steps on all machines before reproducing the issue.
1. Change the directory to the folder containing *SQLTrace.ps1*.

   ```powershell
   CD C:\MSDATA
   ```

1. Start the trace collection.

   ```powershell
   .\SQLTrace.ps1 -start
   ```
1. Reproduce the issue when the command prompt appears.
1. Stop the trace.

   ```powershell
   .\SQLTrace.ps1 -stop
   ```

An output folder is generated in the current directory and you can use it for further analysis.

The trace might take a minute or two to completely stop since downloading the event logs might take a while.

You can start and stop the trace several times without redoing the configuration steps. Each time it's taken, a new folder is created with a timestamp as part of the folder name. The time corresponds to the time the trace was started.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

---
title: Enable verbose logging and configure SQL Server Profiler
description: Describes how to enable verbose logging and configure SQL Server Profiler for troubleshooting issue in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Site Server and Roles\Site and Component Status Monitoring
---
# Enable verbose logging and configure SQL Server Profiler for troubleshooting

_Applies to:_ &nbsp; Configuration Manager

In Configuration Manager, client and site server components record process information in individual log files. You can use the information in these log files to help you troubleshoot issues that might occur.

## Enable verbose and debug logging on the client and management point

- Verbose logging can be enabled by creating the following registry value as **REG_DWORD** with value **0x0**:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\@GLOBAL\LogLevel`

- Debug logging can be enabled by creating the following registry value as **REG_SZ** with a value of **True**:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\DebugLogging\Enabled`

- The CCM log size can be increased to 5 MB by setting the following registry value as **REG_DWORD** with a value of **5242880** (decimal):

    `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\@GLOBAL\LogMaxSize`

- You can edit the **REG_DWORD** value for the following registry value to increase the number of history log files to be retained:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM\Logging\@GLOBAL\LogMaxHistory`

> [!NOTE]
> Restart the SMS Agent Host service to enable the changes. On the management point, you may have to restart IIS-related services for verbose logging to take effect for some logs.

## Enable verbose logging for the state system component on the site server

To enable verbose logging for State System (StateSys), set the **REG_DWORD** value for the following registry value to **1**:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Components\SMS_STATE_SYSTEM\Verbose logging`

> [!NOTE]
> This registry key change doesn't require a restart of the `SMS_Executive` service or the `SMS_STATE_SYSTEM` thread.

## Enable verbose logging for WSUS Synchronization Manager (WSYNCMGR)

To enable verbose logging for WsyncMgr.log, create or modify the following registry value on the site server and set the **REG_DWORD** value to **0**:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_WSUS_SYNC_MANAGER\LogLevel`

## Enable SQL tracing for Configuration Manager logs

To enable SQL tracing, set the **REG_DWORD** value for the following registry value to **1**:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SqlEnabled`

> [!NOTE]
> This registry change doesn't require a restart of the `SMS_Executive` service. This registry value adds SQL trace logging for all site server logs. This should only be done temporarily while troubleshooting, and should be disabled after getting the relevant logs.

## Enable verbose logging for Windows Update Agent

To enable verbose logging, create the following registry subkey with two values:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Trace`

|Value name|Value type|Value data|
|---|---|---|
|Flags|REG_DWORD|00000007|
|Level|REG_DWORD|00000004|
  
This subkey turns on an extended tracing to the %systemroot%\Windowsupdate.log file, it also turns on an extended tracing to any attached debuggers.

> [!NOTE]
> Extended verbose logging can be enabled by setting the value of **Flags** to **17** instead of 7. However, it will significantly increase the size of WindowsUpdate.log.

## Configure SQL Server Profiler to troubleshoot WSUS location request issues

In some circumstances, you may need to use SQL Server Profiler to find the call to the `MP_GetWSUSServerLocation` stored procedure and see what parameters are passed.

To do this, configure the SQL Server Profiler as shown in the following screenshot:

:::image type="content" source="media/enable-verbose-logging/mp-get-wsus-server-location.png" alt-text="Screenshot shows the configuration of SQL Server Profiler to call MP_GetWSUSServerLocation." border="false":::

## Configure SQL Server Profiler to view state message processing

To do this, configure the SQL Server Profiler as shown in the following screenshot:

:::image type="content" source="media/enable-verbose-logging/sp-process.png" alt-text="Screenshot shows the configuration of SQL Server Profiler to call spProcess." border="false":::

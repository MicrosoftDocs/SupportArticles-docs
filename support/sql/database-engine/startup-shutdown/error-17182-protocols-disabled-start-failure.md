---
title: Error 17182 when you start SQL Server service
description: This article provides resolutions for the problem where SQL Server fails to start when all the protocols are disabled.
ms.date: 12/17/2021
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ramakoni
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---
# SQL Server can't start if all the protocols are disabled

_Applies to:_ &nbsp; SQL Server

## Symptoms

If all network protocols for a Microsoft SQL Server instance are disabled, SQL Server doesn't start, and you receive  the following error message, depending on how you try to start the service:

- By using the Services applet:

  > Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.  
  > If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.

- By using a command prompt:

  > C:\Users\username>NET START MSSQLSERVER  
  > The SQL Server (MSSQLSERVER) service is starting.  
  > The SQL Server (MSSQLSERVER) service could not be started.  
  > A service specific error occurred: 13.
  > More help is available by typing NET HELPMSG 3547.  

## Resolution

Here's how to resolve this problem:

1. Check the System event log, and verify that you see the following event entry:

    ```output
    Event ID: 7024  
    The SQL Server (MSSQLSERVER) service terminated with the following service-specific error:  
    The data is invalid.  
    ```

2. Check the SQL Server error log, and verify that you see error message entries that resemble the following:

    ```output
    <Datetime> spid9s      Server name is '<ServerName>'. This is an informational message only. No user action is required.  
    <Datetime> spid17s     Error: 17182, Severity: 16, State: 1.  
    <Datetime> spid17s     TDSSNIClient initialization failed with error 0xd, status code 0x4. Reason: **All protocols are disabled. The data is invalid**.  
    <Datetime> spid17s     Error: 17182, Severity: 16, State: 1.  
    <Datetime> spid17s     TDSSNIClient initialization failed with error 0xd, status code 0x1. Reason: Initialization failed with an infrastructure error. Check for previous errors. The data is invalid.  
    .  
    .  
    <Datetime> spid17s     Error: 17826, Severity: 18, State: 3.  
    <Datetime> spid17s     Could not start the network library because of an internal error in the network library. To determine the cause, review the errors immediately preceding this one in the error log.  
    <Datetime> spid17s     Error: 17120, Severity: 16, State: 1.  
    <Datetime> spid17s     SQL Server could not spawn FRunCommunicationsManager thread. Check the SQL Server error log and the operating system error log for information about possible related problems.  
    ```

3. After you verify the problem that's mentioned in the [Symptoms](#symptoms) section, use the SQL Server Network Configuration node of SQL Server Configuration Manager to [enable the required network protocols](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol). Then, restart the SQL Server service.

   > [!NOTE]
   >
   > - If you don't want to enable remote connections to your SQL Server instance, you can enable only the Shared Memory protocol, and then restart the SQL Server service.
   > - You can also validate network library settings by using the following registry keys
   >
   >    If the `Enabled` value is set to zero, the corresponding network library is disabled.
   >
   >     - Shared Memory: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Sm\Enabled`
   >     - TCP/IP: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Tcp\Enabled`
   >     - Named Pipes: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Np\Enabled`

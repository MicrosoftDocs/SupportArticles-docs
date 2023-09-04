---
title: SQL Server startup errors  
description: This article provides resolutions for the problem where SQL Server fails to start on a standalone server.
ms.date: 02/03/2020
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ramakoni
---
# SQL Server startup errors on a standalone server

There are various reasons why SQL Server service might not start. At a high level, the causes can be classified into the following categories:

- Issues that affect the account that is configured to run the SQL Server service
- Inaccessible system databases
- Missing dependencies
- Incorrect configuration of the SQL Server service
- Issues that affect the certificate configuration

This topic helps you troubleshoot most common SQL Server startup issues in these categories on a standalone server.

_Applies to:_ &nbsp; SQL Server

## Summary

SQL Server may not start, and you receive an error message when you use any of the following tools to start the SQL Server service:

- SQL Server Configuration Manager
- SQL Server Management Studio
- Windows Service Control Manager
- Windows command prompt

> [!NOTE]
> The error message may vary slightly depending on the tool that you use. However, in general, the event IDs, error numbers, and descriptions are very similar.

## Steps to troubleshoot these problems

1. Note the error message that you receive from the tool when you start the service.

1. Note the corresponding event ID and its associated description that is logged in the Windows Application and System logs.

1. Use the following table to locate the corresponding topic that contains additional troubleshooting information about the error, event ID, and description.

> [!NOTE]
> All these troubleshooters use Service Control Manager to identify the startup error, and they use SQL Server Configuration Manager to provide a resolution.  
Troubleshooting typically requires that you are an administrator on the SQL Server computer.

## SQL Server startup error messages

|Error message from Services Applet|Review|
|---|---|
|The dependency service or group failed to start. |[The SQL Server service and the SQL Server Agent Service fail to start on a standalone server](/troubleshoot/sql/admin/agent-service-fails-start-stand-alone-server)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer. <br/> Error 1069: The service did not start due to a logon failure.|[Logon failure and SQL Server service does not start successfully](/troubleshoot/sql/admin/error-password-service-account-changed)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/> If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.|[SQL Server can't start if all the protocols are disabled](../startup-shutdown/error-17182-protocols-disabled-start-failure.md)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 1067: The process terminated unexpectedly.|[Event ID 17058 and SQL Server doesn't start](/troubleshoot/sql/admin/event-id-17058-start-sql-server)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 2: The system cannot find the file specified.|[Event ID 7000 and SQL Server doesn't start](/troubleshoot/sql/admin/event-id-7000-fail-start)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 17113|[Service-specific error 17113 when you start SQL Server service](/troubleshoot/sql/admin/error-17113-start-service)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 1814.|[Event ID 1814 and SQL Server doesn't start](/troubleshoot/sql/admin/event-id-1814-fail-start)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code -2146885628.|[Event ID 33565 and SQL Server doesn't start after you enable encryption](/troubleshoot/sql/admin/event-id-33565-start-sql-server)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.|[Event ID 33566 and SQL Server doesn't start after you enable encryption](/troubleshoot/sql/admin/event-id-33566-start-sql-server)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 5: Access is denied.|["Access is denied" error and SQL Server doesn't start](/troubleshoot/sql/admin/event-id-7000-access-denied)|
||

## Reference

[SQL Server service cannot start after you configure an instance to use a Secure Sockets Layer certificate](/troubleshoot/sql/security/service-cannot-start)

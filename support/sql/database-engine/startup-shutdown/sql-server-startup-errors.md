---
title: Troubleshoot SQL Server Startup Errors on a Standalone Server
description: Troubleshoot SQL Server startup errors on a standalone server. Match the error message or event ID from the Windows Services applet to the article that resolves it.
ms.date: 10/29/2026
ms.reviewer: jopilov
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ai-usage: ai-assisted
---
# SQL Server startup errors on a standalone server

_Applies to:_ &nbsp; SQL Server

## Summary

This article helps you troubleshoot SQL Server startup errors on a standalone server when the SQL Server service fails to start. Match the error message from the Windows Services applet, or the event ID in the Windows Application and System logs, to the article that resolves your startup failure.

## Common causes of SQL Server startup failures

There are various reasons why the SQL Server service might not start. At a high level, the causes fall into the following categories:

- Issues that affect the account that is configured to run the SQL Server service. For more information, see [Configure Windows service accounts and permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions).
- Inaccessible system databases
- Missing dependencies
- Incorrect configuration of the SQL Server service
- Issues that affect the certificate configuration

## Symptoms

SQL Server might not start, and you receive an error message when you use any of the following tools to start the SQL Server service:

- [SQL Server Configuration Manager](/sql/tools/configuration-manager/sql-server-configuration-manager)
- SQL Server Management Studio (SSMS)
- Windows Service Control Manager
- Windows command prompt

> [!NOTE]
> The error message might vary slightly depending on the tool that you use. However, in general, the event IDs, error numbers, and descriptions are very similar.

## Steps to troubleshoot SQL Server startup errors

Troubleshooting typically requires that you're an administrator on the SQL Server computer.

1. Note the error message that you receive from the tool when you start the service.

1. Note the corresponding event ID and its associated description that is logged in the Windows Application and System logs.

1. Use the table in the next section to locate the article that contains more troubleshooting information about the error, event ID, and description.

> [!NOTE]
> All the linked articles use Service Control Manager to identify the startup error, and they use SQL Server Configuration Manager to provide a resolution.

## SQL Server startup error messages and resolutions

|Error message from Services applet|Review|
|---|---|
|The dependency service or group failed to start. |[The SQL Server service and the SQL Server Agent Service fail to start on a standalone server](agent-service-fails-start-stand-alone-server.md)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer. <br/> Error 1069: The service did not start due to a logon failure.|[Logon failure and SQL Server service does not start successfully](error-1069-service-cannot-start.md)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/> If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.|[SQL Server can't start if all the protocols are disabled](error-17182-protocols-disabled-start-failure.md)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 1067: The process terminated unexpectedly.|[Event ID 17058 and SQL Server doesn't start](event-id-17058-start-sql-server.md)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 2: The system cannot find the file specified.|[Event ID 7000 and SQL Server doesn't start](event-id-7000-fail-start.md)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 17113.|[Service-specific error 17113 when you start SQL Server service](error-17113-start-service.md)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 1814.|[Event ID 1814 and SQL Server doesn't start](event-id-1814-fail-start.md)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code -2146885628.|[Event ID 33565 and SQL Server doesn't start after you enable encryption](event-id-33565-start-sql-server.md)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.|[Event ID 33566 and SQL Server doesn't start after you enable encryption](event-id-33566-start-sql-server.md)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 5: Access is denied.|["Access is denied" error and SQL Server doesn't start](event-id-7000-access-denied.md)|

## Related content

- [SQL Server service cannot start after you configure an instance to use a Secure Sockets Layer certificate](service-cannot-start.md)
- [SQL Server Service fails to start under a gMSA](gmsa-service-startup-failures.md)
- [SQL Server services using domain credentials fail to start](sql-cannot-start-with-domain-account.md)
- [SQL Server Agent Startup Fails with Error 17156 Could Not Initiate the EventLog Service](error-17156-event-log-service.md)
- [Manage the error log](manage-error-log.md)

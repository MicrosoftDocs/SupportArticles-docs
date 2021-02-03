---
title: SQL Server startup errors  
description: This article provides resolutions for the problem where SQL Server fails to start on a stand-alone server.
ms.date: 2/3/2020
author: cobibi
ms.author: v-yunhya
ms.reviewer: ramakoni
---
# SQL Server startup errors on a stand-alone server (require edit)

SQL Server service may fail to start due to various reasons. At a high level, the causes can be classified into following categories:

1. Issue with account that is configured to run SQL Server service.
2. System databases being inaccessible.
3. Missing dependencies.
4. Improper configuration of SQL Server service.
5. Issues with certificate configuration.

The topic provides information on troubleshooting most common SQL Server startup issues on a stand-alone server in these categories.

_Applies to:_ &nbsp; SQL Server

## Summary

If you use any of the tools below to start SQL Server service, SQL Server may fail to start and report an error message.

- Service Control Manager
- SQL Server Configuration Manager
- SQL Server Management Studio
- Command prompt

> [!NOTE]
> The error message may vary slightly depending on the tool being used, but in general, the event ids, error numbers and descriptions are very similar to each other.

To start troubleshooting these problems:

1. Note down the error that you get when starting the service from the tool that you are using.
2. Note down the corresponding Event ID and its associated description that is logged in the Windows System event log.
3. Use the table below to navigate to the corresponding topic that contains additional troubleshooting information for the Error, Event ID and Description combination.

> [!NOTE]
> All these troubleshooters use Service Control manager to identify the startup error and SQL Server Configuration manager to provide resolution.

## SQL Server startup error messages

|Error message from Services Applet|Review|
|---|---|
|The dependency service or group failed to start. |[The SQL Server service and the SQL Server Agent Service fail to start on a stand-alone server](https://docs.microsoft.com/troubleshoot/sql/admin/agent-service-fails-start-stand-alone-server)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer. <br/> Error 1069: The service did not start due to a logon failure.|[Logon failure and SQL Server service does not start successfully](https://review.docs.microsoft.com/troubleshoot/sql/security/error-password-service-account-changed)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/> If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.|[SQL Server can't start if all the protocols are disabled](https://review.docs.microsoft.com/troubleshoot/sql/admin/error-17182-protocols-disabled-start-failure)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 1067: The process terminated unexpectedly.|[Event ID 17058 and SQL Server doesn't start](https://review.docs.microsoft.com/troubleshoot/sql/admin/event-id-17058-start-sql-server)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 2: The system cannot find the file specified.|[Event ID 7000 and SQL Server doesn't start](https://review.docs.microsoft.com/troubleshoot/sql/admin/event-id-7000-fail-start)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 17113|[Service-specific error 17113 when you start SQL Server service](https://review.docs.microsoft.com/troubleshoot/sql/admin/error-17113-start-service)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 1814.|[Event ID 1814 and SQL Server doesn't start](https://review.docs.microsoft.com/troubleshoot/sql/admin/event-id-1814-fail-start)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code -2146885628.|[Event ID 33565 and SQL Server doesn't start after you enable encryption](https://review.docs.microsoft.com/troubleshoot/sql/admin/event-id-33565-start-sql-server)|
|Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.<br/>If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.|[Event ID 33566 and SQL Server doesn't start after you enable encryption](https://review.docs.microsoft.com/troubleshoot/sql/admin/event-id-33566-start-sql-server)|
|Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.<br/>Error 5: Access is denied.|["Access is denied" error and SQL Server doesn't start](https://review.docs.microsoft.com/troubleshoot/sql/admin/event-id-7000-access-denied)|
||

## Reference

[SQL Server service cannot start after you configure an instance to use a Secure Sockets Layer certificate](/troubleshoot/sql/security/service-cannot-start)

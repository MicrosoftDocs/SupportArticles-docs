---
title: SQL Server and SQL Server Agent Services Fail to Start
description: Fix error 1068 and event ID 7038 when SQL Server and SQL Server Agent services fail to start on a standalone or domain member server.
ms.date: 11/24/2026
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ms.reviewer: jopilov
ai-usage: ai-assisted
---
# SQL Server and SQL Server Agent services fail to start on a standalone server or domain member server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 307288

## Summary

The SQL Server (MSSQLSERVER) service and the SQL Server Agent (SQLSERVERAGENT) service might fail to start with error 1068 on a standalone (workgroup) server. The SQL Server service might also fail to start with event ID 7038 on a domain member server. These failures occur when the services are configured to use a domain account, but domain authentication isn't available at startup. This article describes the symptoms and causes of each issue, and explains how to fix them by changing the service account, delaying startup, or adding service dependencies.

## Symptoms of the startup failures

The symptoms depend on whether the server is a standalone computer in a workgroup or a member of a domain.

### Issues 1 and 2: Error 1068 on a standalone server

On a standalone server, you experience one or both of the following issues:

- **Issue 1:** The MSSQLSERVER service might fail to start, and you receive the following error message:

  ```output
  An error 1068 - (The dependency service or group failed to start.) occurred while performing this service operation on the MSSQLServer Service.
  ```

- **Issue 2:** Similarly, the SQLServerAgent service might also fail to start, and you receive the following error message:

  ```output
  An error 1068 - (The dependency service or group failed to start.) occurred while performing this service operation on the SQLServerAgent Service.
  ```

**Issue 1** and **Issue 2** occur when both of the following conditions are true:

- The server computer is in a workgroup and not part of a domain.
- Both the MSSQLSERVER and SQLServerAgent services are set to use a domain account for the startup.

### Issue 3: Event ID 7038 on a domain member server

- **Issue 3:** On a domain member server, the MSSQLSERVER service might not start during the server start, and you receive the following message in [Event Viewer](/shows/inside/event-viewer) with event ID 7038:

  ```output
  The MSSQLSERVER service was unable to log on as domain\mssqlsvc with the currently configured password due to the following error: Source: NetLogon Description: There are currently no logon servers available to service the logon request. The MSSQLSERVER service terminated unexpectedly.
  ```

This problem occurs when all the following conditions are true:

- The server is part of a domain.
- Both the MSSQLSERVER and SQLServerAgent services are set to use a domain account for the startup.
- The startup mode for the MSSQLSERVER and SQLServerAgent is set to **Automatic**.

## Cause of the startup failures

The cause depends on the issue that you experience:

- **Issue 1** and **Issue 2** occur because the server is a standalone computer and the NetLogon service doesn't start on the server. Hence, no domain-wide logon authentications are possible.
- **Issue 3** occurs because SQL Server services try to start before the NetLogon service starts.

## Solution for error 1068: Change the service startup account

If the MSSQLSERVER service, the SQLServerAgent service, or both fail to start with error 1068 on a standalone server that uses a domain account for the services (**Issue 1** and **Issue 2**), change the startup account for both services so that they don't depend on domain authentication:

1. In SQL Server Configuration Manager, change the startup account of both the MSSQLSERVER and SQLServerAgent services to use the Local System account. For more information, see [SQL Server Configuration Manager: Change the service startup account](/sql/database-engine/configure-windows/scm-services-change-the-service-startup-account).
1. Restart the server.

> [!NOTE]
> On a standalone computer, set the NetLogon service for **manual** startup.

## Solution for event ID 7038: Delay or retry the service startup

If the MSSQLSERVER service doesn't start at server startup on a domain member server and event ID 7038 reports that no logon servers are available (**Issue 3**), use one or more of the following workarounds:

- **Configure delayed start.** Configure the SQL Server startup to **delayed start** for particular Windows servers. Other Windows services such as NetLogon complete first, and SQL Server starts without problems. For more information, see [Automatically starting services](/windows/win32/services/automatically-starting-services).

- **Configure retry.** Configure the SQL Server startup to **retry**. The startup can be completed on the second startup attempt.

- **Change the Duplicate Address Detection value.** Change the Duplicate Address Detection (`-DadTransmits`) value to `1` for all network interfaces on the server. For more information, see the [Set-NetIPInterface](/powershell/module/nettcpip/set-netipinterface) command.

- **Change the service recovery options.** Change the **Recovery** options for the SQL Server and SQL Server Agent services. Specify **Restart the service** as the action for the failure options. You can perform this action from the Services console (`services.msc`) in Administrative Tools by using the Service Control Manager interfaces.

## Solution for event ID 7038 when delayed start doesn't help: Add service dependencies

If the **delayed start** option can't fix **Issue 3** (the SQL Server service still fails at startup on a domain member server with event ID 7038), add the following dependencies to the SQL Server service:

- IP Helper service (`iphlpsvc`)
- Server service (`LanmanServer`)
- Network List service (`netprofm`)

To add the dependencies, run the following commands at an elevated command prompt. The example assumes a default SQL Server instance named `MSSQLSERVER`. For a named instance, use `MSSQL$INSTANCENAME`.

1. View the current dependencies:

   ```cmd
   sc.exe qc MSSQLSERVER
   ```

1. Add the dependencies:

   ```cmd
   sc.exe config MSSQLSERVER depend= iphlpsvc/LanmanServer/netprofm
   ```

1. View the dependencies again to verify the change:

   ```cmd
   sc.exe qc MSSQLSERVER
   ```

The first and third commands display the dependencies before and after the change.

## Related content

- [SQL Server startup errors](sql-server-startup-errors.md)
- [Error 1069 occurs when you start SQL Server Service](error-1069-service-cannot-start.md)
- [SQL Server Agent shuts down unexpectedly when you try to start it](sql-server-agent-crashes-upon-start.md)
- [SQL Server services using domain credentials fail to start](sql-cannot-start-with-domain-account.md)
- [Select an account for the SQL Server Agent service](/ssms/agent/select-an-account-for-the-sql-server-agent-service)

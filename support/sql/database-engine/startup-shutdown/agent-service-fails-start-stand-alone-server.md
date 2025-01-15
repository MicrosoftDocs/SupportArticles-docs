---
title: Agent Service fails to start on standalone server
description: Provides the resolutions for the problems where the SQL Server service and the SQL Server Agent Service may not start on a stand-alone server.
ms.date: 01/15/2025
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
ms.reviewer: jopilov
---
# The SQL Server service and the SQL Server Agent Service fail to start on a standalone server

This article helps you resolve the problems where the SQL Server service and the SQL Server Agent Service may not start on a standalone server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 307288

## Symptoms

- **Issue 1:** On a standalone server, the MSSQLSERVER service might fail to start, and you receive the following error message:

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

- **Issue 3**: On a domain member server, the MSSQLSERVER service might not start during the server start, and you receive the following message in [Event Viewer](/shows/inside/event-viewer) with event id 7038:

  ```output
  The MSSQLSERVER service was unable to log on as domain\mssqlsvc with the currently configured password due to the following error: Source: NetLogon Description: There are currently no logon servers available to service the logon request. The MSSQLSERVER service terminated unexpectedly.
  ```
 
  This problem occurs when all the following conditions are true:

  - The server is part of a domain.
  - Both the MSSQLSERVER and SQLServerAgent services are set to use a domain account for the startup.
  - The startup mode for the MSSQLSERVER and SQLServerAgent is set to Automatic.

## Cause

**Issue 1** and **Issue 2** occur because the server is a standalone computer and the NetLogon service does not start on the server, hence no domain-wide logon authentications are possible.

**Issue 3** occurs because SQL Server services try to start before NetLogon service starts.

## Resolution

- To fix the **Issue 1** and **Issue 2**, follow these steps:

  1. Change the startup account of both the MSSQLSERVER and SQLServerAgent to use the local system account.
  1. Restart the server.

- To fix the **Issue 3**, use the following workarounds:

  - Configure the SQL Server startup to **delayed start** for particular Windows servers, other Windows services such as NetLogon complete first and SQL Server starts without problems.

  - Configure the SQL Server startup to **retry**, the startup can be completed on the second startup attempt.

  - Change the Duplicate Address Detection (-DadTransmits) value to 1 for all network interfaces on the server. See command [Set-NetIPInterface](/powershell/module/nettcpip/set-netipinterface) for more information.

  - Change the **Recovery** options for SQL Server and SQL Server Agent services. Specify **Restart the service** as action for the failure options. You can perform this option from the Services applet of Administrative Tools using the familiar Service Control Manager interfaces.

  If the **delayed start** option can't fix this **Issue 3**, add the following dependencies to the SQL Server service:

  - Ip helper service
  - Server Service
  - Network list service

  You can add the dependencies by using the following commands. The following example assumes a default SQL Server instance `MSSQLSERVER`. For a named instance, use `MSSQL$INSTANCENAME`:

  ```cmd
  sc.exe qc MSSQLSERVER ::view dependencies
  sc.exe config MSSQLSERVER depend=iphlpsvc/LanmanServer/netprofm
  sc.exe qc MSSQLSERVER ::view dependencies
  ```
  The first and third commands display the dependencies before and after the change. 

## More information

On a standalone computer, the NetLogon Service should be set for **manual** startup.

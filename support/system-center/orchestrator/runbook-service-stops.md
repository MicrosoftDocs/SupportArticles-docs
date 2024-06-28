---
title: Runbook Service stops unexpectedly after 30-60 seconds
description: Provides a solution to an issue where Orchestrator Runbook Service on a System Center Orchestrator runbook server starts successfully but then stops after 30-60 seconds.
ms.date: 06/26/2024
---
# The Orchestrator Runbook Service starts and then stops after 30-60 seconds

This article helps you fix an issue where Orchestrator Runbook Service on a System Center Orchestrator runbook server starts successfully but then stops after 30-60 seconds.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2702157

## Symptoms

The Orchestrator Runbook Service on a System Center Orchestrator runbook server starts successfully but then terminates after 30-60 seconds.

In the System event log of the System Center Orchestrator runbook server, the following sequence of events will be seen:

> Log Name: System  
> Source: Service Control Manager  
> Date:  
> Event ID: 7036  
> Task Category: None  
> Level: Information  
> Keywords: Classic  
> User: N/A  
> Computer: \<Computer>  
> Description:  
> The Orchestrator Runbook Service service entered the running state.  

> Log Name: System  
> Source: Service Control Manager  
> Date:  
> Event ID: 7036  
> Task Category: None  
> Level: Information  
> Keywords: Classic  
> User: N/A  
> Computer: \<Computer>  
> Description:  
> The Orchestrator Runbook Service service entered the stopped state.  

> Log Name: System  
> Source: Service Control Manager  
> Date:  
> Event ID: 7023  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<Computer>  
> Description:  
> The Orchestrator Runbook Service service terminated with the following error:  
> %%-2147467259  

When querying the status of the Orchestrator Runbook Service using `SC.exe`, the following output shows the last exit code when the service is in a stopped state:

```console
C:\Windows\system32>sc query orunbook
```

> SERVICE_NAME: orunbook  
> TYPE: 10 WIN32_OWN_PROCESS  
> STATE: 1 STOPPED  
> WIN32_EXIT_CODE: -2147467259 (0x80004005)  
> SERVICE_EXIT_CODE: 0 (0x0)  
> CHECKPOINT: 0x0  
> WAIT_HINT: 0x0  

One or more exceptions may be captured in the Orchestrator Runbook Service logging folder on the Orchestrator runbook server computer. The default path for these logs is `C:\ProgramData\Microsoft System Center 2012\Orchestrator\RunbookService.exe\Logs`.

## Cause

The Orchestrator Runbook Service isn't able to connect to the Orchestrator database. This could be due to any of the following reasons:

- The service for the Microsoft SQL Server database instance isn't running.
- The hostname for the SQL Server database instance doesn't resolve correctly.
- An incorrect database instance has been configured.
- An incorrect TCP/IP port may have been configured in Orchestrator or in SQL Server for the database instance.
- TCP/IP may not be configured as an acceptable binding or an alternative protocol binding may be configured as higher priority causing connections to work from some locations but not others (such as local versus remote).
- The user account provided doesn't have appropriate permissions to the Orchestrator database.

## Resolution

Correct the problem that's preventing the Orchestrator Runbook Service from connecting to the Orchestrator database.

1. Verify the SQL Server database instance that hosts the Orchestrator database is running.
2. Verify that the hostname for the SQL Server instance is correct and resolves correctly in DNS.
3. Verify that the correct SQL Server instance is configured in System Center Orchestrator.
4. Check that the TCP/IP port configured in Microsoft SQL Server for the instance that hosts the Orchestrator database matches the TCP/IP port defined in System Center Orchestrator.
5. Check the protocol configuration for the SQL Server instance that hosts the Orchestrator database to ensure communication via TCP/IP is the default protocol.
6. Verify that the user account of the Orchestrator Runbook Service or the SQL Server user account is a member of the `Microsoft.SystemCenter.Orchestrator.Runtime` user role in the Orchestrator database.

## More information

The Orchestrator Runbook Service will only terminate due to failed connectivity to the Orchestrator database during the service start. Once the service has successfully started with full database connectivity, any future database issues will be captured and logged without the service terminating.

This issue occurs most frequently when the System Center Orchestrator environment is restarted and the Orchestrator Runbook Service starts before the Orchestrator database is fully online. In this case, configuring the Orchestrator Runbook Service recovery properties can often automatically remediate the problem by having the service wait a period of time and then attempt to start again.

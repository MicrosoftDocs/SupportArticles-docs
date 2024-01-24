---
title: New WMI arbitrator behavior in Windows Server
description: Introduces new WMI arbitrator behavior in Windows Server 2016 and 2012 R2 introduced by March 2018 Windows cumulative updates.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, gbrag, lindakup, stevepar, arrenc, v-jeffbo
ms.custom: sap:wmi, csstroubleshoot
ms.subservice: system-mgmt-components
---
# New WMI arbitrator behavior in Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019

This article introduces new WMI arbitrator behavior in Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4096063

## Summary

This article describes Windows Management Instrumentation (WMI) arbitrator's behavior that was introduced in the March 20, 2018 cumulative updates for Windows Server 2016 and Windows Server 2012 R2.

## More information

The arbitrator is an important WMI component that implements the following functionality:

- Stores the details of queries that are submitted by the clients. The details include the query text, submission time, user name, client PID, and memory usage.
- Schedules the tasks to run the queries.
- Stores the results that are returned by the providers while the results are waiting to be retrieved by the clients.
- Throttles query execution when the total amount of memory used reaches the threshold of 256 MB.

For more information, see the update history for the cumulative update of Windows Server 2012 R2 and Windows Server 2016.

Before the implementation of the new functionality, there was the potential for a query that uses a large amount of memory to cause a deadlock condition in WMI if a client does not retrieve the results. In this case, if the offending query causes total memory usage to reach the threshold of 256 MB, all other queries are throttled (not executed) until the memory pressure decreases. However, if the client is unable to retrieve the data, this condition cannot be resolved until WMI or the computer is restarted.

This change implements a mechanism to cancel the WMI request that is using a large amount of memory if the client is detected as not being active for long time, or if the arbitrator's memory threshold is reached.

### Scenarios

These are the two possible scenarios:

- The client is detected to be idle for longer than the time that is specified in the registry value `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Wbem\CIMOM\ArbTaskMaxIdle`. The default value is 1200000 ms (20 minutes).

    When the task is canceled, an event ID 5858 is logged in the WMI-Activity/Operational log with the possible cause "Throttling Idle Tasks, refer to CIMOM regkey: ArbTaskMaxIdle."
- The cumulative memory usage in the arbitrator buffer reaches the 256-MB threshold.

    WMI service will start the cleanup process that cancels queries, enumerations, or ESS tasks/requests that hold memory in Winmgmt. When this cleanup occurs, an event ID 5858 is logged in the WMI-Activity/Operational log with the possible cause "Throttling Idle/stack Tasks in hitting Max Memory quota."

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).

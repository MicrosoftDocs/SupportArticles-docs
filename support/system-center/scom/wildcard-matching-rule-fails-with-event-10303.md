---
title: A wildcard matching rule fails with event 10303
description: Fixes an issue in which a wildcard matching rule fails and event ID 10303 is logged in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: adoyle, jchornbe, kaushika
---
# A Wildcard matching rule fails and event ID 10303 is logged in Operations Manager

This article helps you fix an issue in which a wildcard matching rule fails and event ID 10303 is logged in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3004791

## Symptoms

In the Operations Manager component for System Center 2016, System Center 2012 R2, System Center 2012, a wildcard matching rule fails, and the following event is logged in the event log:

> Event Type: Error  
> Event Source: Health Service Modules  
> Event Category: None  
> Event ID: 10303  
> Date:  
> User: N/A  
> Computer: <*ComputerName*>  
> Description:  
> The Microsoft Operations Manager Expression Filter Module failed to process a data item and dropped it.
>
> Error: 0x80004005
>
> One or more workflows were affected by this.
>  
> Workflow name: <*WorkflowName*>  
> Instance name: <*InstanceName*>  
> Instance ID: {*InstanceID*}  
> Management group: <*MG name*>

## Cause

This problem may occur if the length of the line for the match is longer than the Expression Filter can handle.

## Resolution

> [!IMPORTANT]
> Before you modify the registry, follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, follow these steps:

1. Create the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Modules\Global\ExpressionFilter`

2. Under this subkey, create a DWORD value.
3. Type the `MaxExpressionDepth` name for the DWORD value.
4. Assign a data value that is between 500 and 100000. The default value is **2000**.

> [!NOTE]
> After you change the registry, the MonitoringHost.exe process may crash and you will see an event 4000 in the Operations Manager event log. In this case, try to use a different operator in the **Rule** filter. For example, try the **Contains** operator instead of using regular expression or wildcard. If it doesn't resolve the problem, contact Microsoft Support.

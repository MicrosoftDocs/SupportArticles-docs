---
title: Can't see performance or availability details
description: Fixes an issue in which you are unable to see any performance or availability details when you use performance widgets in System Center 2012 Operations Manager.
ms.date: 04/15/2024
ms.reviewer: monsee, adoyle
---
# Unable to see any performance or availability details using System Center 2012 Operations Manager widgets

This article helps you fix an issue in which you are unable to see any performance or availability details when you use performance widgets in System Center 2012 Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2711375

## Symptoms

When using performance widgets in System Center 2012 Operations Manager, you may experience one or more of the following symptoms:

- While creating performance widgets, none of the performance objects or counters are shown in the wizard.
- You're unable to retrieve availability details using Operations Manager state widgets.
- Network dashboard views aren't showing any availability details or performance details.
- The Reset Health State task fails with the exception below shown under the task status view:

    > A module reported an error 0x80070490 from a callback which was running as part of rule "System.Health.ResetState" running for instance "\<instance name>" with id:"{GUID}" in management group "\<Management Group Name>".
    >
    > Error Code: -2130771918 (Unknown error (0x80ff0032)).

## Cause

It can occur if the management group ID is different in the `MT_ManagementGroup` and `__MOMManagementGroupInfo__` tables. If you create the `OperationsManager` database using DBCreateWizard.exe, the management group GUIDs will be different. We can safely change the management group ID in `__MOMManagementGroupInfo__` table.

> [!NOTE]
> This issue will only happen on upgraded environments from System Center Operations Manager 2007 R2.

## Resolution

To resolve this issue, complete the steps below.

1. Find the management group ID in `MT_ManagementGroup` and `__MOMManagementGroupInfo__` tables. To do it, run the following queries on the `OperationsManager` database:

    ```sql
    Select ManagementGroupId from __MOMManagementGroupInfo__
    Select Id_6B1D1BE8_EBB4_B425_08DC_2385C5930B04 from MT_ManagementGroup
    ```

2. If the values (GUIDs) are different, change the management group ID in the `__MOMManagementGroupInfo__` table. To do it, run the following query to update the `__MOMManagementGroupInfo__` table:

    ```sql
    Update __MOMManagementGroupInfo__ SET ManagementGroupId = '<GUID>'
    ```

    > [!NOTE]
    > Change the \<GUID> to match the ID from `MT_ManagementGroup` table.

3. Once the query is executed, restart the **System Center Data Access Service**, the **System Center Management Configuration** service, and the **System Center Management** service on the management server.

4. Reopen the Operations Manager console using the `/clearcache` switch. For example, run the following command at a command prompt:

    ```console
    microsoft.mom.ui.console.exe /clearcache
    ```

## More information

Make sure that you have recent backups of the `OperationsManager` and `OperationsManagerDW` databases before updating the tables.

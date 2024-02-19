---
title: Changes aren't replicated to destination domain controllers
description: Describes an issue that occurs in a Windows Server 2003 environment, where changes that are made to security groups or distribution groups aren‘t replicated to destination domain controllers when you use link value replication. Resolution is provided.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ArrenC, GrahamM
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Changes to security groups or distribution groups are not replicated to destination domain controllers when you use link value replication in a Windows Server 2003 environment

This article provides a solution to an issue where changes that are made to security groups or distribution groups aren't replicated to destination domain controllers when you use link value replication.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 958838

## Symptoms

Consider the following scenario. In a Windows Server 2003 environment, you set the forest functional level in the forest to Windows Server 2003 or to a later version of Windows. You do this to apply link value replication (LVR) changes to group membership on LVR-enabled attributes. In this scenario, you may experience the following symptoms:

- Changes to the security group or distribution group that exists on the source domain controller aren't replicated to the destination domain controllers. You experience this symptom when the group membership change is initiated either by an administrator or by a program.

- When you run the `repadmin /showreps` command, you receive a message that states that a Windows Server 2008-based or Windows Server 2003-based destination domain controller can't replicate inbound changes to a directory partition from one or more source domain controllers. In this situation, you also receive a Win32 error 8451.

    > [!NOTE]
    > Win32 error 8451 corresponds to the ERROR_DS_DRA_DB_ERROR error and to the following description:  
    The replication operation encountered a database error.

    The affected Windows Server 2008-based or Windows Server 2003-based destination domain controller may not replicate inbound changes that are made to read-only partitions from global catalogs or from domain controllers that are hosting writable directory partitions.

- Windows Server 2008-based and Windows Server 2003-based destination domain controllers log events in the Directory Service log.

    > [!NOTE]
    >
    > - NTDS general event 1173 indicates a generic replication failure.
    > - The additional data error value -1603 maps to a **Currency not on a record** jet error and to the symbolic name *errNoCurrentRecord*. The misspelling of currently in the **Currency not on a record** error text.
    > - Exception e0010004 corresponds to error DSA_DB_EXCEPTION.
    > - Internal ID 2050344 corresponds to a function in the database layer code of NTDS. This number depends on the operating system, on the service pack, and on the patching revisions.

- Windows Server 2008-based and Windows Server 2003-based destination domain controllers log the Directory Service event 1692.

    > [!NOTE]
    > This event is logged when you enable diagnostic logging and set the value for the **5 Replication Events** registry entry to 1 or greater.

    For more information about NTDS diagnostic logging, see [How to configure Active Directory and LDS diagnostic event logging](configure-ad-and-lds-event-logging.md).

These symptoms may occur when changes are made to any LVR-replicated object class that has forward links. (These changes to the LVR-replicated object class are also to the changes that are made to security and distribution groups.)

## Cause

This issue occurs if Windows Server 2008-based or Windows Server 2003-based destination domain controllers stop inbound replication when they receive LVR updates of objects that don't exist in their local copies of Active Directory.

Specifically, this issue may occur if the following conditions are true:

- Membership changes that are made to lingering security or distribution groups on source domain controllers are outbound-replicated by using link value replication (LVR) to destination domain controllers that don't have an instance of the group that is being modified. For example, this issue may occur when an object is deleted, and the lifetime of the tombstone objects has expired from the local copy of Active Directory.

- The forest functional level is set to Windows Server 2003 Interim mode or a later version.

- The lingering security or distribution groups reside on either read-only or writable partitions of Windows Server 2003-based or Windows Server 2008-based source domain controllers, and replication stops between the source and destination domain controllers.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this issue, follow these steps:

1. Run the following repadmin command on the primary domain controller (PDC) to create a .csv file that contains the list of destination domain controllers:

    ```console
    repadmin /showrepl * /csv >showrepl.csv
    ```

2. Open the .csv file in Excel, and then identify replication failures on destination domain controllers that have failed the incoming replication process and that display Win32 error 8451.

3. On the domain controllers that log the "Win32 error 8451" error message, make sure that diagnostic logging for the **5 Replication Events** registry entry is set to a value of **1**. To do this, follow these steps:

    1. Click **Start**, and then click **Run**.
    2. In the **Open** box, type regedit, and then click **OK**.
    3. Locate and then click the following registry key:
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`

    4. In the details pane, double-click **5 Replication Events**, type 1 in the **Value data** box, and then click **OK**.
    5. Close Registry Editor.

4. On the destination domain controllers, verify that Directory Service event 1692 is logged in the Directory Service log. The event displays changes to the **member** attribute of the security group or to other LVR-replicated attributes and to the lingering object GUIDs.

5. Remove the lingering objects from the Windows Server 2008-based or Windows Server 2003-based destination domain controllers by using the `repadmin /removelingeringobjects` command.

> [!IMPORTANT]
> Disabling strict replication consistency functionality in the registry of Windows Server 2008-based or Windows Server 2003-based destination domain controllers does not resume replication. You must not set the value of the Strict Replication Consistency registry entry to 0 to unblock replication of directory partitions.
>
> Do not force replication of directory partitions on source domain controllers by using the repadmin /sync command or an equivalent command together with the /force switch.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

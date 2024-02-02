---
title: Troubleshoot replication error 8614
description: Fixes Active Directory replication error 8614.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# Troubleshoot Active Directory replication error 8614

This article provides the steps to troubleshoot Active Directory replication error 8614.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2020053

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, please [ask the Microsoft Community](https://answers.microsoft.com).

## Symptoms

1. DCDIAG reports that Active Directory Replications test failed with error status code 8614: Active Directory can't replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.

    ```output
    Testing server: <site name><destination dc name>  
    Starting test: Replications  
    * Replications Check  
    [Replications Check,<destination DC name] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: <directory partition DN path>  
     The replication generated an error (8614):
     Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
    The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.  
    3 failures have occurred since the last success.  
    ```

2. REPADMIN.EXE reports that the last replication attempt failed with status 8614. REPADMIN commands that commonly cite the 8614 status include but aren't limited to:

     - `REPADMIN /REPLSUM`
     - `REPADMIN /SHOWREPL`
     - `REPADMIN /SHOWREPS`
     - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS` depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the **replication access was denied** error is shown below:

    ```output
     efault-First-Site-Name\CONTOSO-DC1  
     DSA Options: IS_GC  
     Site Options: (none)  
     DSA object GUID:  
     DSA invocationID:  
    
    ==== INBOUND NEIGHBORS ======================================  
    
    DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID:  
    Last attempt @ <date> <time> failed, result 8614(0x21a6):
    The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.  
    ```

3. NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the five statuses are logged in the Directory Service event log.

    Active Directory events that commonly cite the 8524 status include but aren't limited to:

    | Event source| ID| Event string |
    |---|---|---|
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|

4. NTDS Replication Event 2042 may be logged in the Directory Service event log:

    ```output
    Event Type: Error
    Event Source: NTDS Replication
    Event Category: Replication
    Event ID: 2042
    User: NT AUTHORITY\ANONYMOUS LOGON
    Computer: <name of DC that logged event>
    
    Description:  
    It has been too long since this machine last replicated with the named source
    machine. The time between replications with this source has exceeded the tombstone
    lifetime. Replication has been stopped with this source.
    
    The reason that replication is not allowed to continue is that the two machine's views of deleted objects may now be different. The source machine may still have copies of objects that have been deleted (and garbage collected) on this machine. If they were allowed to replicate, the source machine might return objects which have already been deleted.
    
    Time of last successful replication: YYYY-MM-DD HH:MM:SS
    Invocation ID of source: <32 character GUID for source DC>
    Name of source: <fully qualified cname record of source DC>
    Tombstone lifetime (days): <current TSL value. Default = 60 or 180 days>
    
    The replication operation has failed.

    User Action:

    Determine which of the two machines was disconnected from the forest and is now out of date. You have three options:

    1. Demote or reinstall the machine(s) that were disconnected.
    2. Use the repadmin /removelingeringobjects tool to remove inconsistent deleted objects and then resume replication.
    3. Resume replication. Inconsistent deleted objects may be introduced. You can continue replication by using the following registry key. Once the systems replicate once, it's recommended that you remove the key to reinstate the protection.  
    ```

5. The **replicate now** command in Active Directory Sites and Services returns the following message:

   > Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.

    Right-clicking on the connection object from a source DC and choosing **replicate now** in Active Directory Sites and Services (DSSITE.MSC) is unsuccessful. You receive the following message:

    > Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.

    The on-screen error message text is as follows:  

    Dialog title text: Replicate Now  
    Dialog message text: The following error occurred during the attempt to synchronize naming context <%directory partition name%> from Domain Controller \<Source DC> to Domain Controller \<Destination DC>:

    > The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
    > The operation will not continue

    Buttons in the dialog: OK

## Cause

Active Directory domain controllers support multi-master replication. Any domain controller that holds a writable partition can originate a create, modify, or delete of an object or attribute (value). Knowledge of object/attribute deletion persists for tombstone lifetime number of days. (See [Information about lingering objects in a Windows Server Active Directory forest](https://support.microsoft.com/help/910205/).

Active Directory requires end-to-end replication from all partition holders to transitively replicate all originating deletes for directory partitions to all partition holders. Failure to inbound-replicate a directory partition in a rolling TSL number of days results in lingering objects. A lingering object is an object that has been intentionally deleted by at least one DC, but incorrectly exists on destination DCs which failed to inbound-replicate the transient knowledge of all unique deletions.

Error 8614 is an example of logic added in domain controllers that are running Windows Server 2003 or a later version. It quarantines the spread of lingering objects and identifies long-term replication failures that cause inconsistent directory partitions.

Root causes for error 8614 and NTDS Replication Event 2042 include:

1. The destination DC that logs the 8614 error failed to inbound-replicate a directory partition from one or more source DCs for tombstone lifetime number of days.

2. System time on the destination DC moved, or jumped, tombstone lifetime one or more numbers of days in the future since the last successful replication. It gives the _appearance_ to the replication engine that the destination DC failed to inbound-replicate a directory partition for tombstone lifetime elapsed number of days.

    Time jumps can occur when the following conditions are true:

    - A destination DC successfully inbound-replicates, adopts _bad_ system time TSL or more number of days in the future.
    - The destination DC then tries to inbound-replicate from a source that was last replicated from TSL or more number of days in the past.

    Or

    Time jumps from current time to a date/time tombstone lifetime or more days in the past, successfully inbound-replicates. Then it tries to inbound-replicate after it adopts time TSL or more number of days in the future.

Basically, the cause and resolution for replication error 8614 apply equally to the cause and resolution for NTDS replication event 2042.

## Resolution

> [!NOTE]
> There are two action plans to recover Active Directory domain controllers that log error status 8614 or NTDS Replication event 2042. You can either force-demote the domain controller, or use the action plan below that says, **Check for required fixes, look for time jumps, check for lingering objects, and remove them if present, remove any replication quarantines, resolve replication failures, then put the DC back into service.** Force-demoting such DCs may be easier and faster, but can result in the loss of originating updates (that is, data loss) on the domain controller that's being force-demoted. Active Directory recovers gracefully from this condition by following the steps below. Select the best solution for your scenario. Don't assume that a force demotion is the only workable solution, especially when replication failure is easy to resolve or is external to Active Directory.

1. Check for nondefault values of tombstone lifetime.

    By default, tombstone lifetime uses either 60 or 180 days, depending on the version of Windows deployed in your forest. Microsoft Support regularly sees DCs that have failed inbound replication for those periods of time. It's also possible that the tombstone lifetime has been configured to a short period, such as two days. If so, DCs that didn't inbound-replicate for, say, five days will fail the following test:

    **All DCs must replicate with a rolling TSL number of days**

    Use `repadmin /showattr` to see whether a nondefault value for the **TombstoneLifetime** attribute has been configured.

    ```console
    repadmin /showattr "CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=<forest root domain>,DC=<top level domain>"
    ```

    If the attribute isn't present in the `showattr` output, an internal default value is being used.

2. Check for DCs that failed inbound replication for TSL number of days.

    Run `repadmin /showrepl * /csv` parsed by using Excel as specified in the [Verify successful replication to a domain controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc794749(v=ws.10)) section. Sort the replsum output in Excel on the last replication success column in the order from least current to the most current date and time.

3. Check for Windows Server 2003 RTM domain controllers.

    If the 8614 error occurred on a Windows Server 2003 RTM domain controller, install the latest Windows Server 2003 service pack.

4. Check for time jumps.

    To determine whether a time _jump_ occurred, check event and diagnostic logs (`repadmin /showreps`, dcdiag logs) on destination DCs that are logging 8614 errors for the following timestamps:

    - Date stamps that predate the release of an operating system. For example, date stamps from Windows Server 2003 for an OS released in Windows Server 2008.
    - Date stamps that predate the installation of the operating system in your forest.
    - Date stamps in the future.
    - No events being logged in a given date range.

    Microsoft Support teams have seen system time on production domain controllers incorrectly jump hours, days, weeks, years, and even tens of years in the past and future.

    If system time was found to be inaccurate, correct it. Then try to determine why time jumped, and what can be done to prevent inaccurate time going forward vs. just correcting the bad time. Possible areas to investigate include:

    - Was the forest root PDC configured by using an external time source?
    - Are reference time sources online, available on the network, and resolvable in DNS?
    - Was the Microsoft or third-party time service running and in an error-free state?
    - Are DC-role computers configured to use NT5DS hierarchy to source time?
    - Was the time rollback protection described in [How to configure the Windows Time service against a large time offset](https://support.microsoft.com/help/884776) in place?
    - Do system clocks have good batteries and accurate time in the BIOS?
    - Are virtual host and guest computers configured to source time according to the hosting manufacturers recommendations?

    This article [How to configure the Windows Time service against a large time offset](https://support.microsoft.com/help/884776) documents steps to help protect domain controllers from listening to invalid time samples. More information on **MaxPosPhaseCorrection** and **MaxNegPhaseCorrection** is available in [Windows Time Service](/archive/blogs/w32time/).

5. Check for and remove lingering objects if they're present.

    The point of the 8614 error replication quarantine is to check for lingering objects and remove them, if present, in each locally held partition before setting **Allow Replication with divergent and corrupt partner** to 1 in the registry of the destination DC, even if you think that all destination DCs in the forest are running in strict replication consistency.

    Removing lingering objects is beyond the scope of this article. For more information, see the following articles:

    - [Information about lingering objects in a Windows Server Active Directory forest](https://support.microsoft.com/help/910205).

    - [Event ID 1388 or 1988: A lingering object is detected](/previous-versions/orphan-topics/ws.10/cc780362(v=ws.10))

    `Repadmin` syntax is shown here:

    |Syntax|Online help (Windows Server 2008 and later)|
    |---|---|
    |`c:\>repadmin /removelingeringobjects <Dest_DSA_LIST> <Source DSA GUID> <NC> [/advisory_mode]`| `c:\>repadmin /help:removelingeringobject` |

6. Evaluate setting strict replication on destination DCs.

    Strict mode replication prevents lingering objects from being reanimated on destination DCs that have used garbage collection to create, delete, and reclaim intentionally deleted objects.

    The registry key for strict replication:

    - Path: `HKEY_LOCAL_MACHINE\system\ccs\services\ntds\parameters`
    - Setting: Strict Replication Consistency   \<- not case sensitive>
    - Type: reg_dword
    - Value: 0 | 1

    `Repadmin` syntax for enabling and disabling strict replication on a single or multiple DCs is as follows:

    | Syntax| Online help (Windows Server 2008 and later)|Enable on a single DC|Enable on all DCs in forest|Enable on all GCs in forest|
    |---|---|---|---|---|
    | `repadmin /regkey <DSA_LIST> <{+|-}key> [value [/reg_sz]`]| `Repadmin /help:regkey` | `repadmin /regkey <fully qualified computer name> +strict` | `repadmin /regkey * +strict` | `repadmin /regkey gc: +strict` |

7. Set **Allow replication with divergent and corrupt partner** to 1 on the 8614 DC.

    After any lingering objects are removed, disable the time-based replication quarantine:

    **Registry method**：
  
    - Registry path: `HKEY_LOCAL_MACHINE\system\ccs\services\ntds\parameters`
    - Registry setting: Allow replication with divergent and corrupt partner   <- Not case sensitive》
    - Registry value: 0 = disallow, 1 = allow

    **`Repadmin` method**：

    | Syntax| Online help (Windows Server 2008 and later)|Enable on a single DC|Enable on all DCs in forest|Enable on all GCs in forest|
    |---|---|---|---|---|
    |`repadmin /regkey <DSA_LIST> <{+|-}key> [value [/reg_sz]`] | `Repadmin /help:regkey` |`repadmin /regkey dc01.contoso.com +allowDivergent` |`repadmin /regkey * +allowDivergent` |`repadmin /regkey GC: +allowDivergent` |

8. Resolve AD replication failures if they're present.

    When the 8614 error status is logged on a destination DC, prior replication errors that were logged in the previous TSL number of days are masked.

    The fact that the 8614 error was reported by the destination DC doesn't mean that the replication fault resides on the destination DC. Instead, the source of the replication failure could lie with the network or DNS name resolution. Or, there could be a problem with one of the following items:

    - authentication
    - jet database
    - topology
    - the replication engine on either the source DC or the destination DC

    Review past Directory Service events and diagnostic output (dcdiag, `repadmin` logs) that was generated by the source DC, by the destination DC, and by alternative replication partners in the past to identify the scope and failure status that is preventing replication between the destination DC and the source DC.

9. Delete **Allow replication with divergent and corrupt partner** or set **Allow replication with divergent and corrupt partner** to 0 in the registry.

10. Monitor Active Directory replication daily going forward.

    Monitor end-to-end replication in your Active Directory forest daily by using an Active Directory monitoring application. One inexpensive but effective option is to run `repadmin /showrepl * /csv` and then parse the results in Excel. For more information, see [Method 2: Monitor replication by using a command line](information-lingering-objects.md#method-2-monitor-replication-by-using-a-command-line-command).

    Identify DCs that are approaching replication failures for 50 percent and for 90 percent of tombstone lifetime. Put them on a watch list. At 50 percent of TSL, make a strong push to resolve replication errors. At 90 percent, consider demoting DCs that cause replication errors forcibly if it's necessary. To do so, use the `dcpromo /forceremoval` command.

    Again, replication errors that are logged on a destination DC may be caused by a problem on:

    - The source DC
    - The destination DC
    - The underlying network

    Therefore, try to determine the cause and where the fault is before you take preventive action.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## References

[Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)](/previous-versions/windows/it-pro/windows-server-2003/cc738018(v=ws.10))

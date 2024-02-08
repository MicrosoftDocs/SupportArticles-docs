---
title: Troubleshoot replication error 8456 or 8457
description: Describes how to troubleshoot replication error 8456 or 8457.
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
# Active Directory replication error 8456 or 8457: The source | destination server is currently rejecting replication requests

This article describes the symptoms, cause, and resolution steps for situations where Active Directory operations fail with error 8456 or 8457.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2023007

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

## Symptoms

Active Directory operations fail with error 8456 or 8457: The source | destination server is currently rejecting replication requests.

1. The DCPROMO promotion of a new domain controller in an existing forest fails with the error: The source server is currently rejecting replication requests.

    Dialog title text: Active Directory Installation Wizard
    Dialog message text:

    > The operation failed because: Active Directory could not transfer the remaining data in directory partition \<directory partition DN path> to domain controller \<destination DC>.  "The source server is currently rejecting replication requests."  

2. DCDIAG reports the error: **The source server is currently rejecting replication requests** or **The destination server is currently rejecting replication requests**.

    > Testing server: Default-First-Site-Name\<DC NAME>  
    Starting test: Replications  
    \* Replications Check  
    [Replications Check,\<DC NAME>] A recent replication attempt failed:  
    From IADOMINO to \<DC NAME>  
    Naming Context: DC=\<DN path of partition>  
     **The replication generated an error (8456):**  
    The source server is currently rejecting replication requests.  
    The failure occurred at \<Date> \<Time>.  
    The last success occurred at \<Date> \<time>.  
    957 failures have occurred since the last success.  
    Replication has been explicitly disabled through the server options  
    >
    > Testing server: Default-First-Site-Name\<DC NAME>  
    Starting test: Replications  
    \* Replications Check  
    [Replications Check,\<DC NAME>] A recent replication attempt failed:  
    From IADOMINO to \<DC NAME>  
    Naming Context: DC=\<DN path of partition>  
     **The replication generated an error (8457):**  
    The destination server is currently rejecting replication requests.  
    The failure occurred at \<Date> \<Time>.  
    The last success occurred at \<Date> \<time>.  
    957 failures have occurred since the last success.  
    Replication has been explicitly disabled through the server options

3. REPADMIN indicates that incoming and outgoing Active Directory replication may be failing with the error: The source | destination server is currently rejecting replication.

    > DC=Contoso,DC=COM  
        \<site name>\<dc name> via RPC  
            DC object GUID: \<objectguid of source DCs NTDS settings object>  
            Last attempt @ \<date> \<time> failed, result 8457 (0x2109):  
                The destination server is currently rejecting replication requests.  
    >
    > DC=Contoso,DC=COM  
        \<site name>\<dc name> via RPC  
            DC object GUID: \<objectguid of source DCs NTDS settings object>  
            Last attempt @ \<date> \<time> failed, result 8456 (0x2108):  
                The source server is currently rejecting replication requests.

    > [!NOTE]
    > REPADMIN commands may display both the hexadecimal and the decimal equivalent for the currently rejecting replication error.

4. Event sources and event IDs that indicate that a USN rollback has occurred include but are not limited to the following.

    | Event source| Event ID| Event string |
    |---|---|---|
    |NTDS KCC|1308| The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following domain controller has consistently failed. |
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS KCC|1926|The attempt to establish a replication link to a read-only directory partition with the following parameters failed|
    |NTDS Replication|1586| The Windows NT 4.0 or earlier replication checkpoint with the PDC emulator master was unsuccessful. A full synchronization of the security accounts manager (SAM) database to domain controllers running Windows NT 4.0 and earlier might occur if the PDC emulator master role is transferred to the local domain controller before the next successful checkpoint. The checkpoint process will be tried again in four hours. |
    |NTDS Replication|2023|The local domain controller was unable to replicate changes to the following remote domain controller for the following directory partition.|
    | Microsoft-Windows-ActiveDirectory_DomainService|2095|During an Active Directory Domain Services replication request, the local domain controller (DC) identified a remote DC which has received replication data from the local DC by using already acknowledged USN tracking numbers.|
    | Microsoft-Windows-ActiveDirectory_DomainService|2103|The Active Directory Domain Services database was restored by using an unsupported restoration procedure.  Active Directory Domain Services will be unable to log on users while this condition persists. Therefore, the Net Logon service has paused. |

      Where embedded status codes 8456 and 8457 map to the following.

    | Decimal error| Hexadecimal error| Error string |
    |---|---|---|
    |8456|2108|The source server is currently rejecting replication|
    |8457|2109|The destination server is currently rejecting replication|

5. NTDS General Event 2013 may be logged in the Directory Services event log. This indicates that a USN rollback occurred because of an unsupported rollback or restore of the Active Directory Database.

    > Event Type: Error  
    Event Source: NTDS General  
    Event Category: Service Control  
    Event ID: 2103  
    Date: \<date>  
    Time: \<time>  
    User: \<user name>  
    Computer: \<computer name>  
    Description: The Active Directory database has been restored by using an unsupported restoration procedure. Active Directory will be unable to log on users while this condition persists. As a result, the Net Logon service has paused. User Action See previous event logs for details. For more information, visit the Help and Support Center at `https://support.microsoft.com`.

6. NTDS General Event 1393 may be logged in the Directory Services event log. This indicates that the physical or virtual drive that is hosting the Active Directory database or log files lacks sufficient free disk space:

    > Event Type: Error  
    Event Source: NTDS General  
    Event Category: Service Control  
    Event ID: 1393  
    Date: \<date>  
    Time: \<time>  
    User: \<user name>  
    Computer: \<computer name>
    Description:  
    Attempts to update the Directory Service database are failing with error 112. Since Windows will be unable to log on users while this condition persists, the NetLogon service is being paused. M ake sure that sufficient free disk space is available on the drives where the directory database and log files reside.

## Cause

Incoming or outgoing replication was automatically disabled by the operating system because of multiple root causes.

Three events that disable inbound or outbound replication include:

- A USN rollback occurred (NTDS General Event 2103).
- The hard disk is full (NTDS General Event 1393).
- A corrupt UTD vector is present (Event 2881).

The operating system automatically makes four configuration changes when one of three conditions occurs. The four configuration changes are as follows:

1. Incoming Active Directory replication is disabled.
2. Outgoing Active Directory replication is disabled.
3. **DSA not writable** is set to a nonzero value in the registry.
4. The NETLOGON service status is changed from **running** to **paused**.

The dominant root cause for this error condition is a USN rollback discussed in [A Windows Server domain controller logs Directory Services event 2095 when it encounters a USN rollback](https://support.microsoft.com/help/875495).

Do not assume that any nonzero value for **DSA not writable** or that a source or destination server is currently rejecting replication requests during DCPROMO / AD Replication definitively means that a USN rollback has occurred and that such domain controllers implicitly have to be force-demoted or force-repromoted. Demotionmaybe the correct option. However, it may be excessive when the error is caused by insufficient free disk space.

## Resolution

1. Check the value for **DSA not writable**.

    For each domain controller that is logging the 8456 or 8457 error, determine whether one of the three triggering events automatically disabled incoming or outgoing Active Directory Replication by reading the value for " DSA not writable" from the local registry.

    When replication is automatically disabled, the operating system writes one of four possible values to **DSA not writable**:

    - Path: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`
    - Setting: DSA not writable
    - Type: Reg_dword
    - Values:
      - #define DSA_WRITABLE_GEN 1
      - #define DSA_WRITABLE_NO_SPACE 2
      - #define DSA_WRITABLE_USNROLLBCK 4
      - #define DSA_WRITABLE_CORRUPT_UTDV 8

    A value of 1 can be written only when the forest version is incompatible with the OS (for example, the W2K DC is promoted into a Windows Server 2003 forest functional level forest or the like).

    A value of 2 means that the physical or virtual drive that is hosting the Active Directory database or log files lacks sufficient free disk space.

    A value of 4 means that a USN rollback occurred because the Active Directory database was incorrectly rolled back in time. Operations that are known to cause a USN rollback include the following:

    - The booting from previously saved virtual machine snapshots of domain controller role computers on Hyper-V or VMWARE hosts.
    - Incorrect physical-to-virtual (P2V) conversions in forests that contain more than one domain controller.
    - Restoring DC role computers by using imaging products such as Ghost.
    - Rolling the contents of a partition that is hosting the active directory database back in time by using an advanced disk subsystem.

    A value of 8 indicates that the up-to-dateness-vector is corrupted on the local DC.  

    Technically, **DSA not writable** could consist of multiple values. For example, a registry value of 10 would indicate insufficient disk space and a corrupted UTD. Typically, a single value is written to **DSA not writable**.

    > [!NOTE]
    > It is common for support professionals and administrators to partly disable the replication quarantine by enabling outgoing replication, by enabling incoming replication, by changing the startup value for the NETLOGON service from disabled to automatic, and by starting the NETLOGON service. Therefore, the full quarantine configuration may not be in place when it is examined.

2. Check the Directory Service event log for quarantine events.

    Assuming the Directory Service event log has not wrapped, you may find one or more related events logged in the Directory Service event log of a domain controller that is logging the 8456 or 8457 error.

    |Event|Details|
    |---|---|
    |NTDS General 2103|The Active Directory database was restored by using an unsupported restoration procedure. Active Directory will be unable to log on users while this condition persists. Therefore, the Net Logon service has paused. User Action See previous event logs for more information.|
    |NTDS General Event 1393|There is insufficient space on the disk.|
    |Event 2881|Not applicable|

3. Perform the recovery based on the value of **DSA not writable** or on events that are logged on the system:

   - If **DSA not writable** equals 4 or if NTDS General Event 2103 is logged, perform the recovery steps for a USN Rollback. For more information, see [A Windows Server domain controller logs Directory Services event 2095 when it encounters a USN rollback](https://support.microsoft.com/en-us/help/875495).

   - If **DSA not writable** equals 2 or if NTDS General event 1393 is logged, check for sufficient free disk space on the physical and virtual partitions that are hosting the Active Directory database and log files. Free up space as required.

   - If **DSA not writable** equals 8, demote and then repromote the domain controller before it can replicate its bad value to other domain controllers in the forest.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

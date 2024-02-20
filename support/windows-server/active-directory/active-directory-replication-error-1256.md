---
title: Active Directory replication error 1256
description: Describes how to Active Directory replication error 1256.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, justintu
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication error 1256: The remote system is not available

This article describes the symptoms, cause, and resolution steps for cases when Active Directory replication fails with error 1256: The remote system is not available.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2200187

## Symptoms

1. The DCDIAG reports that the Active Directory Replications test has failed with error 1256: The remote system is not available.

    > Starting test: Replications  
    [Replications Check, \<Destination DC>] A recent replication attempt failed:  
    From \<source DC> to \<destination DC>  
    Naming Context: \<directory partition DN path>  
    The replication generated an error **(1256):**  
    **The remote system is not available.** For information about network troubleshooting, see Windows Help.  
    The failure occurred at \<date> \<time>  
    The last success occurred at \<date> \<time>

2. REPADMIN.EXE reports that a replication attempt has failed with status 1256.
 REPADMIN commands that commonly cite the 1256 status include but are not limited to:  

    - `REPADMIN /REPLSUM`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /SHOWREPL`
    - `REPADMIN /FAILCACHE`

     Sample output from `REPADMIN /SHOWREPS` depicting inbound replication from LonEMEADC to LonContosoDC failing with The remote system is not available error is shown below:  

    > Repadmin: running command /showrepl against full DC localhost  
    London\LONCONTOSODC  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID: a29bbfda-8425-4cb9-9c66-8e07d505a5c6  
    DSA invocationID: d58a6322-6a28-4708-82d3-53b7dcc13c1a
    >
    > ==== INBOUND NEIGHBORS ======================================  
    \<snip>  
    DC=ForestDnsZones,DC=Contoso,DC=com  
    London\LONEMEADC via RPC  
    DSA object GUID: cd691606-63d1-4cc8-b77a-055674ba569d  
    Last attempt @ 2010-06-10 17:35:46 failed, result 1256 (0x4e8):  
        The remote system is not available. For information about network troubleshooting, see Windows Help.  
    <#> consecutive failure(s).  
    Last success @ \<date> \<time>.

3. NTDS KCC, NTDS Replication, or ActiveDirectory_DomainService events with the 1256 status are logged in the directory service event log.  

    | Event Source| Event ID| Event String |
    |---|---|---|
    | NTDS Replication ActiveDirectory_DomainService| 1085 *| Internal event: Active Directory Domain Services could not synchronize the following directory partition with the directory service at the following network address. |
    | NTDS KCC ActiveDirectory_DomainService| 1308| The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following domain controller has consistently failed. The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following directory service has consistently failed. |

    > [!NOTE]
    > Event 1085 is only logged if the NTDS Diagnostics value **5 Replication Events** has been set to a value of 1 or higher.

## Cause

Replication status 1256 is logged for the following reason:  

When the destination DC fails to bind to the source DC using RPC a win32 error code in the Repsfrom status for that partition - usually Schema or Configuration since these partitions are replicated at a higher priority. After an RPC bind failure has occurred, a cleanup routine will run to clear the destination DCs queue from that same source DC. This is done to avoid wasting time attempting to replicate with a DC that it can't connect to. Since it hasn't attempted a sync for the partitions that have been cleared from the queue, a status 1256 is logged. In a scenario where destination DC replicates Schema, Configuration, and several GC non-writable partitions from the source DC, the win32 error status for the Schema and Configuration partitions that caused the RPC bind failure is logged. The destination DC will then cancel the pending replication tasks for the remaining partitions and log win32 error 1256 for the status.  

In summary: 1256 is logged as the replication status per partition as a result of the destination DC cancelling the sync request from the source DC due to a connectivity failure previously encountered.

## Resolution

The win32 error 1256 should not be the focus of troubleshooting efforts, instead find the replication status that led to the RPC bind failure and then follow the corresponding _Troubleshooting Active Directory operations that fail with error..._ article.

[Diagnose Active Directory replication failures](diagnose-replication-failures.md).

In order to determine the actual win32 error to troubleshoot,  use one of the following methods:

1. View `repadmin /showreps` or `/showrepl`output on the destination DC

    1. Identify Source DC in the output and list all win32 status messages per partition
    2. The win32 status that is listed that is not a 1256 should be the focus of troubleshooting efforts  

2. Use `repadmin /showrepl * /csv` output:

    1. Filter column K, **Last Failure Status:** Deselect **0** and **(Blanks)**  
    2. Filter column C, **Destination DSA**: Deselect **(Select All)** and select just the DC where the 1256 status is logged.
    3. If 1256 is logged on more than one Source DC, Filter column F, **Source DSA**: Deselect **(Select All)** and Select just one DC to narrow the focus.
    4. Column K, **Last Failure Status** will list the 1256's along with the real win32 error that led to the RPC bind failure.

    In the following example, win32 error 1722 is logged for the Configuration and Schema partitions and should be the focus of troubleshooting.

    | B| C| D| E| F| H| I| J| K |
    |---|---|---|---|---|---|---|---|---|
    | **Destination** **DSA Site**| **Destination DSA**| **Naming Context**| **Source DSA Site**| **Source DSA**| **Number of Failures**| **Last Failure Time**| **Last Success Time**| **Last Failure Status** |
    | London| LONCONTOSODC| CN=Configuration,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1722 |
    | London| LONCONTOSODC| CN=Schema,CN=Configuration, DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:36| 6/10/2010 14:50| 1722 |
    | London| LONCONTOSODC| DC=ForestDnsZones,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1256 |
    | London| LONCONTOSODC| DC=corp,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1256 |
    | London| LONCONTOSODC| DC=EMEA,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:54| 1256 |
    | London| LONCONTOSODC| DC=apac,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1256 |

3. Initiate a manual replication sync between source and destination DCs using repadmin.

    `Repadmin /replicate DestinationDC SourceDC <DN of partition reporting status 1256>` (This will require **/readonly** switch for GC partition or **/selsecrets** switch if destination is an RODC)

    `repadmin /replicate loncontosodc lonemeadc.emea.contoso.com dc=forestdnszones,dc=contoso,dc=com`

    DsReplicaSync() failed with status 1722 (0x6ba):

    > The RPC server is unavailable.  

    Take note that after manually initiating replication for the partition that the status has changed from 1256 to 1722:

    | B| C| D| E| F| H| I| J| K |
    |---|---|---|---|---|---|---|---|---|
    | **Destination DSA Site**| **Destination DSA**| **Naming Context**| **Source DSA Site**| **Source DSA**| **Number** **of Failures**| **Last Failure Time**| **Last Success Time**| **Last Failure Status** |
    | London| LONCONTOSODC| CN=Configuration,DC=Contoso, DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1722 |
    | London| LONCONTOSODC| CN=Schema,CN=Configuration, DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:36| 6/10/2010 14:50| 1722 |
    | London| LONCONTOSODC| DC=ForestDnsZones, DC=Contoso,DC=com| London| LONEMEADC| 12| 6/10/2010 17:46| 6/10/2010 14:50| 1722 |
    | London| LONCONTOSODC| DC=corp,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1256 |
    | London| LONCONTOSODC| DC=EMEA,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:54| 1256 |
    | London| LONCONTOSODC| DC=apac,DC=Contoso,DC=com| London| LONEMEADC| 11| 6/10/2010 17:35| 6/10/2010 14:50| 1256 |

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

The following articles contain the troubleshooting procedures for errors typically logged with win32 error 1256:

|Win32 error|Article|
|---|---|
| -2146893022| [Active Directory replication error -2146893022: The target principal name is incorrect](replication-error-2146893022.md)|
| 5| [Active Directory replication error 5 - Access is denied](replication-error-5.md)|
| 1722| [Active Directory replication error 1722: The RPC server is unavailable](replication-error-1722-rpc-server-unavailable.md)|
| 1727| [Troubleshoot domain controller replication error 1727-The remote procedure call failed and did not execute](remote-procedure-call-failed-and-did-not-execute-error.md) |
| 1753| [Active Directory Replication Error 1753: There are no more endpoints available from the endpoint mapper](replication-error-1753.md)|
| 1908| [Troubleshooting Active Directory operations that fail with error 1908: Could not find the domain controller for this domain](https://support.microsoft.com/help/2712026)|
| 8524| [Active Directory Replication Error 8524: The DSA operation is unable to proceed because of a DNS lookup failure](replication-error-8524.md)|
| 8453| [Active Directory replication error 8453: Replication access was denied](replication-error-8453.md)|

---
title: Abandoned objects block replication for Global Catalog naming contexts
description: 
ms.date: 04/08/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Abandoned objects block replication for Global Catalog naming contexts

## Summary

Abandoned objects in Active Directory Domain Services are objects that exist on some DCs in the forest, but have never replicated to other DCs. The DCs that hold these objects are typically global catalog servers (GCs) or read-only domain controllers (RODCs).

Abandoned objects resemble lingering objects. However, lingering objects are objects that at some point existed in all Active Directory replicas. Abandoned objects never existed in all replicas. This difference is one reason that lingering object removal tools might identify abandoned objects, but can't remove them. For more information about how abandoned objects and lingering objects occur and how they differ, see [How abandoned objects and lingering objects occur](#how-abandoned-objects-and-lingering-objects-occur).

### Prerequisites

- Understand lingering objects and how to remove them, as described in the following articles:

  - [Active Directory replication Event ID 1388 or 1988: A lingering object is detected](active-directory-replication-event-id-1388-1988.md)
  - [How to detect and remove lingering objects in a Windows Server Active Directory forest](information-lingering-objects.md)

- Understand replication components, including Directory Service Agent IDs (DSA GUIDs or DSAs), invocation IDs, and update sequence numbers (USNs), as described in the following articles:

  - [Safely virtualizing Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100)
  - [A Windows Server domain controller logs Directory Services event 2095 when it encounters a USN rollback](detect-and-recover-from-usn-rollback.md)

## Symptoms

You are running a Windows Active Directory forest that has multiple domains and/or Read-Only Domain Controllers (RODCs). You encounter behavior, events or error messages that resemble any of the following examples.

### Example 1: Transient or phantom objects

An application or user searches for an Active Directory object, but the search results are inconsistent.

- The user or application might find the object while connected to an RODC or a GC, but if they connect to a writable DC, the object doesn't appear to exist.
- If the user or application searches at the forest level, they find the object. If they search at the domain level, the object doesn't appear to exist in any domain.

Similarly, a user or application tries to create an object, but receives an error message that indicates that the distinguished name (DN), UPN ,or SPN is already in use. However, a search can't find an object that has that DN.

### Example 2: GC replication errors :"Couldn't update an object" and "There is no such object on the server"

> [!NOTE]  
> Unlike GCs, RODCs might not generate events or errors when they contain abandoned objects. GCs can replicate to one another, but RODCs don't replicate to any other DCs.

The event log contains Event ID 1084, which indicates that an expected object is missing from the Active Directory instance on the destination GC.

```output
Log Name:      Directory Service
Event Source:  Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      1084
Task Category: Replication
Level:         Error

Description:
The directory replication agent (DRA) couldn't update object <FQDN> (GUID <ObjectGUID>) on this system with changes which have been received from source server <SourceServerGUID>._msdcs.bc.com. An error occurred during the application of the changes to the directory database on this system.  

You receive the following error message:  
There is no such object on the server.
```

If you run `repadmin /showreps` at a command prompt on the destination GC, the output includes a message that resembles the following example.

```output
<Site_Name>\<GC> via RPC  
DSA object GUID: 2521a874-d379-4281-8744-4bd34c792026  
Last attempt @ 2002-01-21 16:10.54 failed, result 8240:  
There is no such object on the server.
```

> [!NOTE]  
> In this example, \<Site_Name>/\<GC> is the site name and NetBios name that identify the destination GC. The Directory System Agent (DSA) object GUID is the permanent identifier of the source GC.

### Example 2: "Lingering objects" that you can't remove

In addition to Event ID 1084, you might see Event ID 1988. Typically, this event indicates that Active Directory contains lingering objects. However, in this case, it might indicate abandoned objects.

```output
Event Type: Error
Event Source: NTDS Replication
Event Category: Replication
Event ID: 1988
User: NT AUTHORITY\ANONYMOUS LOGON

Description:
Active Directory Replication encountered the existence of objects in the following partition that have been deleted from the local domain controllers (DCs) Active Directory database. Not all direct or transitive replication partners replicated in the deletion before the tombstone lifetime number of days passed. Objects that have been deleted and garbage collected from an Active Directory partition but still exist in the writable partitions of other DCs in the same domain, or read-only partitions of global catalog servers in other domains in the forest are known as "lingering objects".

This event is being logged because the source DC contains a lingering object which does not exist on the local DCs Active Directory database. This replication attempt has been blocked.

The best solution to this problem is to identify and remove all lingering objects in the forest.

Source DC (Transport-specific network address):
a3a724aa-55cf-4a0f-8889-2b3fd37a72bd._msdcs.contoso.com

Object:
DC=175.3\0ACNF:160e575d-9205-493d-89b8-97f152af40a5,CN=LostAndFound,DC=contoso,DC=com

Object GUID:
160e575d-9205-493d-89b8-97f152af40a5
```

To distinguish whether you have lingering objects or abandoned objects, open a Command Prompt window and then run the following command:

```console
repadmin /removelingeringobjects
```

After the command finishes, run it a second time. If the objects are still present, they are likely to be abandoned objects instead of lingering objects. The details of this behavior depend on the Windows Server version that you're using.

When you check the objects by name or GUID, you will not find them on writable DCs.

## Cause

The basic scenario is that an object is created on a hub DC that has RODCs or GCs as replication partners, in addition to other read-write replicas. A condition on the DC or in the infrastructure allows the object to replicate to a read-only replica, but not to a writeable replica. A firewall configuration issue or a networking issue could cause this behavior.

Before this replication issue is fixed, the hub DC is forcefully removed from the forest. Because the writeable DCs don't use GCs or RODCs as inbound replication partners, the object can't get to writeable DCs. The object is considered an *abandoned object* on the RODCs or GCs.

A similar situation occurs if an object is deleted and then restored on a hub DC that has RODCs or GCs as replication partners, in addition to other read-write replicas. Again, the restoration only replicates to read-only replicas before the hub DC is forcibly removed. On the writeable DCs, the object remains in its tombstone state until its tombstone lifetime expires. Then the garbage collection process removes the object completely. Again, the object is considered an abandoned object on the RODCs or GCs. 

For more information, see [How abandoned objects and lingering objects occur](#how-abandoned-objects-and-lingering-objects-occur).

## Resolution

You might need assistance to follow the proper course of action for the your particular issue. You can request Microsoft Technical Support to assist you with resolving this problem.

> [!IMPORTANT]  
> These methods focus on removing the abandoned objects, instead of creating or restoring the objects on the DCs that they didn't replicate to. For reference information that might help you to identify the replication issues that generated the abandoned objects in the first place, see [More information](#more-information).

The algorithm that `repadmin /removelingeringobjects` uses checks the scope of the up-to-dateness vector. It does not remove objects outside the up-to-dateness vector. Abandoned objects, by definition, don't exist in the up-to-dateness vectors of the writeable DCs. Therefore, you have to use tools other than `repadmin` to remove abandoned objects.

This article describes processes that uses manual steps and scripts to remove abandoned objects. The precise details of the steps that you follow depend on the details of your forest and the type of abandoned objects that you have.

### Step 1: Collect the GUIDs of the abandoned objects and the DCs that host them

To remove abandoned objects, you have to identify each object by its `objectGUID` value. You can get this information from events and error messages, and from log files that record operations such as searches that produced inconsistent results. You can also use scripts to identify objects that exist in some Active Directory replicas and not others.

The following example Powershell script detects abandoned objects. It creates a list of the objects in the GC naming context, and then it checks to see if each object is present in the child domain. If an object is not present, the script exports the object information to a .csv file and to a .ldf file. The script doesn't change any of the objects or object attributes.

You will need to customize the server and domain names.

> [!NOTE]  
> In this script, change the value of `$GCdomain` to the DN of the affected domain, and change `$rwdomain` to the DN of the reference DC.

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```powershell
$GCdomain = "contoso.com"
$rwdomain = "child.contoso.com"
$rwdomainNC = get-addomain $rwdomain

$GC = "dc2.contoso.com:3268"
$gcdc = "dc2.contoso.com"
$allrwdcs = Get-ADDomainController -filter * -server $rwdomain | select-object hostname
get-adobject -filter '*' -searchbase $rwdomainnc .distinguishedname -server$GC|select-propertyname,distinguishedname,objectguid|export-csv-path.\root.csv-NoTypeInformation
$objects = import-csv .\root.csv

Foreach($objectin$objects)
{
   try
      {
         foreach ($dcin$allrwdcs)
            {get-adobject$object.objectguid -server$dc.hostname >$Null}
      }
   catch {$object|export-csv-path.\abandoned.csv-NoTypeInformation-Append
      $name = $object .name
      ldifde -f .\ $name .ldf -d $object .distinguishedname -s$gcdc-t3268-lname,objectclass,objectguid
      }
}
```

### Step 2: Address abandoned objects that were restored on the read-only replica, but are still tombstones on the writeable replicas

#### Use the tombstones to reset the replication metadata for the objects across the replication topology

> [!IMPORTANT]  
> This method isn't appropriate for all kinds of objects. For example, using this approach on a Domain Controller Computer object and a child Rid Set object would cause additional issues.

You can use this method under the following conditions:

- The abandoned object is restored from a deleted state.
- The object still exists as a tombstone in the other replicas in the forest (`tombstoneLifetime` hasn't expired).
- The GC or RODC that has the abandoned object is replicating correctly.

In this scenario, you can connect to one of the writeable replicas, undelete the object, and then delete it again. The changes replicate to the other DCs and to the original GC or RODC, and the object's state becomes consistent through the forest. The up-to-dateness vectors also synchronize.

#### Clear the tombstones from the replication topology

In many cases, the reference DC has tombstones (or objects in the Recycle Bin) for the abandoned objects that you want to remove, and the previous method to remove the abandoned objects isn't feasible. In such cases, it might not be practical to wait for the tombstones to expire naturally. For example, if you have Recycle Bin enabled, objects remain in the Recycle Bin for `msDS-deletedObjectLifetime` (180 days by default). At that point, they become recycled objects. Active Directory treats recycled objects as tombstones, so the objects remain in this state for `tombstoneLifetime` (180 days by default).

> [!NOTE]  
> For GC naming contexts where a GC initially replicates from a writeable DC and then later switches to replicate from a read-only replica on a GC, you might receive the replication errors before `tombstoneLifetime` expires. Therefore, to let these objects age out and still allow other replication to happen, you might have to disable strict replication consistency, and also allow replication with corrupt or divergent partners. For information about how to use these settings, see [Troubleshoot Active Directory replication error 8614](replication-error-8614.md).

To more quickly clean out the tombstones or deleted objects from the reference DC, use the following methods to shorten the amount of time that these objects remain before the garbage collector process removes them.

- **Remove objects from the Recycle Bin.** You can use Windows PowerShell to force deleted objects to become recycled objects before `msDS-deletedObjectLifetime` expires. To do this, open an administrative PowerShell Command Prompt window on the reference DC, and then run a command that resembles the following example:

  ```powershell
  Get-ADObject -Filter 'isDeleted -eq $True -and -not (isRecycled -eq $true) -and name -ne "Deleted Objects" -and lastKnownParent -eq "<LastKnownParent_DN>"' -IncludeDeletedObjects | Remove-ADObject
  ```

  >[!NOTE]  
  > In this command, \<LastKnownParent_DN> represent the DN of the container that held the object before the object was deleted.

  After you run this command, `tombstoneLifetime` controls how long the recycled objects remain in the replica.

- **Shorten `tombstoneLifetime`.** If you reduce `tombstoneLifetime` from 180 days to a few days (or less), you can speed up the garbage collector process.

  > [!IMPORTANT]  
  > If your forest has ongoing replication issues and some DCs are significantly out of sync, reducing `tombstoneLifetime` increases the risk of lingering objects accumulating in the forest.

### Step 3: Remove abandoned objects that don't have tombstones

You can use this method when the abandoned object doesn't exist in any form (such as a tombstone object or an object in the Recycle bin)on the writable DC that you use as a reference DC. Verify that the `objectGUID` of the abandoned object doesn't exist anywhere in the replica on the reference DC.

To remove abandoned objects, follow the process in [Manually Remove Lingering Objects on Outdated Replication Partners](/troubleshoot/windows-server/active-directory/manually-remove-lingering-objects). If you used a script to create a list of abandoned objects, you can use that list as input to the scripts that this process uses.

This article provides detailed instructions. Although it's presented as a manual process for removing lingering objects, it works for abandoned objects as well. The article includes scripts that run the `ldp.exe` tool's `removelingeringobject` operational attribute at the `RootDSE` level of the reference DC's replica.

After you complete this process, run the following command to make sure that the abandoned object doesn't exist in the forest.

```console
repadmin /showobjmeta \* "\<guid=orphaned objectGUID\>"
```

This command checks the existence of the abandoned object on all DCs in the forest. When the object has been successfully removed, the command generates output that resembles the following example:

```output
DsReplicaGetInfo() failed with status 8439 (0x20f7):  
The distinguished name specified for this replication operation is invalid.
```

## More information

This section provides detailed information that can help you diagnose how your forest generated abandoned objects.

### How abandoned objects and lingering objects occur

The following table provides a simplified view of how lingering objects and the two types of abandoned objects occur. It highlights the similarities and differences between the three types of objects.

> [!IMPORTANT]  
> The following table describes sequences of events. These sequences are not troubleshooting instructions.

| Abandoned object type 1 | Abandoned object type 2 | Lingering object |
| - | - | - |
| 1. Object doesn't exist. | 1. Object exists on all DCs | 1. Object exists on all DCs. |
|   |  | 2. One DC (DC-1) disconnects from the network. |
|   | 2. Delete the object. That change replicates to all DCs. | 3. Delete the object. That change replicates to all remaining DCs. |
| 2. Connect to a DC (DC-2), and then create the object. | 3. Before the tombstone lifetime expires, connect to one DC (DC-3), and then restore (undelete) the object. | |
| 3. The "create object" change replicates to GCs or RODCs. Before the change replicates to regular DCs, DC-2 disconnects from the network. | 4. The "restore" change replicates to GCs or RODCs. Before the replicates to regular DCs, DC-3 disconnects from the newtork. | |
| | 5. The tombstone lifetime expires. | 4. The tombstone lifetime expires. |
| | | 5. DC-1 reconnects to the network. |
| **Result**: Some GCs or RODCs have the object, and the "create" USN. Regular DCs don't have the object or the "create" USN, and don't receive inbound replication from GCs or RODCs. | **Result**: Some GCs or RODCs have the object, and the "restore" USN. Regular DCs don't have the object or the "restore" USN, and don't receive inbound replication from GCs or RODCs. | **Result**: Only DC-1 has the object. DC-1 doesn't have the "delete" USN. The other DCs don't have any reference to the object beyond the historical USNs. |

### Investigating abandoned objects: How to interpret information from replication partners and up-to-dateness vectors

Finding replication issues can be a complicated effort for a number of reasons. One of these reasons is that replication reports and records typically use multiple identifiers to track a single DC, and those identifiers change over time. Each DC tracks inbound replication in the following terms:

- The identity of the replication partner.
- The state of the Active Directory replica on that replication partner, including whether (and when) it has been restored from backup.
- Whether the replication partner has changes ready to send.
- All changes that the replication partner has sent previously, both before and after each restoration.

#### Identifying replication partners

To trace abandoned objects, you need two globally unique identifiers (GUIDs) for each of the affected DCs and their inbound replication partners. The following table describes these GUIDs.

| GUID type | Also referred to as | Description |
| - | - | - |
| DSA object GUID | DSA GUID | This GUID is the DC's permanent identifier. Windows creates this GUID when you promote a Windows-based server to a DC. This GUID doesn't change. |
| DSA invocationID | invocationID | This GUID identifies the current copy of Active Directory on the DC. Windows configures this GUID when you add the DC to a new or existing domain. This GUID changes to track particular directory service events. |

Event ID 1084 and event ID 1988 both identify a *source server*. This server is typically a GC that acts as an inbound replication partner to the DC that generated the events (the *destination server*, typically also a GC). The abandoned object exists on the source server, but not the destination server.

To get a snapshot of the current replication status of your forest, including the current DC identifiers (DSA GUIDS and invocation IDs), open a Command Prompt window on one of the DCs and run a command that resembles the following command:

```console
repadmin /showrepl *
```

> [!NOTE]  
> For large topologies, you can constrain the command to run on a particular DC. For more information, see [Repadmin](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc770963(v=ws.11)).

In the case of a forest that has two GCs, this command generates output that resembles the following example:

```output
Repadmin: running command /showrepl against full DC GC-1.contosotest.com
Default-First-Site-Name\GC-1
DSA Options: IS_GC
Site Options: (none)
DSA object GUID: 8e294159-140d-41f8-b041-23896e86cb00
DSA invocationID: 9789f50b-6b9f-4632-ba93-dccf617325a2

==== INBOUND NEIGHBORS ======================================

DC=contosotest,DC=com
    Default-First-Site-Name\GC-2 via RPC
        DSA object GUID: 0dd82239-b6e1-4f03-9899-76a80ad9f88a
        Last attempt @ 2026-02-10 15:52:38 was successful.

. . .

Repadmin: running command /showrepl against full DC GC-2.contosotest.com
Default-First-Site-Name\GC-2
DSA Options: IS_GC
Site Options: (none)
DSA object GUID: 0dd82239-b6e1-4f03-9899-76a80ad9f88a
DSA invocationID: 3e04086d-da99-465f-b82d-e74f31a1caf1

==== INBOUND NEIGHBORS ======================================

DC=contosotest,DC=com
    Default-First-Site-Name\GC-1 via RPC
        DSA object GUID: 8e294159-140d-41f8-b041-23896e86cb00
        Last attempt @ 2026-02-10 16:07:51 was successful.
```

This example identifies the following two DCs:

| DC name | DSA GUID | Current invocation ID |
| - | - | - |
| GC-1 | 8e294159-140d-41f8-b041-23896e86cb00 | 3e04086d-da99-465f-b82d-e74f31a1caf1 |
| GC-2 | 0dd82239-b6e1-4f03-9899-76a80ad9f88a | 9789f50b-6b9f-4632-ba93-dccf617325a2 |

#### Deriving the replication history from up-to-dateness vectors

Each DC maintains an up-to-dateness vector as a record of its own state and the state of each of its replication partners. To see a DC's up-to-dateness vector, run a command that resembles the following command at a command prompt on the DC.

```console
repadmin /showutdvec GC-1 dc=contosotest,dc=com
```

In the case of a forest that has two GCs, this command generates output that resembles the following example:

```output
Caching GUIDs.
..
Default-First-Site-Name\GC-2           @ USN     24987 @ Time 2026-02-10 16:56:31
Default-First-Site-Name\GC-1           @ USN     28677 @ Time 2026-02-10 15:07:21
Default-First-Site-Name\GC-1           @ USN     28957 @ Time 2026-02-10 17:03:15
Default-First-Site-Name\GC-2 (retired) @ USN     24580 @ Time 2026-02-10 15:10:48
```

This output is GC-1's up-to-dateness vector, which records both changes made on GC-1 and changes replicated in from GC-2. Each GC uses it's own independent USN series. GC-1 and GC-2 each have two entries in the up-to-dateness vector, which indicates that both GCs have been restored from a backup. This output provides enough data to derive the following information:

- GC-1 was restored from backup some time between 15:07:21 and 17:03:15. The changes that were recorded at 15:07:21 were the last changes to be recorded before the restoration.
- When GC-1 started recording changes after the restoration, it created a new entry in its up-to-dateness vector. The most recent changes that were made on GC-1 occurred at 17:03:15.
- GC-2 was restored from backup some time between 15:10:48 and 16:56:31. The changes that were recorded at 15:10:48 were the last changes to be replicated to GC-1 before GC-2 was restored.
- When GC-2 started replicating changes after the restoration, GC-1 assigned it a new entry in its up-to-dateness vector. The most recent changes that were made on GC-2 and then replicated to GC-1 occurred at 16:56:31.
- The old entry for GC-2 is labeled as "retired" to distinguish it from the entry that records replication that occurred after GC-2 was restored.

  > [!NOTE]  
  > The first entry of the first DC in the forest is never marked as "retired," even if it's no longer active.

To ge a slightly different view of the up-to-dateness vector, run the same `repadmin` command together with the `/nocache` option. This command resembles the following example:

```console
repadmin /showutdvec GC-1 dc=contosotest,dc=com /nocache
```

This time, the vector entries in the output use GUIDs instead of site and server names.

```output
3e04086d-da99-465f-b82d-e74f31a1caf1 @ USN     24987 @ Time 2026-02-10 16:56:31
8e294159-140d-41f8-b041-23896e86cb00 @ USN     28677 @ Time 2026-02-10 15:07:21
9789f50b-6b9f-4632-ba93-dccf617325a2 @ USN     28958 @ Time 2026-02-10 17:03:59
ae04509e-574a-4487-914c-7c08df548db9 @ USN     24580 @ Time 2026-02-10 15:10:48
```

You can compare these GUIDs to the DSA and invocation ID GUIDs from the output of `repadmin /showrepl`. You can also match USNs and timestamps between this set of entries and the previous example. In this example, replication continued after the first run of `repadmin /showutdvec`, so the second run produced some slight changes in USNs and timestamps. The two examples together provide enough data to derive the following information:

- Each entry has a unique GUID. In this example, you can compare the GUID version of the output to the site\server name version of the output to associate GUIDs and GCs and identify the two entries for each GC.
- To further identify the GUIDs, compare the GC and GUID combinations to the output of `repadmin /showrepl`. From this data, you can derive the following information:

  - The oldest entry for GC-1 contains GC-1's DSA GUID. This entry indicates that GC-1 is the first DC in the forest. The second entry for GC-1 contains its current invocation ID.
  - None of the entries for GC-2 use its DSA GUID. GC-2 is the second DC in the forest. When you add a DC to an existing forest, Windows immediately assigns it an invocation ID. The oldest entry for GC-2 uses this first invocation ID.

In this example, GC-2 also accepts inbound replication from GC-1. Running `repadmin /showutdvec` against GC-2 generates its view of its own changes and the changes that were replicated from GC-1.

```output
Caching GUIDs.
..
Default-First-Site-Name\GC-2           @ USN     25016 @ Time 2026-02-10 17:03:02
Default-First-Site-Name\GC-1           @ USN     28677 @ Time 2026-02-10 15:07:21
Default-First-Site-Name\GC-1           @ USN     28957 @ Time 2026-02-10 17:02:30
Default-First-Site-Name\GC-2 (retired) @ USN     24580 @ Time 2026-02-10 15:10:48
```

Comparing the historical data for GC-1 and GC-2 shows that the up-to-dateness vectors are consistent:

| Entry | Reported by GC-1 | Reported by GC-2 |
| - | - | - |
| GC-1, DSA GUID | `@ USN 28677 @ Time 2026-02-10 15:07:21` | `@ USN 28677 @ Time 2026-02-10 15:07:21` |
| GC-2, retired | `@ USN 24580 @ Time 2026-02-10 15:10:48` | `@ USN 24580 @ Time 2026-02-10 15:10:48` |

| Entry | Reported by GC-1 | Reported by GC-2 |
| - | - | - |
| GC-1 | `@ USN 28958 @ Time 2026-02-10 17:03:59` | `@ USN 28957 @ Time 2026-02-10 17:02:30` |
| GC-2 | `@ USN 24987 @ Time 2026-02-10 16:56:31` | `@ USN 25016 @ Time 2026-02-10 17:03:02` |

This table shows that each GC's view of the other is slightly out of date. GC-1 hasn't yet replicated change 28958 to GC-2, and GC-2 hasn't yet replicated changes 24988-25016 to GC-1. In this situation, even though the numbers don't match, the highest USNs correspond with the latest timestamps. This condition is expected, and the next replication cycle should synchronize changes on both GCs.

#### Finding indicators of abandoned objects in the replication partner data and the up-to-dateness vectors

When the naming context you're investigating has abandoned objects, you might see the following discrepancies (in addition to the error messages that the Symptoms section describes).

- The invocation ID (or DSA GUID) of the source GC never appears in the up-to-dateness vector. This result indicates that the source GC never successfully replicated this naming context to the destination GC.
- The invocation ID (or DSA GUID) of the source GC exists in the up-to-dateness vector, but its timestamp of the most recent entry is not current. This result indicates that the source GC has stopped replicating or was removed from the replication topology.

To help determine what caused the issue, you can retrieve up-to-dateness information from other DCs or GCs that use the affected GC as a replication source. For example, identifying which servers didn't information from the affected source GC and which did can help isolate a network infrastructure issue.

## References

- [`Remove-ADObject`](/powershell/module/activedirectory/remove-adobject)
- [Active Directory replication Event ID 1388 or 1988 - A lingering object is detected](/troubleshoot/windows-server/active-directory/active-directory-replication-event-id-1388-1988)
- [Active Directory replication Event ID 2042 (It has been too long since this machine replicated)](/troubleshoot/windows-server/active-directory/active-directory-replication-event-id-2042)
- [Troubleshoot replication error 8614](/troubleshoot/windows-server/active-directory/replication-error-8614)
- [Troubleshoot AD Replication error 8240 There is no such object on the server](/troubleshoot/windows-server/active-directory/active-directory-replication-error-8240)
- [Lingering objects in an AD DS forest](/troubleshoot/windows-server/active-directory/information-lingering-objects)
- [\[MS-ADTS\]: Tombstone Lifetime and Deleted-Object Lifetime](/openspecs/windows_protocols/ms-adts/1887de08-2a9e-4694-95e2-898cde411180)  
- [The AD Recycle Bin: Understanding, Implementing, Best Practices, and Troubleshooting](https://techcommunity.microsoft.com/blog/askds/the-ad-recycle-bin-understanding-implementing-best-practices-and-troubleshooting/396944)

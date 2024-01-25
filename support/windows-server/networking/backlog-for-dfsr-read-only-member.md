---
title: Backlog is reported for DFSR Read-Only member
description: Describes an issue in which a backlog is reported for a Read-Only member after you remove a replication file filter.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, rolandw, wincicadsec
ms.custom: sap:dfsr, csstroubleshoot
ms.subservice: networking
---
# A backlog is reported for a DFSR Read-Only member after you remove a replication file filter

This article provides a solution to an issue where a backlog is reported for a Read-Only member after you remove a replication file filter.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4021676

## Symptoms

Consider the following scenario:

- You are running Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2.
- The system uses Distributed File System Replication (DFSR) and includes Read-Only replicated folders.
- You are prestaging data regardless of the replication filter from DFSR Read/Write to Read-Only member candidates. Therefore, files that are in the filter set now exist on all members.
- After the initial replication, you remove a replication file filter.
- When DFSR members detect the filter change, they all run a **DirWalkerTask** look-up for content.
- On a Read-Only member, this process creates a UID for the file object and increments the version vector Global Version Sequence Number (GVSN). However, the local change is not propagated.
- The Read/Write partner creates its own UID for the same file, and the Read-Only member detects a name conflict.
- Per standard conflict resolution, the newer local version of the file is selected. The Read-Only member reports **Local version dominates** and subsumes the update from the Read/Write partner.
- The Read-Only member increments its GVSN and generates a tombstone for the UID from the Read/Write partner. However, neither change is propagated.

In this scenario, a backlog is reported from the Read-Only member to the Read/Write partner because the DFSR service has two local changes that are not replicated to its partner. The first report entry is for the local change when DFSR introduces the file as a new object. The second entry is created when DFSR generates a tombstone for the file version from the Read/Write partner that lost the conflict resolution. It does this by deleting that file version.

> [!NOTE]
> When the same file is later changed on the Read/Write member, the Read-Only member reuses the tombstone record in its database by reporting it as "Remote version dominates" and then providing its own UID version. This action generates conflict event 4412. Additionally, the Read-Only member clears its backlog.

## Cause

This behavior is by design. The Read-Only member applies the standard conflict resolution mechanism to new replication content if a filter is removed and existing content has to be integrated into DFSR.

## Resolution

In most circumstances, you can safely ignore backlogs that are reported in the DFSR Read-Only member to Read/Write partner direction. This is because a Read-Only member is not intended to have real changes.

If only a few files are affected, consider making generic changes to the files on the Read/Write member.

Generally, an initial sync is required for the Read-Only member to remove such a backlog.

## More information

When you use Windows PowerShell scripts and the `Get-DfsrBacklog` cmdlet to create an overview for multiple DFSR setups, you may want to consider the following logic to exclude backlog outputs from Read-Only members to their partners:

```powershell
#variables for checking multiple DFSR setups, may be different in your existing script
$RGName="ReplicationGroupName"
$RFName="ReplicatedFolderName"
$SMem="SendingMember"
$RMem="ReceivingMember"

#new variable for the DFSR subcription for the RF, containing the value/attribute "ReadOnly"; obtained by Get-DfsrMembership

$DfsrSubscription=Get-DfsrMembership -Groupname $RGName -Computername $SMem | Where-object {$_.foldername -eq $RFName}

#now gather only the Backlog output, when the senders configuration for this RF is not Read-only

if ($DfsrSubscription.ReadOnly -eq 0)
{
    Get-DfsrBacklog -Groupname $RGName -Foldername $RFName -SourceComputerName $SMem -DestinationComputerName $RMem -verbose
}
else
{
    Write-Host "Backlog detection skipped because Sending Member ($SMem) is Read-only for this RF ($RFName)"
}
```

**Result:** Instead of backlog output from the Read-Only member, you now see the following report entry:

> Backlog detection skipped because Sending Member (SendingMember) is Read-Only for this RF (ReplicatedFolderName)

> [!NOTE]
> Even after the initial backlog clears, Read-Only members may again show a backlog of updates after some time. If these updates are version vector tombstones (also known as **VersionVectorTombstones**), you can ignore them. Such updates do not include actual changes. A Read-Only member generates version vector tombstone updates under the following conditions:

- When it detects and marks stale database GUIDs (**GcTask::GcStaleDbGuids**)
- When it signals replication partners that it is alive and waiting for updates (**GcTask::GcSendDbKeepAlive**)

For more information about these functions, see **The UID of version vector tombstones** in [Processing Updates](/openspecs/windows_protocols/ms-frs2/e1075c0b-a96d-4265-ad9d-c6db558ddffd).

These generic updates increase version sequence numbers (and therefore change the GVSN version chain vector) on the Read-Only member. However, the Read-Only member never shares these updates with its replication partners, so the updates are never tracked by using the global version vector on the other members. Therefore, a backlog count shows a visible delta between the Read-Only member and its replication partners.

To keep such updates from generating confusing data, scripts that gather backlog data should exclude Read-Only members.

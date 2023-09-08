---
title: Fails to modify or remove VM guest from protection group in DPM
description: Provides a solution for an error that occurs when you modify a protection group or remove a VM from a protection group.
ms.date: 12/02/2022
ms.reviewer: jarrettr, scdpmcsscontent, v-weizhu
---
# VM guest can't be modified or removed from a protection group in Data Protection Manager

This article provides a solution for an error that occurs when you modify a protection group or remove a VM from a protection group.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager  
_Original KB number:_ &nbsp; 4018988

## Symptoms

When you try to modify a protection group that contains Hyper-V Virtual Machine (VM) guests, or you try to remove a VM from a protection group, you receive an error message that resembles the following:

> Removing Guest_Name failed:  
> Error 157: Guest_Name cannot be added to protection because it is already a member of a protection group.

## Cause

This issue is due to duplicate entries in the DPM database. The duplicate entries may occur after a protected virtual machine is migrated from one Hyper-V cluster to a different Hyper-V cluster, and then that VM is re-protected on the new cluster.

## Resolution

To fix this issue, contact [Microsoft Support](https://support.microsoft.com/) for help removing the duplicate entries. To prevent future occurrences, enable live migration. To do this, see [Set up protection for live migration](/previous-versions/system-center/system-center-2012-R2/jj656643(v=sc.12)).

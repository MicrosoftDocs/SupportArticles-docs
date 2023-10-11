---
title: Can't delete a recovery checkpoint for a virtual machine in DPM
description: Describes an issue that blocks you from deleting a recovery checkpoint for a virtual machine in System Center 2012 Data Protection Manager. A resolution is provided.
ms.date: 12/07/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:snapshots-checkpoints-and-differencing-disks, csstroubleshoot
ms.technology: hyper-v
---
# You can't delete a recovery checkpoint for a virtual machine in Data Protection Manager

This article describes an issue that blocks you from deleting a broken recovery checkpoint for a virtual machine in System Center 2012 Data Protection Manager.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3059372

## Symptoms

After Data Protection Manager (DPM) backup fails, you can't delete broken recovery checkpoints for a virtual machine that was created by Hyper-V. When you try to do this, you discover that there's no option listed for a virtual machine in the Hyper-V Manager Console GUI.

:::image type="content" source="media/cannot-delete-recovery-checkpoint-vm/no-vm-listed.png" alt-text="Screenshot of the Checkpoints window, which shows that there's no option listed for a virtual machine in the Hyper-V Manager Console GUI.":::

The following command returns the list of snapshots for the VM and its type:

```console
Get-VMSnapshot -VMName <virtual machine name>  
```

The snapshots that Hyper-V typically creates are of the **Standard** type. However, DPM creates snapshots of the **Recovery** type. In the list that's returned, you have to delete the Recovery snapshots, as these are actually the broken checkpoints.

## Cause

How does DPM work?

Generally, DPM requests Hyper-V to create a checkpoint for the virtual machine as part of the VM backup process. After DPM completes the backup, it sends a backup complete notice, and then Hyper-V merges the checkpoint back into the primary .vhd file and deletes the .avhd file.

What causes broken checkpoints?

There's a known issue in which Windows Server leaves a virtual machine in a locked or backup state even after backup is complete. To resolve this issue, apply the hotfix that's described in [Hyper-V virtual machine backup leaves the VM in a locked state](https://support.microsoft.com/help/2964439).

However, even after you do this, the broken recovery checkpoints remain.

## Resolution

There's no way to delete the broken recovery checkpoints through the GUI. Instead, you must manually merge them. For information about how to merge the .avhd files into the .vhd file, see [Manually merge .avhd to .vhd in Hyper-V](https://social.technet.microsoft.com/wiki/contents/articles/6257.manually-merge-avhd-to-vhd-in-hyper-v.aspx).

This resource also suggests that a better solution (if you have 2008 R2 or later) is to create a snapshot of the VM. Then, select that snapshot and export it. This creates a copy of your VM in a single VHD file. You can then remove the old VM and import the new one.

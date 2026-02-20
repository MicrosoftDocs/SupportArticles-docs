---
title: Hyper-V Environments Experience Frequent Power-offs and Rapid Disk Space Consumption
description: Provides solutions to address issues in a Hyper-V environment where frequent power-offs and rapid disk space consumption are observed.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-lianna
ms.custom:
- sap:virtualization and hyper-v\virtual machine state
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Hyper-V environments experience frequent power-offs and rapid disk space consumption

This article provides solutions to address issues in a Hyper-V environment where frequent power-offs and rapid disk space consumption are observed. The problem is linked to volume D, where space can't be freed due to virtual machines (VMs) being attached to `.vhdx` files and checkpoints.

> [!NOTE]
> Before proceeding with the steps outlined in this article, ensure the following items:
>
> * Access to the Hyper-V host environment.
> * Administrative privileges to modify VM configurations.
> * A backup solution to preserve VM data.

You might encounter the following symptoms in your Hyper-V environment:

* Hyper-V instances frequently power off unexpectedly.
* Disk space on volume D fills up rapidly.
* Inability to delete some VMs.
* Checkpoints with suffix S001 are misidentified as files, causing confusion.

## Mismanagement and misunderstanding of checkpoints attached to VMs

The primary cause of these issues is the mismanagement and misunderstanding of checkpoints attached to VMs. When checkpoints aren't handled correctly, they consume significant disk space and disrupt the normal operation of the VMs.

## Back up the entire VM and delete checkpoints

To resolve the issue, follow these steps:

1. Conduct a full backup:

   Back up the entire VM, including its associated `vhdx` files and checkpoints, to prevent data corruption or loss.

2. Delete checkpoints systematically:

   1. Identify the latest checkpoint at the end of the subtree.
   2. Delete this checkpoint to allow it to merge with the previous checkpoint.
   3. Repeat this process step by step until all checkpoints are merged.

3. Perform operations while the VM is stopped:

   Ensure that the VM is turned off during the entire operation. This action minimizes the risk of data corruption and ensures a smooth merge process.

4. Evaluate disk space needs:

   If disk space on volume D remains insufficient, consider adding a larger disk to the host to accommodate the storage requirements.

> [!TIP]
> Tips for long-term management:
>
> * Regularly monitor and manage checkpoints to avoid accumulation.
> * Schedule periodic backups to safeguard VM data.
> * Allocate additional disk storage in advance to prevent rapid consumption.

---
title: Can't Power on Hyper-V VM and Merges Fail
description: Resolves issues that prevent you from powering on Hyper-V VM because of insufficient free disk space.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\virtual machine state
- pcy: Virtualization\virtual machine state
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Can't power on Hyper-V VM and merge operations fail

## Summary

This article discusses an issue in which a virtual machine (VM) that runs on Hyper-V can't power on because of insufficient free disk space. This problem is often associated with checkpoint disks and failed merge operations that cause critical I/O alerts. The following steps help you to resolve this issue effectively.

## Prerequisites

- Make sure that you have access to the Hyper-V environment.
- Back up all essential data from the VM before you try any of the solutions.
- Verify that you have sufficient permissions to perform the resolutions.

## Symptoms

You might encounter the following symptoms:

- The VM can't power on. Merge operations for checkpoint disks fail.
- Critical I/O alerts appear in the Hyper-V Manager or event logs.
- A snapshot of approximately 800GB (or other large sizes) doesn't merge.

## Cause

The root cause of the issue is insufficient free disk space on the drive that hosts the VM. This lack of space prevents the merge operation of checkpoint disks. That condition, in turn, prevents the VM from powering on. This issue is observed in environments that run Windows Server 2019.

## Solution 1: Export the VM to a temporary location

1. Export the affected VM to a Network Attached Storage (NAS) appliance or any other storage device that has sufficient free space.
2. Verify that the export process completes successfully.
3. Run the VM from the NAS appliance temporarily until permanent storage is ready.

## Solution 2: Upgrade the existing storage

1. Upgrade the current drives that host the VM. Replace them with larger-capacity drives.
2. Rebuild the storage array to accommodate the new drives.
3. Create a new Logical Unit Number (LUN) to allocate storage for the VM.

## Solution 3: Migrate the VM back to local storage

1. After the new storage is configured, restore the VM from the NAS appliance to the local storage that has expanded capacity.
2. Start the merge operation for the checkpoint disks by using the increased storage space.
3. Monitor the merge process to make sure that it finishes successfully.

These steps should help you to resolve the issue and enable the VM to power on without any more disk space-related errors.

## Determine the cause of the problem

If the issue persists, or if you encounter additional problems, review the following items:

- Check the available disk space on the drive hosting the VM and make sure it meets the requirements.
- Review Hyper-V Manager logs for any further details regarding the merge failures or I/O alerts.
- Verify the configuration of the storage array to make sure it's optimized for VM operations.

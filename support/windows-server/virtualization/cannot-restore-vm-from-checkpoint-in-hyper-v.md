---
title: Can't Restore VM From Checkpoint in Hyper-V on Windows Server 2016
description: Discusses how to fix an issue in which you can't restore a virtual machine from a checkpoint in a Hyper-V environment that runs on Windows Server 2016.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\snapshots, checkpoints, and differencing disks
- pcy: Virtualization\snapshots, checkpoints, and differencing disks
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Can't restore a VM from a checkpoint in Hyper-V on Windows Server 2016

## Summary

This article discusses an issue in which you can't restore a virtual machine (VM) from a checkpoint in a Hyper-V environment that runs on Windows Server 2016. The issue typically occurs after an operating system (OS) upgrade, and it often involves checkpoint corruption or misalignment.

## Symptoms

- Error message: "An error occurred while attempting to export the data from checkpoint."
- The VM can't be restored from the latest checkpoint.
- Multiple checkpoints are present, but none can be used to successfully restore the VM.
- Data loss is reported, requiring urgent recovery.
- The issue begins immediately after an OS upgrade, such as from Windows 10 to Windows 11.
- Hyper-V VM Management Service (VMMS) admin logs and checkpoint chain integrity are analyzed, revealing irregularities.
- Attempts to merge checkpoints fail, causing concerns about possible data loss.

## Cause

The issue occurs because of one or more of the following reasons:

- The checkpoint wasn't merged correctly before you ran the OS upgrade, or the upgrade was run without using the latest checkpoint in the VM.
- Changes were made directly to the original virtual hard disk (VHDX) file after creating a checkpoint, causing a misalignment in the checkpoint chain.
- The VM became inconsistent with the checkpoint structure and caused corruption or breakage in the chain.
- A corrupted or missing VM configuration file further contributed to the inability to restore the VM from the checkpoint.

## Resolution

To resolve the issue, follow these steps:

1. Back up VM files:

    - Before you try any recovery steps, back up all checkpoints and VHD files to a secure location. This step minimizes the risk of permanent data loss.
1. Inspect the checkpoint chain:

    - Run the following PowerShell script to verify the chain of differencing disks:

    ```powershell
    Get-VHDChain -Path <path to vhd file></path>
    ```

    - Analyze the output to identify any inconsistencies or corruption in the chain.

1. Manually merge checkpoints:

    - Try to manually merge the checkpoints by using PowerShell commands. For example:

        ```powershell
        Merge-VHD -Path <Path to AVHDX file> -DestinationPath <Path to merged VHDX file>
        ```
    - Notify the customer of potential risks, including data loss, before you proceed to merge.
1. Re-create the VM:

    - If merging checkpoints fails, re-create the VM by using the backed-up files. Make sure that you configure the new VM to point to the merged VHDX file.

1. Follow proper checkpoint management practices:
        - Always merge checkpoints before you perform OS upgrades.
        - Avoid direct changes to the original VHDX file if checkpoints exist.
        - Regularly maintain and verify checkpoints to make sure of integrity.
1. Confirm resolution:

    - After the recovery steps are completed, verify with the customer that the VM is operational and data was restored.

By following these steps and recommendations, you can resolve the checkpoint restoration issue and prevent similar problems in the future.

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- Hyper-V VMMS admin logs. These logs can be collected from the Event Viewer under Applications and Services Logs > Microsoft > Windows > Hyper-V-VMMS.
- Results from running the Get-VHDChain PowerShell command to inspect the integrity of the VHD chain.
- Any additional error messages or logs that provide insight into the checkpoint issue.

## References

- [Using checkpoints to revert virtual machines to a previous state](/windows-server/virtualization/hyper-v/checkpoints?tabs=hyper-v-manager)
- [Windows Server 2012 Hyper-V Best Practices](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/windows-server-2012-hyper-v-best-practices-in-easy-checklist-form/256060)

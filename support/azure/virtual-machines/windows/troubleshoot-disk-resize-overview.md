---
title: Start here for troubleshooting Azure VM disk resize issues
description: Learn how to find the right troubleshooting article for Azure VM disk resize issues, including portal errors, live resize failures, and volume extension problems.
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, donajilugo, v-leedennis
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Windows (Guest OS)
ms.topic: troubleshooting
---

# Start here for troubleshooting Azure VM disk resize issues

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you find the right troubleshooting resource for disk resize issues on Azure virtual machines (VMs). Use the following table to identify your scenario and go to the relevant article.

## Identify your scenario

Disk resize on Azure involves two steps: resizing the disk in the Azure portal (platform side), and then extending the volume inside the VM (guest OS side). The troubleshooting path depends on which step fails.

### Platform-side errors (resizing the disk in Azure)

| Symptom | Error code | Article |
|---|---|---|
| Azure portal, CLI, or PowerShell returns an error when you try to resize | `ChangeDiskSizeWhileAttachedNotAllowed`, `LiveDiskPropertyChangeOfVMOfSizeNotSupported`, or `LiveResizeSharedDiskNotAllowed` | [Troubleshoot Azure VM disk resize errors](troubleshoot-disk-resize-errors.md) |
| Resize request is accepted but the operation fails with an internal error | `LiveResizeStorageClientFailure` | [Troubleshoot live resize failure](troubleshoot-live-resize-failure.md) |
| You want to make a disk smaller (downsize) | N/A — downsizing isn't supported directly | [Downsize a data disk without losing data](downsize-data-disk-without-losing-data.md) |

### Guest OS errors (extending the volume inside the VM)

| Symptom | Operating system | Article |
|---|---|---|
| "Extend Volume" is greyed out in Disk Management, or the volume won't extend to full size | Windows | [Can't extend a volume on an Azure Windows VM](cannot-extend-volume-windows-vm.md) |
| Can't extend an encrypted Azure Disk Encryption (ADE)/BitLocker OS volume due to System Reserved partition | Windows | [Can't extend an encrypted OS volume in Windows](cannot-extend-encrypted-os-volume.md) |
| Can't extend a volume on a SQL Server VM from Azure Marketplace | Windows | [Can't extend volume on a SQL standalone server virtual machine](cannot-extend-volume-sql-server.md) |
| MBR partition limits data disk resize to 2 TB | Linux | [Failed to resize MBR partition for a data disk larger than 2 TB](../linux/convert-mbr-partition-to-gpt.md) |
| Need to extend a partition after platform-side resize | Linux | [Expand virtual hard disks on a Linux VM](/azure/virtual-machines/linux/expand-disks) |
| Need to extend a partition after platform-side resize | Windows | [Expand virtual hard disks on a Windows VM](/azure/virtual-machines/windows/expand-os-disk) |

## References

- [Azure managed disk types](/azure/virtual-machines/disks-types)
- [Expand managed disks without downtime](/azure/virtual-machines/windows/expand-os-disk#expand-without-downtime)

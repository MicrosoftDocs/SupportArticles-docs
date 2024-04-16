---
title: Ghost NIC built from VMware Templates
description: Provides a solution to an issue where you have a VMware Virtual Machine that is running Windows Server 2008 R2 or Windows 7, and is configured with a Synthetic NIC (VMXNET3).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika,  johnfern
ms.custom: sap:Virtualization and Hyper-V\Configuration of virtual machine settings, csstroubleshoot
---
# Ghost NIC seen on Windows 7/Windows 2008 R2 machines built from VMware Templates when the Template uses a Synthetic NIC (VMXNET3)

This article provides a solution to an issue where you have a VMware Virtual Machine that is running Windows Server 2008 R2 or Windows 7, and is configured with a Synthetic NIC (VMXNET3).

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2526142

## Symptoms

Consider the following situations:

1. You have a VMware Virtual Machine that is running Windows Server 2008 R2 or Windows 7, and is configured with a Synthetic NIC (VMXNET3).
2. The NIC is seen as "Local Area Connection", "vmxnet3 Ethernet Adapter".
3. A VM Template is created using the Windows Server 2008 R2 or Windows 7 Virtual Machine.
4. For each VM deployed using this Template, a new MAC address is assigned by the clone/deploy operation.
5. Upon boot-up, Windows recognizes the NIC as a new device and the adapter is seen as "Local Area Connection 2", "vmxnet3 Ethernet Adapter #2".
6. The original NIC "Local Area Connection", "vmxnet3 Ethernet Adapter" remains on the machine as a Hidden / Ghost Network Adapter.

> [!NOTE]
> This issue isn't seen if the Template has been configured with a Emulated NIC (Intel Pro/1000 MT Network Connection)

## Cause

The issue is seen because Windows recognizes the network adapter or the motherboard as a new device. Which causes the network adapter or motherboard device to generate a different serial number than the previous network adapter or motherboard device.

## Resolution

Install the hotfix referenced in ["0x0000007B" Stop error when you replace an iSCSI or PCI Express network adapter or a motherboard with an identical device on a Windows Server 2008 R2-based or Windows 7-based computer](https://support.microsoft.com/help/2344941), which addresses a similar issue with iSCSI NICs.

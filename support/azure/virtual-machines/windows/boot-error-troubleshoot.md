---
title: Troubleshoot boot errors in Azure virtual machines
description: This article helps link you to articles on how to troubleshoot boot errors in Azure virtual machines.
ms.service: azure-virtual-machines
ms.collection: windows
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 08/07/2024
ms.topic: overview
ms.custom: sap:My VM is not booting
---
# Troubleshoot Azure virtual machine boot errors

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you troubleshoot common boot errors that you may encounter when you start an Azure Windows virtual machine (VM).

## Troubleshooting steps for VM boot errors

> [!Note]
> We recommend that you follow these troubleshooting sections in order. First, identify the problem, and then review the provided remediation information. If you still can't solve the problem after following the guidance in this article, proceed to open a support ticket.

If you can't connect to your Windows VM and are unsure of the cause, perform the following troubleshooting steps:

1. Verify that your VM is started.
2. If your VM can't start and you recently applied Windows updates, see [Troubleshoot VM not booting after Windows update](troubleshoot-stuck-updating-boot-error.md).
3. Understand [how to use boot diagnostics to troubleshoot virtual machines in Azure](boot-diagnostics.md).

If your VM isn't on the <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> security screen, it may be experiencing a boot error. To troubleshoot this issue, follow these steps:

1. Try restarting the VM.
2. Review the following recommended articles for troubleshooting guidance. There are other articles in the table of contents on the left side of this article that may also be helpful.

## Troubleshooting information for specific boot errors

For other boot errors you may encounter, see the "Specific boot errors – Windows" section in the table of contents on the left side of this page. The most common issues are:

- [Updating boot errors](troubleshoot-stuck-updating-boot-error.md)
- [Check disk boot errors](troubleshoot-check-disk-boot-error.md)
- [BitLocker boot errors](troubleshoot-bitlocker-boot-error.md)
- [Boot configuration update](troubleshoot-vm-boot-configure-update.md)
- [Common blue screen errors](troubleshoot-common-blue-screen-error.md)
- [Critical service failed boot errors](troubleshoot-critical-service-failed-boot-error.md)
- [Reboot loop](troubleshoot-reboot-loop.md)

## Other resources

- [Common VM repair procedures](troubleshoot-vm-by-use-nested-virtualization.md) (This article and others in the "Procedures to repair a Windows VM" section can help you perform tasks such as repairing disks and collecting troubleshooting information.)
- [Troubleshoot specific Remote Desktop connection errors](troubleshoot-specific-rdp-errors.md)
- [Detailed troubleshooting across network components](detailed-troubleshoot-rdp.md)
- [Address Remote Desktop License Server error](troubleshoot-specific-rdp-errors.md#rdplicense)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

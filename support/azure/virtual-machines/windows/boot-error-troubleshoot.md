---
title: Troubleshoot boot errors in Azure virtual machines
description: This article helps link you to articles to troubleshoot boot errors in Azure virtual machines.
ms.service: virtual-machines
ms.collection: windows
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 08/02/2024
ms.topic: overview
ms.custom: sap:My VM is not booting
---
# Troubleshoot Azure virtual machines boot errors

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you troubleshoot the common boot errors that you may encounter when you start an Azure Windows virtual machine (VM).

## Troubleshooting steps for VM boot errors

> [!Note]
> We recommend that you follow these troubleshooting sections in order. First, identify the problem, and then review the provided remediation information. If you still can't solve your problem after following the guidance in this article, proceed to open a support ticket.

If you can't connect to your Windows virtual machine (VM) and are unsure of the cause, perform the following troubleshooting steps:

- Verify that your VM has been started.
- If your VM fails to start and you recently applied Windows Updates, see [Troubleshooting VM not booting after Windows Update](troubleshoot-stuck-updating-boot-error.md).
- Understand [how to use boot diagnostics to troubleshoot virtual machines](boot-diagnostics.md) in Azure.

If your VM is not at the <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> security screen, it may be experiencing a boot error. To troubleshoot this issue, follow these steps:

1. Try restarting the virtual machine.
2. Review the articles suggested below for troubleshooting guidance. There are additional articles in the Table of Contents on the left of this article that may also be helpful.

## Troubleshooting information for specific boot errors

See the "Specific boot errors – Windows" section in the Table of Contents on the left side of this page for additional boot errors you may encounter. Among the most common issues are:

- [Updating boot error](troubleshoot-stuck-updating-boot-error.md)
- [Check disk boot error](troubleshoot-check-disk-boot-error.md)
- [BitLocker boot error](troubleshoot-bitlocker-boot-error.md)
- [Boot configuration update](troubleshoot-vm-boot-configure-update.md)
- [Common blue screen error](troubleshoot-common-blue-screen-error.md)
- [Critical service failed boot error](troubleshoot-critical-service-failed-boot-error.md)
- [Reboot loop](troubleshoot-reboot-loop.md)

## Other resources

- [Common VM repair procedures](troubleshoot-vm-by-use-nested-virtualization.md) (This article and others in the "Procedures to repair a Windows VM" section can help you perform tasks such as repairing disks and collecting troubleshooting information).
- [Troubleshoot specific Remote Desktop connection errors](troubleshoot-specific-rdp-errors.md)
- [Detailed troubleshooting across network components](detailed-troubleshoot-rdp.md)
- [Address Remote Desktop License Server error](troubleshoot-specific-rdp-errors.md#rdplicense)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

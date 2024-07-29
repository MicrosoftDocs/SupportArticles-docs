---
title: 'Troubleshoot boot errors in Azure Virtual Machines'
description: This article helps link you to articles to troubleshoot boot errors in Azure Virtual Machines.
ms.service: virtual-machines
ms.collection: windows
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 07/30/2024
ms.topic: landing-page
page_type: landing
ms.custom: sap:My VM is not booting
---

# Troubleshoot Azure Virtual Machines boot errors

**Applies to:** :heavy_check_mark: Windows VMs

## Troubleshooting steps and information

> [!Note]
> We recommend that you follow these troubleshooting sections in order. First, identify the problem, and then review the provided remediation information. If you still can't solve your problem after following the guidance in this article, then you should proceed to open a support ticket.

If you can't connect to your Windows virtual machine (VM) and are unsure of the cause, perform the following troubleshooting steps:

- Verify that your VM has been started.
- If your VM fails to start and you recently applied Windows Updates, see [Troubleshooting VM not booting after Windows Update](/azure/virtual-machines/troubleshooting/troubleshoot-stuck-updating-boot-error).
- Understand [how to use boot diagnostics to troubleshoot virtual machines](/azure/virtual-machines/troubleshooting/boot-diagnostics) in Azure.

If your VM is not at the ctrl-alt-del screen, it may be experiencing a boot error. To resolve boot issues, follow these steps:

1.	Try restarting the VM.
2.	Review the [common boot errors and solutions for non-bootable VMs](/azure/virtual-machines/troubleshooting/boot-error-troubleshoot) troubleshooting guide.

## Troubleshooting information for specific boot errors

See the section "Specific boot errors – Windows" in the Table of Contents on the left side of this page for additional boot errors you may encounter. Among the most common issues are:

- [Updating boot error](/azure/virtual-machines/troubleshooting/troubleshoot-stuck-updating-boot-error)
- [Check disk boot error](/azure/virtual-machines/troubleshooting/troubleshoot-check-disk-boot-error)
- [BitLocker boot error](/azure/virtual-machines/windows/troubleshoot-bitlocker-boot-error)
- [Boot configuration update](/azure/virtual-machines/troubleshooting/troubleshoot-vm-boot-configure-update)
- [Common blue screen error](/azure/virtual-machines/troubleshooting/troubleshoot-common-blue-screen-error)
- [Critical service failed boot error](/azure/virtual-machines/troubleshooting/troubleshoot-critical-service-failed-boot-error)
- [Reboot loop](/azure/virtual-machines/troubleshooting/troubleshoot-reboot-loop)

## Other resources

- [Common VM repair procedures](troubleshoot-vm-by-use-nested-virtualization.md) (This article and others in the same section can help you perform tasks such as repairing disks and collecting troubleshooting information).
- [Troubleshoot specific Remote Desktop connection errors](/azure/virtual-machines/troubleshooting/troubleshoot-specific-rdp-errors)
- [Detailed troubleshooting across network components](/azure/virtual-machines/troubleshooting/detailed-troubleshoot-rdp)
- [Address Remote Desktop License Server error](/azure/virtual-machines/troubleshooting/troubleshoot-specific-rdp-errors#rdplicense)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

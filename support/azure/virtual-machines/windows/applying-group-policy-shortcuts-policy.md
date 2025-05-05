---
title: Windows VM Startup is Stuck on "Applying Group Policy Shortcuts policy" in Azure
description: Provides troubleshooting steps for an Azure virtual machine (VM) that is stuck in startup with the message "Applying Group Policy Shortcuts policy."
ms.date: 05/05/2025
author: cwhitley-MSFT 
ms.author: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# VM startup is stuck on "Applying Group Policy Shortcuts policy"

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses an issue that causes a Microsoft Azure virtual machine (VM) to get stuck during startup on the **Applying Group Policy Shortcuts policy** screen.

## Symptoms

A Windows VM doesn't start. When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you see that the Windows operating system displays the message, **Applying Group Policy Shortcuts policy**.

:::image type="content" source="media/applying-group-policy-shortcuts-policy/applying-group-policy-shortcuts-policy-screen.png" alt-text="Screenshot of Windows operating system displaying the message 'Applying Group Policy Shortcuts policy'.":::

## Cause

Further investigation is required to determine the specific cause of this issue.

## Collect memory dump for troubleshooting

For this scenario, Azure Support requires a memory dump in order to be able to troubleshoot and diagnose the issue.

Follow the steps in [this article](./collect-os-memory-dump-file.md) to collect a memory dump. Then, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
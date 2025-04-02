---
title: Windows VM startup is stuck on "Applying Group Policy Environment policy" in Microsoft Azure
description: Troubleshooting steps for an Azure virtual machine (VM) that is stuck booting with message "Applying Group Policy Environment policy".
ms.date: 03/03/2025
author: cwhitley-MSFT 
ms.author: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# VM startup is stuck on "Applying Group Policy Environment policy"

**Applies to:** :heavy_check_mark: Windows VMs

This article describes an issue that Azure Windows virtual machine (VM) startup is stuck on the **Applying Group Policy Environment policy** screen.

## Symptom

A Windows VM doesn't start. When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you see that the Windows operating system displays the message **Applying Group Policy Environment policy**.

:::image type="content" source="media/applying-group-policy-environment-policy/ApplyingGroupPolicyEnvironmentPolicy.png" alt-text="Screenshot of Windows operating system displaying the message 'Applying Group Policy Environment Policy'.":::

## Cause

Further investigation is required to determine the specific cause.

## Collect memory dump for troubleshooting

For this scenario, a memory dump is required to troubleshoot the issue further and diagnose the problem.

Follow the steps in [this article](./collect-os-memory-dump-file.md) to collect a memory dump. Then proceed with [creating a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

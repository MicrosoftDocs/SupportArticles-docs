---
title: Azure VM login stops responding at "Applying Group Policy Environment".
description: Troubleshooting steps for an Azure virtual machine (VM) that is stuck booting with message "Applying Group Policy Environment Policy".
ms.date: 03/03/2025
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Azure VM login hangs at "Applying Group Policy Environment"

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to troubleshoot issues where a Windows VM is stuck booting with message "Applying Group Policy Environment Policy" displayed in Boot Diagnostics.

## Symptom

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you see that the OS hasn't completed the boot process and is displaying the message **Applying Group Policy Environment policy**.

:::image type="content" source="media/applying-group-policy-environment-policy/ApplyingGroupPolicyEnvironmentPolicy.png" alt-text="Screenshot of Windows operating system displaying the message 'Applying Group Policy Environment Policy'.":::

## Cause

Further investigation is required to determine the specific cause.

## Solution

For this scenario, a memory dump is required to troubleshoot the issue further and diagnose the problem.

Follow [this article](./collect-os-memory-dump-file.md) to collect a memory dump. Then proceed with [creating a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
---
title: Windows VM Startup is Stuck on "Please wait for the Group Policy Client" in Azure
description: Provides troubleshooting steps for an Azure virtual machine (VM) that is stuck in startup with the message "Please wait for the Group Policy Client"
ms.date: 05/14/2025
author: cwhitley-MSFT 
ms.author: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# VM startup is stuck on "Please wait for the  Group Policy Client"

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses an issue that causes a Microsoft Azure virtual machine (VM) to get stuck during startup on the **Please wait for the  Group Policy Client** screen.

## Symptoms

A Windows VM doesn't start. When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you see that the Windows operating system displays the message, **Please wait for the  Group Policy Client**.

:::image type="content" source="media/please-wait-for-the-group-policy-client/please-wait-for-the-group-policy-client.png" alt-text="Screenshot of Windows operating system displaying the message 'Please wait for the  Group Policy Client'.":::

## Cause

When a Windows virtual machine (VM) starts up, it may take time to apply system settings known as Group Policies. If there are many policies or they are particularly complex, this process can take longer than usual.

We recommend allowing up to one hour for the VM to finish applying these settings. If the VM remains stuck on the same screen after that time, additional troubleshooting may be needed to identify the specific cause.

## Collect memory dump for troubleshooting

For this scenario, Azure Support requires a memory dump in order to be able to troubleshoot and diagnose the issue.

Follow the steps in [this article](./collect-os-memory-dump-file.md) to collect a memory dump. Then, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

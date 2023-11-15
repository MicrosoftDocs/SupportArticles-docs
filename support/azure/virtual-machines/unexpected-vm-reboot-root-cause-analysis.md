---
title: Root Cause Analysis for unexpected Azure virtual machine reboots
description: Describes how to determine root causes for unexpected Azure virtual machine reboots.
services: virtual-machines
ms.service: virtual-machines
ms.subservice: vm-troubleshooting-tools
ms.workload: infrastructure-services
ms.date: 11/15/2023
ms.reviewer: tagangwa, v-weizhu
---

# How to check Root Cause Analysis for unexpected Azure virtual machine reboots

Azure provides methods to access detailed Root Cause Analysis (RCA) of unexpected reboots of Azure virtual machines (VMs) through the Azure portal. This article walks you through the steps to check RCA information in the Azure portal, ensuring that you can quickly identify and resolve the unexpected VM reboot issue.

## Method 1: Check resource health

1.	Navigate to the impacted VM in the Azure portal.
2.	Go to the **Help** section and then select **Resource health**.
3. Check the health events for the unexpected VM reboot to get RCA information.

:::image type="content" source="media/unexpected-vm-reboot-root-cause-analysis/resource-health-check.png" alt-text="Screenshot that shows the Azure portal 'Resource health' dashboard.":::

## Method 2: Run diagnostics

1.	Navigate to the impacted VM in the Azure portal.
2.	Select **Diagnose and solve problems** > **Common problems** > **VM restarted or stopped unexpectedly**.

   :::image type="content" source="media/unexpected-vm-reboot-root-cause-analysis/diagnose-and-solve-problems.png" alt-text="Screenshot that shows 'Diagnose and solve problems' for Azure VM.":::

3.	On the **VM restarted or stopped unexpectedly** page, select **My resource has been stopped unexpectedly** from the **Tell us more about the problem you are experiencing** drop-down menu.

   :::image type="content" source="media/unexpected-vm-reboot-root-cause-analysis/vm-restarted-or-stopped-unexpectedly.png" alt-text="Screenshot that shows how to select your problem type.":::


4. Once you select **My resource has been stopped unexpectedly**, the diagnostic runs on the impacted VM. After the diagnostic is completed, you can check the reboot RCA information from the diagnostic result.

    :::image type="content" source="media/unexpected-vm-reboot-root-cause-analysis/my-resource-has-been-stopped-unexpectedly.png" alt-text="Screenshot that shows diagnostics results."::: 

   > [!Note]
   > If there is more information about the root cause of a VM unavailability, the **Resource Health** tab may post additional details up to 72 hours after the VM was impacted. This type of RCA is only available for Azure VMs.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

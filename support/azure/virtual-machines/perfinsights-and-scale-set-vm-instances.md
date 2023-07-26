---
title: PerfInsights and scale set VM instances
description: Download, install, and run PerfInsights to troubleshoot problematic Windows or Linux virtual machine (VM) instances within a virtual machine scale set.
ms.date: 11/17/2021
ms.reviewer: v-leedennis
ms.service: virtual-machines
ms.subservice: vm-performance
---
# PerfInsights and scale set VM instances

 If you have a Microsoft Azure virtual machine scale set, you can troubleshoot performance issues on scale set virtual machine (VM) instances using PerfInsights. PerfInsights is a tool for downloading and installing onto problematic Windows or Linux VM instances. Then you can run PerfInsights to collect performance diagnostic data from those VM instances.

> [!NOTE]
> PerfInsights can instead be installed on a virtual machine scale set using the [Azure Performance Diagnostics VM extension](performance-diagnostics-vm-extension.md). Because the current user experience of the Performance Diagnostics VM extension isn't designed for virtual machine scale sets, Microsoft doesn't currently recommend using that extension with scale set VM instances.

## Setup

To get performance diagnostic data from your scale set, follow a two-part process:

1. Determine which scale set VM instances are suffering from performance issues. Monitor the VM instances in your scale set using [Azure Monitor VM Insights](/azure/azure-monitor/vm/vminsights-overview). Or monitor the applications in your VM instances using the [Azure Monitor Application Insights Agent](/azure/azure-monitor/app/azure-vm-vmss-apps). With this monitoring, you can identify the VM instances that have lesser performance.

2. Install PerfInsights onto just the problematic VM instances that are identified. PerfInsights offers deeper analysis than VM Insights and the Application Insights Agent by identifying the possible causes of the performance problems on a VM instance. See the instructions for installing [PerfInsights on a Windows VM](how-to-use-perfInsights.md#run-the-perfinsights-tool-on-your-vm) or [PerfInsights on a Linux VM](how-to-use-perfinsights-linux.md#run-the-perfinsights-linux-on-your-vm).

> [!NOTE]
> If you install the Performance Diagnostics VM extension from the Azure portal instead, the PerfInsights tool is run on every VM instance in the scale set. You can then find the PerfInsights logs in the associated storage account.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

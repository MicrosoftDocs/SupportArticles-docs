---
title: Troubleshoot performance issues on Virtual Machine Scale Set instances using Performance Diagnostics (PerfInsights)
description: Use Performance Diagnostics (PerfInsights) to troubleshoot performance issues on Linux or Windows Virtual Machine Scale Set instances.
ms.date: 05/23/2024
ms.reviewer: v-leedennis
ms.service: virtual-machines
ms.custom: sap:VM Performance, linux-related-content
---
# Troubleshoot performance issues on Virtual Machine Scale Set instances using Performance Diagnostics (PerfInsights)

[Azure Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/overview) are groups of load-balanced VMs. This article explains how to use [Performance Diagnostics (PerfInsights)](performance-diagnostics.md) to troubleshoot performance issues on Virtual Machine Scale Set instances.

## Monitor continuous performance and troubleshoot identified issues

To identify and troubleshoot performance issues in your Azure Virtual Machine Scale Set:

1. Monitor the continuous performance of Virtual Machine Scale Set instances using [VM Insights](/azure/azure-monitor/vm/vminsights-overview) or [Application Insights for Azure VMs and virtual machine scale sets](/azure/azure-monitor/app/azure-vm-vmss-apps). 

1. Run Performance Diagnostics (PerfInsights) on problematic VM instances to troubleshoot performance issues:

    - In [Flexible orchestration mode](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-flexible-orchestration), from the [Performance Diagnostics](performance-diagnostics.md)tool in the portal, which automatically installs and runs the PerfInsights extension on the instance. 
    - In [Uniform orchestration mode](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes#scale-sets-with-uniform-orchestration), by downloading, installing, and running the PerfInsights extension on your [Windows VM](how-to-use-perfInsights.md#run-performance-diagnostics-on-your-vm-using-the-cli-tool) or [Linux VM](../linux/how-to-use-perfinsights-linux.md#run-the-perfinsights-linux-on-your-vm) instance.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

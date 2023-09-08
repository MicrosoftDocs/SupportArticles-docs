---
title: Gather log files for offline analysis and preservation
description: Learn how to gather log files for the offline analysis and preservation of diagnostic data from an Azure platform as a service (PaaS) Windows virtual machine.
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, piw, prpillai, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure virtual machine user, I want to know how to gather log files for the offline analysis and preservation of diagnostic data from a platform as a service (PaaS) Windows virtual machine (VM) so that I can use this data to help troubleshoot various problems.
---

# Gather log files for offline analysis and preservation

This article discusses how to gather log files from a Microsoft Azure platform as a service (PaaS) Windows virtual machine (VM) for offline analysis and preservation.

If you aren't concerned about gathering all the log files into one central location, you can usually analyze the files while you're using Remote Desktop Protocol (RDP) to access the VM and do a live troubleshooting session. However, there are several scenarios in which you might want to easily gather all the log files and save them outside the VM for analysis by someone else. Or, you might want to preserve the files for analysis at a later time so that you can redeploy your hosted service and restore your application's functionality.

The following sections describe the options for quickly gathering diagnostic logs from a PaaS VM.

## Option 1: Use RDP to run CollectGuestLogs.exe on the VM

The easiest option for gathering logs is to use Remote Desktop Protocol (RDP) to access the VM, and then run the *CollectGuestLogs.exe* executable. This executable ships together with the Azure Guest Agent. The agent is present on all PaaS VMs and most infrastructure as a service (IaaS) VMs. *CollectGuestLogs.exe* creates a .zip file of the logs from the VM. The location of this .zip file is outlined in the following table.

| Virtual machine type | File location                                      |
|----------------------|----------------------------------------------------|
| PaaS VM              | *D:\\Packages\\GuestAgent\\CollectGuestLogs.exe*   |
| IaaS VM              | *C:\\WindowsAzure\\Packages\\CollectGuestLogs.exe* |

By default, the CollectGuestLogs executable collects [Internet Information Services (IIS) logs](windows-azure-paas-compute-diagnostic-data.md#internet-information-services-logs). These logs can be large for long-running web roles. To prevent IIS log collection, run `CollectGuestLogs.exe -Mode:ga`. For more information, run `CollectGuestLogs.exe -?`.

## Option 2: Run the Azure Log Collector Extension

You can run the Azure Log Collector Extension from your local development computer. This option is useful for collecting the logs without having to use RDP to access the VM. It's also convenient if you want to collect logs from many VMs simultaneously. For more information, see the following Azure Developer Blog article:

[Simplifying virtual machine troubleshooting using Azure Log Collector](https://azure.microsoft.com/blog/simplifying-virtual-machine-troubleshooting-using-azure-log-collector/).

## More information

- [Windows Azure PaaS compute diagnostic data](windows-azure-paas-compute-diagnostic-data.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

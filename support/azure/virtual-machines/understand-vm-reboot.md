---
title: Understand a system reboot for an Azure VM
description: Lists the events that can cause a VM to reboot.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: ''
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.topic: troubleshooting
ms.tgt_pltfrm: na
ms.workload: infrastructure-services
ms.date: 02/18/2024
ms.author: genli
ms.reviewer: yutorigo, v-weizhu
---

# Understand a system reboot for Azure VM

Azure virtual machines (VMs) might sometimes reboot for no apparent reason, without evidence of your having initiated the reboot operation. This article lists the actions and events that can cause VMs to reboot and provides insight into how to avoid unexpected reboot issues or reduce the impact of such issues.

## Configure the VMs for high availability

The best way to protect an application that's running on Azure against VM reboots and downtime is to configure the VMs for high availability.

To provide this level of redundancy to your application, we recommend that you group two or more VMs in an availability set. This configuration ensures that during either a planned or unplanned maintenance event, at least one VM is available and meets the 99.95 percent [Azure SLA](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/).

For more information about availability sets, see [Manage the availability of VMs](/azure/virtual-machines/manage-availability)

## Resource Health information

Azure Resource Health is a service that exposes the health of individual Azure resources and provides actionable guidance for troubleshooting problems. In a cloud environment where it isn’t possible to directly access servers or infrastructure elements, the goal of Resource Health is to reduce the time that you spend on troubleshooting. In particular, the aim is to reduce the time that you spend determining whether the root of the problem lies in the application or in an event inside the Azure platform. For more information, see [Understand and use Resource Health](/azure/service-health/resource-health-overview).

If Azure has further information about the root cause of a platform-initiated unavailability for a Virtual Machine, that information may be posted in resource health up to 72 hours after the initial unavailability.

## Missing VM downtimes in activity log

[Resource Health alerts](/azure/service-health/resource-health-alert-monitor-guide) are sent based on the [activity Log](/azure/azure-monitor/essentials/activity-log) information. In some cases, VM downtimes may not show in the activity log. If the downtime doesn't show in the activity log, Resource Health alerts won't be sent for the downtime. The downtime is still visible in Resource Health.

Here are the cases where VM downtimes don't show in the activity log:

- When a VM is created or migrated to a new host, Azure platform doesn't display VM state correctly and the state changes to Unknown. Only after all network connectivity and node processes are established, the VM state changes to Available. The prolonged period of the Unknown state is filtered out of the activity log.
- When the VM availability state changes from Available to Unavailable and then goes back to Available within 35 seconds, the downtime doesn't show in the activity log. This case won't occur if a correlated downtime is sent within 15 minutes before the occurrence of the first transition.
- If the VM health changes from a state to Unknown and then goes back to the original state, the intermittent Unknown state and related transitions are filtered out of the activity log.

The VM downtimes that don't show in the activity log are filtered on the Azure platform side to prevent transient errors from showing incorrect downtimes to customers. With ongoing investments in VM health quality, the filters may no longer be necessary and may cause quick changes in VM health to remain unreported. Microsoft is working on a phase-out plan to deliver the best customer experience.

## Actions and events that can cause the VM to reboot

### Planned maintenance

Microsoft Azure periodically performs updates across the globe to improve the reliability, performance, and security of the host infrastructure that underlies VMs. Many of these updates, including memory-preserving updates, are performed without any impact on your VMs or cloud services.

However, some updates do require a reboot. In such cases, the VMs are shut down while we patch the infrastructure, and then the VMs are restarted.

To understand what Azure planned maintenance is and how it can affect the availability of your Linux VMs, see the articles listed here. The articles provide background about the Azure planned maintenance process and how to schedule planned maintenance to further reduce the impact.

- [Planned maintenance for VMs in Azure](/azure/virtual-machines/maintenance-and-updates?bc=/azure/virtual-machines/windows/breadcrumb/toc.json&toc=/azure/virtual-machines/windows/toc.json)
- [How to schedule planned maintenance on Azure VMs](/azure/virtual-machines/maintenance-and-updates?bc=/azure/virtual-machines/windows/breadcrumb/toc.json&toc=/azure/virtual-machines/windows/toc.json)

### Memory-preserving updates

For this class of updates in Microsoft Azure, users experience no impact on their running VMs. Many of these updates are to components or services that can be updated without interfering with the running instance. Some are platform infrastructure updates on the host operating system that can be applied without a reboot of the VMs.

These memory-preserving updates are accomplished with technology that enables in-place live migration. When it is being updated, the VM is placed in a *paused* state. This state preserves the memory in RAM while the underlying host operating system receives the necessary updates and patches. The VM is resumed typically within 30 seconds of being paused. After the VM is resumed, its clock is automatically synchronized.

Because of the short pause period, deploying updates through this mechanism greatly reduces the impact on the VMs. However, not all updates can be deployed in this way.

Multi-instance updates (for VMs in an availability set) are applied one update domain at a time.

> [!NOTE]
> Linux machines that have old kernel versions are affected by a kernel panic during this update method. To avoid this issue, update to kernel version 3.10.0-327.10.1 or later. For more information, see [An Azure Linux VM on a 3.10-based kernel panics after a host node upgrade](https://support.microsoft.com/help/3212236).

### User-initiated reboot or shutdown actions

If you perform a reboot from the Azure portal, Azure PowerShell, command-line interface, or REST API, you can find the event in the [Azure Activity Log](/azure/azure-monitor/platform/platform-logs-overview).

If you perform the action from the VM's operating system, you can find the event in the system logs.

Other scenarios that usually cause the VM to reboot include multiple configuration-change actions. You'll ordinarily see a warning message indicating that executing a particular action will result in a reboot of the VM. Examples include any VM resize operations, changing the password of the administrative account, and setting a static IP address.

### Microsoft Defender for Cloud and Windows Update

Microsoft Defender for Cloud monitors daily Windows and Linux VMs for missing operating-system updates. Defender for Cloud retrieves a list of available security and critical updates from Windows Update or Windows Server Update Services (WSUS), depending on which service is configured on a Windows VM. Defender for Cloud also checks for the latest updates for Linux systems. If your VM is missing a system update, Defender for Cloud recommends that you apply system updates. The application of these system updates is controlled through the Defender for Cloud in the Azure portal. After you apply some updates, VM reboots might be required. For more information, see [Apply system updates in Microsoft Defender for Cloud](/azure/security-center/asset-inventory).

Like on-premises servers, Azure does not push updates from Windows Update to Windows VMs, because these machines are intended to be managed by their users. You are, however, encouraged to leave the automatic Windows Update setting enabled. Automatic installation of updates from Windows Update can also cause reboots to occur after the updates are applied. For more information, see [Windows Update FAQ](https://support.microsoft.com/help/12373/windows-update-faq).

### Other situations affecting the availability of your VM

There are other cases in which Azure might actively suspend the use of a VM. You'll receive email notifications before this action is taken, so you'll have a chance to resolve the underlying issues. Examples of issues that affect VM availability include security violations and the expiration of payment methods.

### Host server faults

The VM is hosted on a physical server that is running inside an Azure datacenter. The physical server runs an agent called the Host Agent in addition to a few other Azure components. When these Azure software components on the physical server become unresponsive, the monitoring system triggers a reboot of the host server to attempt recovery. In many cases, the VM will be available again within 10-15 minutes and continues to live on the same host as before.

Server faults are usually caused by hardware failure, such as the failure of a hard disk or solid-state drive. Azure continuously monitors these occurrences, identifies the underlying bugs, and rolls out updates after the mitigation has been implemented and tested.

Because some host server faults can be specific to that server, a repeated VM reboot situation might be improved by manually redeploying the VM to another host server. This operation can be triggered by using the **redeploy** option on the details page of the VM, or by stopping and restarting the VM in the Azure portal.

### Auto-recovery

If the host server cannot reboot for any reason, the Azure platform initiates an auto-recovery action to take the faulty host server out of rotation for further investigation.

All VMs on that host are automatically relocated to a different, healthy host server. Although this process typically completes within 15 minutes, the time needed for recovery may vary depending on several factors, including the size of the host memory and the recovery methods employed. To learn more about the auto-recovery process, see [Auto-recovery of VMs](https://azure.microsoft.com/blog/service-healing-auto-recovery-of-virtual-machines).

### Unplanned maintenance

On rare occasions, the Azure operations team might need to perform maintenance activities to ensure the overall health of the Azure platform. This behavior might affect VM availability, and it usually results in the same auto-recovery action as described earlier.  

Unplanned maintenance include the following:

- Urgent node defragmentation
- Urgent network switch updates

### VM crashes

VMs might restart because of issues within the VM itself. The workload or role that's running on the VM might trigger a bug check within the guest operating system. For help determining the reason for the crash, view the system and application logs for Windows VMs, and the serial logs for Linux VMs.

### Storage-related forced shutdowns

VMs in Azure rely on virtual disks for operating system and data storage that is hosted on the Azure Storage infrastructure. Whenever the availability or connectivity between the VM and the associated virtual disks is affected for more than 120 seconds, the Azure platform performs a forced shutdown of the VMs to avoid data corruption. The VMs are automatically powered back on after storage connectivity has been restored. The duration of the shutdown can be as short as five minutes but can be significantly longer.

### Other incidents

In rare circumstances, a widespread issue can affect multiple servers in an Azure datacenter. If this issue occurs, the Azure team sends email notifications to the affected subscriptions. You can check the [Azure Service Health dashboard](https://azure.microsoft.com/status/) and the Azure portal for the status of ongoing outages and past incidents.

## Diagnose VM Restarts

You can use the Diagnose and Solve blade on the VM blade to run additional diagnostics. This may uncover more specific reasons for your recent VM restart. If there is any Guest OS issue, please collect memory dump and contact support.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

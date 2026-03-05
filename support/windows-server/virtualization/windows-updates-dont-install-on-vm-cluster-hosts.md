---
title: Windows Updates Don't Install on VM Cluster Hosts
description: Discusses how to resolve issues that you might experience when you apply Windows updates to the hosts of a virtual machine (VM) cluster.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ms.custom:
- sap:virtualization and hyper-v\high availability virtual machines
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Windows updates don't install on VM cluster hosts

This article discusses how to resolve issues that you might experience when you apply Windows updates to the hosts of a virtual machine (VM) cluster.

## Symptoms

You experience one or more of these symptoms:

- Windows updates don't install on cluster hosts.
- VMs intermittently don't migrate correctly.
- Operations time out unexpectedly.

## Cause

These issues occur if checkpoints (sometimes known as snapshots) for the VMs in the cluster grow too large. Checkpoints generate large VMRS files. Such files consume disk space and can disrupt the migration process. Disruptions and insufficient disk space can further cause operations to time out and updates to fail to install.

For more information about checkpoints, see [Using checkpoints to revert virtual machines to a previous state](/windows-server/virtualization/hyper-v/checkpoints).

## Resolution

Before you start, verify that you have admin access to the cluster hosts. Make sure you back up all critical data and configuration information.

The following procedures assume that you're familiar with the Windows Update service and [Cluster-Aware Updating overview](/windows-server/failover-clustering/cluster-aware-updating).

To resolve this issue, use one of the following solutions.

### Solution 1: Manually update all hosts to the latest version

> [!IMPORTANT]  
> All hosts in a cluster should run the same version of Windows Server (including the same updates).

Follow these steps on each cluster host:

1. To identify the most recently installed update on the host computer, select **Settings** > **Update & Security** > **Windows Update** > **View update history**.
1. Download and install the most recent compatible update for the host. You can use any of the following tools to access updates:

   - Windows Update
   - Windows Server Update Services (WSUS)
   - The [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/)

1. If it's necessary, restart the host.
1. After the update process finishes, review the host's update history. Make sure that the update installed successfully.

### Solution 2: Schedule CAU to occur during a maintenance window, and temporarily disable Windows Update services

Use this solution to prevent conflicts between CAU and the Windows Update service.

> [!IMPORTANT]  
> Your systems might be vulnerable if you leave automatic updates disabled for an extended period. Schedule your maintenance window to be as brief as possible.

1. In Failover Cluster Manager, select **Cluster-Aware Updating**.

   > [!NOTE]  
   > As an alternative method, you can open a Windows PowerShell Command Prompt window, and then run `Get-CauRun`.

1. Review and modify the update schedule to align with your maintenance window.
1. On each host, follow these steps to temporarily disable the Windows Update service:

   1. Open the Services console (services.msc), and then select **Windows Update service**.
   1. Right-click the service, select **Properties**, and then set **Startup type** to **Disabled**.
   1. To stop the service, select **Stop**.

1. After the subsequent maintenance window ends, check each host's update history to make sure that the updates installed successfully. To check a host's update history, select **Settings** > **Update & Security** > **Windows Update** > **View update history**.
1. Use the Services console to re-enable the Windows Update service. In the service properties, set **Startup type** to **Automatic**, and then select **Start**.

   > [!IMPORTANT]
   > This final step makes sure that your hosts continue to receive security updates.

### Solution 3: Remove checkpoints that you don't need

Don't try to use VM checkpoints for long-term backup storage. Typically, checkpoints are useful for testing purposes.

> [!NOTE]
> Use this procedure during a maintenance window. When you delete a checkpoint, Windows merges the related differencing disk into the parent VHDX of the VM. For large VMs, this operation can be time-consuming and resource-intensive.

When you no longer need the checkpoints, follow these steps to remove the checkpoints:

1. Open the Hyper-V Manager or your preferred virtualization management tool.
1. Go to the VM that has checkpoints.
1. Review the checkpoints, and confirm that you don't need them.
1. Delete each checkpoint. If it's necessary, confirm that you want to delete the checkpoint.
1. Check the VM to make sure that the checkpoint is removed and the disk space is reclaimed.
1. Try again to install the updates on the cluster hosts.

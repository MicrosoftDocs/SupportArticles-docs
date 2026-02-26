---
title: Windows Server 2019 cluster role doesn't come online after you rebuild the cluster
description: Discusses how to resolve an issue in which a Windwos Server 2019 cluster role doesn't come online on a specific node after you rebuild the cluster.
ms.date: 02/27/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:clustering and high availability\cluster service fails to start
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Windows Server 2019 cluster role doesn't come online after you rebuild the cluster

## Summary

Use this article to resolve a Windows Server 2019 failover cluster in which a cluster role doesn't come online on a specific node after you rebuild the cluster. The problem is caused by insufficient permissions for the Cluster Name Object (CNO) to update the secure Domain Name System (DNS) zone. This article explains the symptoms, root cause, and recommended resolution steps.

## Symptoms

You rebuild a Windows Server 2019 failover cluster, and then you experience one or more of the following symptoms:

- On one particular node, cluster roles don't run.
- On that node, the event log displays the following error message, which indicates a permissions issue:

  ```output
  Cluster network name resource failed registration of one or more associated DNS name(s) because the access to update the secure DNS was denied.
  ```

- A generic role can't fail over to another node. In fact, unless you involve your cluster vendor, no roles fail over successfully.

The issue persists even if you destroy the cluster and then rebuild it again.

## Cause

This issue occurs when the cluster network name resource cannot register its DNS names because the CNO does not have the required permissions to update the secure DNS zone. Without these permissions, DNS registration fails. Therefore, the cluster role on the affected node can't come online.

## Resolution

To resolve this issue in Windows Server 2019 failover clusters:

1. Verify that the CNO exists in Active Directory, and isn't disabled.
1. Confirm that the CNO has sufficient permissions to update records in the secure DNS zone. Follow these steps:
   1. In the DNS Manager console, locate the forward lookup zone for your cluster domain.
   1. Right-click the zone, select **Properties**, and then select **Security**.
   1. Verify that the CNO has the **Create all child objects** and **Write all properties** permissions.
   1. If the permissions are missing, configure them.
1. Try to bring the cluster role online.
1. To test the cluster, perform a manual failover.
1. Review the event logs to verify that DNS registration succeeds and doesn't generate permission errors.

After you grant the correct permissions to the CNO, failover between nodes should work as expected.

## Data collection

If the issue persists after you finish the resolution steps, collect the following data and then contact Microsoft Support:

- Cluster logs from all nodes. To collect logs, run the following command on one of the cluster nodes:

  ```powershell
   Get-ClusterLog -UseLocalTime -Destination <folder path></folder>
  ```

- Relevant event logs from **FailoverClustering** and **DNS Server** event log channels.
- Details of the CNO object in Active Directory, including security permissions.

This information helps support engineers quickly identify permission or configuration issues.

## References

- [Prestage cluster computer objects in Active Directory Domain Services](windows-server/failover-clustering/prestage-cluster-adds)

---
title: Shared Volumes Don't Respond During Planned Cluster Node Drain
description: Resolves issues that occur during a planned cluster node drain operation if Cluster Shared Volumes stop responding. 
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\high availability virtual machines
- pcy: Virtualization\high availability virtual machines
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Cluster Shared Volumes don't respond during a planned cluster node drain

## Summary

This article resolves issues that might occur during a planned cluster node drain operation if Cluster Shared Volumes (CSVs) stop responding and enter a pending offline state. This situation can disrupt I/O operations and cause the VMs (VMs) that are hosted on the affected volumes to fail.

## Symptoms

During the planned cluster node drain operation, you encounter the following symptoms:

- CSVs become unresponsive and get stuck in a pending offline state.
- I/O operations are paused for approximately 20–30 minutes.
- The resource-hosting subsystem (RHS) process was terminated and caused the eviction of the affected node from the cluster.
- The affected node is the quorum owner. This condition causes unresponsiveness in overall cluster management.
- All VMs that are hosted on the affected volumes fail.
- Other volumes on the same node fail over successfully and are unaffected.
- Logs indicate repeated timeouts and resource failures for the affected volumes.
- Network-related issues occur, including packet loss that's detected by the NetFT (Network Fault Tolerant) adapter.
- SMB (Server Message Block) multichannel connectivity can't be established because of inconsistent adapter settings.

## Cause

The root cause of this issue is a combination of factors:

- The node that's undergoing the drain operation is the cluster owner. This condition amplifies the effect of the operation.
- File locks on the affected volumes hinder their migration and cause timeouts and subsequent failures.
- Network congestion occurs. The NetFT adapter reports packet loss during the failover attempt.
- Inconsistent network adapter settings across nodes prevent SMB multichannel connectivity.
- The resource drain process triggers resource failures, and causes termination of the RHS process and initiated cluster recovery operations.

## Resolution

To resolve these issues and prevent future occurrences, follow these steps:

1. Log Analysis and Diagnostics: Collect analyzed cluster logs, cluster validation reports, and failure minidump data to identify contributing factors.
2. Network Configuration:

   - Make sure that network adapter settings are uniform across all cluster nodes to enable SMB multichannel connectivity.
   - Increase the network bandwidth or reduce congestion to avoid packet loss during failover operations.

3. Cluster ownership consideration:

   - Plan node drain operations carefully.
   - Before you start maintenance, make sure that critical roles, such as quorum ownership, are moved to other nodes.

4. Preventive actions:

   - Review file lock mechanisms to reduce the risk of migration failures.
   - Perform regular cluster validation tests to identify and resolve potential inconsistencies or misconfigurations.

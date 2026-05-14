---
title: Troubleshoot Failover Cluster Live Migration Freeze with TSM Role
description: Troubleshoot live migration hangs in Windows Failover Clusters, identify the TSM backup role as the root cause, and apply a safe fix during patching cycles.
ms.date: 05/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:clustering and high availability\cannot bring a resource online
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
---

# Troubleshoot failover cluster live migration freeze with TSM role

## Summary

A Windows Failover Cluster might hang and become unresponsive during live migration operations, such as role or VM movement between cluster nodes. This problem can occur intermittently and is often reproducible during scheduled patching cycles when you evacuate nodes. Use this article to resolve cluster hangs that occur during live migration when a third-party backup agent runs as a cluster role.

## Symptoms

You might observe one or more of the following symptoms:

- The failover cluster hangs or freezes during live migration of cluster roles.
- Cluster nodes become unresponsive mid-migration.
- The problem recurs consistently during patching windows.
- No successful role movement occurs without the hang.

Memory dump analysis typically reveals the following findings:

- A consistent deadlock pattern occurs when `\Device\NetBt_If1` is being destroyed during the live migration process.
- The Sysmon driver isn't updated for an extended period (for example, approximately five years). Outdated Sysmon drivers are a known source of deadlocks and network-related instability during live migration.
- The `PktMon.sys` driver shows an old timestamp (for example, 2007-06-16), which indicates it's outdated.

## Cause

The cause is the TSM (IBM Tivoli Storage Manager) backup service running as a Failover Cluster role. During live migration, the TSM cluster role interferes with the network teardown sequence, causing a deadlock.

> [!NOTE]
> Although dump analysis might initially point to Sysmon and PktMon as potential contributors, the actual root cause is the TSM backup service role in the cluster. Disabling this role resolves the problem without any Sysmon or PktMon changes.

## Resolution

Disable the TSM backup service role before performing live migration. You can apply the fix during a patching cycle.

1. Identify all cluster roles and note any third-party backup agents, such as TSM or IBM Spectrum Protect, running as cluster roles.
1. In Failover Cluster Manager, disable the TSM backup service role before starting live migration or node evacuation.
1. Perform the live migration or node drain operation.
1. Re-enable the TSM backup service role after the migration finishes and the node is back online.

> [!IMPORTANT]
> Don't remove or delete any built-in Windows drivers, such as `PktMon.sys`, from production environments without thorough testing in a nonproduction environment first. PktMon is a built-in Windows network traffic analyzer and should only be updated, not removed.

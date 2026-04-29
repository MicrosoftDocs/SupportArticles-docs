---
title: Cluster service doesn't start after you apply CIS Windows Server 2025 Benchmark v1.x recommendations
description: Discusses how to resolve an issue in which the Windows Failover Cluster service fails to start after you apply security hardening recommendations.
ms.date: 04/22/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, carlosm, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:clustering and high availability\cluster service fails to start
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Cluster service doesn't start after you apply CIS Windows Server 2025 Benchmark v1.x recommendations

## Summary

This article discusses how to resolve an issue in which the Windows Failover Cluster service doesn't start in a Windows Server 2025 failover cluster after you apply security hardening recommendations from the Center for Internet Security (CIS) or similar security sources. CIS has published updated recommendations that don't cause this issue, and this article includes procedures for reconfiguring the policy setting that caused the issue.

## Symptoms

To harden your clustering environment, you configure it according to the recommendations of "CIS Microsoft Windows Server 2025 Benchmark version 1._x_", or similar hardening tools. Afterward, the Windows Failover Cluster service doesn't start. Cluster nodes might report errors that indicate that the Cluster Authentication Manager (CAM) can't load.

## Cause

CIS Microsoft Windows Server 2025 Benchmark v1._x_ recommends that you disable the following Group Policy setting in the LocalSecurityAuthority administrative template:

- Policy setting: Allow Custom SSPs and APs to be loaded into LSASS
- Policy location: **Computer Configuration** > **Administrative Templates** > **System** > **Local Security Authority**
- Registry storage location and entry: `HKLM\SOFTWARE\Policies\Microsoft\Windows\System\AllowCustomSSPsAPs`

If this setting is disabled, Local Security Authority Subsystem Service (LSASS) can't load custom Security Support Providers (SSPs) and Authentication Providers (APs). However, the CAM functions as an SSP. If the CAM can't load into LSASS, Windows clusters can't authenticate and start.

Custom or third-party hardening tools might also include this Group Policy recommendation.

## Resolution

"CIS Microsoft Windows Server 2025 Benchmark v2.0" fixes this issue by scoping the recommendation to domain controllers (DCs) but not member servers. To harden your environment, use "CIS Microsoft Windows Server 2025 Benchmark v2.0" or similarly updated standards or tools.

If you already implemented the v1._x_ recommendations, use one of the following methods to restore cluster functionality.

### Method 1: Change the policy setting directly on a cluster node

1. Open the Local Group Policy Editor (gpedit.msc).
1. In the policy editor, locate **Computer Configuration** > **Administrative Templates** > **System** > **Local Security Authority**.
1. Right-click **Allow Custom SSPs and APs to be loaded into LSASS**, and then select **Edit**.
1. Select **Enabled**, and then select **OK**.
1. Restart the Cluster service on the node.

### Method 2: Change the policy setting at the domain or forest level

1. Open the Group Policy Management Console (GPMC) on a DC.
1. Right-click the Group Policy Object (GPO) that controls **Allow Custom SSPs and APs to be loaded into LSASS** on cluster nodes, and then select **Edit**.
1. In the policy editor, locate **Computer Configuration** > **Administrative Templates** > **System** > **Local Security Authority**.
1. Right-click **Allow Custom SSPs and APs to be loaded into LSASS**, and then select **Edit**.
1. Select **Enabled**, and then select **OK**.
1. To propagate the updated policy, run `gpupdate /force` on the affected nodes
1. To start the affected nodes, run a command such as the Windows PowerShell [`Start-Cluster`](/powershell/module/failoverclusters/start-cluster) cmdlet or [`Start-ClusterNode`](/powershell/module/failoverclusters/start-clusternode) cmdlet.

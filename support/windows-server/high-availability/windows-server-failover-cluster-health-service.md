---
title: Windows Server Failover Cluster Health Service Troubleshooting Guide
description: Resolves issues that affect the Windows Server Failover Cluster Health Service.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: high availability\health service
- pcy: High availability\health service
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Windows Server failover cluster health service troubleshooting guide

## Summary

Windows Server Health Service is a key component of Windows Server, Failover Clustering, and System Center environments. It proactively monitors the health and availability of critical cluster resources, services, disks, storage, and network connectivity, and generates alerts to help administrators address faults before they lead to outages. 
If the Health Service malfunctions, doesn't start, or produces persistent warnings, it can mask underlying problems or generate false positives, endangering both availability and performance.

This article provides a detailed checklist for troubleshooting Health Service issues. It covers diagnostic steps, common error scenarios, verified solutions, and tools for collecting data for root cause analysis.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- Verify Health Service Status
    - Check the status in Failover Cluster Manager (mmc), Windows Event Viewer, and PowerShell: Get-Service -Name HealthServiceGet-ClusterResource | Where-Object {$_.ResourceType -eq "HealthService"}
- Review Recent Alerts and Events
    - Inspect the System, Application, and FailoverClustering event logs for errors or recurrent warnings (Event Viewer).
    - Note Event IDs such as 0, 7024, 7031, 7034, 5120, 5121, 5126.
- Check Cluster Resource State
    - Verify that the Health Service is online (green state) in the cluster dashboard.
    - Make sure that no dependent resources or critical services are failing.
- Assess System Prerequisites
    - Verify that cluster nodes have consistent OS and update levels.
    - Sufficient disk space, memory, and network connectivity exist.
    - Antivirus or security software exclusions are configured for cluster paths and binaries.
- Review Recent Changes
    - Any recent updates, upgrades, network changes, cluster configuration modifications, or disk additions?
    - Roll back or validate the impact of recent updates if symptoms began after changes.
- Examine Network and Firewall Settings
    - Make sure that required ports (both cluster and Health Service) are open between nodes (for example, TCP/UDP 5985, 135, 445, 3343).
- Verify Disk and Storage Health
    - Check CSV, quorum disks, or witness disk state.
    - Run chkdsk and review health diagnostics.
- Synchronize Time and Certificates
    - NTP is properly configured; no significant clock drift across cluster nodes.
    - Certificates used by Health Service (if any) are valid and not expired.
- Run Cluster Validation
    - Use the Cluster Validation Wizard in Failover Cluster Manager for automated checks, focusing on storage, networking, and system configuration.

## Common issues and solutions

### 1. Health service doesn't start or goes offline

#### Symptoms

- Failover Cluster Manager shows the Health Service as offline or in a failed state.
- Event IDs: 7024, 7031, 0 (service terminated unexpectedly), Cluster event 1205/1069.

#### Cause and resolution

- Corrupted Health Service Binary/Install:
    - Action: Uninstall and reinstall the Health Service role/component.
- System Integrity Violation:
    - Action: Run sfc /scannow and DISM repair on each node.DISM /Online /Cleanup-Image /RestoreHealth
- Insufficient Resources (RAM/CPU/Disk):
    - Action: Free up space, increase resources, move workloads as needed.
- Pending Windows Updates:
    - Action: Install all pending updates and restart cluster nodes.
- Dependent Services Not Running:
    - Action: Make sure that WMI, RemoteRegistry, and Cluster Service are running.
- AV/Firewall Interference:
    - Action:Add exclusions for:
        - C:\Windows\Cluster
        - C:\ClusterStorage
        - Cluster binaries and SQL/Hyper-V binaries

### 2. Health Service event log errors or recurrent cluster health alerts

#### Symptoms

- Constant health warnings.
- Event Log IDs: 5120/5121 (storage/network issue), 5126 (resource offline), WMI errors.

#### Cause and resolution

- Resource Dependency Failure:
    - Action: Verify all dependencies (disks, SMB, storage, replication) are online and healthy.
- Network Partition:
    - Action: Use Cluster Validation and netstat to trace missing/broken communication.
    - Reconfigure or repair network adapters, review switch and routing logs.
- Quorum Disk or Witness Failure:
    - Action: Check disk health, run chkdsk, replace or reconfigure the quorum or witness disk as needed.
- Storage Spaces/S2D Pool Problems:
    - Action: Use PowerShell: Get-StoragePool, Get-VirtualDisk, Get-PhysicalDiskfor state.
    - Run pool optimization, add/replace failed disks.

### 3. High CPU and memory usage by Health Service

#### Symptoms

- "HealthService.exe" consumes excessive system resources.

#### Cause and resolution

- Many resources/monitors:
    - Action: Optimize monitored objects, remove unneeded performance counters, or split workloads across nodes.
- Log file bloat or leaks:
    - Action: Archive or truncate logs, check for stuck transactions, clear temp directories.
- Corrupted performance counters:
    - Action: Rebuild counters: lodctr /r

### 4. Health Service Certificate/Authentication Errors

#### Symptoms

- Events mentioning certificate issues, access denied (5), authentication or secure channel errors.

#### Cause and resolution
- Expired/revoked certificate:
    - Action: Renew or replace Health Service and cluster certificates. Make sure that CRLs (Certificate Revocation Lists) are accessible.
- Time skew:
    - Action: Make sure that NTP time sync across cluster nodes.w32tm /query /status
- Mismatched Security/Authentication Protocols:
    - Action: Verify cluster Kerberos/NTLM protocols match (Windows Authentication must align across nodes).
    - Set GPO/registry settings as appropriate.

### 5. "Access Denied" or permissions/registry issues

#### Symptoms

- Health Service can't access cluster resources, system logs, or registry keys.
- Specific error codes (for example, 5, 0x80070005).

#### Cause and resolution
- Lack of permissions:
    - Action: Add the cluster service account and SYSTEM to local administrator and required resource permissions.
- Computer/service account password problems:
    - Action: Reset secure channels withTest-ComputerSecureChannel -Repair -Verbose

### 6. WMI issues affect Health Service

#### Symptoms

- Errors involving WMI repository, management object access failures.
- Cluster logs show WMI-related errors.

#### Cause and resolution

- Corrupted WMI Repository:
    - Action:

    ```console
    winmgmt /verifyrepository
    winmgmt /resetrepository
    mofcomp cluswmi.mof
    ```

- Insufficient WMI namespace permissions:

    - Action: Use "wmimgmt.msc" to verify security on root\cimv2 and cluster namespaces, Repair by using "wmimgmt" or PowerShell.

## Common issues quick reference table

| Symptom | Error/Event IDs | Cause | Resolution |
| --- | --- | --- | --- |
| Health Service offline | 7024, 7031, 0 | Binary corruption, missing dependency | Reinstall, check services |
| Persistent health warnings | 5120, 5121, 5126 | Storage/network/quorum issue | Check disks, CSV/Network |
| High CPU/Memory HealthService | - | Many monitors/perf counters, leaks | Optimize, clear counters |
| Access Denied | 5, 0x80070005 | Permissions, AV, or ACL misconfiguration | Set permissions, AV excl. |
| WMI repository errors | - | WMI repository corrupt | winmgmt /resetrepository |
| SSL/certificate/auth failures | 7034, 1069, 1207 | Expired/missing certificates, time skew | Renew/re-import, sync NTP |
| Health check triggers failover | 1676, 1135, 1177 | Missed heartbeat, IsAlive threshold, VSS | Optimize backup, net diag |
| Service can't access registry | 86, 5126 | Missing Registry key or permission | Add/restore, ACL review |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- Cluster diagnostics logs: Get-ClusterLog -Destination \<path> -UseLocalTime
- Service event logs:
      - Application, system, and FailoverClustering logs from Event Viewer.
- Service state snapshots: Get-Service HealthService, Get-ClusterResource
- Network and Storage Health: ipconfiguration /all, Test-NetConnection, Get-StoragePool, Get-VirtualDisk
- Resource and role list: Get-ClusterGroup, Get-ClusterResource
- WMI diagnostics: winmgmt /verifyrepository
- Cluster validation report: Run cluster validation in Failover Cluster Manager.
- Specific Error Screenshots and Resource Status.

Send logs and diagnostics to support or use secure workspace sharing per organizational policy.

## References

- [Windows Server Failover Cluster Health Service Documentation](/windows-server/failover-clustering/health-service-overview)
- [Event ID and Diagnostic Reference](/windows/win32/eventlog/event-logging)
- [Cluster Validation Wizard Guide](/troubleshoot/windows-server/high-availability/validate-hardware-failover-cluster?source=recommendations)
- [Health Service reports](/windows-server/failover-clustering/health-service-reports)

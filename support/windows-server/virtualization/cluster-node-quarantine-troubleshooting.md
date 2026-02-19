---
title: Guidance for troubleshooting cluster node quarantine issues
description: Discusses how to isolate and fix issues that cause a cluster node quarantine to temporarily isolate an unstable or problematic node.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\backup and restore of virtual machines
- pcy: Virtualization\backup and restore of virtual machines
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Cluster node quarantine troubleshooting guidance

## Summary

Cluster node quarantine is a protective feature in Windows Server Failover Clustering that temporarily isolates unstable or problematic nodes to safeguard cluster health and application workloads. A quarantined node can't host cluster roles, such as virtual machines (VMs), until it exits quarantine, either automatically or through administrator intervention. Several issues can trigger a quarantine, including repeated health check failures, persistent service failures, hardware issues, or storage or network communication problems. This article provides a thorough approach to investigating and resolving node quarantine incidents to help administrators ensure cluster stability and minimal downtime.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- Identify quarantined nodes
  - Use Failover Cluster Manager or `Get-ClusterNode` PowerShell cmdlet.
- Review cluster events and error messages
  - Check Event Viewer (System and Cluster logs) for quarantine reasons, for example Event IDs 1641, 1647, 1649.
  - Examine recent application, system, and failover clustering logs.
- Check node status and resource hosting subsystem (RHS)
  - Check whether RHS or core services are repeatedly crashing.
  - Review service health and recent restarts.
- Assess network connectivity
  - Verify that the node can communicate with other cluster members (ICMP/ping, ports 3343 and others).
  - Verify no packet loss, MTU mismatches, firewall blocks.
- Verify cluster storage connectivity
  - Check for access to Cluster Shared Volumes (CSVs) and disk resources.
  - Look for Event IDs 5120, 5142 (CSV paused/disconnected).
- Check system resource health
  - Investigate disk status, memory, CPU utilization, hardware alerts.
  - Run diagnostics for hardware issues.
- Cluster configuration review
  - Validate node certificates, static IP, cluster network settings, quorum configuration.
- Examine security software or antivirus
  - Determine whether security agent is interfering with cluster traffic or services.
  - Temporarily disable to test stability.
- Collect relevant data for analysis
  - Cluster logs (`Get-ClusterLog`), event logs, network traces, crash dumps.

## Common issues and solutions

### Quarantine because of repeated RHS/service failures

#### Symptoms

- Node appears in "Quarantine" state.
- Event IDs: 1641 (`Node quarantine activated`), 1647, repeated 7031 (Service Control Manager: `unexpected service termination`).
- Cluster roles continuously fail over from the node. VMs may repeatedly restart or move.

#### Resolution:

- Review failure details in Cluster.log and System/Application event logs.
- If a specific process (for example, MsSense.exe, rhs.exe) is implicated:
  - Obtain memory dump files of the process. Analyze for deadlocks or memory leaks.
  - Remove or disable problematic VM/service.
  - Apply the latest updates for Windows, Hyper-V, and third-party software.
  - Add antivirus exclusions for .avhdx, .vhdx, and cluster-related files.
- Check for known bugs (for example, WDATP/MsSense.exe memory leak), and apply a MSFT hotfix, if it's available.

### Network communication issues

#### Symptoms

- Node is quarantined. Network events show dropped packets or heartbeat failures.
- Event IDs: 1135 (`Node removed from cluster`), 1177, warnings about broken communication channels (status `10054`).
- Other nodes show failed connection attempts to quarantined node (port 3343).

#### Resolution

- Make sure that all required cluster ports (UDP 3343, SMB, TCP 6600 for live migration) are open and not blocked by firewall/security software.
- Run `Test-NetConnection` for key ports.
- Check for MTU mismatches. Set consistent MTU values across all cluster adapter settings.
- Update network adapter drivers/firmware. Verify the RDMA configuration, if used.
- If antivirus/firewall is blocking traffic, add exceptions, or temporarily disable for testing.

### Storage/CSV issues that cause quarantine

#### Symptoms

- Event IDs 5120, 5142, CSV paused or disconnected, node enters quarantine after failure.
- VM disks or CSVs inaccessible from quarantined node.
- Event logs show storage path failures, degraded MPIO, or controller resets.

#### Resolution

- Verify the health of the storage subsystem (use vendor tools and logs).
- Reconnect or restart storage paths, check for persistent disks.
- Exclude cluster storage directories from antivirus.
- Run `Get-ClusterSharedVolumeState` on affected nodes.
- Verify multipath I/O (MPIO), check failover/failback logs, apply the latest firmware or storage drivers.

### Security platform/antivirus interference

#### Symptoms

- Cluster communication dropped by third-party security software.
- Cluster event logs or TCP/IP diagnostic logs indicate silent packet drops.
- Procmon shows blocked cluster service execution.

#### Resolution

- Disable/remove offending security software. Retest cluster stability.
- Reinstall after you verify that cluster communication works.
- Add cluster service, process, and directories to software exclusion list.

### Configuration and infrastructure gaps

#### Symptoms

- Quarantine initiated after node restart or updating.
- IP misconfigurations occur (DHCP used instead of static), and cluster certificate is missing.
- Quorum witness resource repeatedly fails.

#### Resolution

- Set cluster IP resource to static, not DHCP (Set-ClusterParameter).
- Verify cluster node certificates; export/import from healthy node if missing.
- Validate and repair quorum witness configuration (disk/file share witness settings).
- Use Update-ClusterNetworkNameResource to refresh network name resources.

### Recovering from quarantine state

General Recovery Steps:

- Use PowerShell to clear node quarantine: `Start-ClusterNode -Name <NodeName> -ClearQuarantine`.
- Evict and re-add node; restart cluster service, if it's necessary.
- Restart node after clearing issues (hardware, network, service-related).
- Monitor logs for confirmation: node rejoins cluster normally.

## Common issues quick reference table

| Issue | Key symptoms | Resolution | Reference event IDs |
| --- | --- | --- | --- |
| RHS/service failure | Quarantine state, VM failovers, crash logs | Analyze dumps, update/update, AV exclusions, remove problematic service/VM | 1641, 7031 |
| Network communication error | Node removal, dropped packets, port failures | Open cluster ports, fix MTU, update NIC drivers, AV/firewall exclusions | 1135, 1177, 10054 |
| Storage/CSV Access Failure | CSV paused/disconnected, VM disk I/O errors | Storage vendor analysis, update firmware/drivers, fix MPIO, AV exclusions | 5120, 5142 |
| Antivirus/security platform issues | Packet dropped by filter, service block | Disable/remove AV/Security, set exclusions, reinstall as necessary | Varies |
| Configuration/quorum issues | Quorum witness fail, IP/certificate errors | Set static IPs, fix certificates, rebuild quorum witness, update resources | 1069, 1558, 121 |
| Recovery steps (general) | Can't host roles, node stays quarantined | `Start-ClusterNode -ClearQuarantine`, evict/re-add, restart, monitor logs | 1641 |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- Cluster Logs: `Get-ClusterLog -Destination \<FolderPath> -UseLocal -TimeSpan <Minutes>`
- Event Logs: Export System, Application, and FailoverClustering logs.
- Network Trace: `Netsh trace start scenario=GENERAL capture=yes tracefile=<path>`
- Process dumps files: As needed, using Sysinternals or built-in Windows tools.
- Storage and hardware diagnostics: Collect through vendor tool output.
- Security software logs: Export relevant security agent filtering and action logs.

## References

- [Recommended antivirus exclusions for Hyper-V hosts](antivirus-exclusions-for-hyper-v-hosts.md)

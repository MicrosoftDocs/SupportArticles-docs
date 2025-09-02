---
title: Hyper-V Virtual Machine Live Migration Troubleshooting Guide
description: Provides a comprehensive troubleshooting process, detailed solutions for common migration issues, structured data collection procedures, and quick reference resources.
ms.date: 09/02/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\migration
- pcy:WinComm Storage High Avail
---
# Troubleshooting Guide: Hyper-V Virtual Machine Live Migration

## Introduction

Live Migration in Hyper-V allows virtual machines (VMs) to be moved between hosts with minimal downtime—a critical feature for high availability and maintenance in Windows Server environments. Despite its capabilities, Live Migration can fail due to a wide array of factors—hardware incompatibility, authentication, network configuration, VM settings, and storage problems. Properly diagnosing and resolving Live Migration failures is vital for business continuity, especially in clustered and production settings. This guide provides a comprehensive troubleshooting process, detailed solutions for common migration issues, structured data collection procedures, and quick reference resources.

## Troubleshooting Checklist

Use this checklist as a step-wise process before and during troubleshooting:
1. **Baseline Health Checks**    - Confirm VM integration services are up-to-date.
    - Ensure all hosts are fully patched and running supported Windows Server versions.
    - Confirm the VM is in a supported state for migration (not in Backing Up, Stopping, etc.).
2. **Cluster and Host Configuration**    - Check cluster node/host compatibility (CPU, BIOS/firmware versions, configuration versions).
    - Verify all cluster nodes are online, healthy, and visible in Failover Cluster Manager.
    - Validate VM configuration version consistency across hosts.
3. **Network & Storage**    - Confirm live migration, management, and storage networks are correctly configured and reachable.
    - Ensure VM storage is accessible on the destination host.
    - Check firewall rules and port accessibility (e.g., UDP 3343 for WSFC).
4. **Authentication/Permissions**    - Verify Kerberos or CredSSP is enabled and delegated properly for live migrations.
    - Check required Service Principal Names (SPNs) are registered.
    - Confirm permission levels for migration accounts.
5. **Virtual Switches/Networks**    - Ensure required VM switches exist and are identically configured across hosts.
    - Validate network teaming (SET or LBFO) consistency.
6. **VM-Specific Features**    - If using vTPM/Shielded VM, confirm certificate requirements between hosts.
    - Check for snapshots/checkpoints—merge or delete as appropriate.

## Common Issues and Their Respective Solutions

### 1. **Hardware/CPU Incompatibility**

**Symptoms:**
- Error: “The virtual machine uses processor-specific features not supported on the physical computer”
- Event ID 21502

**Resolution:**
- In Hyper-V Manager, set VM’s processor settings: Enable “Migrate to a physical computer with a different processor version”.
- Ensure target host supports VM’s CPU features.
- *Tip:* Always start VMs for the first time on the oldest (least capable) CPU host.

### 2. **VM Configuration Version Mismatch**

**Symptoms:**
- Migration works one way but not in reverse (esp. after moving to a newer OS).
- Error: Live migration or quick migration fails with compatibility issues.
- Event IDs 10698, 21502

**Resolution:**
- Upgrade VM configuration version when moving to a newer host (Hyper-V Manager: Action > Upgrade VM Configuration Version).
- *Note:* Cannot roll back; VMs with upgraded version cannot be migrated back to older hosts.
- Verify configuration versions with Get-VM \* | select Name, Version.

### 3. **Network Connectivity/Configuration Issues**

**Symptoms:**
- Live migration fails before/during transfer.
- Migration fails with: "The client cannot connect to the destination specified in the request" or "WinRM protocol errors."
- Event IDs: 20406, 280

**Resolution:**
- Ensure hosts can resolve and reach each other via hostname/IP (test with ping).
- Use winrm quickconfig to verify/configure WinRM on both hosts.
- Update TrustedHosts as needed:Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<Host1>,<Host2>"
- Verify firewall allows necessary ports (default SMB, WinRM, and clustering ports).
- Match network configurations (switch names/types, teaming) across hosts.

### 4. **Authentication/Delegation Problems**

**Symptoms:**
- Error code: “General access denied error (0x80070005)”
- Errors 0x8009030E, 0x8009030D (delegation/Kerberos/SPN problems)

**Resolution:**
- Enable Kerberos authentication:Hyper-V Settings > Live Migrations > Advanced > Authentication protocol: Kerberos
- Configure constrained delegation in AD:    - Computer Properties > Delegation tab > Trust this computer for delegation to specified services only > Add cifs and Microsoft Virtual System Migration Service.
- Register missing SPNs: setspn -s Microsoft Virtual System Migration Service/<FQDN> <ComputerName>
- Purge old Kerberos tickets:KLIST PURGE -li 0x3e7

### 5. **Storage/Shared Disk Issues**

**Symptoms:**
- Migration fails for VMs with shared VHDX/shared disks
- Error: Shared disk missing in migration options.

**Resolution:**
- Shared virtual disks can only be used in clustered VM roles and cannot be migrated using standard methods.
- Manually move and reattach shared disks at destination where required.

### 6. **vTPM/Shielded VM Certificate Issues**

**Symptoms:**
- Error: "The key protector for the virtual machine could not be unwrapped."
- Migration only fails for vTPM-protected VMs.

**Resolution:**
- Export Shielding/Key Protector certificates from source host and import on destination.
- Windows Certificates Snap-in (certmgr.msc) can be used.
- PowerShell: Export-PfxCertificate and Import-PfxCertificate

### 7. **State File/Checkpoint Problems**

**Symptoms:**
- Error: “Cannot restore this virtual machine because the saved state data cannot be read. Delete the saved state data and then try to start the virtual machine. (0xC0370027)”
- VMs stuck in “Backing up” state

**Resolution:**
- In Hyper-V Manager: Select VM > Delete Saved State
- Manually delete .bin and .vsv files from VM folder if necessary.
- Remove or merge corrupted checkpoints.

### 8. **Cluster/Migration Limit Issues**

**Symptoms:**
- Error: “Virtual machine migration limit 1 was reached, please wait for completion of an ongoing migration operation.”
- VMs enter Saved state during node drain or reboot.

**Resolution:**
- Increase Simultaneous Migrations:Hyper-V Settings > Live Migrations > Simultaneous Migrations
- PowerShell:Set-VMHost -MaximumVirtualMachineMigrations N
- Always drain roles before reboot with:Suspend-ClusterNode -Name <NodeName> -Drain

### 9. **Code Defects/Bugs**

**Symptoms:**
- VMs stuck in “Stopping” state after migration; orphaned vport reported in livedump analysis.
- Case #: 2502260050001354003

**Resolution:**
- Update to latest Windows Server Cumulative Update.
- If upgrade not possible, request Microsoft support for hotfix if bug is referenced.

## Data Collection

**Standard Data Collection Checklist:**
- **Event Logs:**Get-WinEvent -LogName "Microsoft-Windows-Hyper-V-VMMS/Admin"
- **Cluster Logs:**Get-ClusterLog -UseLocalTime -Destination <Path>
- **Hyper-V Migration Logs:**Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Worker-Admin
- **Network Diagnostics:**Get-NetAdapter, ipconfig /all, and ensure all network paths are up.
- **Delegation and SPN Checks:**setspn -L <HostName>, check Delegation tab in AD.
- **VM and System Configuration:**Get-VM \* | select Name, Version Get-VMSwitch Get-VMProcessor -VMName <VMName>
- **WinRM Configuration:**winrm quickconfig Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<Host1>,<Host2>"
- **PowerShell to Gather Live Migration Traces:**TSS.ps1 -CollectLog SHA_support-all -noBasicLog -noUpdate -NewSession
- **Snapshot/Checkpoint Chain:**Get-VHDChain -Path <PathToVHD>

## Common Issues Quick Reference Table

| Symptom/Error | Likely Root Cause | Resolution Summary |
| --- | --- | --- |
| "The VM uses processor-specific features not supported..." | CPU feature/BIOS/firmware mismatch | Enable migration compatibility; check host CPU features and BIOS |
| VM migration fails with version error | Config version mismatch | Upgrade VM config version on new host, can't migrate back to old host |
| "General access denied error (0x80070005)", 0x8009030E/0x8009030D | SPN/delegation/Kerberos misconfig | Configure constrained delegation, register SPNs, set Kerberos, check AD |
| "The server does not support WS-Management Identify operations..." | WinRM/proxy/trustedhosts misconfig | Set WinRM/trusted hosts, update hosts files, bypass proxy |
| "Cannot restore this virtual machine because the saved state data..." | Corrupt checkpoint/saved state files | Delete Saved State, remove/merge checkpoints, manually delete .bin/.vsv |
| vTPM-enabled VM fails: "The key protector... could not be unwrapped." | Certificate/Shielded VM config | Export/import key protector certificates |
| Migration fails—shared disk not available in migration wizard | Unsupported scenario | Manual re-attach disks, follow shared disk migration documentation |
| Live migration limit reached; VMs enter Saved state in draining | Concurrency settings low; improper drain | Raise migration limit, drain roles before reboot |
| "No matching virtual switch found..." | Network switch config inconsistency | Ensure identical virtual switch config on all hosts |
| Live migration events show failures post-update | Patch/Firmware/Speculation setting | Ensure all nodes are updated/patched; check speculation control settings |
| VM backs up forever, can't move/out/in "Backing up" state | Backup software lock | Restart backup service, VMMS service, or power on VM to merge checkpoints |

## References
- **WinRM and TrustedHosts Configuration:**[<u>https://learn.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management</u>](https://learn.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management)
- **Cluster Shared Volumes and Migration Limits:**[<u>https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-csvs</u>](https://learn.microsoft.com/en-us/windows-server/failover-clustering/failover-cluster-csvs)
- **SCVMM VMware-to-Hyper-V Conversion:**[<u>https://learn.microsoft.com/en-us/system-center/vmm/vm-convert-vmware?view=sc-vmm-2022</u>](https://learn.microsoft.com/en-us/system-center/vmm/vm-convert-vmware?view=sc-vmm-2022)

## Summary

Ensuring successful Hyper-V Live Migration requires diligent configuration management—including CPU, firmware, network, authentication, storage, and permissions—across all participating hosts. By following the troubleshooting checklist, addressing known root causes as outlined in the solutions section, and using targeted data collection, most migration failures can be swiftly resolved or appropriately escalated. Staying current with patches, standardizing cluster configurations, and understanding log outputs will minimize downtime and operational risk for mission-critical virtual machine workloads.
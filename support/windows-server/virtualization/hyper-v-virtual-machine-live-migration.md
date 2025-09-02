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
# Troubleshooting guide: Hyper-V virtual machine live migration

Live migration in Hyper-V allows virtual machines (VMs) to be moved between hosts with minimal downtime—a critical feature for high availability and maintenance in Windows Server environments. Despite its capabilities, live migration can fail due to a wide array of factors—hardware incompatibility, authentication, network configuration, VM settings, and storage problems. Properly diagnosing and resolving live migration failures is vital for business continuity, especially in clustered and production settings. This guide provides a comprehensive troubleshooting process, detailed solutions for common migration issues, structured data collection procedures, and quick reference resources.

## Troubleshooting checklist

Use this checklist as a step-wise process before and during troubleshooting:

1. Baseline health checks

    - Confirm VM integration services are up-to-date.
    - Ensure all hosts are fully patched and running supported Windows Server versions.
    - Confirm the VM is in a supported state for migration (for example, not in backing up or stopping).

1. Cluster and host configuration

    - Check cluster node/host compatibility (CPU, BIOS/firmware versions, configuration versions).
    - Verify all cluster nodes are online, healthy, and visible in Failover Cluster Manager.
    - Validate VM configuration version consistency across hosts.

1. Network and storage

    - Confirm live migration, management, and storage networks are correctly configured and reachable.
    - Ensure VM storage is accessible on the destination host.
    - Check firewall rules and port accessibility (for example, UDP 3343 for WSFC).

1. Authentication or permissions

    - Verify Kerberos or CredSSP is enabled and delegated properly for live migrations.
    - Check required Service Principal Names (SPNs) are registered.
    - Confirm permission levels for migration accounts.

1. Virtual switches or networks

    - Ensure required VM switches exist and are identically configured across hosts.
    - Validate network teaming (SET or LBFO) consistency.

1. VM-specific features

    - If using vTPM/Shielded VM, confirm certificate requirements between hosts.
    - Check for snapshots/checkpoints—merge or delete as appropriate.

Here are common issues and their respective resolutions:

## Hardware or CPU incompatibility

Symptoms:

- Error message:

  > The virtual machine uses processor-specific features not supported on the physical computer
- Event ID 21502

### Resolution

- In Hyper-V Manager, set VM's processor settings: Enable **Migrate to a physical computer with a different processor version**.
- Ensure target host supports VM's CPU features.

> [!TIP]
> Always start VMs for the first time on the oldest (least capable) CPU host.

## VM configuration version mismatch

Symptoms:

- Migration works one way but not in reverse (especially after moving to a newer OS).
- Error message:

  > Live migration or quick migration fails with compatibility issues.
- Event IDs 10698, 21502

### Resolution

- Upgrade VM configuration version when moving to a newer host (Hyper-V Manager: Action > Upgrade VM Configuration Version).

  > [!NOTE]
  > Can't roll back; VMs with upgraded version can't be migrated back to older hosts.

- Verify configuration versions with the `Get-VM * | select Name, Version` cmdlet.

## Network connectivity or configuration issues

Symptoms:

- Live migration fails before/during transfer.
- Migration fails with: "The client cannot connect to the destination specified in the request" or "WinRM protocol errors."
- Event IDs: 20406, 280

### Resolution

- Ensure hosts can resolve and reach each other via hostname/IP (test with `ping`).
- Use winrm quickconfig to verify/configure WinRM on both hosts.
- Update TrustedHosts as needed: `Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<Host1>,<Host2>"`
- Verify firewall allows necessary ports (default SMB, WinRM, and clustering ports).
- Match network configurations (switch names/types, teaming) across hosts.

## Authentication or delegation problems

Symptoms:

- Error code: "General access denied error (0x80070005)"
- Errors 0x8009030E, 0x8009030D (delegation/Kerberos/SPN problems)

### Resolution

- Enable Kerberos authentication: **Hyper-V Settings** > **Live Migrations** > **Advanced** > **Authentication protocol: Kerberos**.
- Configure constrained delegation in AD: **Computer Properties** > **Delegation** tab > **Trust this computer for delegation to specified services only** > **Add cifs and Microsoft Virtual System Migration Service**.
- Register missing SPNs: `setspn -s Microsoft Virtual System Migration Service/<FQDN> <ComputerName>`
- Purge old Kerberos tickets: `KLIST PURGE -li 0x3e7`

## Storage or shared disk issues

Symptoms:

- Migration fails for VMs with shared VHDX/shared disks
- Error: Shared disk missing in migration options.

### Resolution

- Shared virtual disks can only be used in clustered VM roles and can't be migrated using standard methods.
- Manually move and reattach shared disks at destination where required.

## VTPM or shielded VM certificate issues

Symptoms:

- Error: "The key protector for the virtual machine could not be unwrapped."
- Migration only fails for vTPM-protected VMs.

### Resolution

- Export shielding or key protector certificates from source host and import on destination.
- Windows certificates snap-in (**certmgr.msc**) can be used.
- PowerShell cmdlet:
  
  ```powershell
  Export-PfxCertificate and Import-PfxCertificate
  ```

## State file or checkpoint problems

Symptoms:

- Error message:
  
  > Cannot restore this virtual machine because the saved state data cannot be read. Delete the saved state data and then try to start the virtual machine. (0xC0370027)
- VMs stuck in "Backing up" state

### Resolution

- In Hyper-V Manager: Select **VM** > **Delete Saved State**.
- Manually delete `.bin` and `.vsv` files from VM folder if necessary.
- Remove or merge corrupted checkpoints.

## Cluster or migration limit issues

Symptoms:

- Error message:
  
  > Virtual machine migration limit 1 was reached, please wait for completion of an ongoing migration operation.
- VMs enter Saved state during node drain or reboot.

### Resolution

- Increase Simultaneous Migrations: **Hyper-V Settings** > **Live Migrations** > **Simultaneous Migrations**.
- PowerShell cmdlet:

  ```powershell
  Set-VMHost -MaximumVirtualMachineMigrations N
  ```

- Always drain roles before reboot with: `Suspend-ClusterNode -Name <NodeName> -Drain`

## Code defects or bugs

Symptoms:

- VMs stuck in "Stopping" state after migration; orphaned vport reported in live dump analysis.
- Case number: 2502260050001354003

### Resolution

- Update to latest Windows Server Cumulative Update.
- If upgrade not possible, request Microsoft support for hotfix if bug is referenced.

## Data collection

Standard data collection checklist:

- Event logs: `Get-WinEvent -LogName "Microsoft-Windows-Hyper-V-VMMS/Admin"`
- Cluster logs: `Get-ClusterLog -UseLocalTime -Destination <Path>`
- Hyper-V migration logs: `Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Worker-Admin`
- Network diagnostics: `Get-NetAdapter`, `ipconfig /all`, and ensure all network paths are up.
- Delegation and SPN checks: run `setspn -L <HostName>`, and check **Delegation** tab in AD.
- VM and system configuration: `Get-VM * | select Name, Version`, `Get-VMSwitch`, and `Get-VMProcessor -VMName <VMName>`.
- WinRM configuration: `winrm quickconfig Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<Host1>,<Host2>"`
- PowerShell to gather live migration traces: `TSS.ps1 -CollectLog SHA_support-all -noBasicLog -noUpdate -NewSession`
- Snapshot or checkpoint chain: `Get-VHDChain -Path <PathToVHD>`

## Common issues quick reference table

| Symptom or error | Likely root cause | Resolution summary |
| --- | --- | --- |
| "The VM uses processor-specific features not supported..." | CPU feature/BIOS/firmware mismatch | Enable migration compatibility; check host CPU features and BIOS |
| VM migration fails with version error | Config version mismatch | Upgrade VM config version on new host, can't migrate back to old host |
| "General access denied error (0x80070005)," 0x8009030E/0x8009030D | SPN/delegation/Kerberos misconfig | Configure constrained delegation, register SPNs, set Kerberos, check AD |
| "The server does not support WS-Management Identify operations..." | WinRM/proxy/trustedhosts misconfig | Set WinRM/trusted hosts, update hosts files, bypass proxy |
| "Cannot restore this virtual machine because the saved state data..." | Corrupt checkpoint/saved state files | Delete Saved State, remove/merge checkpoints, manually delete .bin/.vsv |
| vTPM-enabled VM fails: "The key protector... could not be unwrapped." | Certificate/Shielded VM config | Export/import key protector certificates |
| Migration fails—shared disk not available in migration wizard | Unsupported scenario | Manual re-attach disks, follow shared disk migration documentation |
| Live migration limit reached; VMs enter Saved state in draining | Concurrency settings low; improper drain | Raise migration limit, drain roles before reboot |
| "No matching virtual switch found..." | Network switch config inconsistency | Ensure identical virtual switch config on all hosts |
| Live migration events show failures post-update | Patch/Firmware/Speculation setting | Ensure all nodes are updated/patched; check speculation control settings |
| VM backs up forever, can't move/out/in "Backing up" state | Backup software lock | Restart backup service, VMMS service, or power on VM to merge checkpoints |

## References

- WinRM and `TrustedHosts` configuration: [Installation and configuration for Windows Remote Management](/windows/win32/winrm/installation-and-configuration-for-windows-remote-management)
- Cluster Shared Volumes and migration limits: [Cluster Shared Volumes overview](/windows-server/failover-clustering/failover-cluster-csvs)
- SCVMM VMware-to-Hyper-V conversion: [Convert a VMware VM to Hyper-V in the VMM fabric](/system-center/vmm/vm-convert-vmware)

## Summary

Ensuring successful Hyper-V live migration requires diligent configuration management—including CPU, firmware, network, authentication, storage, and permissions—across all participating hosts. By following the troubleshooting checklist, addressing known root causes as outlined in the solutions section, and using targeted data collection, most migration failures can be swiftly resolved or appropriately escalated. Staying current with patches, standardizing cluster configurations, and understanding log outputs minimize downtime and operational risk for mission-critical virtual machine workloads.

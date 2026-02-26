---
title: Hyper-V Virtual Machine Live Migration Troubleshooting Guide
description: Provides a comprehensive troubleshooting process, detailed solutions for common migration issues, structured data collection procedures, and quick reference resources.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\migration
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshooting guide: Hyper-V virtual machine live migration

Live migration in Hyper-V allows virtual machines (VMs) to be moved between hosts with minimal downtime—a critical feature for high availability and maintenance in Windows Server environments. Despite its capabilities, live migration can fail due to a wide array of factors—hardware incompatibility, authentication, network configuration, VM settings, and storage issues. Properly diagnosing and resolving live migration failures is vital for business continuity, especially in clustered and production settings. This guide provides a comprehensive troubleshooting process, detailed solutions for common migration issues, structured data collection procedures, and quick reference resources.

## Troubleshooting checklist

Use this checklist as a stepwise process before and during troubleshooting:

1. Baseline health checks

    - Confirm VM integration services are up-to-date.
    - Ensure all hosts are fully patched and running supported Windows Server versions.
    - Confirm the VM is in a supported state for migration (for example, not in "Backing up" or "Stopping").

1. Cluster and host configuration

    - Check cluster node/host compatibility (CPU, BIOS/firmware versions, configuration versions).
    - Verify all cluster nodes are online, healthy, and visible in Failover Cluster Manager.
    - Validate VM configuration version consistency across hosts.

1. Network and storage

    - Confirm live migration, management, and storage networks are correctly configured and reachable.
    - Ensure the VM storage is accessible on the destination host.
    - Check firewall rules and port accessibility (for example, UDP 3343 for WSFC).

1. Authentication or permissions

    - Verify Kerberos or CredSSP is enabled and delegated properly for live migrations.
    - Ensure the required Service Principal Names (SPNs) are registered.
    - Confirm permission levels of migration accounts.

1. Virtual switches or networks

    - Ensure the required VM switches exist and are identically configured across hosts.
    - Validate network teaming (SET or LBFO) consistency.

1. VM-specific features

    - If using vTPM/Shielded VMs, confirm certificate requirements between hosts.
    - Check for snapshots/checkpoints—merge or delete as appropriate.

Here are common issues and their respective resolutions:

## Hardware or CPU incompatibility

- Error message:

  > The virtual machine uses processor-specific features not supported on the physical computer
- Event ID 21502

### Resolution

- In Hyper-V Manager, set the VM's processor settings. Enable **Migrate to a physical computer with a different processor version**.
- Ensure the target host supports the VM's CPU features.

> [!TIP]
> Always start VMs for the first time on the oldest (least capable) CPU host.

## VM configuration version mismatch

- Migration works one way but not in reverse (especially after moving to a newer OS).
- Error message:

  > Live migration or quick migration fails with compatibility issues.
- Event IDs 10698 and 21502

### Resolution

- Upgrade the VM configuration version when moving to a newer host (Hyper-V Manager: **Action** > **Upgrade VM Configuration Version**).

  > [!NOTE]
  > This action can't be rolled back. VMs with the upgraded version can't be migrated back to older hosts.

- Verify the configuration version with the `Get-VM * | select Name, Version` cmdlet.

## Network connectivity or configuration issues

- Live migration fails before/during the transfer.
- Migration fails with: "The client cannot connect to the destination specified in the request" or "WinRM protocol errors."
- Event IDs: 20406 and 280

### Resolution

- Ensure hosts can resolve and reach each other via hostname/IP (test with `ping`).
- Use `winrm quickconfig` to verify/configure WinRM on both hosts.
- Update TrustedHosts as needed: `Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<Host1>,<Host2>"`.
- Verify firewall allows the necessary ports (default SMB, WinRM, and clustering ports).
- Match network configurations (switch names/types, teaming) across hosts.

## Authentication or delegation issues

- Error code: "General access denied error (0x80070005)"
- Errors 0x8009030E and 0x8009030D (delegation/Kerberos/SPN issues)

### Resolution

- Enable Kerberos authentication: **Hyper-V Settings** > **Live Migrations** > **Advanced** > **Authentication protocol: Kerberos**.
- Configure constrained delegation in Active Directory (AD): **Computer Properties** > **Delegation** tab > **Trust this computer for delegation to specified services only** > **Add cifs and Microsoft Virtual System Migration Service**.
- Register missing SPNs: `setspn -s Microsoft Virtual System Migration Service/<FQDN> <ComputerName>`.
- Purge old Kerberos tickets: `KLIST PURGE -li 0x3e7`.

## Storage or shared disk issues

- Migration fails for VMs with shared VHDX/shared disks.
- Error: Shared disk missing in migration options.

### Resolution

- Shared virtual disks can only be used in clustered VM roles and can't be migrated using standard methods.
- Manually move and reattach shared disks at the destination where required.

## VTPM or shielded VM certificate issues

- Error: "The key protector for the virtual machine could not be unwrapped."
- Migration fails only for vTPM-protected VMs.

### Resolution

- Export shielding or key protector certificates from the source host and import them on the destination.
- Windows certificates snap-in (**certmgr.msc**) can be used.
- PowerShell cmdlets: `Export-PfxCertificate` and `Import-PfxCertificate`.

## State file or checkpoint issues

- Error message:
  
  > Cannot restore this virtual machine because the saved state data cannot be read. Delete the saved state data and then try to start the virtual machine. (0xC0370027)
- VMs are stuck in the "Backing up" state.

### Resolution

- In Hyper-V Manager: Select **VM** > **Delete Saved State**.
- Manually delete `.bin` and `.vsv` files from the VM folder if necessary.
- Remove or merge corrupted checkpoints.

## Cluster or migration limit issues

- Error message:
  
  > Virtual machine migration limit 1 was reached, please wait for completion of an ongoing migration operation.
- VMs enter the "Saved" state during a node drain or reboot.

### Resolution

- Increase Simultaneous Migrations: **Hyper-V Settings** > **Live Migrations** > **Simultaneous Migrations**.
- PowerShell cmdlet:

  ```powershell
  Set-VMHost -MaximumVirtualMachineMigrations N
  ```

- Always drain roles before rebooting with `Suspend-ClusterNode -Name <NodeName> -Drain`.

## Code defects or bugs

VMs are stuck in the "Stopping" state after migration; orphaned vports are reported in live dump analysis.

### Resolution

- Update to the latest Windows Server Cumulative Update.
- If an upgrade isn't possible, request Microsoft support for a hotfix if the bug is referenced.

## Data collection

Standard data collection checklist:

- Event logs: `Get-WinEvent -LogName "Microsoft-Windows-Hyper-V-VMMS/Admin"`.
- Cluster logs: `Get-ClusterLog -UseLocalTime -Destination <Path>`.
- Hyper-V migration logs: `Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Worker-Admin`.
- Network diagnostics: `Get-NetAdapter`, `ipconfig /all`, and ensure all network paths are up.
- Delegation and SPN checks: run `setspn -L <HostName>`, and check the **Delegation** tab in AD.
- VM and system configuration: `Get-VM * | select Name, Version`, `Get-VMSwitch`, and `Get-VMProcessor -VMName <VMName>`.
- WinRM configuration: `winrm quickconfig Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<Host1>,<Host2>"`.
- PowerShell to gather live migration traces: `TSS.ps1 -CollectLog SHA_support-all -noBasicLog -noUpdate -NewSession`.
- Snapshot or checkpoint chain: `Get-VHDChain -Path <PathToVHD>`.

## Common issue quick reference table

| Symptom or error | Possible root cause | Resolution summary |
| --- | --- | --- |
| "The VM uses processor-specific features not supported..." | CPU feature/BIOS/firmware mismatch | Enable migration compatibility; check the host CPU features and BIOS. |
| VM migration fails with a version error. | Configuration version mismatch | Upgrade the VM configuration version on the new host; can't migrate back to the old host. |
| "General access denied error (0x80070005)," 0x8009030E/0x8009030D | SPN/delegation/Kerberos misconfiguration | Configure constrained delegation, register SPNs, set Kerberos, and check AD. |
| "The server does not support WS-Management Identify operations..." | WinRM/proxy/trustedhosts misconfiguration | Set WinRM/trusted hosts, update hosts files, and bypass the proxy. |
| "Cannot restore this virtual machine because the saved state data..." | Corrupt checkpoints/saved state files | Delete the "Saved" state, remove/merge checkpoints, and manually delete .bin/.vsv files. |
| vTPM-enabled VM fails with "The key protector... could not be unwrapped." | Certificate/Shielded VM configuration | Export/import key protector certificates. |
| Migration fails—the shared disk isn't available in the migration wizard. | Unsupported scenario | Manually reattach disks; follow the shared disk migration documentation. |
| Live migration limit reached; VMs enter the "Saved" state in draining. | Low concurrency settings; improper drain | Raise the migration limit; drain roles before rebooting. |
| "No matching virtual switch found..." | Inconsistent network switch configuration | Ensure the identical virtual switch configuration on all hosts. |
| Live migration events show failures post-update. | Patch/Firmware/Speculation settings | Ensure all nodes are updated/patched; check speculation control settings. |
| VM backs up forever and can't move in/out of the "Backing up" state. | Backup software lock | Restart the backup service and VMMS service, or power on the VM to merge checkpoints. |

Ensuring successful Hyper-V live migrations requires diligent configuration management—including CPU, firmware, network, authentication, storage, and permissions—across all participating hosts. By following the troubleshooting checklist, addressing the known root causes as outlined in the resolution sections, and using targeted data collection, most migration failures can be swiftly resolved or appropriately escalated. Staying current with patches, standardizing cluster configurations, and understanding log outputs minimizes downtime and operational risk for mission-critical VM workloads.

## References

- WinRM and `TrustedHosts` configuration: [Installation and configuration for Windows Remote Management](/windows/win32/winrm/installation-and-configuration-for-windows-remote-management)
- Cluster Shared Volumes and migration limits: [Cluster Shared Volumes overview](/windows-server/failover-clustering/failover-cluster-csvs)
- SCVMM VMware-to-Hyper-V conversion: [Convert a VMware VM to Hyper-V in the VMM fabric](/system-center/vmm/vm-convert-vmware)

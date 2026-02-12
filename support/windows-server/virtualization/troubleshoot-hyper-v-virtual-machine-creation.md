---
title: Guidance for troubleshooting Hyper-V virtual machine creation
description: Provides steps, recommendations, and fixes to resolve problems in using VMs in Microsoft Hyper-V environments.
ms.date: 10/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Virtualization and Hyper-V\Virtual machine creation
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Hyper-V virtual machine creation troubleshooting guidance

## Summary

This article provides a comprehensive set of steps, recommendations, and fixes to help resolve problems in creating, importing, and starting virtual machines (VMs) in Microsoft Hyper-V environments. Hyper-V is a critical server role for virtualization, but it can fail because of file system, permissions, configuration, network, driver, licensing, and hardware issues. These issues can create service outages, data availability impacts, and failed disaster recovery scenarios. This article is designed to help administrators troubleshoot, collect relevant diagnostic information, and apply proven solutions for the most common failure modes.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting:

- Verify that VM and host OS are supported on the current Hyper-V version.
- Check for the latest Windows Server and Hyper-V updates and hotfixes.
- Verify VM configuration settings (generation, network, disk, resources).
- Review file system permissions and ownership on VM configuration folders.
- Make sure that Group Policy settings for Hyper-V and NT VM accounts and service are configured.
- Inspect the registry keys that are relevant to Hyper-V operation (especially for permission issues).
- Validate hardware settings in BIOS/UEFI (virtualization and execute disable features).
- Check for failed or stuck checkpoints and snapshots and orphaned AVHD files.
- Review VM disks and network adapters for misconfiguration or driver issues.
- Query event logs (Windows and Event Viewer) and VM logs for error details.
- Verify licensing compliance and edition entitlements.
- For clusters, run validation reports and examine cluster and infrastructure logs.
- Collect recent minidump files for system failures (blue screens).
- If you're using templates, verify template configuration for disk names, SIDs, and unique identifiers.
- Check for conflicts with backup, antivirus, or third-party drivers and software.

## Common issues and solutions

The following sections detail the most common failure modes and provide step-by-step solutions.

### File system and permission issues

#### Symptoms

- VM import fails, config files missing, "Permissions Denied" error.

#### Resolution

- Compare and correct NTFS permissions on the VM directory. Make sure that SYSTEM, Administrators, Hyper-V groups have full control.
- Set ownership to Administrators or SYSTEM, enable inheritance, and propagate permissions.
- Retry import/export operation.

### Registry Permission Errors

#### Symptoms

- Dynamic network address assignment fails, "No available MAC address", "ACCESS DENIED" events.

#### Resolution

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

- Export the following registry subkey from a working host:
   `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Worker`
- Import the subkey to the affected server, set vmwp.exe or SYSTEM account to Full Control.
- Use Registry Editor for permission changes, and test importing or starting the VM.

### Group Policy, cluster, and service account misconfiguration

#### Symptoms

- VM isn't created or doesn't start: "Logon failure: the user has not been granted the requested logon type."

#### Resolution

- In Group Policy Editor (gpedit.msc), make sure that "NT Virtual Machines" and cluster service accounts have the following privileges:
  - **Access this computer from the network**
  - **Create symbolic links**
  - **Log on as a service**
- Run `gpupdate /force`. Restart cluster nodes, if it's required.

### Virtual switch or network adapter issues

#### Symptoms

- VM has no network connectivity
- Virtual switch creation fails
- Network driver errors

#### Resolution

- Check and re-create virtual switch in Hyper-V Manager.
- Update all relevant network drivers (especially for third-party platforms).
- Use `Get-VMNetworkAdapter -VMName <VMName>` to review adapter status.

### Checkpoint and Snapshot Chain Errors

#### Symptoms 

- VM reverts to old snapshot after failure or maintenance.

#### Resolution

- Review VM storage for orphaned or missing .avhdx files.
- Merge or delete unused checkpoints through Hyper-V Manager.
- Avoid manual file moves or renames.

### Cluster and failover issues

#### Symptoms

- VMs exists in cluster manager but is missing in Hyper-V.
- Validation and report failures.

#### Resolution

- Refresh or synchronize cluster configuration.
- Resolve storage issues that are identified in the cluster validation report.
- Remove stale VM references from cluster manager.

### Hypervisor/BIOS/UEFI setting

#### Symptoms

- "Virtual machine could not start because the hypervisor is not running."

#### Resolution

- Enable virtualization (VT-x/AMD-V) and Execute Disable/NX in BIOS/UEFI.
- Run `bcdedit /set hypervisorlaunchtype auto`.
- Restart the host.

### OS, update, and software driver problems

#### Symptoms

- VMs fail after updates, stuck update service, system failures (blue screen)

#### Resolution

- Run `sfc /scannow` and `DISM /Online /Cleanup-Image /RestoreHealth`.
- Clear C:\Windows\SoftwareDistribution cache after stopping the update service.
- For blue screens, analyze minidump files by using BlueScreenView, and update problematic third-party drivers (for example, airlock and Crowdstrike).
- Reinstall the Hyper-V role, if it's necessary.

### Resource overcommitment

#### Symptoms

- Performance and availability issues.
- Users try to block CPU or memory overallocation.

#### Resolution

- Educate users that Hyper-V allows overcommitment by design.
- Use CPU groups or allocation controls for partial restriction.
- Monitor system health and resource usage proactively.

### Licensing Issues

#### Symptoms

- VM count exceeds license.
- Confusion over core or socket entitlements.

#### Resolution

- Standard: License all physical cores for up to two VMs per host.
- Datacenter: Unlimited VMs per host when fully licensed.
- Direct licensing questions to Microsoft sales or account team for scenario validation.

### Import/export failures from network shares

#### Symptoms

- "Hyper-V did not find virtual machines to import from location...permission errors."

#### Resolution

- Copy export folder locally to core server, and use direct PowerShell import:

  ```powershell
  Import-VM -Path <VMPath> -Copy -GenerateNewId -VhdDestinationPath <CSVLocation> -VirtualMachinePath <ConfigPath>
  ```

### Template and disk naming conflicts

#### Symptoms

- New VMs share disk names. This condition causes confusion in bulk deployments.

#### Resolution

- Use post-deployment commands to rename disks without shutting down the VM, or adjust template settings to allow unique disk naming.

### Blue screen when modifying the VM page file or creating a VM

#### Symptoms

- System fails after you move a page file or during VM creation, especially on Windows 11.

#### Resolution

- Set the memory dump file to "complete," collect a minidump file after a failure, analyze using BlueScreenView.
- Update all third-party drivers that are associated with storage or paging.

### Unsupported OS/VM generation mismatches

#### Symptoms

- Can't start a new VM.
- VM fails after conversion or installation.

#### Resolution

- Make sure that the guest OS is supported on the host (for example, Windows Server 2025 on Hyper-V 2022, not 2019).
- Use a tool to convert the disk between Gen1 and Gen2. Verify that the disk partition type matches the VM generation.

## Common issues quick reference table

| Symptom | Error message or event ID | Root cause | Solution | Tool or log |
| --- | --- | --- | --- | --- |
| Import/Export Fails, Permissions Denied | "Could not locate VM config," "Permission Denied" | Directory/ownership issue | Fix NTFS, set ownership/inheritance, add groups | File system, Procmon |
| Dynamic MAC/Network Assign Fails | "No available MAC," "ACCESS DENIED" | Registry permission | Grant vmwp.exe full control, import working reg key | Registry Editor |
| VM Fails to Start, Logon Failure | `0x80070569` | GPO/group policy misconfig | Set rights in GPO, `gpupdate/force`, restart nodes | gpedit.msc |
| VM Can't Start, Hypervisor Not Running | "Hypervisor not running" | BIOS/UEFI not set | Enable VT-x/NX/XD, check BIOS, run `bcdedit `command | BIOS, bcdedit |
| VM Reverts to Old Checkpoint after Maintenance | n/a | Orphaned .avhdx files | Merge/delete old checkpoints, clean up chain | Hyper-V Manager |
| Cluster, Failover Issues | "Validation failed," missing VMs | Storage/service misconfig | Cluster validation, fix storage, refresh/sync cluster config | FCM, validation logs |
| Network/Switch Setup Problems | No connectivity, adapter install fails | Driver/switch misconfig | Update network drivers, recreate switches, use Get-VMNetworkAdapter | Hyper-V, PowerShell |
| VM Creation Crashes/BSOD | BSOD, MiniDump generated | Faulty third-party driver | Analyze dump, update driver, full memory dump | BlueScreenView |
| VM Disks Named Identically from Template | n/a | Template naming convention | Post-deploy disk rename, template change | PowerShell, Hyper-V |
| Licensing/Resource Restrictions | License exceeded, core/socket doubts | Misunderstood licensing | License all cores, check edition, refer to sales/account team | N/A |
| Import via Network Share Fails | "Location not found," perms error | Path/resolution or perms issue | Local copy, use direct PowerShell import | PowerShell |
| OS/Gen Conversion/Install Fails | VM start fails, disk not recognized | Unsupported config | Verify OS support, correct VM generation, disk partition type | Hyper-V, conversion |
| Page file move blue screen | Blue screen after changing page file location | Driver conflict | Analyze minidump, update storage driver | BlueScreenView |

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue.

- **System and storage event logs** (eventvwr.msc, filter for disk/storage-related IDs)
- **MPIO configuration and status:**

  ```console
  mpclaim -s -d
  mpclaim -v
  ```

- **Hardware/driver/firmware version info**
- **Device Manager screenshots (all storage and DSMs)**
- **Perfmon or Storport traces**:

  ```console
  logman create counter PerfLog -o C:\PerfLog.blg -f bincirc ...
  logman create trace storport -ow -o <output path> -p <provider>
  ```

- **Cluster logs:** `Get-ClusterLog -Node \<NodeName> -TimeSpan 3`
- **DiskPart:**

  ```console
  diskpart
  list disk
  list volume
  san
  ```

- **TSS or WPR logs** for IO, storage, failover, VSS issues
- **Vendor log collection tool, as advised**

## References

- [Best Practices Analyzer for Hyper-V](/windows-server/virtualization/hyper-v/best-practices-analyzer/best-practices-analyzer-for-hyper-v)
- [Export and import virtual machines](/windows-server/virtualization/hyper-v/deploy/export-and-import-virtual-machines)
- [Comparison of Windows Server editions](/windows-server/get-started/editions-comparison)
- [Validate hardware for a failover cluster](../high-availability/validate-hardware-failover-cluster.md)
- [BlueScreenView tool](https://www.nirsoft.net/utils/blue_screen_view.html)

**Third-party contact disclaimer**

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.

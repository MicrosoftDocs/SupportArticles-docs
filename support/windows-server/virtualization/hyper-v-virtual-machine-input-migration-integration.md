---
title: Troubleshoot Hyper-V Virtual Machine Input, Migration, and Device Integration Issues
description: Provides a comprehensive guide to troubleshoot common issues encountered with Hyper-V virtual machines (VMs).
ms.date: 08/18/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhuge, v-lianna
ms.custom:
- sap:virtualization and hyper-v\integration components
- pcy:WinComm Storage High Avail
---
# Troubleshoot Hyper-V virtual machine input, migration, and device integration issues

This article provides a comprehensive guide to troubleshoot common issues encountered with Hyper-V virtual machines (VMs). It focuses on resolving problems related to device integration (such as mouse, keyboard, graphics processing unit (GPU), or USB), migration, and enhanced session mode. These issues might arise following platform upgrades, changes in cluster configurations, or migrations from other hypervisors, like VMware. Addressing these problems is critical to maintaining VM usability, ensuring network connectivity, and supporting business operations.

## End-user symptoms

- Mouse movements appear inverted vertically in Linux guest VMs after upgrading to Windows 11.
- Mouse and keyboard become unresponsive in Windows 11 VMs when using Enhanced Session Mode.
- Failure to perform live migration of VMs with Trusted Platform Module (TPM) enabled.
- VMs assigned to virtual local area networks (VLANs) lose network connectivity.
- Inability to connect USB devices or GPU cards to VMs after migration from VMware.
- VMs experience frequent, random reboots or unexpected connectivity loss to business applications.

## Technical/system symptoms

- Error messages or event IDs:

  - > Failed to remove checkpoint. (Virtual machine ID …)
  - > Virtual machine failed to generate VHD tree: Catastrophic failure (0x8000FFFF)
  - > Cannot delete checkpoint: Catastrophic failure (0x8000FFFF)
  - > The system cannot find the file specified.
  - Event ID 1069 (Failover Clustering): Cluster resource failure.
  - Event ID 41 (Kernel-Power): System rebooted without a clean shutdown.
  - Event ID 18502 (Hyper-V-Worker): VM was turned off.
  - Event ID 3056 (Hyper-V-Worker): NUMA topology mismatch warning.
  - Event ID 1106 (Hyper-V VMMS): Access violation (c0000005) during live migration.
  - Reliability Monitor shows repeated System Center Virtual Machine Manager (SCVMM) agent crashes.

- Inability to uninstall VMware Tools after migration to Hyper-V.
- VMs hang or become unresponsive, with high CPU usage by services like Windows Management Instrumentation (WMI) or Local Security Authority Subsystem Service (LSASS).
- Hyper-V Manager displays orphaned checkpoints that block backups.

## Cause 1: Input and device integration failures

- Operating system (OS) or hypervisor compatibility: Upgrading the host OS (for example, to Windows 11, version 24H2) might introduce changes in Hyper-V integration services, leading to input inversion or loss, especially in non-Windows guest VMs.
- Enhanced Session Mode: Protocol or driver issues might disrupt input device functionality within Enhanced Session Mode on Windows 11 VMs.
- Migration from VMware: Incomplete or incompatible removal of VMware Tools or differences in device passthrough (for example, USB or GPU) between VMware and Hyper-V might cause connectivity and performance problems.

### Resolution: Input and device integration issues

#### Mouse or keyboard issues in guest VMs

For inverted mouse input in Linux guest VMs on Windows 11, version 24H2, revert the host OS to Windows 11, version 23H2 until a permanent fix is available.

To resolve Enhanced Session Mode input loss in Windows 11 VMs, follow these steps:

1. Open **Hyper-V Manager**.
2. Navigate to **Hyper-V Settings** > **Enhanced Session Mode Policy**.
3. Uncheck **Allow enhanced session mode** to disable the feature.
4. Test input functionality in standard session mode.

#### USB or GPU passthrough after VMware migration

- USB devices:

  - Use Remote Desktop USB redirection or Enhanced Session Mode for supported OSs.
  - Alternatively, configure a network USB solution as Hyper-V doesn't natively support direct USB passthrough.

- GPU assignment:

  - Follow guidance from [Deploying graphics devices using Discrete Device Assignment (DDA)](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda#configure-the-vm-for-dda).
  - Confirm hardware, drivers, and VM configuration support for DDA.

#### Uninstalling VMware tools

Use PowerShell scripts, like **Uninstall-VMwareTools.ps1** from GitHub, to forcibly remove VMware tools and associated services after migration.

## Cause 2: Migration and cluster failures

- TPM/shielded VM certificate misconfiguration: Missing or improperly transferred shielding certificates can prevent live migration for TPM-enabled VMs.
- VLAN/network configuration: Physical switch port misconfigurations or legacy network teaming setups might isolate VMs after VLAN assignment.
- VM configuration version: Outdated VM configuration versions might be incompatible with newer Hyper-V hosts, leading to migration failures.
- Heartbeat integration: High CPU usage, resource exhaustion, or application hangs within VMs might trigger cluster heartbeat failures, resulting in forced restarts.

### Resolution: Migration and cluster issues

#### TPM/shielded VM migration failures

1. On the source node, list shielded VM certificates by using the following command:

    ```console
    bashcertutil -store "Shielded VM Local Certificates"
    ```

2. Export encryption and signing certificates by using the following commands:

    ```console
    certutil -exportPFX -p <password> "Shielded VM Local Certificates" <SerialNumber> c:\cert-VMEncryption.pfx
    certutil -exportPFX -p <password> "Shielded VM Local Certificates" <SerialNumber> c:\cert-VMSigning.pfx
    ```

3. Import certificates on the target node by using the following command:

    ```console
    bashcertutil -importPFX "Shielded VM Local Certificates" c:\cert-VMEncryption.pfxcertutil -importPFX "Shielded VM Local Certificates" c:\cert-VMSigning.pfx
    ```

#### VLAN/network connectivity

- Configure physical switch ports as trunk ports to allow all VLANs.
- Replace legacy LBFO (Load Balancing and Failover) teams with Switch Embedded Teaming (SET) for physical NICs.
- Assign VLAN IDs and verify connectivity for each physical interface.

#### VM configuration version

Update the VM configuration by using the following cmdlet:

```powershell
Update-VMVersion -Name <VMName>
```

After the updating, test live migration. If issues persist, shut down the VM, perform a quick migration, and then restart.

#### Cluster/heartbeat-related reboots

If VMs are rebooted due to heartbeat failures, follow these steps:

1. Disable the Heartbeat Integration Service for affected VMs:
    1. Go to **VM settings > Integration Services**.
    2. Uncheck **Heartbeat**.
2. Monitor VM stability. If high CPU usage (for example, by WMI or LSASS) is detected, investigate resource usage.
3. Collect memory dumps for analysis by using the following command:

    ```console
    -Name -InjectNonMaskableInterrupt -Force
    ```

## Cause 3: File system and storage issues

- Orphaned checkpoints: Incomplete merge operations can leave behind phantom checkpoint files, blocking backups or checkpoint deletions.
- File system corruption: Issues with storage or the file system might disrupt checkpoint removal or VHD chain updates.

### Resolution: File system, storage, and checkpoint failures

#### Orphaned/phantom checkpoints

1. Create a new checkpoint for the affected VM.
2. Export the latest checkpoint to a safe location.
3. Delete the VM from Hyper-V Manager.
4. Import the VM back into Hyper-V using the restore option. For clusters, remove the VM from the cluster, recreate it with the same configuration, attach the existing VHD/VHDX, and add it back to the cluster.
5. Inspect checkpoints using PowerShell:

    ```powershell
    Get-VM -Name <VMName> | Get-VMSnapshot
    Get-VHDChain -Path <path-to-vhdx>
    ```

6. Use tools like Process Monitor (procmon) to trace file access and verify system integrity.

## Cause 4: Application-level and third-party integration

Monitoring/agent crashes: Third-party monitoring or agent software (such as SCVMM or Zenoss) might fail due to changes in Hyper-V or Windows Server. These failures often occur without a direct impact unless associated with failed operations.

### Resolution: Application-level and third-party integration issues

If monitoring or agent integration fails:

- Verify WMI and WINRM configurations on hosts.
- Review application logs for authentication errors, such as GSS challenge failures.
- If Hyper-V and WMI are functional, escalate to the third-party vendor for further support.

## General remediation and prevention

- Apply the latest Windows updates and cluster patches.
- Regularly monitor storage infrastructure to prevent file system corruption.
- Maintain up-to-date documentation of VM configurations, certificates, and network settings.
- For security vulnerabilities, ensure correct revocation policies and registry settings by using the following command:

  ```console
  bashSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name EnableVirtualizationBasedSecurity -Value 0 -Type DWordRestart-Computer
  ```

## Data collection

To collect logs and information:

- Cluster and event logs: Gather TSS logs, Performance Monitor data, and Event Viewer logs (Hyper-V-VMMS, Hyper-V-Worker, System, Application).
- VM configuration:

    ```powershell
    Update-VMVersion -Name <VMName>
    ```

- Snapshot/checkpoint inspection:

    ```powershell
    Get-VM -Name <VMName> | Get-VMSnapshot
    Get-VHDChain -Path <path-to-vhdx>
    ```

- Certificate management:

    ```console
    certutil -store "Shielded VM Local Certificates"
    certutil -exportPFX ...
    certutil -importPFX ...
    ```

- Memory dump collection:

    ```powershell
    Debug-VM -Name <VMName> -InjectNonMaskableInterrupt -Force
    ```

- Process/file system monitoring: Use Process Monitor (procmon) to track errors.

## References

- [Deploying graphics devices using DDA](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda#configure-the-vm-for-dda)
- Check Microsoft advisories for relevant updates and patches.

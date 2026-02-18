---
title: Hyper-V Nested Virtualization Troubleshooting Guide
description: Provides a structured approach for troubleshooting nested virtualization issues in physical and cloud-based environments.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom:
- sap:clustering and high availability\nested virtualization
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshooting guide: Hyper-V nested virtualization

Nested virtualization allows you to run Hyper-V (or other hypervisors) within a virtual machine, enabling powerful development, testing, and learning scenarios where you need virtual machines inside other VMs. This is typically available in Windows Server 2016 or later versions, Windows 10 or Windows 11 Pro and Enterprise (with Hyper-V), and supported Azure virtual machine series. Nested virtualization introduces complexity—networking, memory, CPU compatibility, host/guest configuration, and performance often require careful consideration. This guide provides a structured approach for troubleshooting nested virtualization issues in physical and cloud-based environments.

## Troubleshooting checklist

Before diving into specific issues, follow this checklist to ensure the environment is correctly set up for nested virtualization:

1. Verify host compatibility:

    - Host is Windows Server 2016 or later version, Windows 10 or Windows 11 Pro or Enterprise.
    - Host CPU supports VT-x (Intel) or AMD-V (AMD); hardware virtualization enabled in BIOS/UEFI.

1. Confirm guest VM settings:

    - Guest VM is Generation 2.
    - Guest VM running compatible OS (Windows Server 2016, or later version, Windows 10, Windows 11, or later version, select Linux with Hyper-V support).

1. Enable nested virtualization:

    - For Hyper-V, set via PowerShell:

      ```powershell
      Set-VMProcessor -VMName "<VMName>" -ExposeVirtualizationExtensions $true
      ```

    - VM must be powered off.

1. CPU, memory, and resource allocation:

    - Assign at least two virtual CPUs to nested VM.
    - Sufficient memory assigned (recommended ≥ 4GB for the VM hosting nested VMs).

1. Network configuration:

    - Use an "External" virtual switch for the guest VM to enable outbound access.
    - Ensure NAT/port forwarding is correctly set up if needed.

1. Update host and guest:

    - Fully patch and update Windows OS for host and guest.
    - Use the latest Hyper-V Integration Services and drivers.

1. Check security and policy:

    - Credential Guard and Device Guard might block nested virtualization.
    - No conflicting Group Policies or anti-virus blocking Hyper-V processes.

Here are common issues and their respective solutions:

## Nested VM can't start Hyper-V role or install other hypervisors

- Errors when enabling or installing Hyper-V in a VM.
- "Hyper-V cannot be installed: The processor does not have required virtualization capabilities" or similar error messages.
- Role installation fails without detailed errors.

### Root causes

- Virtualization extensions not exposed to the guest VM.
- Guest VM isn't Generation 2 or running unsupported OS/version.
- Insufficient resources assigned.

### Resolution

1. Power off the guest VM.
2. Run PowerShell on host:

    ```powershell
    Set-VMProcessor -VMName "<VMName>" -ExposeVirtualizationExtensions $true
    ```

3. Confirm guest VM is Generation 2 (**Hyper-V Manager** > **VM properties**).
4. Ensure at least two virtual CPUs and ≥4GB RAM allocated.
5. Reboot and retry enabling the Hyper-V role in the guest.

## Network connectivity issues in nested VMs

- Nested VM can't access external network.
- Only internal connectivity works (Host <-> Guest), not Host <-> Physical LAN <-> Nested VM.
- Unreachable IP, failed ping, or application connectivity.

### Root causes

- Virtual switch configured as "Internal" or "Private."
- NAT wrong configuration; port forwarding not set.
- Windows Firewall or security software blocking traffic.

### Resolution

1. In Hyper-V Manager, create or select an "External" virtual switch.
2. Assign the external switch to the nested VM's network adapter.
3. If using NAT with multiple guests, set up port forwarding:

    ```console
    netsh int portproxy add v4tov4 listenaddress=<host IP> listenport=<port> connectaddress=<nested VM IP> connectport=<port>
    ```

4. Check Windows Firewall and disable or create rules to allow traffic.
5. Restart VMs if network configuration changes.

## Performance degradation in nested virtualization

- Nested VM is slow, lags, or fails to install operating systems and roles.
- Disk and network I/O bottlenecks.
- High resource usage on host.

### Root causes

- Under-provisioned resources—CPU, RAM, disk.
- Overcommitted host resources.
- Outdated host/hypervisor drivers.
- Bandwidth limitations due to virtual switch configuration.

### Resolution

1. Increase guest VM vCPUs (minimum 2; recommended ≥4 for heavy workloads).
2. Assign sufficient RAM (recommended ≥4GB for guest; ≥8GB for host).
3. Use fixed size VHDs instead of dynamically expanding for better performance.
4. Ensure SSD-based storage for host and guest disks.
5. Update host and guest integration services and drivers.
6. Avoid running resource-intensive applications in other host VMs.

## Nested Hyper-V installation or operation blocked by security policies

- Hyper-V role installation blocked.
- Errors referencing "Credential Guard" or "Device Guard."
- "Virtualization-based security is enabled. Nested virtualization is not supported."

### Root causes

- VBS, Credential Guard, Device Guard active in host or guest.
- Group Policies or registry settings prevent virtualization extensions.

### Resolution

1. Disable Credential Guard/Device Guard in host and guest.

    - Use Group Policy Editor (**gpedit.msc**) > **Computer Configuration** > **Administrative Templates** > **System** > **Device Guard**.
1. If controlled by registry:

    ```console
    reg delete HKLM\System\CurrentControlSet\Control\DeviceGuard /v EnableVirtualizationBasedSecurity /f
    reg delete HKLM\System\CurrentControlSet\Control\DeviceGuard /v RequirePlatformSecurityFeatures /f
    ```

1. Reboot the VM.
1. Verify with **Msinfo32.exe** that VBS is "Not enabled".

## NAT and port forwarding issues

- Unable to reach nested VMs from external networks.
- "Process cannot access the file because it is being used by another process" when starting NAT driver.
- WinNAT service fails to start.

### Root causes

- Incorrect static mapping of ports.
- Conflicting NAT configuration.
- WinNAT file lock.

### Resolution

1. Remove incorrect NAT configurations:

    ```console
    netsh nat delete <incorrect mapping>
    ```

2. Restart host, and ensure NAT/WinNAT service isn't locked.
3. Reconfigure NAT/port proxy for required connectivity:

    ```console
    netsh int portproxy add v4tov4 listenaddress=<host IP> listenport=<port> connectaddress=<nested VM IP> connectport=<port>
    ```

4. Test connectivity from external host using ping and application ports.

## Snapshot/Checkpoint and differencing disk issues

- Snapshots disappear or can't be merged.
- Merge operation fails with "The system cannot find the file specified (0x80070002)" or "The chain of virtual hard disks is broken (0xC03A000D)."

### Root causes

- Parent VHD file moved or deleted.
- Hardware failure.
- Broken differencing disk chain.

### Resolution

1. Ensure all VHD/AVHDX files are in their original locations.
2. Use PowerShell to check chain and merge:

    ```powershell
    Get-VHD -Path <AVHDX path> | fl \*
    Merge-VHD -Path <child AVHDX> -DestinationPath <parent VHD>
    ```

3. If data recovery is needed, restore the parent disk from backup, and then retry the merge.

## VM resource changes not recognized (for example, RAM increase)

- VM doesn't detect increased RAM after configuration.
- No error, but resource remains at previous allocation.

### Root causes

- Configuration not applied/committed while VM was off.
- Platform limitations (nested, cluster, or hot-add not supported).

### Resolution

1. Power off VM before resizing resources.
2. Use **Hyper-V Manager** > **Edit VM settings** > **Increase RAM**.
3. Start VM and verify resource allocation in guest OS.
4. Review documentation for hot-add support in nested scenarios.

## Data collection

Gather the following data for troubleshooting and escalation:

- System information:

  - Host and guest OS versions, build numbers.
  - CPU type, RAM configuration.
- Virtual machine configuration:

  - Hyper-V Manager details (generation, CPUs, RAM, disks).
  - Virtual switch/network setup.
- Event logs:

  - Hyper-V logs: VMMS, Worker logs, System, Application.
  - Cluster logs if in a failover setup.
- PowerShell output:

    ```powershell
    Get-VM -Name <VMName> | fl \*
    Get-VMProcessor -VMName <VMName>
    Get-VHD -Path <AVHDX path> | fl \*
    ```

- Network traces:

    ```console
    netsh trace start capture=yes scenario=Virtualization,NetConnection tracefile=<path>
    netsh trace start capture=yes scenario=NetConnection level=5 maxsize=1024 tracefile=<path>
    ```

- Screenshots/Error messages:

    Installation errors, role addition failure messages, device manager status.
- Procmon trace (for install/role activation issues).
- MiniDump files (if host or VM crashes).

## Common issues quick reference table

| Issue | Symptoms/Errors | Root cause | Resolution steps |
| --- | --- | --- | --- |
| Nested VM can't start Hyper-V | Role installation fails; CPU extension error | Extensions not exposed; Gen1 VM | Power off VM; `Set-VMProcessor -ExposeVirtualizationExtensions $true`; use Gen2 VM; assign ≥2 vCPUs. |
| Network connectivity issues | No internet/LAN in nested VM | Internal switch/NAT misconfiguration | Use external switch; correct NAT configuration; allow firewall rules. |
| Slow performance | Lag; high resource usage | Under-provisioned resources | Increase vCPUs/RAM; use SSDs; update drivers. |
| Role or Hyper-V installation blocked by security | Policy or VBS/Credential Guard errors | Device/Credential Guard enabled | Disable VBS/Credential Guard; reboot. |
| NAT/port forwarding fails | Can't connect to nested VM; WinNAT errors | Wrong mapping/service lock | Remove/re-add NAT configuration; restart host; `netsh` `portproxy` commands. |
| Snapshot/disk chain broken | Merge fails; file not found; broken chain errors | Parent disk moved/deleted | Restore parent VHD; `Get-VHD`/`Merge-VHD` PowerShell cmdlets. |
| VM doesn't recognize increased RAM | No error; allocation unchanged | Setting not saved/applied, platform | Power off VM; edit settings; start VM; check host/cluster/nested support. |

Nested virtualization is a powerful but complex feature that often encounters resource, networking, configuration, and security challenges. Troubleshooting starts with verifying correct setup and continues by addressing common failure modes including role install problems, networking misconfiguration, storage chain errors, and blocked installations due to security policies. Careful data collection, step-by-step diagnosis, and understanding of platform limitations are essential for stable operation. For persistent issues or unsupported scenarios, engaging with platform support or escalation might be required.

## References

- [What is Nested Virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization)
- [Set-VMProcessor](/powershell/module/hyper-v/set-vmprocessor)

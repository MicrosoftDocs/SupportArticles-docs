---
title: Troubleshoot Linux Virtual Machine Issues on Hyper-V
description: Provides a comprehensive guide to diagnosing and resolving common issues encountered when deploying and managing Linux VMs in Microsoft Hyper-V environments.
ms.date: 08/05/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\integration components
- pcy:WinComm Storage High Avail
---
# Troubleshoot Linux virtual machine issues on Hyper-V

This article provides a comprehensive guide to diagnosing and resolving common issues in deploying and managing Linux virtual machines (VMs) in Microsoft Hyper-V environments.

These issues might include installation challenges, live migration failures, time synchronization problems, missing VM information in management consoles, central processing unit (CPU) compatibility discrepancies, and licensing or support inquiries. Resolving these issues is critical to ensuring the reliability, compatibility, and optimal performance of Linux workloads in Hyper-V infrastructures.

## Common issues observed in Linux VMs on Hyper-V

- VM installation and boot issues:

  - Installations of a Linux operating system (OS), such as SUSE Linux Enterprise Server (SLES) 15 SP5, stall or fail on Generation 2 VMs but succeed on Generation 1 VMs.
  - Installation menus appear, but the process fails to complete.

- Live migration and VM state errors:

  - Specific Ubuntu-based or vendor-supplied Linux VMs fail to migrate, with errors occurring between 58% and 68% completion.
  - Error message: "Cannot restore this virtual machine because the saved state data can't be read. Delete the saved state data and then try to start the virtual machine. (0xC0370027)."
  - Event ID 21502 in Hyper-V logs.
  - Additional error codes 0x80048054 and 0x80070037.

- Management console and integration data issues:

  - Linux VM IP addresses and hostnames aren't visible in Hyper-V Manager, System Center Virtual Machine Manager (SCVMM), or other management consoles.
  - Integration services are installed and configured, but the data is still missing.

- Time synchronization issues:

  - Linux VM system time doesn't synchronize with the Hyper-V host.
  - Time zone inconsistencies are observed on the VM's real-time clock (RTC), causing application time drift.

- CPU feature/instruction set issues:

  - Missing CPU flags, such as `sse4_2`, inside Linux VMs (`cat /proc/cpuinfo`).
  - Applications or tools fail due to missing CPU instructions.

- Frequent VM disconnections:

  - Linux VMs, especially those based on Red Hat Enterprise Linux (RHEL), frequently disconnect from the Hyper-V console.
  - Error messages appear when connecting via Hyper-V Manager.

- Licensing, support, and feature inquiries:

  - Questions about licensing non-Windows operating systems on Windows Server Standard/Datacenter.
  - Inquiries about support for legacy Linux versions or Oracle Database workloads.
  - Questions regarding Windows Subsystem for Linux 2 (WSL2) support and nested virtualization requirements.

## Root causes categorized by issue type

- Configuration and compatibility:

  - Generation 2 VM incompatibility: Certain Linux distributions require specific Generation 2 Hyper-V settings, such as Secure Boot or UEFI, for successful installation.
  - Unsupported Linux versions: Earlier or unlisted Linux versions might not work with Hyper-V integration components, leading to data loss or operational failures.
  - Licensing and support gaps: Documentation might not cover all scenarios for OS/distribution/version compatibility.

- Integration services and VM data reporting:

  - Missing or misconfigured integration services: Without proper configuration, Linux integration services might fail to report data like IP addresses and hostnames.
  - Console/SCVMM synchronization issues: Synchronization delays or database errors might prevent updated VM data from being displayed.

- File/state corruption and migration failures:

  - Corrupted VMRS files: Migration issues might arise if VM saved state or runtime files are corrupted.
  - File permission problems: Insufficient permissions or locked files related to the VM can block migration or restoration.

- Guest OS settings and platform differences:

  - RTC and time zone handling: Hyper-V provides the system time to the guest RTC without time zone metadata; the guest OS settings determine the interpretation.
  - CPU compatibility mode: Enabling this mode restricts available CPU instructions for the guest, causing feature gaps.

- External or unsupported scenarios:

  - Application/OS-specific issues: Problems within guest OS or applications, like Oracle Database, require vendor support.
  - Feature or environment limitations: Advanced features, such as nested virtualization and WSL2, need specific VM configurations or hardware.

## Resolve VM installation issues (Generation 2 Linux VMs)

1. Review the VM configuration:

    - Disable Secure Boot or set it to use the correct template (for example, `MicrosoftUEFICertificateAuthority` for supported Linux distributions).
    - Ensure the VM generation matches the Linux distribution's requirements.

2. Adjust VM settings:

    - Set the firmware to boot from the correct device (DVD or ISO).
    - Remove unnecessary hardware, such as legacy network adapters.

3. Retry the OS installation after making the necessary changes.
4. If issues persist, install the OS on a Generation 1 VM.

## Resolve live migration and state file errors

1. Check event logs and error codes. Review Hyper-V logs for Event ID 21502 and error codes such as 0xC0370027, 0x80048054, or 0x80070037.
2. Inspect VM state files. Ensure `.vmrs` and `.vmcx` files are accessible on both the source and destination nodes.
3. Create a new VM:

    1. Shut down the affected VM.
    2. Create a new VM and attach the original OS/data disks. Match the CPU and RAM settings to the original configuration.

4. Test migration. Perform a live migration with the new VM.
5. Monitor for recurrence. If the issue is resolved, continue monitoring the VM. If the issue persists, escalate for further disk or file system investigation.

## Resolve management console and integration data issues

1. Verify integration services:

    - Use the `lsmod | grep hv` command in the guest OS to confirm that Hyper-V modules are loaded.
    - Ensure the latest Linux integration services are installed.

2. Enable data exchange. In the VM settings, ensure "Data Exchange" is enabled under integration services.
3. Update the management console. Apply the latest updates to Hyper-V, SCVMM, or other management platforms.
4. Correct the SCVMM database (if needed):

    1. Back up the SCVMM database.
    2. Use SQL queries to update missing VM names or IP addresses.

## Resolve time synchronization issues

1. Update integration services. Ensure the guest OS has the latest Linux integration services installed.
2. Verify time synchronization settings. In Hyper-V Manager, ensure "Time Synchronization" is enabled.
3. Adjust guest OS settings. Use `timedatectl` to configure the system clock and time zone correctly. For example, `timedatectl set-timezone UTC`.
4. Delay application startup. For time-sensitive applications, delay startup until synchronization completes.

## Resolve CPU feature/instruction set issues

1. Disable CPU compatibility mode in Hyper-V Manager or via PowerShell:

    ```powershell
    Set-VMProcessor -VMName -CompatibilityForMigrationEnabled $false
    ```

2. Validate in the guest OS. Run `cat /proc/cpuinfo` to confirm that the required CPU flags are present.
3. Restart the VM to apply the changes.

## Resolve frequent VM disconnections

1. Check network and VM health. Verify that network adapters are correctly configured and functioning.
2. Review VM cloning practices. Ensure unique MAC addresses and proper cleanup after cloning.
3. Adjust Secure Boot settings. Enable or disable Secure Boot as required by the Linux distribution.
4. Contact Linux vendor support. Escalate issues that persist to the Linux distribution vendor.

## Resolve licensing, support, and feature inquiries

- Licensing questions: Consult Microsoft licensing specialists for queries about licensing non-Windows operating systems on Windows Server.
- Legacy OS or unsupported features: Refer to the relevant vendor for support on legacy Linux versions, Oracle Database, or WSL2.
- Nested virtualization: Confirm that your VM size or hardware supports nested virtualization.

## Data collection

To help with troubleshooting, gather the following logs and information:

- VML traces (for live migration):

    ```console
    VmlTrace.exe /m a /f all all
    VmlTrace.exe stop
    ```

- NetSH network trace:

    ```console
    netsh trace start capture=yes tracefile=network-trace.etl overwrite=yes persistent=yes
    netsh trace stop
    ```

- Integration services check:

    ```powershell
    Get-VMIntegrationService -VMName
    ```

- CPU validation:

    ```console
    cat /proc/cpuinfo
    ```

- Time settings (Linux):

    ```console
    timedatectl status
    timedatectl set-timezone
    ```

## References

- [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](/windows-server/virtualization/hyper-v/supported-centos-and-red-hat-enterprise-linux-virtual-machines-on-hyper-v)
- [Supported Debian virtual machines on Hyper-V](/windows-server/virtualization/hyper-v/supported-debian-virtual-machines-on-hyper-v)

If issues persist after following these steps, collect the relevant logs and contact Microsoft Support or your Linux distribution vendor for further assistance.

---
title: Troubleshoot Linux Virtual Machine Issues on Hyper-V
description: Provides a comprehensive guide to diagnosing and resolving common issues encountered when deploying and managing Linux virtual machines (VMs) on Microsoft Hyper-V environments.
ms.date: 08/05/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\integration components
- pcy:WinComm Storage High Avail
---
# Troubleshooting Linux Virtual Machine Issues on Hyper-V

This article provides a comprehensive guide to diagnosing and resolving common issues encountered when deploying and managing Linux virtual machines (VMs) on Microsoft Hyper-V environments. These issues may include installation challenges, live migration failures, time synchronization problems, missing VM information in management consoles, CPU compatibility discrepancies, and licensing or support inquiries. Resolving these problems is critical for ensuring reliability, compatibility, and optimal performance of Linux workloads in Hyper-V infrastructures.

## Symptoms

### Common issues observed in Linux VMs on Hyper-V

- **VM installation and boot issues**:    - Linux OS installations, such as SUSE Linux Enterprise Server (SLES) 15 SP5, stall or fail on Generation 2 VMs but succeed on Generation 1.
    - Installation menus appear, but the process cannot complete.
- **Live migration and VM state errors**:    - Specific Ubuntu-based or vendor-supplied Linux VMs fail to migrate, with errors occurring at 58–68% completion.
    - Error message: "Cannot restore this virtual machine because the saved state data cannot be read. Delete the saved state data and then try to start the virtual machine. (0xC0370027)."
    - Event ID: **21502** in Hyper-V logs.
    - Additional error codes: **0x80048054** and **0x80070037**.
- **Management console and integration data issues**:    - Linux VM IP addresses and hostnames are not visible in Hyper-V Manager, System Center Virtual Machine Manager (SCVMM), or other management consoles.
    - Integration Services are installed and configured, but data remains missing.
- **Time synchronization issues**:    - Linux VM system time does not sync with the Hyper-V host.
    - Time zone inconsistencies are observed on the VM’s real-time clock (RTC), causing application time drift.
- **CPU feature/instruction set issues**:    - Missing CPU flags, such as sse4_2, inside Linux VMs (cat /proc/cpuinfo).
    - Applications or tools fail due to missing CPU instructions.
- **Frequent VM disconnects**:    - Linux VMs, especially Red Hat Enterprise Linux (RHEL)-based, frequently disconnect from the Hyper-V console.
    - Error messages appear when connecting via Hyper-V Manager.
- **Licensing, support, and feature inquiries**:    - Questions about licensing non-Windows operating systems on Windows Server Standard/Datacenter.
    - Inquiries about support for legacy Linux versions or Oracle Database workloads.
    - Questions regarding Windows Subsystem for Linux 2 (WSL2) support and nested virtualization requirements.

## Cause

### Root causes categorized by issue type
1. **Configuration and compatibility**:    - **Generation 2 VM incompatibility**: Certain Linux distributions require specific Generation 2 Hyper-V settings, such as Secure Boot or UEFI, for successful installation.
    - **Unsupported Linux versions**: Older or unlisted Linux versions may not work with Hyper-V integration components, leading to missing data or failed operations.
    - **Licensing and support gaps**: Documentation may not cover all scenarios for OS/distribution/version compatibility.
2. **Integration services and VM data reporting**:    - **Missing or misconfigured Integration Services**: Without proper configuration, Linux Integration Services may fail to report data like IP addresses and hostnames.
    - **Console/SCVMM sync issues**: Synchronization delays or database errors may prevent updated VM data from displaying.
3. **File/state corruption and migration failures**:    - **Corrupted VMRS files**: Migration issues may arise if VM saved state or runtime files are corrupted.
    - **File permission problems**: Insufficient permissions or locked files related to the VM can block migration or restoration.
4. **Guest OS settings and platform differences**:    - **RTC and time zone handling**: Hyper-V provides system time to the guest RTC without time zone metadata; guest OS settings determine interpretation.
    - **CPU compatibility mode**: Enabling this mode restricts available CPU instructions for the guest, causing feature gaps.
5. **External or unsupported scenarios**:    - **Application/OS-specific issues**: Problems within guest OS or applications, like Oracle Database, require vendor support.
    - **Feature or environment limitations**: Advanced features, such as nested virtualization and WSL2, need specific VM configurations or hardware.

## Resolution

### 1. Resolving VM installation issues (Generation 2 Linux VMs)
1. **Review VM configuration**:    - Disable Secure Boot or set it to use the correct template (e.g., MicrosoftUEFICertificateAuthority for supported Linux distributions).
    - Ensure the VM generation matches the Linux distribution’s requirements.
2. **Adjust VM settings**:    - Set the firmware to boot from the correct device (DVD or ISO).
    - Remove unnecessary hardware, such as legacy network adapters.
3. **Retry installation**:    - Reattempt the OS installation after making the necessary changes.
4. **Workaround**:    - If issues persist, install the OS on a Generation 1 VM.

### 2. Resolving live migration and state file errors
1. **Check event logs and error codes**:    - Review Hyper-V logs for Event ID **21502** and error codes such as **0xC0370027**, **0x80048054**, or **0x80070037**.
2. **Inspect VM state files**:    - Ensure .vmrs and .vmcx files are accessible on both source and destination nodes.
3. **Create a new VM**:    - Shut down the affected VM.
    - Create a new VM and attach the original OS/data disks. Match CPU and RAM settings to the original configuration.
4. **Test migration**:    - Attempt live migration with the new VM.
5. **Monitor for recurrence**:    - If resolved, continue monitoring the VM. If the issue persists, escalate for further disk or file system investigation.

### 3. Resolving management console and integration data issues
1. **Verify Integration Services**:    - Use the command lsmod | grep hv in the guest OS to confirm that Hyper-V modules are loaded.
    - Ensure the latest Linux Integration Services are installed.
2. **Enable data exchange**:    - In VM settings, ensure "Data Exchange" is enabled under Integration Services.
3. **Update management console**:    - Apply the latest updates to Hyper-V, SCVMM, or other management platforms.
4. **Correct SCVMM database**(if needed):    - Backup the SCVMM database.
    - Use SQL queries to update missing VM names or IPs.

### 4. Resolving time synchronization issues
1. **Update Integration Services**:    - Ensure the guest OS has the latest Linux Integration Services installed.
2. **Verify time sync settings**:    - In Hyper-V Manager, ensure "Time Synchronization" is enabled.
3. **Adjust guest OS settings**:    - Use timedatectl to configure the system clock and time zone correctly. For example: timedatectl set-timezone UTC.
4. **Delay application startup**:    - For time-sensitive applications, delay startup until synchronization completes.

### 5. Resolving CPU feature/instruction set issues
1. **Disable CPU compatibility mode**:    - In Hyper-V Manager or via PowerShell:

        Set-VMProcessor -VMName -CompatibilityForMigrationEnabled $false
2. **Validate in guest OS**:    - Run cat /proc/cpuinfo to confirm that required CPU flags are present.
3. **Restart VM**:    - Restart the VM to apply changes.

### 6. Resolving frequent VM disconnects
1. **Check network and VM health**:    - Verify that network adapters are correctly configured and functioning.
2. **Review VM cloning practices**:    - Ensure unique MAC addresses and proper cleanup after cloning.
3. **Adjust Secure Boot settings**:    - Enable or disable Secure Boot as required by the Linux distribution.
4. **Contact Linux vendor support**:    - Escalate issues that persist to the Linux distribution vendor.

### 7. Resolving licensing, support, and feature inquiries
1. **Licensing questions**:    - Consult Microsoft licensing specialists for queries about licensing non-Windows OSes on Windows Server.
2. **Legacy OS or unsupported features**:    - Refer to the relevant vendor for support on legacy Linux versions, Oracle Database, or WSL2.
3. **Nested virtualization**:    - Confirm that your VM size or hardware supports nested virtualization.

## Data collection

To assist in troubleshooting, gather the following logs and information:
- **VML traces** (for live migration):

    VmlTrace.exe /m a /f all all
VmlTrace.exe stop

    ```plaintext
     
    ```
- **NetSH network trace**:

    netsh trace start capture=yes tracefile=network-trace.etl overwrite=yes persistent=yes
netsh trace stop

    ```plaintext
     
    ```
- **Integration Services check**:

    Get-VMIntegrationService -VMName
- **CPU validation**:

    cat /proc/cpuinfo
- **Time settings** (Linux):

    timedatectl status
timedatectl set-timezone

## References
- [Supported Linux and FreeBSD Virtual Machines on Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-centos-and-red-hat-enterprise-linux-virtual-machines-on-hyper-v)
- [Linux Integration Services Documentation](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-debian-virtual-machines-on-hyper-v)

If issues persist after following these steps, collect the relevant logs and contact Microsoft Support or your Linux distribution vendor for further assistance.
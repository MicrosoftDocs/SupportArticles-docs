---
title: Troubleshoot Hyper-V Installation, Configuration, and Operational Failures
description: Provides a comprehensive guide for diagnosing and resolving common installation, configuration, and operational issues related to Microsoft Hyper-V in both Windows Server and Windows client environments.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\installation and configuration of hyper-v
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot Hyper-V installation, configuration, and operational failures

This article provides a comprehensive guide for diagnosing and resolving common installation, configuration, and operational issues related to Microsoft Hyper-V in both Windows Server and Windows client environments. Hyper-V issues can arise during feature installation, virtual machine (VM) management, cluster creation, networking, or service startup, often impacting mission-critical workloads, and high availability configurations. Quickly identifying and addressing these problems is critical to maintaining business continuity, VM uptime, and cluster stability.

You might encounter one or more of the following issues:

- [Installation and configuration failures](#installation-and-configuration-failures)
- [Cluster and live migration issues](#cluster-and-live-migration-issues)
- [VM operations and Hyper-V Manager issues](#vm-operations-and-hyper-v-manager-issues)
- [Networking and storage issues](#networking-and-storage-issues)
- [Other technical and security symptoms](#other-technical-and-security-symptoms)

## Installation and configuration failures

- Error messages:
  - > The request to add or remove features on the specified server has failed.
  - > Hyper-V feature unknown.
- CBS (Component-Based Servicing) logs: "ERROR_SXS_ASSEMBLY_MISSING."
- Hyper-V role isn't visible after installation or server reboot.
- Windows Management Instrumentation (WMI)-related errors:
  - > Error CSI 000000b5 (F) Logged (install online) $(runtime.System32)\WindowsVirtualization.V2.mof [gle=0x80004005].
  - > Error CSI 000000b6 (F) CMIADAPTER: Inner Error Message (0x1002): 0X80041002 Class, instance, or property CIM_RegisteredProfile was not found.
- MSinfo32 fails to open; WMI queries fail.

## Cluster and live migration issues

- Error messages:
  - > Failed to access remote registry on \<hostname\>. Ensure that the remote registry service is running, and remote administration is enabled.
  - > The virtual machine cannot be live migrated to the destination host because the hardware on the destination computer isn't compatible...
  - > The credentials supplied to the package were not recognized (0x8009030D).
- Cluster validation fails or is abnormally slow.
- Cluster shared volumes appear as RAW or are inaccessible from noncluster nodes.

## VM operations and Hyper-V Manager issues

- VM fails to start error message:

  > Virtual machine failed to start due to insufficient memory.
- VM is stuck in a "saved state" or unable to boot after host upgrade/reboot.
- Virtual Machine Management Service (VMMS) fails to start.
- Error message:

  > An error occurred while Hyper-V was attempting to access an object on the computer.
- Error message when Hyper-V Manager can't connect:

  > The WinRM client cannot process the request...
- Enhanced Session Mode is unavailable in audit mode.

## Networking and storage issues

- Network adapters are disabled after Hyper-V installation; no IP address is assigned, or IPv4 is unchecked.
- VM can't obtain an IP address or communicate with the network.
- Hyper-V virtual switch is stuck in an "unidentified" state.
- VLAN tagging issues—only the native VLAN works.

## Other technical and security symptoms

- Unexpected VM MAC address changes or conflicts after reboot.
- Port reservation conflicts (for example, Transmission Control Protocol (TCP) ports 50000–50059) blocking application use after enabling Hyper-V.
- Frequent Service Principal Name (SPN) registration failures: Event ID 14050 from Microsoft-Windows-Hyper-V-VMMS.
- WMI repository corruption and inability to install or use Hyper-V features.

The root causes vary depending on the symptom category:

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

## Cause 1: Installation and feature enablement issues

- Missing or corrupt CBS packages: Logged as "ERROR_SXS_ASSEMBLY_MISSING" in CBS logs. Registry permissions related to CBS packages might be incorrect or incomplete.
- Unsupported operating system (OS) edition or hardware: Hyper-V is unavailable on Windows Home editions or unsupported CPUs. Incompatible hardware can also lead to boot failures.
- Corrupt WMI repository: WMI subsystem errors disrupt feature installation and system information retrieval.
- BIOS/UEFI misconfiguration: Virtualization features aren't enabled in BIOS/UEFI settings.

### Resolution

1. Fix CBS package and registry issues:

    1. Grant full control permissions to all users on the following registry key:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages`
    2. Run a PowerShell script to reset package states:

        ```powershell
        $name = "CurrentState"
        $check = (get-childitem -Path HKLM:\software\microsoft\windows\currentversion\component based servicing\packages -Recurse).Name
        foreach ($check1 in $check) {
        if ((Get-ItemProperty -Path $check1).$name -eq 0x50 -or (Get-ItemProperty -Path $check1).$name -eq 0x40) {
        Set-ItemProperty -Path $check1 -Name $name -Value 0
        }
        }
        ```

    3. Enable Hyper-V features using Deployment Image Servicing and Management (DISM):

        ```console
        Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /All
        Dism /online /enable-feature /featurename:Microsoft-Hyper-V-Management-Clients
        Dism /online /enable-feature /featurename:Microsoft-Hyper-V-Management-PowerShell
        ```

    4. Ensure you're using a supported OS edition, such as Windows Pro, Enterprise, or Education.
2. Repair the WMI repository:

    - Open Command Prompt as Administrator and run:

        ```console
        winmgmt /resetrepository
        winmgmt /verifyrepository
        winmgmt /salvagerepository
        cd %windir%\system32\wbem
        for /f %s in ('dir /b \*.mof') do mofcomp %s
        for /f %s in ('dir /b \*.mfl') do mofcomp %s
        ```

3. Update BIOS/UEFI configuration:

    - Enable Intel VT-x or AMD-V features in the BIOS/UEFI settings.
    - For Trusted Platform Module (TPM) support, ensure all required options are configured.

## Cause 2: Cluster and VM migration failures

- Missing registry keys for cryptography or TLS/SSL: Missing keys such as `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002` block authentication and secure connections.
- Processor or hardware incompatibility: Live migration fails if VM state relies on CPU features unavailable on the destination host.
- Kerberos or delegation misconfiguration: Lack of Kerberos authentication or constrained delegation in Active Directory prevents live migration.
- Cluster database corruption: Errors during third-party software upgrades or outages can corrupt cluster databases.

### Resolution

1. Restore cryptography configuration:

    1. Export the missing registry key from a working server:

        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`
    2. Import the key to the affected server and reboot.
2. Enable Kerberos and delegation for live migration:

    1. In Hyper-V Manager, go to **Settings** > **Live Migrations** > **Advanced Features** and select **Use Kerberos**.
    2. Configure delegation in Active Directory by adding Common Internet File System (CIFS) and Microsoft Virtual System Migration Service for partner hosts.
3. Address CPU compatibility:

    1. Perform a quick migration to align VM state with the new host.
    2. Validate CPU features across cluster nodes.

## Cause 3: VM operations, networking, and storage

- Disabled or misconfigured network adapter properties: IPv4 might be unchecked or virtual switches improperly configured.
- Improper VLAN or network interface card (NIC) teaming setup: VLAN tagging might be misapplied or inconsistent with the physical switch configuration.
- Disk or storage corruption: Corruption or hardware failure results in VM inaccessibility.
- Port reservation conflicts: Hyper-V reserves high TCP ports that might conflict with application requirements.

### Resolution

- Re-enable network adapters:

    1. In Device Manager, enable IPv4 on the affected network adapter.
    2. Use PowerShell:

       ```powershell
       Enable-NetAdapter -Name "<adaptername>"
       Enable-NetAdapterBinding -Name "<adaptername>" -ComponentID ms_tcpip
       ```

- Fix virtual switch or VLAN tagging issues:

    Modify virtual switches using PowerShell:

    ```powershell
    New-VMSwitch -Name "SET" -NetAdapterName "<adaptername>" -EnableEmbeddedTeaming $true
    Set-VMNetworkAdapterVlan -VMName "<vmname>" -Access -VlanId <vlan_id>
    ```

- Resolve disk issues:

    Use `DiskPart` to clear the read-only attribute:

    ```console
    diskpart
    list disk
    select disk <disk number>
    attributes disk clear readonly
    ```

- Address port reservation conflicts:

   Reserve application-required ports before enabling Hyper-V:

   ```console
   netsh int ipv4 delete excludedportrange protocol=tcp <startport> <numberofports>
   ```

## Cause 4: Permissions, security, and system services

- Incorrect file or folder permissions: Insufficient permissions for Hyper-V or "NT VIRTUAL MACHINE\Virtual Machines" can block access to VM folders.
- Service account deletion: Deletion of SQL Server or System Center Virtual Machine Manager (SCVMM) accounts can prevent services from starting.
- SPN registration failures: Missing or misconfigured SPNs disrupt Kerberos authentication.

### Resolution

- Correct file and folder permissions:

  Ensure full access for "Administrators," "Hyper-V Administrators," and "NT VIRTUAL MACHINE\Virtual Machines" on VM folders and VHDs.
- Restore service accounts:

  If service accounts are deleted, assign a new owner to the database and restart the associated service.
- Fix SPN registration failures:

  Review cluster configuration settings, and ensure all required SPNs are registered.

## Cause 5: Known bugs and product defects

- World Wide Port Name (WWPN) generator bug: Registry values out of range cause VMMS service to fail.
- **MsMpEng.exe** or NTFS deadlock bug: A bug in Microsoft Defender causes deadlocks with NTFS transactional metadata.
- Cluster creation and Key Management Service (KMS) activation defects: Internal product bugs might affect cluster operations and license activation.

### Resolution

- WWPN generator bug:

  Edit the `NextWWPN` registry value to align with the defined range and restart the Hyper-V/VMMS service.

- Cluster creation and KMS activation defects:

  Escalate unresolved issues to [Microsoft Support](https://support.microsoft.com/) with logs and configuration details.

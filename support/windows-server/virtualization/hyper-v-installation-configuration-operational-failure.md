---
title: Troubleshooting Hyper-V Installation, Configuration, and Operational Failures
description: Provides a comprehensive guide for diagnosing and resolving common installation, configuration, and operational issues related to Microsoft Hyper-V in both Windows Server and Windows client environments.
ms.date: 09/01/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\installation and configuration of hyper-v
- pcy:WinComm Storage High Avail
---
# Troubleshooting Hyper-V Installation, Configuration, and Operational Failures

This article provides a comprehensive guide for diagnosing and resolving common installation, configuration, and operational issues related to Microsoft Hyper-V in both Windows Server and Windows client environments. Hyper-V issues can arise during feature installation, virtual machine (VM) management, cluster creation, networking, or service startup, often impacting mission-critical workloads and high availability configurations. Quickly identifying and addressing these problems is critical to maintaining business continuity, VM uptime, and cluster stability.

## Symptoms

End users and system administrators may encounter one or more of the following issues:

### Installation and configuration failures

- Error: "The request to add or remove features on the specified server has failed."
- Error: "Hyper-V功能未知" ("Hyper-V feature unknown").
- CBS (Component-Based Servicing) logs: "ERROR_SXS_ASSEMBLY_MISSING."
- Hyper-V role not visible after installation or server reboot.
- WMI (Windows Management Instrumentation)-related errors:
    - "Error CSI 000000b5 (F) Logged (install online) $(runtime.System32)\WindowsVirtualization.V2.mof [gle=0x80004005]."
    - "Error CSI 000000b6 (F) CMIADAPTER: Inner Error Message (0x1002): 0X80041002 Class, instance, or property CIM_RegisteredProfile was not found."
- MSinfo32 fails to open; WMI queries fail.

### Cluster and live migration issues

- Error: "Failed to access remote registry on <hostname>. Ensure that the remote registry service is running, and remote administration is enabled.&quot;</hostname>
- Error: "The virtual machine cannot be live migrated to the destination host because the hardware on the destination computer isn’t compatible..."
- Error: "The credentials supplied to the package were not recognized (0x8009030D)."
- Cluster validation fails or is abnormally slow.
- Cluster shared volumes appear as RAW or are inaccessible from non-cluster nodes.

### VM operations and Hyper-V Manager issues

- VM fails to start: "Virtual machine failed to start due to insufficient memory."
- VM stuck in a "saved state" or unable to boot after host upgrade/reboot.
- Virtual Machine Management Service (VMMS) fails to start.
- Error: "An error occurred while Hyper-V was attempting to access an object on the computer."
- Hyper-V Manager cannot connect: "The WinRM client cannot process the request..."
- Enhanced Session Mode unavailable in audit mode.

### Networking and storage issues

- Network adapters are disabled after Hyper-V installation; no IP address assigned, or IPv4 is unchecked.
- VM cannot obtain an IP address or communicate with the network.
- Hyper-V virtual switch stuck in an "unidentified" state.
- VLAN tagging issues—only the native VLAN works.

### Other technical and security symptoms

- Unexpected VM MAC address changes or conflicts after reboot.
- Port reservation conflicts (e.g., TCP ports 50000–50059) blocking application use after enabling Hyper-V.
- Frequent SPN (Service Principal Name) registration failures: Event ID 14050 from Microsoft-Windows-Hyper-V-VMMS.
- WMI repository corruption and inability to install or use Hyper-V features.

## Cause

The root causes vary depending on the symptom category:

### Installation and feature enablement issues

- **Missing or corrupt CBS packages**: Logged as "ERROR_SXS_ASSEMBLY_MISSING" in CBS logs. Registry permissions related to CBS packages may be incorrect or incomplete.
- **Unsupported operating system (OS) edition or hardware**: Hyper-V is unavailable on Windows Home editions or unsupported CPUs. Incompatible hardware can also lead to boot failures.
- **Corrupt WMI repository**: WMI subsystem errors disrupt feature installation and system information retrieval.
- **BIOS/UEFI misconfiguration**: Virtualization features are not enabled in BIOS/UEFI settings.

### Cluster and VM migration failures

- **Missing registry keys for cryptography or TLS/SSL**: Missing keys such as HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002 block authentication and secure connections.
- **Processor or hardware incompatibility**: Live migration fails if VM state relies on CPU features unavailable on the destination host.
- **Kerberos or delegation misconfiguration**: Lack of Kerberos authentication or constrained delegation in Active Directory prevents live migration.
- **Cluster database corruption**: Errors during third-party software upgrades or outages can corrupt cluster databases.

### VM operations, networking, and storage

- **Disabled or misconfigured network adapter properties**: IPv4 may be unchecked or virtual switches improperly configured.
- **Improper VLAN or NIC teaming setup**: VLAN tagging may be misapplied or inconsistent with the physical switch configuration.
- **Disk or storage corruption**: Corruption or hardware failure results in VM inaccessibility.
- **Port reservation conflicts**: Hyper-V reserves high TCP ports that may conflict with application requirements.

### Permissions, security, and system services

- **Incorrect file or folder permissions**: Insufficient permissions for Hyper-V or "NT VIRTUAL MACHINE\Virtual Machines" can block access to VM folders.
- **Service account deletion**: Deletion of SQL Server or SCVMM (System Center Virtual Machine Manager) accounts can prevent services from starting.
- **SPN registration failures**: Missing or misconfigured SPNs disrupt Kerberos authentication.

### Known bugs and product defects

- **WWPN (World Wide Port Name) generator bug**: Registry values out of range cause VMMS service to fail.
- **MsMpEng.exe/NTFS deadlock bug**: A bug in Microsoft Defender causes deadlocks with NTFS transactional metadata.
- **Cluster creation and KMS (Key Management Service) activation defects**: Internal product bugs may affect cluster operations and license activation.

## Resolution

### Installation and feature enablement issues

1. **Fix CBS package and registry issues**:

    - Grant full control permissions to all users on the following registry key:

        HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages
    - Run a PowerShell script to reset package states:

        $name = "CurrentState"
$check = (get-childitem -Path HKLM:\software\microsoft\windows\currentversion\component based servicing\packages -Recurse).Name
foreach ($check1 in $check) {
if ((Get-ItemProperty -Path $check1).$name -eq 0x50 -or (Get-ItemProperty -Path $check1).$name -eq 0x40) {
    Set-ItemProperty -Path $check1 -Name $name -Value 0
}
}
    - Enable Hyper-V features using Deployment Image Servicing and Management (DISM):

        Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /All
Dism /online /enable-feature /featurename:Microsoft-Hyper-V-Management-Clients
Dism /online /enable-feature /featurename:Microsoft-Hyper-V-Management-PowerShell
    - Ensure you are using a supported OS edition, such as Windows Pro, Enterprise, or Education.
2. **Repair the WMI repository**:

    - Open Command Prompt as Administrator and run:

        winmgmt /resetrepository
winmgmt /verifyrepository
winmgmt /salvagerepository
cd %windir%\system32\wbem
for /f %s in ('dir /b \*.mof') do mofcomp %s
for /f %s in ('dir /b \*.mfl') do mofcomp %s
3. **Update BIOS/UEFI configuration**:

    - Enable Intel VT-x or AMD-V features in the BIOS/UEFI settings.
    - For Trusted Platform Module (TPM) support, ensure all required options are configured.

### Cluster and VM migration failures

1. **Restore cryptography configuration**:

    - Export the missing registry key from a working server:

        HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002
    - Import the key to the affected server and reboot.
2. **Enable Kerberos and delegation for live migration**:

    - In Hyper-V Manager, go to **Settings > Live Migrations > Advanced Features** and select **Use Kerberos**.
    - Configure delegation in Active Directory by adding cifs and Microsoft Virtual System Migration Service for partner hosts.
3. **Address CPU compatibility**:

    - Perform a quick migration to align VM state with the new host.
    - Validate CPU features across cluster nodes.

### VM operations, networking, and storage

1. **Re-enable network adapters**:

    - In Device Manager, enable IPv4 on the affected network adapter.
    - Use PowerShell:

        Enable-NetAdapter -Name "<adaptername>&quot;<br>Enable-NetAdapterBinding -Name &quot;<adaptername>&quot; -ComponentID ms_tcpip</adaptername></adaptername>
2. **Fix virtual switch or VLAN tagging issues**:

    - Modify virtual switches using PowerShell:

        New-VMSwitch -Name "SET" -NetAdapterName "<adaptername>&quot; -EnableEmbeddedTeaming $true<br>Set-VMNetworkAdapterVlan -VMName &quot;<vmname>&quot; -Access -VlanId <vlan_id></vlan_id></vmname></adaptername>
3. **Resolve disk issues**:

    - Use DiskPart to clear the read-only attribute:

        diskpart
list disk
select disk <disk number><br>attributes disk clear readonly</disk>
4. **Address port reservation conflicts**:

    - Reserve application-required ports before enabling Hyper-V:

        netsh int ipv4 delete excludedportrange protocol=tcp <startport> <numberofports></numberofports></startport>

### Permissions, security, and system services

1. **Correct file and folder permissions**:

    - Ensure full access for "Administrators," "Hyper-V Administrators," and "NT VIRTUAL MACHINE\Virtual Machines" on VM folders and VHDs.
2. **Restore service accounts**:

    - If service accounts are deleted, assign a new owner to the database and restart the associated service.
3. **Fix SPN registration failures**:

    - Review cluster configuration settings and ensure all required SPNs are registered.

### Known bugs and product defects

1. **MsMpEng.exe/NTFS deadlock bug**:

    - Refer to the bug documentation: [MsMpEng.exe/NTFS Deadlock](https://microsoft.visualstudio.com/OS/_workitems/edit/55817624).
2. **WWPN generator bug**:

    - Edit the NextWWPN registry value to align with the defined range and restart the Hyper-V/VMMS service.
3. **Cluster creation and KMS activation defects**:

    - Escalate unresolved issues to Microsoft support with logs and configuration details.

## References

- [Administrative roles in Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/administrative-roles-in-hyper-v)
- [Hyper-V port usage documentation](https://learn.microsoft.com/en-us/windows-server/networking/manage-reserved-ports)
- [Microsoft support for Hyper-V](https://support.microsoft.com/)
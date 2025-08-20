---
title: Troubleshooting Hyper-V Cluster Connectivity, Management, and Configuration Failures
description: Provides a comprehensive guide to troubleshooting various issues related to Hyper-V clusters and management environments on Windows Server 2019 and Windows Server 2022.
ms.date: 08/20/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\integration components
- pcy:WinComm Storage High Avail
---
# Troubleshooting Hyper-V Cluster Connectivity, Management, and Configuration Failures

This article provides a comprehensive guide to troubleshooting various issues related to Hyper-V clusters and management environments on Windows Server 2019 and Windows Server 2022. These issues can manifest as failures in cluster management consoles, virtual machine (VM) migration, remote administration, authentication, storage configuration, and network connectivity. The guide identifies symptoms and root causes, offering actionable resolution steps to address the problems. Effective troubleshooting of these issues is critical to maintaining high availability, business continuity, and compliance in enterprise virtualization environments.

## Symptoms

### End-user symptoms

- Inability to connect to Hyper-V Manager or Failover Cluster Manager consoles.
- Failures in remote VM management operations (e.g., start, stop, or migrate) from certain hosts or accounts.
- Virtual machines fail to migrate between cluster nodes or become inaccessible after migration or upgrade.
- Hyper-V Manager displays "Loading virtual machines…" or "Connecting to Virtual Machine Management service…".
- Certain user accounts cannot perform administrative actions, while built-in administrators succeed.
- Backup or cluster operations hang, fail, or report errors.
- VMs report duplicate universally unique identifiers (UUIDs) detected by third-party tools.

### Technical/system symptoms

- Error: "Cannot connect to the virtual machine. Try to connect again. If the problem persists, contact your system administrator."
- Error: "You do not have the required permission to complete this task. Contact the administrator of the authorization policy for the computer."
- Error: "The operation on computer failed: WinRM process the request. The error code 0x80090311 occurred while using Kerberos authentication."
- Error: "SEC_E_NO_AUTHENTICATING_AUTHORITY: No authority could be contacted for authentication."
- Error: "Start-VM: Hyper-V encountered an error trying to access an object on computer [host] because the object was not found."
- Error: "get-vm: The paging file is too small for this operation to complete."
- Hyper-V Manager becomes unresponsive or does not display any VMs.
- VMConnect fails from certain remote hosts but succeeds from others.
- Netlogon and DNS logs show failed domain controller discovery.
- Windows Management Instrumentation (WMI) errors, including WMIPrvSE.exe crashes.
- Virtual Machine Management Service (VMMS) hangs or enters a deadlock state.
- Duplicate UUIDs detected for VMs (e.g., by vendor extraction tools).
- No error messages, but failures in adding storage, configuring quorum disks, or managing updates.
- Network traces show blocked ports between hosts and domain controllers.
- Event logs and analytic logs may be missing or not generated for affected actions.

## Cause

### Network and authentication issues

- **Firewall blocking**: Required ports (e.g., UDP/TCP 389 for LDAP, port 2179 for VMConnect) are blocked, disrupting authentication, domain controller discovery, or management traffic.
- **DNS/Netlogon failures**: UDP pings or DNS queries to domain controllers fail, which breaks Kerberos authentication and remote management.

### Permission and group membership misconfiguration

- **Insufficient privileges**: Users lack membership in necessary administrative groups (e.g., Hyper-V Administrators, Storage Replica Administrators, or Remote Management Users).
- **Group Policy restrictions**: Policies block credential delegation or Windows Remote Management (WinRM) operations in workgroup or multi-domain environments.

### Configuration and state file corruption

- **Corrupt VM files**: Corrupted .VMRS, .VMCX, or configuration files caused by improper shutdowns or service crashes.
- **Deadlocks in VMMS**: Service deadlocks triggered by pending network operations or driver issues.

### Software/code defects

- **High availability (HA) VM settings bugs**: Known defects in Hyper-V HA settings, especially in Windows Server 2019 and 2022, that affect storage management or cluster operations.

### Environmental and update problems

- **Outdated OS**: Missing Windows updates cause instability in Hyper-V role installation or operation.
- **Backup or third-party software impact**: Backup operations or third-party tools cause services (e.g., WMI) to crash or malfunction.

### Storage and hardware identifier issues

- **Duplicate UUIDs**: Duplicate VM UUIDs due to manufacturer settings or cloning.
- **Storage configuration gaps**: Misconfigured or unrecognized shared storage and storage pools.

### Console/management tool failures

- **Failover Cluster GUI/console issues**: Misconfigurations or duplicate case scenarios prevent the management interface from operating properly.

## Resolution

### Scenario 1: Cluster or Hyper-V Manager console fails to connect/authenticate

1. **Verify network connectivity and firewall rules**:    - Ensure UDP/TCP port 389 is open between Hyper-V hosts and domain controllers.
    - Open port 2179 for VMConnect/console access.
    - Use network trace tools to identify blocked traffic.
2. **Check DNS and Netlogon settings**:    - Review Netlogon logs for failed domain controller discovery.
    - Verify DNS settings and confirm domain controller reachability.
3. **Confirm group memberships and permissions**:    - Ensure users are members of:        - Hyper-V Administrators
        - Remote Management Users
        - Storage Replica Administrators (if applicable).
    - Remove affected users from the default Users group if necessary.
4. **Update Group Policy and WinRM settings**:    - Enable PowerShell Remoting:Enable-PSRemoting
    - Configure CredSSP for authentication:Enable-WSManCredSSP -Role serverEnable-WSManCredSSP -Role client -DelegateComputer "<Hyper-V host>"
5. **Adjust trusted hosts and firewall rules**:    - Set trusted hosts for WinRM:Set-Item wsman:localhost\client\trustedhosts <Hyper-V host IP>
    - Enable relevant firewall rules:        - Remote Administration
        - Remote Desktop
        - Remote Volume Management
        - Windows Management Instrumentation (WMI).

### Scenario 2: Virtual machine fails to migrate, start, or is inaccessible after upgrade

1. **Check storage and network configuration**:    - Verify shared storage and storage pools are configured and accessible from all cluster nodes.
    - Ensure consistent network settings across all nodes.
2. **Validate OS updates**:    - Run Windows Update on all Hyper-V hosts before installing or migrating the Hyper-V role.
3. **Investigate VM state and configuration files**:    - If a VM is unresponsive:        - Shut down all healthy VMs.
        - Reboot the Hyper-V host.
        - Delete the problematic VM from Hyper-V Manager (retain the VHDX file).
        - Backup and, if needed, delete/rename the .vmcx and .vmrs files.
        - Recreate the VM using the existing VHDX disk.
4. **Repair corrupted files**:    - Collect a process dump and analyze for VMMS deadlocks.
    - Use tools like Process Explorer or TSS scripts (from [aka.ms/getTSS](https://aka.ms/getTSS)) to collect logs and terminate stuck processes.

### Scenario 3: Permission/access denied errors when managing VMs

1. **Update user group memberships**:    - Add the user to the appropriate administrative groups on the Hyper-V host.
2. **Recompile WMI classes**:    - Run:MOFCOMP %SYSTEMROOT%\System32\WindowsVirtualization.V2.mof
3. **Reconfigure credential delegation in Group Policy**:    - Allow delegation of fresh credentials with NTLM-only server authentication.

### Scenario 4: Duplicate VM UUIDs detected by vendor tools

1. **For VMware**:    - Edit the VM’s .vmx file:        - Locate uuid.bios = and assign a unique value.
2. **For Hyper-V**:    - Use a third-party tool to randomize/update the BIOS GUID.
    - If not feasible, create a new VM from scratch to ensure a unique UUID.

### Scenario 5: Cluster or Hyper-V role installation fails

1. **Install the latest Windows updates**:    - Fully patch the server before attempting the Hyper-V feature installation.
2. **Retry role installation**:    - Use Server Manager, PowerShell, or Deployment Image Servicing and Management (DISM) tools:Install-WindowsFeature -Name Hyper-V -IncludeManagementTools

### Scenario 6: Backup or WMI-related cluster node failures

1. **Check WMI service status**:    - If WMIPrvSE.exe crashes, restart the service or reboot the node.
2. **Collect logs during the incident**:    - Gather SDP, TSS, and cluster logs for root cause analysis.

### Scenario 7: Failover Cluster console/GUI not working

1. **Check for duplicate cases**:    - Verify the issue is not already tracked in an open support case.
2. **Verify cluster configuration**:    - Review cluster logs and configurations for inconsistencies.

### Scenario 8: Hardening and best practices

1. **Run Best Practices Analyzer (BPA)**:    - Use Server Manager or PowerShell:Invoke-BpaModel -ModelId Microsoft/Windows/Hyper-V
2. **Implement hardening recommendations**:    - Apply security recommendations from Microsoft documentation and BPA output.

## Data collection

### Logs and commands

- **TSS script for Hyper-V diagnostics**:Download and run: [aka.ms/getTSS](https://aka.ms/getTSS)Example:Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned.\TSS.ps1 -SDP HyperV
- **Event log collection**:%SystemRoot%\System32\winevt – Copy and zip event log folders.
- **WMI and VM UUID queries**:Get-CimInstance -ClassName Win32_ComputerSystemProduct | Select UUIDGet-WmiObject Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID
- **WinRM and PowerShell Remoting setup**:Enable-PSRemotingEnable-WSManCredSSP -Role server/clientSet-Item wsman:localhost\client\trustedhosts <host IP>
- **VM operations via remote PowerShell**:$cred = Get-CredentialInvoke-Command -Credential $cred -ComputerName <Hyper-V host IP> -ScriptBlock { Start-VM <VM Name> }

## References

- [Microsoft Lifecycle Documentation](https://learn.microsoft.com/en-us/lifecycle/overview/product-end-of-support-overview)
- [Microsoft Style Guide](https://learn.microsoft.com/en-us/style-guide)
- [Accessibility Checklist](https://learn.microsoft.com/en-us/writing-style-guide-msft-internal/checklists/accessibility-checklist)
---
title: Troubleshoot client agent installation issues
description: Troubleshoot issues that the client agent of System Center 2012 Operations Manager (OpsMgr 2012 and OpsMgr 2012 R2) can't be installed.
ms.date: 04/15/2024
---
# Troubleshoot client agent installation issues in Operations Manager

This guide helps you troubleshoot issues that the client agent of System Center 2012 Operations Manager (OpsMgr 2012 and OpsMgr 2012 R2) can't be installed.

_Original product version:_ &nbsp; System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 10147

The first step is to verify that the potential client computer meets the supported hardware and software configuration. The following article lists the requirements for a System Center 2012 Operations Manager client:

[System Requirements for System Center 2012 - Operations Manager](/previous-versions/system-center/system-center-2012-R2/hh205990(v=sc.12))

If the target client is a Unix/Linux computer, verify that both the distribution and version are supported. The following article lists the supported versions of Unix/Linux:

[Supported UNIX and Linux Operating System Versions](/previous-versions/system-center/system-center-2012-R2/hh212713(v=sc.12))

## Troubleshoot agent deployment via the Discovery Wizard

If the agent will be deployed via discovery from the Operations Manager console, the agent will be installed from the management server or gateway server specified in the Discovery Wizard to manage the agent. It's not the server the Operations console was connected to when it opened. Therefore, any testing should be conducted from the management server or gateway specified when the wizard runs. Or, a different management server or gateway should be specified during the wizard to see if the same error occurs.

### The wizard doesn't display a list of potential agents to install

In this case, the most likely cause is that the account is having trouble accessing Active Directory. The credentials specified in the wizard during the initial discovery must have permission to search Active Directory for potential agents.

Typical errors include the following:

- > Error Code: 800706BA  
  Error Description: The RPC server is unavailable.

- > Error Code: 80070079  
  The MOM Server failed to perform specified operation on computer \<name>. The semaphore timeout period has expired.

- > Error Code: 800706433  
  The Agent Management Operation Agent Install failed for remote computer \<name>

**Possible resolutions**

During discovery, specify an account that has both domain administrator permissions and is a member of the Operations Manager Admins group.

Additionally, if the LDAP query times out or is unable to resolve the potential agents in Active Directory, discovery can be performed via the [Operations Manager Command Shell](#troubleshoot-agent-deployment-via-the-operations-manager-shell).

### The target computer isn't in the list of potential agents after the initial discovery runs

In this case, the computer may already be identified in the database as part of the management group. Or, the computer is listed under **Pending Actions** in the Operations console.

If the target computer is listed under **Administration** > **Pending Actions** in the Operations console, the existing action must either be approved or rejected before a new action can be performed. If the existing installation settings are sufficient, approve the pending installation from the console. Otherwise, reject the pending action, then rerun the discovery wizard.

### The Discovery Wizard encounters an error when trying to install the agent

The most common errors are listed below:

- > Operation: Agent Install  
  > Error Code: 800706D9

- > Error Description: Unknown error 0xC000296E
- > Error Description: Unknown error 0xC0002976
- > Error Code: 80070643  
  > Error Description: Fatal error during installation.

These errors can be caused by one of the following reasons:

- The account previously specified to perform the agent installation in the Discovery Wizard doesn't have permissions to connect to the target computer and install a Windows service. This requires local administrator permissions due to the requirement to write to the registry.
- Group Policy restrictions on the management server computer account or the account used for agent push are preventing successful installation. For example, Group Policy Objects prevent the accounts from accessing the Windows folder, the registry, WMI, or administrative shares on the target computer.
- The Windows Firewall is blocking ports between the management server and the target computer.
- Required services on the target computer aren't running.

**Possible resolutions**

- If the credentials specified in the wizard don't have local administrator permissions, add the account to the local Administrators security group on the target computer. Or use an account that's already a member of that group.
- Block Group Policy inheritance on the target computer, or the user account performing the installation.
- If agent installation is failing when using a domain account to push the agent from a management server, use Windows administrative tools to identify potential issues.

  Log on to the management server with the credentials in question and try the following tasks. If the account doesn't have permission to log on to the management server, the tools can be run under the credentials to be tested from a command prompt.

  - Execute the `runas /user:<UserAccountName> "compmgmt.msc"` command. Select **Action** > **Connect to another computer**. After connected, try to open Event Viewer and browse any event logs.

  - Execute the `runas /user:<UserAccountName> "services.msc"` command. Select **Action** > **Connect to another computer**. After connected, try to start or stop **Print Spooler** or any other service on the target computer.

  - Execute the `runas /user:<UserAccountName> "regedt32.exe"` command. Select **File** > **Connect Network Registry**. After connected, try to open HKLM on the remote machine.

  - Execute the `runas /user:<UserAccountName> "Explorer.exe"` command. Type `\\admin$` in the address bar.

If any of these tasks fail, use a different account that has Domain Administrator or Local Administrator (on the target computer) permissions. Also try the same tasks from a member server or workstation to see if the tasks fail from multiple computers.

> [!NOTE]
> Failure to connect to the `admin$` share may prevent the management server from copying setup files to the target. Failure to connect to the Windows Registry on the target computer can result in the Health Service not installed properly. Failure to connect to Service Control Manager can prevent setup from starting the service.

The following ports must be open between the management server and the target computer:

- RPC endpoint mapper Port number: 135 Protocol: TCP/UDP
- NetBIOS name service Port number: 137 Protocol: TCP/UDP
- NetBIOS session service Port number: 139 Protocol: TCP/UDP
- SMB over IP Port number: 445 Protocol: TCP
- MOM Channel Port number: 5723 Protocol: TCP/UDP

The following services must be enabled and running on the target computer:

- Netlogon
- Remote Registry
- Windows Installer
- Automatic Updates

The following articles provide more background about deploying the Operations Manager agent using discovery from the management server:

- [How to Deploy the Operations Manager 2007 Agent Using the Agent Setup Wizard](/previous-versions/bb309515(v=technet.10))
- [Troubleshooting Issues When You Use the Discovery Wizard to Install an Agent](/previous-versions/system-center/operations-manager-2007-r2/ff358634(v=technet.10))

### Error Code 800706BA - The RPC server is unavailable

To fix this error, see [Check network issues](troubleshoot-agent-connectivity-issues.md#check-network-issues).

## Troubleshoot agent deployment via the Operations Manager Shell

Automatic discovery of potential agents may time out due to large or complex Active Directory environments. Other situations may require that automatic discovery be run with an LDAP query that's more limited than what is available in the UI. In these cases, automatic discovery of computers and remote installation of the Operations Manager agent is possible via the Operations Manager Shell.

For example, the following command defines an LDAP query and passes it to `New-WindowsDiscoveryConfiguration`, thereby creating an LDAP-based WindowsDiscoveryConfiguration:

```powershell
$query = New-LdapQueryDiscoveryCriteria -LdapQuery: "(sAMAccountType=805306369)(name=srv1.contoso.com*)" -Domain:"contoso.com"$discoConfig = New-WindowsDiscoveryConfiguration -LdapQueryDiscoveryCriteria:$query
```

As another example, the following command defines a name-based WindowsDiscoveryConfiguration that will discover a specific computer or computers:

```powershell
$discoConfig = New-WindowsDiscoveryConfiguration -ComputerName: "srv1.contoso.com", "srv2.contoso.com"
```

The following commands direct the discovery module to use specific credentials, perform verification of each discovered Windows computer, and constrain the type of discovered object to a Windows server. The `ComputerType` parameter can be a workstation, a server or both. The `PerformVerification` switch is used to direct discovery to verify that only available computers are returned.

```powershell
# Prompt for credentials used to perform the discovery
$creds = Get-Credential

# Define a WindowsDiscoveryConfiguration
$discoConfig = New-WindowsDiscoveryConfiguration –ComputerName: "srv3.contoso.com", "srv4.contoso.com" –PerformVerification: $true –ActionAccount:$creds -ComputerType: "Server"

# Select the management server used to run the discovery
$managementServer = Get-ManagementServer –Root: $true

# Start the discovery process
$discoResult = Start-Discovery –ManagementServer: $managementServer –WindowsDiscoveryConfiguration: $discoConfig

# Check if the discovery process discovered the specified computers
$discoResult.CustomMonitoringObjects

# Last but not least, install agents on the discovered computers
Install-SCOMAgent –ManagementServer: $managementServer –AgentManagedComputer: $discoResult.CustomMonitoringObjects
```

## Troubleshoot agent deployment via verbose Windows Installer logging

If the agent installation on a remote computer fails, a verbose Windows Installer log may be created on the management server in the following default location:

`C:\Program Files\System Center Operations Manager\AgentManagement\AgentLogs`

The log can be used to determine if there was a specific error encountered and may be used to further troubleshoot installation of the Operations Manager agent on the target computer.

Look for the first entry with the string **Return Value 3** in the log. The preceding few lines usually indicate the error that Windows Installer encountered. The format is typically in the form of function, description of error, or error return code and can indicate permission issues, missing files, or other settings that need to be changed.

Examples:

- Error message: ConvertStringSecurityDescriptorToSecurityDescriptor failed: 87

    Possible cause: The installation account does not have permission to the security log on the target computer.

- Error message: ModifyEventLogAccessForNetworkService(): Could not grant read access to SecurityLog: 0x00000057

    Possible cause: The installation account does not have permission to the security log on the target computer.

- Error message: Cannot open database file. System error -2147024629

    Possible cause: The installation account does not have permission to the system TEMP folder.

## Troubleshoot manual installation of the agent

When the Operations Manager client agent can't be deployed to a remote computer via the Discovery Wizard, the agent needs to be installed manually. This can be performed via command line using the **MomAgent.msi** file.

The following references describe the various switches and configuration options available to perform a manual installation:

- [Installing Operations Manager from the Command Prompt](/system-center/scom/install-using-cmdline)
- [Process manual agent installations](/system-center/scom/manage-process-manual-agent-install)
- [Install Windows Agent Manually Using MOMAgent.msi](/system-center/scom/manage-deploy-windows-agent-manually)

If the agent is deployed by manual installation, future Service Pack updates or cumulative updates will need to be manually deployed. Computers that have been manually installed won't be designated by the System Center Configuration Management service as being remotely manageable, and the option to upgrade them will not be presented in the Operations console.

Other key considerations during the manual installation of agents:

- If the installation is performed by a domain or local user, the account must be a member of the local Administrators security group in Windows Vista or later versions.
- If the agent is deployed via Configuration Manager, the Configuration Manager Agent service account needs to run as **LocalSystem** (by default) or under the context of a local administrator.

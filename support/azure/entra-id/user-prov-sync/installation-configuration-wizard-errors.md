---
title: How to troubleshoot Azure Active Directory Sync tool installation and Configuration Wizard errors
description: Describes how to troubleshoot Azure Active Directory Sync tool installation and Directory Sync tool Configuration Wizard error messages.
ms.date: 05/09/2022
ms.reviewer: jhayes, willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Troubleshoot Azure Active Directory Sync tool installation and Configuration Wizard errors

This article describes how to troubleshoot Azure Active Directory Sync tool installation and Directory Sync tool Configuration Wizard issues.

_Original product version:_ &nbsp; Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2684395

## Introduction

This article provides resolutions and common causes of error messages that may occur when you install or set up the Directory Sync tool.

## Check system requirements

The Azure Active Directory Sync tool can be installed on a computer if all the following conditions are true:

- Windows PowerShell 1.0 is installed on the computer.
- You're logged on to the computer as a member of the local Administrators group.
- The computer has a 64-bit processor.
- The computer is running one of the following operating systems:
  - Windows Server 2003 x64 with Service Pack 2 (SP2) or a later version
  - An x64-based version of Windows Server 2008
- The computer isn't a domain controller.
- The computer is joined to an Active Directory domain. And it's located in the forest that you want to sync with Microsoft Entra ID.
- The Microsoft .NET Framework 3.5 or a later version is installed on the computer.

## Check permissions

To start the Directory Sync tool Configuration Wizard successfully, users who log on to the computer on which the Directory Sync tool is installed must be a member of the local Microsoft Identity Integration Server (MIIS) Admins group that was added during installation of the tool.

When you run the Directory Sync tool Configuration Wizard, you must provide the following information:

- Enterprise admin credentials for the on-premises Active Directory schema
- Global admin credentials for the Microsoft cloud service

## Check domain connectivity by using nltest

[Nltest](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc731935(v=ws.11)) is a command-line tool that is built into Windows Server. It is available as part of the [Remote Server Administration Tools for Windows 10](https://www.microsoft.com/download/details.aspx?id=45520).

- To check the domain controllers of the domain, run the following command at the command prompt:

    ```console
    nltest /dsgetdc:<FQDN of the domain>
    ```

    > [!NOTE]
    > The `nltest` tool requires installation of the Windows Server 2003 Support Tools.

    If the settings are correct, the output resembles the following example:

    ```output
    DC: \DC.contoso.com 
    Address:\ <IP Address> 
    Dom Guid: <GUID> 
    Dom Name: contoso.com 
    Forest Name: contoso.com 
    DC Site Name: Default-First-Site-Name 
    Our Site Name: Default-First-Site-Name 
    Flags: PDC GC DS LDAP KDC TIMESERV GTIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE 
    The command completed successfully
    ```

- To check the computer's site membership, run the following command at the command prompt:

    ```console
    nltest /dsgetsite
    ```

    A successful result resembles the following example:

    ```output
    Default-First-Site-Name 
    The command completed successfully
    ```

## Error 1: The computer must be joined to a domain

To troubleshoot this issue, check the domain membership of the computer by following these steps:

1. Log on to the computer.
2. Right-click **My Computer**, and then select **Properties**.
3. Select the **Computer Name** tab. If the computer is a domain member, the **Full Computer Name** resembles _ComputerName.Domain.xxx_. The domain name appears next to **Domain**.

If the computer is a domain member, and you still receive the error message, verify that:

- The computer can communicate with the domain.
- The computer can discover the domain controller.

To do so, follow these steps:

1. Use the `ipconfig` command-line tool to check the Domain Name System (DNS) settings on the server.
2. Confirm that you can ping the DNS server that's listed in the network properties on the problem computer.
3. Run the `nslookup` command-line tool. If the DNS server is unreachable, you receive an error message. For example, you receive an error message that resembles the following example:

   > DNS request timed out.  
   > timeout was 2 seconds.  
   > *** Can't find server name for address \<IP Address>: Timed out  
   > Default Server: UnKnown  
   > Address: \<IP Address>

Sometimes, joining the computer to a workgroup, and then joining the computer back to the domain may resolve this error message. If the computer can't join the domain, it indicates one of the following problems:

- The computer is experiencing an issue in contacting the domain controllers.
- The Active Directory domain is rejecting the request.

## Error 2: The Azure Active Directory Sync Tool is already installed

In this case, the Directory Sync tool may not be installed because of a previous pending installation. The Setup package also installs software in the background during installation. To resolve this issue, follow these steps:

1. In Control Panel, check whether Microsoft Identity Integration Server is listed in **Add or Remove Programs** or in **Programs and Features**. If it's present, you must remove it.
2. Verify that the Program Files folder contains a subfolder that's named _Microsoft Identity Integration Server_. If the subfolder exists, you must rename the folder to _Microsoft Identity Integration Server_Old_.
3. Run Setup again.

## Troubleshoot other error messages

All directory synchronization logging is viewable in Event Viewer. To view all events that are related to directory synchronization, follow these steps:

1. Open Event Viewer.
2. Expand **Windows Logs**, and then expand **Application**.
3. In the **Actions** pane, select **Filter Current Log**.
4. In the **Event sources**  box, select the **Directory Synchronization** check box.
5. Select **OK**. The following table lists the error name, the error details, the error source, and the steps to help resolve the error.

|Error name|Details|Source|Resolution|
|---|---|---|---|
|AdminRequired|Local administrator permissions are required to install Directory Synchronization|Event Viewer/ Error prompt||
|DirSyncAlreadyInstalled|The Directory Sync tool is already installed. Version {0}|Event Viewer|Uninstall all earlier versions of the Directory Sync tool before you try to install the latest version.|
|DirSyncInstallKeyNotRemoved|Windows Installer could not remove the uninstall registry key from the Azure Active Directory Sync MSI. Retry uninstall or contact Microsoft Online Support.|Event Viewer|Manually remove the registry keys to complete the installation.|
|DirSyncNotInstalledError|A complete installation of the Azure Active Directory Sync tool was not detected on this machine. Please uninstall any versions of this tool and then reinstall the most recent version.|Event Viewer|Uninstall all earlier versions of the Directory Sync tool before you try to install the latest version.|
|ErrorReRunConfigWizard|Unable to start synchronization due to configuration issues. To fix the issues, try running the Configuration Wizard. If you continue to see this error, please contact Microsoft Online Support.|Event Viewer|Run the Directory Sync tool Configuration Wizard.|
|WindowsInstaller45Required|Microsoft Windows Installer 4.5 is required for installation. Please install Microsoft Windows Installer 4.5 and try again.|Event Viewer|Make sure that the server on which the Directory Sync tool is being installed meets the minimum requirements.|
|ErrorClearRunHistory|Could not clear the run history on the MIIS Server. Error returned is '{0}'. Contact Microsoft Online support.|Event Viewer||
|ErrorNoStartConnection|Synchronization failed to start because of connection issues or domain controllers could not be contacted by the server. Verify that you are connected to the server and all the configured domain controllers are connected to the network. If you have recently deleted domain or naming context, please rerun the Configuration Wizard.|Event Viewer|Confirm that the local Active Directory domain controllers can be accessed from the server running the Directory Sync tool.|
|ErrorNoStartCredentials|Synchronization failed to start because of credential problems. Rerun Configuration Wizard to update credentials for Synchronization.|Event Viewer|Run the Directory Sync tool Configuration Wizard, and reenter credentials. Also, confirm that the credentials have Administrator access to the portal.|
|ErrorNoStartNoDomainController|Synchronization failed to start because the domain controller could not be contacted by the server. Verify that the domain controller is connected to the network.|Event Viewer|Confirm that the local Active Directory domain controllers can be accessed from the server running the Directory Sync tool.|
|ErrorStoppedConnectivity|Synchronization stopped because of connectivity loss. Restore connectivity to the server.||Confirm that the local computer can access the Internet. Have the user try to ping `provisioning.microsoftonline.com` to verify that the computer can reach the Microsoft Entra authentication system.|
|ErrorStoppedDatabaseDiskFull|Synchronization stopped because the SQL Server database used by the Synchronization server is full. Create some space in the SQL Server database.|Event Viewer|Free up space on the storage used to hold the directory synchronization SQL database. If the issue isn't resolved, the Directory Sync tool will be unable to run successfully, and the SQL database may be permanently damaged.|
|InstallNotAllowedOnDomainController|Microsoft Online Services Coexistence cannot be installed on a domain controller.|Event Viewer|The Directory Sync tool can be installed only on domain-joined computers that aren't domain controllers.|
|InstallPathLengthTooLong|The installation path is too long. Provide a path of 116 characters or fewer and then try again.|Event Viewer|If you use a custom path for the installation of the Directory Sync tool, the total path must contain fewer than 116 characters.|
|InsufficientDiskSpace|Insufficient Disk Space|Event Viewer|There's insufficient space to install the Directory Sync tool on the local workstation.|
|InvalidPlatform|The Azure Active Directory Sync tool must be installed on a computer running Windows Server 2003 Service Pack 2 or later.|Event Viewer|Make sure that the server on which the Directory Sync tool is being installed meets the minimum requirements.|
|InvalidUPNFormat|User Principal Name (UPN) is your logon name. This error is displayed when the user enters credentials for Microsoft Online that do not contain an "@" character.|Event Viewer|Enter valid credentials.|
|ADCredsNotValid|The Enterprise Administrator credentials that you supplied are not valid. Supply valid credentials and try again.|Event Viewer|The installation wizard couldn't verify that the user account that's used to install the tool is an enterprise administrator.|
|MachineIsDomainJoinedUserIsNot|The computer is joined to a domain, but the current user credentials do not have access permissions on the domain.|Event Viewer|Log on as a domain user by using an account that meets the minimum requirements before you try to install the Directory Sync tool.|
|MachineIsNotDomainJoined|The computer is not joined to any domain.|Event Viewer|Make sure that the server on which the Directory Sync tool is installed meets the minimum requirements.|
|MachineNotDomainJoined|The computer must be joined to a domain.|Event Viewer|Make sure that the server on which the Directory Sync tool is installed meets the minimum requirements.|
|MIISSyncIsInProgressError|The synchronization engine is busy. Retry this operation after this synchronization session is complete.|Event Viewer|There's an existing operation being completed by MIIS. Any new operation can be completed only after the current operation is complete.|
|MIISUserAddRight_AccountNotFound|Account name:'{0}' could not be found. Error Code:{1}|Event Viewer|The Directory Sync tool couldn't add the local account that's being used to complete the installation to the MIIS Admin Group. Manually add the user to the group to continue with the installation.|
|MIISUserAddRight_AddFailed|'{0}' could not be added to the account rights for '{1}'. Error code:{2}|Event Viewer|The Directory Sync tool couldn't add the local account that's being used to complete the installation to the MIIS Admin Group. Manually add the user to the group to continue with the installation.|
|MIISUserAddRight_PolicyHandleNotFound|Failed to obtain the policy handle. Error Code:{0}|Event Viewer|The Directory Sync tool couldn't add the local account that's being used to complete the installation to the MIIS Admin Group. Manually add the user to the group to continue with the installation.|
|PowerShellRequired|PowerShell must be installed.|Event Viewer|Make sure that the server on which the Directory Sync tool is installed meets the minimum requirements.|
|UnsupportedNameFormat|The name format is not supported. Two examples of the supported user name formats are: `someone@example.com` or `example\someone`.|Event Viewer|Enter valid credentials.|
|UserNotAMemberOfMIISAdmins|The current user is not a member of the Microsoft Identity Integration Server (MIIS) Admin group. If you have recently installed the Azure Active Directory Sync tool, you may need to log off and then log on.|Event Viewer|Manually add the local Active Directory user account that's used to run the Directory Sync tool to the MIIS Admin Group.|
|UserNotAnEnterpriseAdmin|User '{0}' is not a member of the Enterprise Admins group.|Event Viewer|Manually add the local Active Directory user account that's used to run the Directory Sync tool to the Active Directory Enterprise Admin Group.|
|UnsupportedClientVersion|This version of the Directory Sync tool is no longer supported. Remove this version and then install the latest version from the Directory Synchronization page of the Migration tab in the Microsoft Online Services Administration Center.|Event Viewer|Download the latest version of the Directory Sync tool. To do so, go to [Install or upgrade the Directory Sync tool](/azure/active-directory/hybrid/how-to-dirsync-upgrade-get-started).|
|InternetQueryOptionError|Internet Explorer proxy settings were not read. Initial configuration using setup wizard may not be able to access online help. WinInet Error {0}|Event Viewer|The installation wizard couldn't read or change proxy settings in Internet Explorer. Verify that the proxy settings that are set in Internet Explorer are formatted correctly.|
|InternetSetOptionError|Internet Explorer proxy settings were not set. Initial configuration using setup wizard may not be able to access online help. WinInet Error {0}|Event Viewer|The installation wizard couldn't read or change proxy settings in Internet Explorer. Verify that the proxy settings that are set in Internet Explorer are formatted correctly.|
|RichCoexistenceNotAllowed|Current local directory does not have Exchange 2010 installed. Rich coexistence is not allowed.|Event Viewer|Install all the prerequisites for a hybrid deployment before you try to install the Directory Sync tool.|
  
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

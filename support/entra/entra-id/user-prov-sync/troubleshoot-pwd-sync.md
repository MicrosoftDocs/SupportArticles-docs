---
title: How to troubleshoot password synchronization when using an Azure AD Sync appliance
description: Troubleshoots common issues when you're using an Azure Active Directory (Azure AD) sync appliance together with password synchronization.
ms.date: 06/22/2020
ms.reviewer: willfid
ms.service: entra-id
ms.custom: sap:Microsoft Entra Connect Sync
---
# How to troubleshoot password synchronization when using Microsoft Entra Connect

This article helps you troubleshoot common issues that you may encounter when you synchronize passwords from the on-premises environment to Microsoft Entra ID by using [Microsoft Entra Connect](/azure/active-directory/hybrid/whatis-azure-ad-connect).

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2855271

[!INCLUDE [Feedback](../../../includes/feedback.md)]

## Before you start troubleshooting

Before you perform the troubleshooting steps, make sure that you have the [latest version of Microsoft Entra Connect](/azure/active-directory/hybrid/how-to-connect-install-roadmap#install-azure-ad-connect) installed.

Additionally, make sure that directory synchronization is in a healthy state. For more information, see [Troubleshoot object synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-objectsync).

## Some users can't sign in to Microsoft 365, Microsoft Entra, or Microsoft Intune

In this scenario, passwords of most users appear to be syncing. However, there are some users whose passwords appear not to sync. The following are scenarios in which a user can't sign in to a Microsoft cloud service, such as Microsoft 365, Entra, or Intune.

### Scenario 1: The "User must change password at next logon" check box is selected for the user's account

To resolve this issue, follow these steps:

1. Take one of the following actions:
   - In the user account properties in Active Directory Users and Computers, clear the **User must change password at next logon** check box.
   - Have the user change their on-premises user account password.
   - Enable the [ForcePasswordChangeOnLogOn](/azure/active-directory/hybrid/how-to-connect-password-hash-synchronization#synchronizing-temporary-passwords-and-force-password-change-on-next-logon) feature in Microsoft Entra ID.
      
2. Wait a few minutes for the change to sync between the on-premises Active Directory Domain Services (AD DS) and Microsoft Entra ID.

### Scenario 2: The user changed their password in the cloud service portal

To resolve this issue, follow these steps:

1. Have the user change their on-premises user account password.
2. Wait a few minutes for the change to sync between the on-premises AD DS and Microsoft Entra ID.

<a name='scenario-3-some-users-dont-appear-to-be-syncing-to-azure-ad'></a>To change the password in the cloud service and have Microsoft Entra Connect update the respective on-premises user account password, enable [Password Writeback](/entra/identity/authentication/tutorial-enable-sspr-writeback).

### Scenario 3: Some users don't appear to be syncing to Microsoft Entra ID

Possible causes are duplicate user names or email addresses.

To resolve this issue, use the IdFix DirSync Error Remediation Tool (IdFix) to help identify potential object-related issues in the on-premises AD DS. You can install IdFix at the following Microsoft website: [IdFix DirSync Error Remediation Tool](https://github.com/microsoft/idfix)

For more info about how to troubleshoot this issue, see [One or more objects don't sync when using the Azure Active Directory Sync tool](objects-dont-sync-ad-sync-tool.md)

### Scenario 4: Users are moved between included and excluded sync scopes

In this scenario, the user is moved to a scope that now allows the user to be synced. It could be when filtering is set up for domains, organizational units, or attributes.

To resolve this issue, see the **How to perform an initial sync** section.

### Scenario 5: Users can't sign in by using a new password but they can sign in by using their old password

In this scenario, you're using Microsoft Entra Connect together with password synchronization. After you disable directory synchronization or password synchronization, users can't sign in by using a new password. However, their old password still works.

To resolve this issue, re-enable directory synchronization and password synchronization. To do it, start Microsoft Entra Connect configuration wizard, select **Configure** and **Customize synchronization options**, then continue through the screens until you see the option to enable password synchronization.

### Scenario 6: Users can't sign in by using their password

In this scenario, the password hash doesn't successfully sync to Microsoft Entra ID. If the user account was created in on-premises AD DS on a version of Windows Server earlier than Windows Server 2003, the account doesn't have a password hash.

## Directory synchronization is running but passwords of all users aren't synced

In this scenario, passwords of all users appear not to sync. It usually occurs if one of the following conditions is true:

- The check box to **Start the synchronization process when configuration completes**, wasn't selected.

- Entra Connect server is in Staging mode.

- Password synchronization is disabled.

- A full directory sync hasn't yet completed.

> [!IMPORTANT]
> Password sync will not start until a full directory sync has completed.

To resolve this issue, first make sure that you enable password synchronization. To do it, start Microsoft Entra Connect configuration wizard, select **Configure** and **Customize synchronization options**, then continue through the screens until you see the option to enable password synchronization.

After password synchronization is enabled, you must wait for a full password sync to finish. Check the Windows [Event Viewer logs](troubleshoot-pwd-sync.md#event-id-messages-in-event-viewer) to monitor the password synchronization process.

## Troubleshoot one user whose password isn't synced

To troubleshoot this issue, see [Troubleshoot password hash synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization#one-object-is-not-synchronizing-passwords-troubleshoot-by-using-the-troubleshooting-task)

## You're changing from a single-sign on (SSO) solution to password synchronization

To resolve this issue, see [How to switch from Single Sign-On to Password Sync](/archive/technet-wiki/17857.dirsync-how-to-switch-from-single-sign-on-to-password-sync).

## Event ID messages in Event Viewer

The following tables list event ID messages in the Application log that are related to password synchronization.

### Informational (no action required)

|Event ID  |Description  |Cause  |
|---------|---------|---------|
| 622|Full password hash synchronization completed for domain: contoso.local|Full password synchronization cycle finishes retrieving the recent passwords from the on-premises AD DS domain.|
| 623|Full password hash synchronization completed for forest: contoso.local|Full password synchronization cycle finishes retrieving the recent passwords from the on-premises AD DS forest.|
| 650|Provision credentials batch start. Count: 1|Password synchronization starts retrieving updated passwords from the on-premises AD DS.|
| 651|Provision credentials batch end. Count: 1|Password synchronization finishes retrieving updated passwords from the on-premises AD DS.|
| 653|Provision credentials ping start.|Password synchronization starts informing Microsoft Entra ID that there are no passwords to be synced. It occurs every 30 minutes if no passwords have been updated in the on-premises AD DS.|
| 654|Provision credentials ping end.|Password synchronization finishes informing Microsoft Entra ID that there are no passwords to be synced. It occurs every 30 minutes if no passwords were updated in the on-premises AD DS.|
| 656|Password Change Request - Anchor: H552hI9GwEykZwosf74JeOQ==, Dn: CN=Viola Hanson,OU=Cloud Objects,DC=contoso,DC=local, Change Date: 05/01/2013 16:34:08|Password synchronization indicates that a password change was detected and tries to sync it to Microsoft Entra ID. It identifies the user or users whose password changed and will be synced. Each batch contains at least one user and at most 50 users.|
| 657|Password Change Result - Anchor: eX5b50Rf+UizRIMe2CA/tg==, Dn: CN=Viola Hanson,OU=Cloud Objects,DC=contoso,DC=local, Result: Success.|Users whose password successfully synced.|
| 657|Password Change Result - Anchor: eX5b50Rf+UizRIMe2CA/tg==, Dn: CN=Viola Hanson,OU=Cloud Objects,DC=contoso,DC=local, Result: Failed.|Users whose password didn't sync.|
  
### Informational (may require action)

|Event ID|Description|Cause|More information|
|---|---|---|---|
| 0|The following password changes failed to synchronized and have scheduled for retry.<br/><br/>DN = CN=Eli McLean,OU=Cloud Objects,DC=contoso,DC=local|User or users whose password wasn't synced|[Configure directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_configuretool) <br/><br/>[One or more objects don't sync when using the Azure Active Directory Sync tool](objects-dont-sync-ad-sync-tool.md)|
| 115|Access to Windows Azure Active Directory has been denied. Contact Technical Support.|Microsoft Entra credentials were updated through Forefront Identity Manager (FIM).|Run the Microsoft Entra Configuration Wizard again. See [Password hash synchronization stops working after you update Microsoft Entra credentials in FIM](pwd-hash-sync-stop-work-fim.md)|
| 657|Password Change Result - Anchor: B0H+OD3LM0GEnYODwdPhpg==, Result: failed, Extended Error:|User or users whose password wasn't synced|[Configure directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_configuretool) <br/><br/>[One or more objects don't sync when using the Azure Active Directory Sync tool](objects-dont-sync-ad-sync-tool.md) |
  
### Error (action required)

|Event ID|Description|Cause|More information|
|---------|---------|---------|---------|
|0|The user name or password is incorrect. Verify your user name, and then type your password again.|Microsoft Entra credentials were updated through Forefront Identity Manager (FIM).|Run the Microsoft Entra Configuration Wizard again. See [Password hash synchronization stops working after you update Microsoft Entra credentials in FIM](pwd-hash-sync-stop-work-fim.md)|
|611|Password synchronization failed for domain: `Contoso.com`.<br/><br/>Microsoft.Online.PasswordSynchronization.SynchronizationManagerException: Recovery task failed. ---> Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8439: The distinguished name specified for this replication operation is invalid. There was an error calling _IDL_DRSGetNCChanges.|Windows Server 2003 domain controllers handle certain scenarios unexpectedly.| [Password hash synchronization for Microsoft Entra ID stops working and Event ID 611 is logged](pwd-hash-sync-stops-work.md)|
|611|Password synchronization failed for domain: `Contoso.com`.<br/><br/>Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8593: The directory service cannot perform the requested operation because the servers involved are of different replication epochs (which is usually related to a domain rename that is in progress).|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|611|Password synchronization failed for domain: `Contoso.com`<br/><br/>System.ArgumentOutOfRangeException: Not a valid Win32|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|611|Password synchronization failed for domain: `Contoso.com`.<br/><br/>System.ArgumentException: An item with the same key has already been added.|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|652|Failed credential provisioning batch. Error: Microsoft.Online.Coexistence.ProvisionException: An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company. Tracking ID: 07e93e8a-cf2d-4f67-9e95-53169c4875e0 Server Name: BL2GR1BBA003. ---> System.ServiceModel.FaultException1[Microsoft.Online.Coexistence.Schema.AdminWebServiceFault]: Password Synchronization has not been activated for this company. (Fault Detail is equal to Microsoft.Online.Coexistence.Schema.AdminWebServiceFault).|Password synchronization failed when retrieving updated passwords from the on-premises AD DS.|[Configure directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_configuretool) <br/><br/>[One or more objects don't sync when using the Azure Active Directory Sync tool](objects-dont-sync-ad-sync-tool.md)|
|652|Failed credential provisioning batch. Error: Microsoft.Online.Coexistence. ProvisionRetryException: An error occurred. Error Code: 81. Error Description: Windows Azure Active Directory is currently busy. This operation will be retried automatically.|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|655|Failed credential provisioning ping. Error: Microsoft.Online.Coexistence.ProvisionException: An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company. Tracking ID: 0744fa31-1d9b-453a-83d8-c2555d843802 Server Name: BL2GR1BBA005. ---> System.ServiceModel.FaultException1[Microsoft.Online.Coexistence.Schema.AdminWebServiceFault]: Password Synchronization has not been activated for this company. (Fault Detail is equal to Microsoft.Online.Coexistence.Schema.AdminWebServiceFault).|Password synchronization failed to inform Microsoft Entra ID that there are no passwords to be synced. It occurs every 30 minutes.|[Configure directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_configuretool) <br/><br/>[One or more objects don't sync when using Azure Active Directory Sync tool](objects-dont-sync-ad-sync-tool.md)|
|655|The user name or password is incorrect. Verify your user name, and then type your password again.|Microsoft Entra credentials were updated through FIM.|Run the Microsoft Entra Configuration Wizard again. See the following Microsoft Knowledge Base article: [Password hash synchronization stops working after updating Microsoft Entra credentials in FIM](pwd-hash-sync-stop-work-fim.md)|
|6900|The server encountered an unexpected error while processing a password change notification:<br/><br/>"The user name or password is incorrect. Verify your user name, and then type your password again.|Microsoft Entra credentials were updated through FIM.|Run the Microsoft Entra Configuration Wizard again. See the following Microsoft Knowledge Base article: [Password hash synchronization stops working after updating Microsoft Entra credentials in FIM](pwd-hash-sync-stop-work-fim.md)|
|6900|The server encountered an unexpected error while processing a password change notification:<br/><br/>"An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company|Password sync isn't enabled for the organization.|See the following Microsoft Knowledge Base article: [User passwords aren't synced, and "Password Synchronization has not been activated for this company" error is logged in Event Viewer](/office365/troubleshoot/active-directory/password-synchronization-not-activated)|
  
## More information

### How to perform an initial sync

To do a full sync, follow these steps, as appropriate on the Microsoft Entra Connect that you're using.

1. On the server where Microsoft Entra Connect is installed, open PowerShell, and then import ADSync module:

```powershell
   Import-Module ADSync
```
      
2. Run the following commands to start an initial sync cycle:

```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```

### How to perform a full password sync

To do a full password sync, run the script that's on this page: [Azure AD Sync: How to Use PowerShell to Trigger a Full Password Sync](/archive/technet-wiki/28433.azure-ad-sync-how-to-use-powershell-to-trigger-a-full-password-sync)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

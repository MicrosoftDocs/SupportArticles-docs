---
title: How to troubleshoot password synchronization when using an Azure AD sync appliance
description: Troubleshoots common issues when you're using an Azure Active Directory (Azure AD) sync appliance together with password synchronization.
ms.date: 06/22/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# How to troubleshoot password synchronization when using an Azure AD sync appliance

This article helps you troubleshoot common issues that you may encounter when you synchronize passwords from the on-premises environment to Azure Active Directory (Azure AD) by using an Azure AD sync appliance.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Azure Active Directory, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2855271

## Before you start troubleshooting

Before you perform the troubleshooting steps, make sure that you have the latest version of Azure AD Connect installed.

> [!NOTE]
> All other Azure AD Sync appliances are being deprecated. Therefore, if you're using another appliance, install Azure AD Connect.

Additionally, make sure that directory synchronization is in a healthy state. To help you with it, run the Troubleshooting Directory Synchronization tool. To run the troubleshooter tool, on the server on which the Azure AD sync appliance is installed, open Internet Explorer, browse to `http://aka.ms/hrcsync`, and then follow the steps on the screen.

## Some users can't sign in to Office 365, Azure, or Microsoft Intune

In this scenario, passwords of most users appear to be syncing. However, there are some users whose passwords appear not to sync. The following are scenarios in which a user can't sign in to a Microsoft cloud service, such as Office 365, Azure, or Intune.

### Scenario 1: The "User must change password at next logon" check box is selected for the user's account

To resolve this issue, follow these steps:

1. Take one of the following actions:
   - In the user account properties in Active Directory Users and Computers, clear the **User must change password at next logon** check box.
   - Have the user change their on-premises user account password.
2. Wait a few minutes for the change to sync between the on-premises Active Directory Domain Services (AD DS) and Azure AD.

### Scenario 2: The user changed their password in the cloud service portal

To resolve this issue, follow these steps:

1. Have the user change their on-premises user account password.
2. Wait a few minutes for the change to sync between the on-premises AD DS and Azure AD.

### Scenario 3: Some users don't appear to be syncing to Azure AD

Possible causes are duplicate user names or email addresses.

To resolve this issue, use the IdFix DirSync Error Remediation Tool (IdFix) to help identify potential object-related issues in the on-premises AD DS. You can install IdFix at the following Microsoft website: [IdFix DirSync Error Remediation Tool](https://github.com/microsoft/idfix)

For more info about how to troubleshoot this issue, see [One or more objects don't sync when using the Azure Active Directory Sync tool](https://support.microsoft.com/help/2643629)

### Scenario 4: Users are moved between filtered and unfiltered scopes

In this scenario, the user is moved to a scope that now allows the user to be synced. It could be when filtering is set up for domains, organizational units, or attributes.

To resolve this issue, see the **How to perform a full password sync** section.

### Scenario 5: Users can't sign in by using a new password but they can sign in by using their old password

In this scenario, you're using the Azure AD Sync Service together with password synchronization. After you disable and then re-enable directory synchronization, users can't sign in by using a new password. However, their old password still works.

To resolve this issue, re-enable password synchronization. To do it, start the Azure AD sync appliance Configuration Wizard, and then continue through the screens until you see the option to enable password synchronization.

### Scenario 6: Users can't sign in by using their password

In this scenario, the password hash doesn't successfully sync to the Azure AD Sync Service. If the user account was created in Active Directory running on a version of Windows Server earlier than Windows Server 2003, the account doesn't have a password hash.

## Directory synchronization is running but passwords of all users aren't synced

In this scenario, passwords of all users appear not to sync. It usually occurs if one of the following conditions is true:

- The **Synchronize now** check box wasn't selected.
- You enabled password synchronization after directory sync already occurred.
- A full directory sync hasn't yet completed.

> [!IMPORTANT]
> Password sync will not start until a full directory sync has completed.

To resolve this issue, first make sure that you enable password synchronization. To do it, start the Azure AD sync appliance Configuration Wizard, and then continue through the screens until you see the option to enable password synchronization.

After password synchronization is enabled, you must do a full password sync. See How to perform a full password sync section.

For more information, see [Troubleshoot password hash synchronization with Azure AD Connect sync](https://docs.microsoft.com/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization#one-object-is-not-synchronizing-passwords-troubleshoot-by-using-the-troubleshooting-task).

## Troubleshoot one user whose password isn't synced

To troubleshoot this issue, see [Troubleshoot password hash synchronization with Azure AD Connect sync](https://docs.microsoft.com/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization#one-object-is-not-synchronizing-passwords-troubleshoot-by-using-the-troubleshooting-task)

## You're changing from a single-sign on (SSO) solution to password synchronization

To resolve this issue, see [How to switch from Single Sign-On to Password Sync](https://social.technet.microsoft.com/wiki/contents/articles/17857.how-to-switch-from-single-sign-on-to-password-sync.aspx).

## Event ID messages in Event Viewer

The following tables list event ID messages in the Application log that are related to password synchronization.

### Informational (no action required)

|Event ID  |Description  |Cause  |
|---------|---------|---------|
| 650|Provision credentials batch start. Count: 1|Password synchronization starts retrieving updated passwords from the on-premises AD DS.|
| 651|Provision credentials batch end. Count: 1|Password synchronization finishes retrieving updated passwords from the on-premises AD DS.|
| 653|Provision credentials ping start.|Password synchronization starts informing Azure AD that there are no passwords to be synced. It occurs every 30 minutes if no passwords have been updated in the on-premises AD DS.|
| 654|Provision credentials ping end.|Password synchronization finishes informing Azure AD that there are no passwords to be synced. It occurs every 30 minutes if no passwords were updated in the on-premises AD DS.|
| 656|Password Change Request - Anchor : H552hI9GwEykZwosf74JeOQ==, Dn : CN=Viola Hanson,OU=Cloud Objects,DC=contoso,DC=local, Change Date : 05/01/2013 16:34:08|Password synchronization indicates that a password change was detected and tries to sync it to Azure AD. It identifies the user or users whose password changed and will be synced. Each batch contains at least one user and at most 50 users.|
| 657|Password Change Result - Anchor : eX5b50Rf+UizRIMe2CA/tg==, Dn : CN=Viola Hanson,OU=Cloud Objects,DC=contoso,DC=local, Result : Success.|Users whose password successfully synced.|
| 657|Password Change Result - Anchor : eX5b50Rf+UizRIMe2CA/tg==, Dn : CN=Viola Hanson,OU=Cloud Objects,DC=contoso,DC=local, Result : Failed.|Users whose password didn't sync.|
||||

### Informational (may require action)

|Event ID|Description|Cause|More information|
|---|---|---|---|
| 0|The following password changes failed to synchronized and have scheduled for retry.<br/>DN = CN=Eli McLean,OU=Cloud Objects,DC=contoso,DC=local|User or users whose password wasn't synced|[Configure directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_configuretool) <br/>[One or more objects don't sync when using the Azure Active Directory Sync tool|](https://support.microsoft.com/help/2643629)
| 115|Access to Windows Azure Active Directory has been denied. Contact Technical Support.|Azure AD credentials were updated through Forefront Identity Manager (FIM).|Run the Azure AD Configuration Wizard again. See [Password hash synchronization stops working after you update Azure Active Directory credentials in FIM](https://support.microsoft.com/help/2962509)<br/>|
| 657|Password Change Result - Anchor : B0H+OD3LM0GEnYODwdPhpg==, Result : failed, Extended Error :|User or users whose password wasn't synced|[Configure directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_configuretool) <br/>[One or more objects don't sync when using the Azure Active Directory Sync tool](https://support.microsoft.com/help/2643629) |
|||||

### Error (action required)

|Event ID|Description|Cause|More information|
|---------|---------|---------|---------|
|0|The user name or password is incorrect. Verify your user name, and then type your password again.|Azure AD credentials were updated through Forefront Identity Manager (FIM).|Run the Azure AD Configuration Wizard again. See [Password hash synchronization stops working after you update Azure Active Directory credentials in FIM](https://support.microsoft.com/help/2962509)|
|611|Password synchronization failed for domain: `Contoso.com`.<br/><br/>Microsoft.Online.PasswordSynchronization.SynchronizationManagerException: Recovery task failed. ---> Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8439 : The distinguished name specified for this replication operation is invalid. There was an error calling _IDL_DRSGetNCChanges.|Windows Server 2003 domain controllers handle certain scenarios unexpectedly.| [Password hash synchronization for Azure AD stops working and Event ID 611 is logged](https://support.microsoft.com/help/2867278)|
|611|Password synchronization failed for domain: `Contoso.com`.<br/><br/>Microsoft.Online.PasswordSynchronization.DirectoryReplicationServices.DrsException: RPC Error 8593 : The directory service cannot perform the requested operation because the servers involved are of different replication epochs (which is usually related to a domain rename that is in progress).|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|611|Password synchronization failed for domain: `Contoso.com`<br/>System.ArgumentOutOfRangeException: Not a valid Win32|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|611|Password synchronization failed for domain: `Contoso.com`.<br/>System.ArgumentException: An item with the same key has already been added.|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807.|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|652|Failed credential provisioning batch. Error: Microsoft.Online.Coexistence.ProvisionException: An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company. Tracking ID: 07e93e8a-cf2d-4f67-9e95-53169c4875e0 Server Name: BL2GR1BBA003. ---> System.ServiceModel.FaultException1[Microsoft.Online.Coexistence.Schema.AdminWebServiceFault]: Password Synchronization has not been activated for this company. (Fault Detail is equal to Microsoft.Online.Coexistence.Schema.AdminWebServiceFault).|Password synchronization failed when retrieving updated passwords from the on-premises AD DS.|<br/> [Configure directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_configuretool) <br/> [One or more objects don't sync when using the Azure Active Directory Sync tool](https://support.microsoft.com/help/2643629)|
|652|Failed credential provisioning batch. Error: Microsoft.Online.Coexistence. ProvisionRetryException : An error occurred. Error Code: 81. Error Description: Windows Azure Active Directory is currently busy. This operation will be retried automatically.|It was a known issue that was fixed in Azure Active Directory Sync tool build 1.0.6455.0807|To resolve this issue, update to latest version of the Azure Active Directory Sync tool.|
|655|Failed credential provisioning ping. Error: Microsoft.Online.Coexistence.ProvisionException: An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company. Tracking ID: 0744fa31-1d9b-453a-83d8-c2555d843802 Server Name: BL2GR1BBA005. ---> System.ServiceModel.FaultException1[Microsoft.Online.Coexistence.Schema.AdminWebServiceFault]: Password Synchronization has not been activated for this company. (Fault Detail is equal to Microsoft.Online.Coexistence.Schema.AdminWebServiceFault).|Password synchronization failed to inform Azure AD that there are no passwords to be synced. It occurs every 30 minutes.|<br/>- [Configure directory synchronization](https://technet.microsoft.com/library/jj151771.aspx#bkmk_configuretool) <br/>- [2643629](https://support.microsoft.com/help/2643629) One or more objects don't sync when using the Azure Active Directory Sync tool|
|655|The user name or password is incorrect. Verify your user name, and then type your password again.|Azure AD credentials were updated through FIM.|Run the Azure AD Configuration Wizard again. See the following Microsoft Knowledge Base article: [2962509](https://support.microsoft.com/help/2962509) Password hash synchronization stops working after you update Azure Active Directory credentials in FIM<br/>|
|6900|The server encountered an unexpected error while processing a password change notification:<br/><br/>"The user name or password is incorrect. Verify your user name, and then type your password again.|Azure AD credentials were updated through FIM.|Run the Azure AD Configuration Wizard again. See the following Microsoft Knowledge Base article: [2962509](https://support.microsoft.com/help/2962509) Password hash synchronization stops working after you update Azure Active Directory credentials in FIM<br/>|
|6900|The server encountered an unexpected error while processing a password change notification:<br/><br/>"An error occurred. Error Code: 90. Error Description: Password Synchronization has not been activated for this company|Password sync isn't enabled for the organization.|See the following Microsoft Knowledge Base article:<br/> [2848640](https://support.microsoft.com/help/2848640) User passwords aren't synced, and "Password Synchronization has not been activated for this company" error is logged in Event Viewer<br/>|
|||||

## More information

### How to perform a full password sync

To do a full password sync, follow these steps, as appropriate for the Azure AD sync appliance that you're using.

1. If you're using the Azure Active Directory Sync tool:

   1. On the server where the tool is installed, open PowerShell, and then run the following command:

      ```powershell
      Import-Module DirSync
      ```

   2. Run the following commands:

      ```powershell
      Set-FullPasswordSync
      ```

      ```powershell
      Restart-Service FIMSynchronizationService -Force
      ```

2. If you're using the Azure AD Sync Service or Azure AD Connect, run the script that's on this page: [Azure AD Sync: How to Use PowerShell to Trigger a Full Password Sync](https://social.technet.microsoft.com/wiki/contents/articles/28433.how-to-use-powershell-to-trigger-a-full-password-sync-in-azure-ad-sync.aspx)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.

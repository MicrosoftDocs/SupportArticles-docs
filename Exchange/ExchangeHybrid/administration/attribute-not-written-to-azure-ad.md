---
title: Exchange Online attributes aren't written back to on-premises AD directory service
description: Describes issues that occur when you use the Azure Active Directory Sync tool to sync Azure AD with Active Directory in an Exchange hybrid deployment scenario. Provides a resolution.
author: Norman-sun
audience: ITPro
ms.prod: office 365
ms.topic: troubleshooting
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.author: v-swei
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Exchange Online
- Office 365 Identity Management
---
# Attributes for Exchange Online aren't written back to on-premises AD directory service

## Problem

After you set up Exchange federation for a hybrid deployment scenario, when you try to use the Microsoft Azure Active Directory Sync tool to sync Azure Active Directory (Azure AD) with your on-premises Active Directory, the following issues may occur:

- Changes that are made to objects through the Exchange admin center or Exchange Online PowerShell aren't synced to the on-premises Active Directory installation.
- Exchange Server features that are expected to work together for the cloud and on-premises don't work as expected.
- You can't view or share online calendars with on-premises users or Exchange Online users.
- You don't receive the most current free/busy information between on-premises and cloud users.
- An error 8344 occurs in Microsoft Identity Integration Server (MIIS) that says, "Insufficient access rights to perform the operation."

These symptoms may occur if shared Exchange features aren't enabled and if the incorrect permissions are applied to Active Directory attributes.

## Resolution

To resolve this issue, follow these steps.

### Step 1: Run the Azure Active Directory Sync tool Configuration Wizard

Make sure that the latest version of the Directory Sync tool is installed and that you run the Azure Active Directory Sync tool Configuration Wizard. When you run the wizard, one screen prompts you to enable rich coexistence. Complete the wizard, and then start directory synchronization.

Alternatively, you can run the `Enable-MSOnlineRichCoexistence` cmdlet after the Directory Sync tool is installed to enable the write-back feature. This cmdlet must be run by using enterprise credentials or should be run by the enterprise admin.

### Step 2: Confirm MSOL_AD_Sync_RichCoexistence permissions

If step 1 doesn't resolve the issue, check that the MSOL_AD_Sync user belongs to the MSOL_AD_Sync_RichCoexistence group and that the group has Allow permissions to the user who is experiencing the issue, where write-back is not working for the following attributes:

- `msExchSafeSendersHash`
- `msExchBlockedSendersHash`
- `msExchSafeRecipientHash`
- `msExchArchiveStatus`
- `msExchUCVoiceMailSettings`
- `ProxyAddresses`

To do this, follow these steps:

1. In Active Directory, make sure that the MSOL_AD_Sync_RichCoexistence group exists and that the MSOL_AD_Sync user is a member of the group.
2. In the on-premises environment, use Active Directory Users and Computers to open the user properties for the user who is experiencing the issue.
3. On the **Security** tab, click **Advanced**.

   > [!NOTE]
   > You must enable advanced features to complete step 3.
4. Make sure that the MSOL_AD_Sync_RichCoexistence group is listed. If it's not listed, add the group, and then make sure that the group is granted Allow permissions to write to the attributes that are listed previously.

> [!NOTE]
> Step 2 may be required if the object does not inherit permissions from the parent. This issue may be resolved by making sure that the object inherits permissions from the parent object.

## More information

To run the `Enable-MSOnlineRichCoexistence` cmdlet, follow these steps:

1. Open Windows PowerShell, type Import-Module DirSync, and then press Enter.
1. Type the following cmdlet, and then press Enter:

   ```powershell
   Enable-MSOnlineRichCoexistence
   ```

1. When you're prompted for credentials, enter your enterprise admin credentials.

When you run the `Enable-MSOnlineRichCoexistence` cmdlet, the cmdlet performs the following actions:

- Checks that directory synchronization is running. If directory synchronization is running, the following warning message is displayed:

  > MSO directory sync is syncing please try again later.

- Sets Write permissions on all attributes for the MSOL_AD_SYNC account that directory synchronization created in the on-premises environment.
- Loads the Source MA and metaverse configurations for the write-back option that was selected. To do this, the `Set-MSOnlineWriteBack` cmdlet runs the `Import-MIISServerConfig [-file path]` cmdlet, where *file path* represents the location of the MA and metaverse config files that are included with the directory synchronization installation.
- Sets the AD MA credentials because the cmdlet has installed a "new" Source MA by using the following cmdlet:

  ```powershell
  Set-MIISADMAconfiguration [-forest] [-login] [-password] [-MA Name]
  ```  

- Sets the Target MA credentials by using the following cmdlet:
  
  ```powershell
  Set-MIISExtMAConfiguration [-MOAC login] [-MOAC password] [-connection URL] [-MA Name]
  ```

- Sets the `FullSyncNeeded` registry value to indicate a full synchronization.
- Calls `Start-OnlineCoexistenceSync` to start directory synchronization by using the new configurations. The first sync is a full synchronization.

## References

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.

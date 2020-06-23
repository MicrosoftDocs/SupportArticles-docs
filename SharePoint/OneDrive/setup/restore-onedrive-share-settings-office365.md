---
title: How to restore Office 365 admin center Sharing settings for OneDrive
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 6/12/2020
audience: Admin
ms.topic: article
ms.prod: onedrive
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- OneDrive
ms.custom: 
- CI 117857
- CSSTroubleshoot 
ms.reviewer: paulpa
description: Describes how to restore the Sharing setting for OneDrive in the Office 365 admin center. 
---

# Restore the OneDrive Sharing settings in Office 365 admin center

## Symptoms

When users select the user details in the [Office 365 admin center](https://admin.microsoft.com/Adminportal/Home?source=applauncher#/users), the **OneDrive Sharing** option is no longer available to them.

:::image type="content" source="../media/restore-onedrive-share-settings-office365/restore-onedrive-share-settings-office365-1.png" alt-text="The Sharing option in the admin center.":::
 
## Cause

This problem occurs if a user navigates to **User details** > **OneDrive** > **Sharing section** > **Manage external sharing** and clears the **Let people outside your organization access your site** check box.

:::image type="content" source="../media/restore-onedrive-share-settings-office365/restore-onedrive-share-settings-office365-2.png" alt-text="Manage external sharing screen.":::

## Resolution

To restore the **OneDrive Sharing** option, follow these steps:

1.	Find the user MySite URL. For example:
    > `https://m365x328152-my.sharepoint.com/personal/meganb_m365x328152_contoso_com`
 
2.	Run the following commands in the [SharePoint Online Management Shell](https://www.microsoft.com/download/details.aspx?id=35588):

     ```powershell
     Connect-SPOService -Url https://m365x328152-admin.sharepoint.com/

     Set-SPOSite -Identity https://m365x328152-my.sharepoint.com/personal/meganb_m365x328152_contoso_com  -SharingCapability ExternalUserSharingOnly
     ```

     > [!NOTE]
     > In these commands, replace the URLs with the actual site URLs.

## More information

For more information, see the article about the [Set-SPOSite cmdlet](https://docs.microsoft.com/powershell/module/sharepoint-online/set-sposite?view=sharepoint-ps).

### How to find the user's MySite URL

#### Option 1

1.	Go to the **Office 365 admin center**.
2.	Select **Active user** > **Account details** > **OneDrive**.
3.	Under **Get access to files**, select **Create link to files** to see the user's **MySite** URL.

#### Option 2
1.	Sign in to the **SharePoint Online admin center**, and then select **More features**.
2.	Under **User profiles**, select **Open**.
3.	Search for and select the user profile. 
4.	Select the arrow at the end of the **Account name**, and then select **Manage Personal Site** to go to the user’s OneDrive site. 

#### Option 3

Use the following PnP PowerShell command to obtain the OneDrive URL of the user:
1.	Start PowerShell.
2.	In the command window, run the following commands:

     ```powershell
     #Set Config Parameters
     $AdminSiteURL="https://<tenantName>-admin.sharepoint.com"
     $UserAccount="<userUPN@domain.com>" #UPN
 
     #Connect to the site
     Connect-PnPOnline $AdminSiteURL -Credentials (Get-Credential)
 
     #powershell to get onedrive for business url
     Get-PnPUserProfileProperty -Account $UserAccount | Select PersonalUrl
     ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
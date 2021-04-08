---
title: This feature has been disabled by your administrator error in Microsoft Office
description: Describes an issue that triggers an error in Office 2013 applications when you try to sign in or share a file. This issue involves certain registry settings. A resolution is provided.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-maqiu
ms.custom:
- CSSTroubleshoot
- CI 124941
appliesto:
- Word O365
- Excel O365
- Outlook O365
- PowerPoint O365
- Publisher O365
- Word 2019
- Excel 2019
- Outlook 2019
- PowerPoint 2019
- Publisher 2019
- Word 2016
- Excel 2016
- Outlook 2016
- PowerPoint 2016
- Publisher 2016
- Microsoft Office 2013 Service Pack 1
- Word 2013
- Excel 2013
- Outlook 2013
- PowerPoint 2013
- Publisher 2013
---
# (This feature has been disabled by your administrator) error in Microsoft Office

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you try to perform certain actions in Microsoft Office O365, 2019, 2016, or 2013 applications, you receive the following error message:

> This feature has been disabled by your administrator.

The actions that trigger this error message may include the following:

- On the **File** menu, you click **Account** or **Office Account**, and then you click **Sign In**.
- On the **File** menu, you click **Share**, and then you click **Present Online**.
- On Microsoft SharePoint Server or in OneDrive for Business, you click **Sync Now**.

In Office 2013, Office 2016, and Office 2019, this error affects connected experience. In Office 365 ProPlus, this error affects Office licensing and connected experience.

## Cause

This issue occurs if one of the following registry values is configured as specified:

> [!NOTE]
> The *xx* placeholder in the following registry entry is **15** for Office 2013 and 16 for Office 2016, Office 2019, and Office 365 ProPlus.

- `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Common\Internet`

  Name: `UseOnlineContent`  
  Type: DWORD  
  Value: 0
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Common\Internet`
  
  Name: `UseOnlineContent`  
  Type: DWORD  
  Value: 0
- `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Common\SignIn`
  
  Name: `SignInOptions`  
  Type: DWORD  
  Value: 3
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Common\SignIn`
  
  Name: `SignInOptions`  
  Type: DWORD  
  Value: 3

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, follow these steps to modify the registry:

1. Exit Microsoft Outlook.
1. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows:

   - Windows 8: Press Windows Key+R to open a **Run** dialog box. Then, type **regedit.exe**,and then press **OK**.
   - Windows 7: Click **Start**, type **regedit.exe** in the search box, and then press Enter.

1. In Registry Editor, locate and then click the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Common\Internet`

   > [!NOTE]
   > The *xx* placeholder is **15** for Office 2013 and **16** for Office 2016, Office 2019, and Office 365 ProPlus.

1. Locate and then double-click the following value: `UseOnlineContent`.
1. In the **Value Data** box, type **2**, and then click **OK**.
1. Locate and then click the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Common\SignIn`

   > [!NOTE]
   > The *xx* placeholder is **15** for Office 2013 and **16** for Office 2016, Office 2019, and Office 365 ProPlus.

   For Office 365 ProPlus, you also locate and select this subkey:

   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Cloud\Office\16.0\Common\SignIn`

1. Locate and then double-click the following value: `SignInOptions`.
1. In the **Value Data** box, type **0**, and then click **OK**.
1. Exit Registry Editor.

> [!NOTE]
> If the `UseOnlineContent` or `SignInOptions` value is located under the **Policies** hive, it may have been created by Group Policy. In this situation, your administrator must modify the policy to change this setting if the administrator set the value.

## More Information

The `UseOnlineContent` setting controls users' access to the Office online features. This setting can be configured by using the following values:

- 0 = Don't allow Office to connect to the Internet. Office applications don't connect to the Internet to access online services or to download the latest online content from Office.com. Connected features of Office are disabled.
- 2 = Allow Office to connect to the Internet. Office applications use online services and download the latest online content from Office.com when users' computers are connected to the Internet. Connected features of Office are enabled. This option enforces the default configuration.

The `SignInOptions` setting controls whether users can provide credentials to Office by using either their Windows Live ID or the user ID that was assigned by their organization (Org ID) for accessing Office 365. This setting can be configured by using the following values:

- 0 = Both IDs allowed
- 1 = Microsoft Account only (see the note below)
- 2 = Org ID only
- 3 = Users can't sign in by using either ID (see the note below)

> [!NOTE]
> Based on the [recent license improvements](https://techcommunity.microsoft.com/t5/office-365-blog/office-365-client-licensing-and-activation-improvements/ba-p/763694), users are required to sign in to activate Office on their devices. We don't recommend using options **1** and **3** for `SignInOptions` in Office 365 ProPlus. Either of these options will block sign-ins that use work accounts or Azure Active Directory (AAD) accounts and users won't be able to access Office clients.

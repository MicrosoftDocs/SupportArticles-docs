---
title: We can't connect to the specified SharePoint site
description: Describes an issue that triggers a We can't connect to the specified SharePoint site error. Occurs when you click Sync Now in OneDrive for Business or SharePoint. A resolution is provided.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - OneDrive for Business
ms.date: 12/17/2023
---

# OneDrive for Business sync returns the error "We can't connect to the specified SharePoint site"

## Symptoms

When you click **Sync Now** in Microsoft SharePoint or OneDrive for Business, the following error is returned:

> We can't connect to the specified SharePoint site

:::image type="content" source="media/onedrive-for-business-sync-returns-error/error-message-dialog-box.png" alt-text="Screenshot of the OneDrive for Business sync error message dialog box." border="false":::

## Cause

This issue occurs if one of the following registry values is configured as follows:

- `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Common\SignIn`
  
  Name: SignInOptions

  Type: DWORD

  Value: 3

- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Common\SignIn`

  Name: SignInOptions

  Type: DWORD

  Value: 3

SignInOptions=3 restricts you from signing in to SharePoint or SharePoint Online by using either a Microsoft or an organizational ID.

> [!NOTE]
> The x.0 placeholder represents your Office version (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365 Apps, 15.0 = Office 2013).

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, follow these steps:

1. Click **OK** to close the sync window.
2. Start Registry Editor.
3. Locate and select the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Common\SignIn`

4. Double-click the **SignInOptions** value.
5. In the **Value Data** box, type **0**, and then click OK.
6. Exit Registry Editor.

> [!NOTE]
> If the SignInOptions value is located under the Policies hive, it may have been created by Group Policy. In this situation, your administrator must modify the policy to change this setting.

## More Information

The SignInOptions value controls whether users can provide credentials to Office by using either their Microsoft Account ID or the user ID that was assigned by their organization (Org ID) for accessing Microsoft 365. This setting can be configured by using the following values:

- 0 = Both ID types allowed
- 1 = Only Microsoft Account IDs allowed
- 2 = Only Org IDs allowed
- 3 = Users can't sign in by using either type of ID

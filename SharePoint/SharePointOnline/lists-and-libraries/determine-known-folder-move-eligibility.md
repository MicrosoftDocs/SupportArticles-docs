---
title: Determine the Known Folder Move eligibility
description: Describes how to check to see if the OneDrive sync client for SharePoint in Windows has the capability to use the Known Folder Move feature.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Lists and Libraries\Add shortcut to OneDrive
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - OneDrive
  - SharePoint Online
search.appverid: MET150
ms.date: 12/17/2023
---
# Check for Known Folder Move eligibility in OneDrive for SharePoint

_Original KB number:_ &nbsp; 4506600

## Summary

This article is for IT admins managing the OneDrive sync client in Windows environments while using the sync client build 18.151.0729.0012 or later. On prior versions, this option will only be displayed in **Settings** if OneDrive has detected that Known Folder Move can be completed successfully for all folders.

> [!NOTE]
> If your organization is using a sync client version with a build between 18.111.0603.0004 and 18.151.0729.0012, this option will only be displayed in **Settings** if OneDrive has detected that Known Folder Move can be completed successfully for all folders.

With the [Known Folder Move](/onedrive/redirect-known-folders) (KFM) feature, we give users the ability to synchronize the data (files and folders) stored within the user's Desktop, Documents, and Pictures folders, including the Screenshots and Camera Roll folders.

This feature is currently available for Windows 10, Windows 8, Windows 8.1, and Windows 7. For more information on how to set up the folder backup, see [Back up your Documents, Pictures, and Desktop folders with OneDrive](https://support.microsoft.com/office/back-up-your-documents-pictures-and-desktop-folders-with-onedrive-d61a7930-a6fb-4b95-b28a-6552e77c3057).

:::image type="content" source="media/determine-known-folder-move-eligibility/backup.png" alt-text="Screenshot of the Manage backup option in OneDrive Backup tab." border="false":::

## Confirm OneDrive.exe version

In order to check whether the version of OneDrive Next Generation Sync client is eligible to have the KFM option, follow the steps below:

1. Locate the [OneDrive cloud icon](https://support.microsoft.com/office/what-do-the-onedrive-icons-mean-11143026-8000-44f8-aaa9-67c985aa49b3) in the taskbar.
2. [Which OneDrive app?](https://support.microsoft.com/office/which-onedrive-app-19246eae-8a51-490a-8d97-a645c151f2ba)
3. Select OneDrive and then select **More**.
4. In the OneDrive settings, locate the **About** tab.
5. Verify that the sync client build is 18.151.0729.0012 or later.

    :::image type="content" source="media/determine-known-folder-move-eligibility/build-version.png" alt-text="Screenshot of the sync client build displayed in the About tab.":::

> [!NOTE]
> Another method is to see [Which OneDrive app?](https://support.microsoft.com/office/which-onedrive-app-19246eae-8a51-490a-8d97-a645c151f2ba) to determine which version of the app you have.

## Verify OneDrive Personal Site Capabilities of the user

In order to check whether the user has the correct [PersonalSiteCapabilities enumeration](/previous-versions/office/sharepoint-csom/jj163383(v=office.15)), follow the below steps:

1. Navigate to [portal.office.com](https://portal.office.com/).
2. Go to **Admin** tab, and then under the **Admin centers**, select **SharePoint**.
3. In the SharePoint Online Admin Center, navigate to "User profiles".
4. Select **Manager User Profiles** and search for the user.
5. Right-click the user's account name and select **Edit My Profile**.
6. In the user's profile, search for **Personal Site Capabilities** and make sure the value is either **4**, **6**, or **8**, depending on the organization's configuration/capabilities provided to the users.

    :::image type="content" source="media/determine-known-folder-move-eligibility/personal-site-capabilities.png" alt-text="Screenshot of the Personal Site Capabilities number.":::

## Confirm the existence of the PreSignInSettingsConfig.json

The PreSignInSettingsConfig.json is one of the most important files for the OneDrive Next Generation Sync Client, therefore it is important to make sure it exists:

1. Open the Explorer.exe in the affected machine.
2. Navigate to `%localappdata%/Microsoft/OneDrive/Settings`.
3. Verify that the file PreSignInSettingsConfig.json is present.

    :::image type="content" source="media/determine-known-folder-move-eligibility/json-file.png" alt-text="Screenshot shows PreSignInSettingsConfig.json is present.":::

If this .json file is missing, make sure there is no proxy or other network configuration blocking one or more of the required [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

Under some scenarios, it's possible that the antivirus installed on the computer can cause this issue. To test for this behavior, copy the .json file from a working machine and paste it in the provided location.

## Need more help?

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

---
title: Resolve file upload errors in Microsoft Forms
description: Resolve some common errors that you might expreience when you try to add a file upload question to a form or upload a file.
author: helenclu
ms.reviewer: zakirh
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.service: forms
ms.custom: 
  - sap:Working with Forms\Issues that are related to form submission
  - CI964
  - CSSTroubleshoot
appliesto: 
  - Microsoft Forms
ms.date: 03/26/2025
---

# Resolve file upload errors in Microsoft Forms

Files that are uploaded through Microsoft Forms are stored in Microsoft SharePoint or in OneDrive for work or school, as follows:

- Files that are uploaded to group forms are stored in the document library on the Microsoft 365 group's SharePoint site.
- Files that are uploaded to individual forms are stored in the form author's personal OneDrive folder.

When you use the file upload functionality in Forms, you might receive an error message in the following scenarios:

- You [try to add a file upload question](https://support.microsoft.com/office/add-questions-that-allow-for-file-uploads-6a75a658-c02b-450e-b119-d068f3cba4cf) to a form.
- You try to upload a file in response to a question.

These errors might occur if file uploads to SharePoint or OneDrive are blocked. This article lists some common error messages and the methods to fix the errors.

## Error: We weren't able to create an upload file folder in OneDrive for Business

This error can occur for the following reasons:

- The **Limited-access user permission lockdown mode** site collection feature is enabled. This feature restricts sharing and access to files and folders.
- The [*People in your organization* sharing links](/microsoft-365/solutions/microsoft-365-limit-sharing?view=o365-worldwide#people-in-your-organization-sharing-links&preserve-view=true) are disabled.
- Sharing files and folders is limited to site owners.

### Resolution

To fix this error for an individual form that you create, sign in to your OneDrive for work or school website, and then follow these steps:

1. Disable the **Limited-access user permission lockdown mode** site collection feature, if it's enabled.

    1. Select the **Settings** icon in the upper-right corner of the screen.
    1. Select **OneDrive settings** > **More Settings**.
    1. Under **Features and storage**, select **Site collection features**.
    1. Locate **Limited-access user permission lockdown mode**. If its **Status** value is **Active**, select **Deactivate**, and then select **Deactivate this feature** on the confirmation page.
1. Enable the *People in your organization* sharing links if they're disabled.

    **Note**: You must be a SharePoint Online administrator and a site collection administrator to run the following PowerShell commands in [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

    To check whether link sharing is disabled in your OneDrive site, run the following PowerShell command:

    ```powershell
    (Get-SPOSite <your OneDrive site URL>).DisableCompanyWideSharingLinks
    ```

    If link sharing is disabled, run the following PowerShell command to enable company-wide link sharing for your OneDrive site:

    ```powershell
    Set-SPOSite -Identity <your OneDrive site URL> -DisableCompanyWideSharingLinks NotDisabled
    ```

    Typically, the URL for a personal OneDrive site is in the following format:

    `https://<tenant name>-my.sharepoint.com/personal/<user principal name>`

To fix this error for a group form, sign in to the Microsoft 365 group's SharePoint site, and then follow these steps:

1. Follow the steps in [Enable or disable site collection features](https://support.microsoft.com/office/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04) to disable the **Limited-access user permission lockdown mode** site collection feature, if it's enabled.
1. Enable the *People in your organization* sharing links if they're disabled.

    **Note**: You must be a SharePoint Online administrator and a site collection administrator to run the following PowerShell commands in [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

    To check whether link sharing is disabled in the SharePoint site, run the following PowerShell command:

    ```powershell
    (Get-SPOSite <Group SharePoint site URL>).DisableCompanyWideSharingLinks
    ```

    If link sharing is disabled, run the following PowerShell command to enable company-wide link sharing for the group's SharePoint site:

    ```powershell
    Set-SPOSite -Identity <Group SharePoint site URL> -DisableCompanyWideSharingLinks NotDisabled
    ```

    Typically, the URL for a Microsoft 365 group's SharePoint site is in the following format:

    `https://<tenant-name>.sharepoint.com/sites/<group-name>`

    > [!NOTE]
    > If information barriers are enabled in your SharePoint site, company-wide link sharing is disabled if the [mode](/purview/information-barriers-sharepoint#sharing-sites-for-ib-modes) is set to **Owner Moderated**, **Implicit**, or **Explicit**. In this case, change the information barriers mode to **Open**. To check the information barriers mode of your site, run the `Get-SPOSite <Group SharePoint site URL> | Select InformationBarriersMode` PowerShell command.
1. Check whether site members can share files and folders. If they can't, follow these steps to update the sharing permission:

    1. Sign in to the group's SharePoint site as a site owner.
    1. Select **Settings** > **Site permissions**.
    1. Under **Site Sharing**, select **Change how members can share**.
    1. Under **Sharing permissions**, select one of the following options:
  
       - Site owners and members can share files, folders, and the site. People with Edit permissions can share files and folders.
       - Site owners and members, and people with Edit permissions can share files and folders, but only site owners can share the site.
    1. Select **Save**.

## Error: Failed to upload your file

This error might occur for either of the following reasons:

- The [*People in your organization* sharing links](/microsoft-365/solutions/microsoft-365-limit-sharing?view=o365-worldwide#people-in-your-organization-sharing-links&preserve-view=true) are disabled.
- An individual form is moved to a group. This situation prevents files from being uploaded to the previous form owner's personal OneDrive site.

### Resolution

To fix this error, use the appropriate method.

- **If the *People in your organization* sharing links are disabled**

  Enable the links by using the [Set-SPOSite](/powershell/module/sharepoint-online/set-sposite?view=sharepoint-ps&preserve-view=true) PowerShell command in [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

  **Note**: You must be a SharePoint Online administrator and a site collection administrator to run the following PowerShell commands.

  - For an individual form that you create, run the following PowerShell command:

     ```powershell
     Set-SPOSite -Identity <your OneDrive site URL> -DisableCompanyWideSharingLinks NotDisabled
     ```

     To verify the status of link sharing, run the following PowerShell command:

     ```powershell
     (Get-SPOSite <your OneDrive site URL>).DisableCompanyWideSharingLinks
     ```

     Typically, the URL for a personal OneDrive site is in the following format:

     `https://<tenant name>-my.sharepoint.com/personal/<user principal name>`

  - For a group form, run the following PowerShell command:

     ```powershell
     Set-SPOSite -Identity <Group SharePoint site URL> -DisableCompanyWideSharingLinks NotDisabled
     ```

     To verify the status of link sharing, run the following PowerShell command:

     ```powershell
     (Get-SPOSite <Group SharePoint site URL>).DisableCompanyWideSharingLinks
     ```

     Typically, the URL for a group SharePoint site is in the following format:

     `https://<tenant-name>.sharepoint.com/sites/<group-name>`

     > [!NOTE]
     > If information barriers are enabled in your SharePoint site, company-wide link sharing is disabled if the [mode](/purview/information-barriers-sharepoint#sharing-sites-for-ib-modes) is set to **Owner Moderated**, **Implicit**, or **Explicit**. In this case, change the information barriers mode to **Open**. To check the information barriers mode of your site, run the `Get-SPOSite <Group SharePoint site URL> | Select InformationBarriersMode` PowerShell command.
- **If an individual form is moved to a Microsoft 365 group**

  Delete the file upload questions, and then re-create them. The previously uploaded files remain on the previous form owner's OneDrive site.
  
  After you re-create the file upload questions, the new questions will be linked to the group's SharePoint site, and all files will be uploaded to the SharePoint site.

## Error: Access denied. You do not have permissions to perform this action or access this resource

This error might occur for either of the following reasons:

- You try to access the form by using an unmanaged device while SharePoint access is blocked for unmanaged devices.
- You try to access the form by using a new account that shares the user principal name (UPN) with a previously deleted account.

### Resolution

To fix this error, use the appropriate method.

- **If you're using an unmanaged device while SharePoint access is blocked for unmanaged devices**

   Follow these steps as a SharePoint administrator:

   1. In the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219), select **Policies** > **Access control**.
   1. Select **Unmanaged devices**, and then select one of the following settings:

       - Allow full access from desktop apps, mobile apps, and the web
       - Allow limited, web-only access

- **If you're using a new account that shares the UPN with a previous account**

   [Fix site user ID mismatch in SharePoint or OneDrive](/sharepoint/troubleshoot/sharing-and-permissions/fix-site-user-id-mismatch).

## Error: Uploaded file(s) is expired or broken, please upload your files again

This error occurs if the **Require documents to be checked out before they can be edited** setting is enabled in the OneDrive or SharePoint site.

### Resolution

To fix this error for an individual form that you create, sign in to your OneDrive for work or school site, and then follow these steps:

1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **OneDrive settings** > **More settings**.
1. Under **Can't find what you are look for**, select **Return to the old Site settings page**.
1. Under **Site Administration**, select **Site libraries and lists**.
1. Locate the library that stores the personal form, and then select **Customize "\<library name\>"**.
1. Under **General Settings**, select **Versioning settings**.
1. Under **Require Check Out** > **Require documents to be checked out before they can be edited?**, select **No**.
1. Select **OK**.

To fix this error for a group form, sign in to the Microsoft 365 group's SharePoint site, and then follow these steps:

1. Select the library that stores the group form.
1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **Library settings** > **More library settings**.
1. Under **General Settings**, select **Versioning settings**.
1. Under **Require Check Out** > **Require documents to be checked out before they can be edited?**, select **No**.
1. Select **OK**.

## Error: You do not have access to create this folder or you do not have a valid license

This issue occurs if the New Folder command is disabled in the site settings. This situation would prevent you from creating folders in the document library where the form is stored.

### Resolution

To fix this error for an individual form that you create, sign in to your OneDrive for work or school site, and then follow these steps:

1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **OneDrive settings** > **More settings**.
1. Under **Can't find what you are look for**, select **Return to the old Site settings page**.
1. Under **Site Administration**, select **Site libraries and lists**.
1. Locate the library that stores the personal form, and then select **Customize "\<library name\>"**.
1. Under **General Settings**, select **Advanced settings**.
1. Under **Folders** > **Make "New Folder" command available**, select **Yes**.
1. Select **OK**.

To fix this error for a group form, sign in to the Microsoft 365 group's SharePoint site, and then follow these steps:

1. Select the library that stores the group form.
1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **Library settings** > **More library settings**.
1. Under **General Settings**, select **Advanced settings**.
1. Under **Folders > Make "New Folder" command available**, select **Yes**.
1. Select **OK**.

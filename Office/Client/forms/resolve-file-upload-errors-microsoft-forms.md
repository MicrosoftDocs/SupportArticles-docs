---
title: Resolve file upload errors in Microsoft Forms
description: Resolve some common errors that you exprience when you try to add a file upload question to a form or upload a file.
author: helenclu
ms.reviewer: derekliddell; meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.service: loop
ms.custom: 
  - sap:Working with Forms\Issues that are related to form submission
  - CI964
  - CSSTroubleshoot
appliesto: 
  - Microsoft Forms
ms.date: 11/21/2024
---

# Resolve file upload errors in Microsoft Forms

In Microsoft Forms, you might experienc the following issues:

- When you [try to add a file upload question](https://support.microsoft.com/office/add-questions-that-allow-for-file-uploads-6a75a658-c02b-450e-b119-d068f3cba4cf) to a form, you receive an error message on the form design page.
- When you try to upload a file in your response to a form, you receive an error message.

Files that are uploaded through Forms are stored in OneDrive or SharePoint:

- For personal forms, files are stored in the form creator's personal OneDrive.
- For group forms, files are stored in the document library on the group SharePoint site.

These issues can occur if file uploads to OneDrive or SharePoint are blocked for various reasons. This article lists some common errors, the cause of each error and how to resolve it. Select the error that you receive and follow the steps to resolve it.

## We weren't able to create an upload file folder in OneDrive for Business

This error can occur for the following reasons:

- The **Limited-access user permission lockdown mode** site collection feature is enabled. This feature restricts sharing and access to files and folders.
- The share by link feature is disabled.
- Sharing files and folders is limited to site owners.

### Resolution

To fix this error for a personal form, sign in to the form creator's personal OneDrive site and follow these steps:

1. Check whether the **Limited-access user permission lockdown mode** site collection feature is enabled. If it's enabled, disable it.

    1. Select the **Settings** icon in the upper-right corner of the screen.
    1. Select **OneDrive settings** > **More Settings**.
    1. Under **Features and storage**, select **Site collection features**.
    1. Locate **Limited-access user permission lockdown mode**.
    1. If its status is **Active**, select **Deactivate**, and then select **Deactivate this feature** in the confirmation page.
1. Check whether the share by link feature is disabled. If it's disabled, enable it.

    **Note**: You must be a SharePoint Online administrator and a site collection administrator to run the PowerShell commands in [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

    To check the status of link sharing, run the following PowerShell command:

    ```powershell
    (Get-SPOSite <the form creator's OneDrive site URL>).DisableCompanyWideSharingLinks
    ```

    To enable company-wide link sharing for the OneDrive site, run the following PowerShell command:

    ```powershell
    Set-SPOSite -Identity <the form creator's OneDrive site URL> -DisableCompanyWideSharingLinks NotDisabled
    ```

    The URL for a personal OneDrive site is typically in the format of `https://<tenant name>-my.sharepoint.com/personal/<user principal name>`.

To fix this error for a group form, sign in to the group SharePoint site and follow these steps:

1. Follow the steps in [Enable or disable site collection features](https://support.microsoft.com/office/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04) to check whether the **Limited-access user permission lockdown mode** site collection feature is enabled. If it's enabled, disable it.
1. Check whether the share by link feature is disabled. If it's disabled, enable it.

    **Note**: You must be a SharePoint Online administrator and a site collection administrator to run the PowerShell commands in [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

    To check the status of link sharing, run the following PowerShell command:

    ```powershell
    (Get-SPOSite <Group SharePoint site URL>).DisableCompanyWideSharingLinks
    ```

    To enable company-wide link sharing for the group SharePoint site, run the following PowerShell command:

    ```powershell
    Set-SPOSite -Identity <Group SharePoint site URL> -DisableCompanyWideSharingLinks NotDisabled
    ```

    The URL for a group SharePoint site is typically in the format of `https://<tenant-name>.sharepoint.com/sites/<group-name>`.

    > [!NOTE]
    > If information barriers are enabled in your site, company-wide link sharing is disabled if the [mode](/purview/information-barriers-sharepoint#sharing-sites-for-ib-modes) is set to **Owner Moderated**, **Implicit**, or **Explicit**. In this case, change the information barriers mode to **Open**. To check the information barriers mode of your site, run the `Get-SPOSite <Group SharePoint site URL> | Select InformationBarriersMode` PowerShell command.
1. Check whether site members can share files and folders. If they can't, update the sharing permission.

    1. Sign in to the group SharePoint site as a site owner.
    1. Select **Settings** > **Site permissions**.
    1. Under **Site Sharing**, select **Change how members can share**.
    1. Under **Sharing permissions**, select one of the following options:
  
       - Site owners and members can share files, folders, and the site. People with Edit permissions can share files and folders.
       - Site owners and members, and people with Edit permissions can share files and folders, but only site owners can share the site.
    1. Select **Save**.

## Failed to upload your file

This error occurs if the share by link feature is disabled.

To fix this error, enable the share by link feature by using the [Set-SPOSite](/powershell/module/sharepoint-online/set-sposite?view=sharepoint-ps&preserve-view=true) PowerShell command in [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

**Note**: You must be a SharePoint Online administrator and a site collection administrator to run the PowerShell commands.

- For a personal form, run the following PowerShell command:

    ```powershell
    Set-SPOSite -Identity <the form creator's OneDrive site URL> -DisableCompanyWideSharingLinks NotDisabled
    ```

    To check the status of link sharing, run the following PowerShell command:

    ```powershell
    (Get-SPOSite <the form creator's OneDrive site URL>).DisableCompanyWideSharingLinks
    ```

    The URL for a personal OneDrive site is typically in the format of `https://<tenant name>-my.sharepoint.com/personal/<user principal name>`.

- For a group form, run the following PowerShell command:

    ```powershell
    Set-SPOSite -Identity <Group SharePoint site URL> -DisableCompanyWideSharingLinks NotDisabled
    ```

    To check the status of link sharing, run the following PowerShell command:

    ```powershell
    (Get-SPOSite <Group SharePoint site URL>).DisableCompanyWideSharingLinks
    ```

    The URL for a group SharePoint site is typically in the format of `https://<tenant-name>.sharepoint.com/sites/<group-name>`.

    > [!NOTE]
    > If information barriers are enabled in your site, company-wide link sharing is disabled if the [mode](/purview/information-barriers-sharepoint#sharing-sites-for-ib-modes) is set to **Owner Moderated**, **Implicit**, or **Explicit**. In this case, change the information barriers mode to **Open**. To check the information barriers mode of your site, run the `Get-SPOSite <Group SharePoint site URL> | Select InformationBarriersMode` PowerShell command.

## Access denied. You do not have permissions to perform this action or access this resource

This issue occurs if you try to access the form by using an unmanaged device while SharePoint access is blocked for unmanaged devices.

To fix this error, follow these steps as a SharePoint administrator:

1. In the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219), select **Policies** > **Access control**.
1. Select **Unmanaged devices**, and then select one of the following settings:

    - Allow full access from desktop apps, mobile apps, and the web
    - Allow limited, web-only access

## Uploaded file(s) is expired or broken, please upload your files again

This error occurs if the OneDrive or SharePoint site requires files to be checked out before they can be edited.

### Resolution

To fix this error for a personal form, sign in to the form creator's personal OneDrive site and follow these steps:

1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **OneDrive settings** > **More settings**.
1. Under **Can't find what you are look for**, select **Return to the old Site settings page**.
1. Under **Site Administration**, select **Site libraries and lists**.
1. Locate the library that stores the personal form, and then select **Customize "\<library name\>"**.
1. Under **General Settings**, select **Versioning settings**.
1. Under **Require Check Out** > **Require documents to be checked out before they can be edited?**, select **No**.
1. Select **OK**.

To fix this error for a group form, sign in to the group SharePoint site and follow these steps:

1. Select the library that stores the group form.
1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **Library settings** > **More library settings**.
1. Under **General Settings**, select **Versioning settings**.
1. Under **Require Check Out** > **Require documents to be checked out before they can be edited?**, select **No**.
1. Select **OK**.

## You do not have access to create this folder or you do not have a valid license

This issue occurs if the New Folder command is disabled in the site settings, preventing you from creating new folders in the document library where the form is stored.

### Resolution

To fix this error for a personal form, sign in to the form creator's personal OneDrive site and follow these steps:

1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **OneDrive settings** > **More settings**.
1. Under **Can't find what you are look for**, select **Return to the old Site settings page**.
1. Under **Site Administration**, select **Site libraries and lists**.
1. Locate the library that stores the personal form, and then select **Customize "\<library name\>"**.
1. Under **General Settings**, select **Advanced settings**.
1. Under **Folders** > **Make "New Folder" command available**, select **Yes**.
1. Select **OK**.

To fix this error for a group form, sign in to the group SharePoint site and follow these steps:

1. Select the library that stores the group form.
1. Select the **Settings** icon in the upper-right corner of the screen.
1. Select **Library settings** > **More library settings**.
1. Under **General Settings**, select **Advanced settings**.
1. Under **Folders > Make "New Folder" command available**, select **Yes**.
1. Select **OK**.

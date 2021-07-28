---
title: Error 403 Forbidden in OneDrive or SharePoint 
description: How to troubleshoot Error 403 Forbidden for OneDrive or SharePoint sites.
author: bpeterse
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-matham
ms.custom: 
- CSSTroubleshoot
- CI 153759
appliesto:
- SharePoint Online
---

# Error: 403 Forbidden in OneDrive or SharePoint

## Symptoms

When you try to access a file from OneDrive or SharePoint that is shared with you, you encounter the following error:

> Error: 403 Forbidden

## Cause

The “403 Forbidden” error might occur due to one of the following issues:

- You need to clear your browser cache

- Your permissions to the file haven’t replicated correctly on the server

- Your OneDrive is locked

- There is an issue with your organization’s SharePoint Online services

## Resolution

Use InPrivate mode (or Incognito if you’re using Google Chrome) when you sign into Microsoft 365, and then try accessing the file. Learn how to browse InPrivate (Incognito) in [Microsoft Edge](https://support.microsoft.com/microsoft-edge/browse-inprivate-in-microsoft-edge-cd2c9a48-0bc4-b98e-5e46-ac40c84e27e2) or [Google Chrome](https://support.google.com/chrome/answer/95464).  

If you can access the file while browsing InPrivate, clear your browser cache. Learn how to clear the browser cache in [Edge](https://support.microsoft.com/microsoft-edge/view-and-delete-browser-history-in-microsoft-edge-00cf7943-a9e1-975a-a33d-ac10ce454ca4) or [Google Chrome](https://support.google.com/accounts/answer/32050).  

If that doesn’t solve the problem, contact the SharePoint or OneDrive administrator for your organization. See [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) if you aren’t sure who it is.

## Actions for administrators

Try the following methods if clearing the cache doesn’t solve the problem.

<details>
<summary><b>Re-share the file</b></summary>

It’s possible permissions for the file haven’t replicated correctly or completely. Ask the individual to wait 30 minutes before trying to access the file again. After 30 minutes, if they’re still encountering the error, try the steps listed under "When accessing a SharePoint site" or "When accessing a OneDrive site" on the page ["Access Denied", "You need permission to access this site", or "User not found in the directory" errors in SharePoint Online and OneDrive for Business](../administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business.md).

</details>
<br/>
<details>
<summary><b>Check if the OneDrive site is locked</b></summary>

It is possible the user’s OneDrive is in a locked state of NoAccess. As a global or SharePoint admin in Microsoft 365, you can unlock the site by using PowerShell. For more information, see [Lock and unlock sites](/sharepoint/manage-lock-status).  

</details>
<br/>
<details>
<summary><b>Check Service health</b></summary>

As an admin, visit the [Service Health](https://portal.office.com/adminportal/home#/servicehealth) page from **Health** > **Service health** in the [Microsoft 365 Admin Center](https://admin.microsoft.com/). Check for any advisories or incidents that might be occurring. If there are no advisories or incidents occurring for SharePoint Online, you can select **Report an issue** if it’s available to you, or open a new service request with Microsoft 365 technical support.

</details>

<br/>
<details>
<summary><b>Provision the OneDrive site</b></summary>

Error 403 can occur if the user is trying to access a OneDrive site that is not provisioned. Have the user attempt to navigate to the OneDrive tile from the Microsoft 365 Portal.

If that does not work, provision the site using the [Request-SPOPersonalSite](/powershell/module/sharepoint-online/request-spopersonalsite) cmdlet.

</details>
<br/>
<details>
<summary><b>Access another user's OneDrive data</b></summary>

If the user is trying to access another user's OneDrive data, such as a former employee's, you can grant permissions to the user by following the steps on the page [Step 4 - Give another employee access to OneDrive and Outlook data](/microsoft-365/admin/add-users/remove-former-employee-step-4).

</details>
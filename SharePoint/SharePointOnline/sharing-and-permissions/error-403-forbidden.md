---
title: Error 403 Forbidden in OneDrive or SharePoint
description: How to troubleshoot Error 403 Forbidden for OneDrive or SharePoint sites.
author: helenclu
ms.reviewer: bpeterse
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sites\Error 404: Site Unavailable
  - CSSTroubleshoot
  - CI 153759
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "403 Forbidden" error on OneDrive or SharePoint

## Symptoms

When you try to access a file from a OneDrive or SharePoint website that another user shares with you, you receive the following error message:

> Error: 403 Forbidden

## Cause

The “403 Forbidden” error might occur because of one of the following conditions:

- Your browser cache has to be cleared.

- Your permissions to the file haven’t replicated correctly on the server.

- Your OneDrive site is locked.

- An issue affects your organization’s SharePoint Online services.

## Resolution

Use the available privacy mode of your web browser when you sign in to Microsoft 365. For example, use InPrivate mode in Microsoft Edge, or Incognito mode in Google Chrome. Then, try to access the file. To learn how to browse through an InPrivate window, see [Microsoft Edge](https://support.microsoft.com/microsoft-edge/browse-inprivate-in-microsoft-edge-cd2c9a48-0bc4-b98e-5e46-ac40c84e27e2). To learn how to browse through an Incognito window, see [Google Chrome](https://support.google.com/chrome/answer/95464).

If you can access the file while you browse in a privacy mode, clear your browser cache. To learn how to clear the browser cache, see [Edge](https://support.microsoft.com/microsoft-edge/view-and-delete-browser-history-in-microsoft-edge-00cf7943-a9e1-975a-a33d-ac10ce454ca4) or [Chrome](https://support.google.com/accounts/answer/32050).  

If that doesn’t solve the problem, contact the SharePoint or OneDrive administrator for your organization. If you don't knows who that is, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b).

#### Third-party information disclaimer

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.

## Actions for administrators

If clearing the cache doesn’t solve the problem, try the following methods.

<details>
<summary><b>Reshare the file</b></summary>

It’s possible that permissions for the file haven’t replicated correctly or completely. Ask the user to wait 30 minutes before trying to access the file again. If the error still occurs after 30 minutes, try the steps that are listed under "When accessing a SharePoint site" or "When accessing a OneDrive site" in ["Access Denied", "You need permission to access this site", or "User not found in the directory" errors in SharePoint Online and OneDrive for Business](../administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business.md).

</details>

<details>
<summary><b>Check whether the OneDrive site is locked</b></summary>

It's possible that the user's OneDrive site is in a locked "NoAccess" state. As a global or SharePoint admin in Microsoft 365, you can unlock the site by using PowerShell or running a Microsoft 365 Diagnostic. For more information, see [SharePoint or OneDrive read-only error messages](/sharepoint/troubleshoot/sites/site-is-read-only).  
</details>

<details>
<summary><b>Check the service health</b></summary>

As an admin, go to the [Service Health](https://portal.office.com/adminportal/home#/servicehealth) page (**Health** > **Service health**) in the [Microsoft 365 Admin Center](https://admin.microsoft.com/). Check for any advisories or incidents that might be occurring. If there are no advisories or incidents occurring for SharePoint Online, you can select **Report an issue** if it’s available to you, or open a new service request with Microsoft 365 technical support.

</details>

<details>
<summary><b>Provision the OneDrive site</b></summary>

Error 403 can occur if the user is trying to access a OneDrive site that is not provisioned. Have the user try to navigate to the OneDrive tile from the Microsoft 365 portal.

If that doesn't work, provision the site by using the [Request-SPOPersonalSite](/powershell/module/sharepoint-online/request-spopersonalsite) cmdlet.

</details>

<details>
<summary><b>Access another user's OneDrive data</b></summary>

If the user is trying to access the OneDrive data of another user, such as a former employee, you can grant permissions to the user by following the steps in [Step 4 - Give another employee access to OneDrive and Outlook data](/microsoft-365/admin/add-users/remove-former-employee-step-4).

</details>

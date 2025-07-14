---
title: Error when uploading files to a Teams chat
description: Troubleshooting steps for when you get the file is locked error when uploading a file to a Teams chat.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Files\Upload File
  - CI 125872
  - CI 147731
  - CSSTroubleshoot
ms.reviewer: prbalusu
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Error when uploading files to a Teams chat

When you try to upload a file in a Microsoft Teams chat, you receive either of the following error messages.

### [Error Message 1](#tab/Error-Message-1)

> The file \<FileName> didn't upload.  
> The file \<FileName> is locked.

This error occurs while Teams is uploading the file to your OneDrive cloud storage.

### [Error Message 2](#tab/Error-Message-2)

> The file \<FileName> didn't upload.  
> Your OneDrive isn't available.

### [Error Message 3](#tab/Error-Message-3)

When you access your OneDrive cloud storage through the **Files** tab, you receive the following error message:

> This item might not exist or is no longer available.  
> This item might have been deleted, expired, or you might not have permission to view it.  
> Contact the owner of this item for more information.

---

## Resolution

To resolve this issue, try the resolutions that are listed under the relevant error message.

### [Error Message 1](#tab/Error-Message-1)

Error 1 can have multiple causes. To resolve Error 1, try each of the following resolutions in the order in which they're listed. Check whether the issue is resolved after you try each resolution before you go to the next one.

**Resolution 1**

Error 1 can occur if the name of the **Documents** folder (the default document library on the OneDrive site) was changed to something else.

To fix the error, you must revert the folder name to **Documents** by using an administrative account and following these steps.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select **Run Tests**, as follows. This will populate the diagnostic in the Microsoft 365 Admin Center. 

    > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Library Rename](https://aka.ms/PillarOneDriveLibraryRename)

2. In the **Run diagnostics** section, type the **User Principal Name (UPN)** of the user who is seeing the error, and then select **Run Tests**.
3. If the test result shows that the default document library name isn't **Documents**, select the check box to authorize the diagnostic to revert it to **Documents**, and then select **Update Settings**. You'll receive a confirmation notification that states that the document library was successfully renamed to **Documents**.
 
**Note:** Although you can use SharePoint Designer to change the name of the default document library, we don't recommend this option.

**Resolution 2**

Error 1 can occur if your OneDrive site is set as ReadOnly.

This setting indicates that your OneDrive site is locked. To fix the error, [unlock the site](/sharepoint/manage-lock-status).

**Resolution 3**

Error 1 can occur if a user is deleted and then re-created by using the same User Principal Name (UPN). This situation will cause a user ID mismatch on the OneDrive site.

To resolve this error, [delete the re-created user, and restore the original user](/sharepoint/troubleshoot/sharing-and-permissions/access-denied-sharepoint-error#accessing-a-onedrive-site).

**Resolution 4**

Error 1 can occur if the user doesn't have permissions to the MySite host. To make SharePoint Online work as expected, all users who use OneDrive sites must have access to the MySite host. In order to restore default permissions to the MySite host site, use one of the following methods:

- Navigate to the site permissions page in your tenant: `https://contoso-my.sharepoint.com/_layouts/15/user.aspx`, and grant **Read** permission to **Everyone except external users**.

- Use SharePoint Online Management Shell to run the following cmdlets:

    ```powershell
    Connect-SPOService -Url https://contoso-admin.sharepoint.com/
    Add-SPOUser -Site https://contoso-my.sharepoint.com -LoginName "Everyone Except External Users" -Group Visitors
    ```

### [Error Message 2](#tab/Error-Message-2)

Error 2 can occur if your OneDrive site is set as NoAccess.

This setting indicates that your OneDrive site is locked. To fix the error, [unlock the site](/sharepoint/manage-lock-status).

### [Error Message 3](#tab/Error-Message-3)

Error 3 can occur if the name of the **Documents** folder (the default document library on the OneDrive site) was changed to something else.

To fix the error, you must revert the folder name to **Documents** by using an administrative account and following these steps.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Select **Run Tests**, as follows. This will populate the diagnostic in the Microsoft 365 Admin Center. 

    > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Library Rename](https://aka.ms/PillarOneDriveLibraryRename)

2. In the **Run diagnostics** section, type the **User Principal Name (UPN)** of the user who is seeing the error, and then select **Run Tests**.
3. If the test result shows that the default document library name isn't **Documents**, select the check box to authorize the diagnostic to change it back to **Documents**, and then select **Update Settings**. You'll receive a confirmation notification that states that the document library was successfully renamed to **Documents**.

---

## Run a self-diagnostics tool

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues that affect uploading files to Teams chat.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select **Run Tests**, as follows. This will populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Unable to upload files to Teams chat](https://aka.ms/TeamsUploadFilesInChat)

The diagnostic performs a large range of verifications.

## Contact Support

If none of these resolutions fix the error, create a new service request. Use the following description: "files upload failing to teams chat." Attach the Teams desktop logs and a browser trace to the request. For information about how to collect the desktop logs and browser trace, see [Collect logs to troubleshoot Teams issues](/microsoftteams/log-files#desktop-logs).

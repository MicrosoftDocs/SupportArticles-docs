---
title: File is locked or item might not exist error
description: Fixes an issue in which you get the "file is locked" error when uploading a file or get the "item might not exist or is no longer available" error when accessing OneDrive in Teams.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 125872
- CI 147731
- CSSTroubleshoot
ms.reviewer: prbalusu
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Error when uploading files to a Teams chat

When you try to upload a file in a Microsoft Teams chat, you receive either of the following error messages.

- **Error Message 1**

    > The file \<FileName> didn't upload.  
    > The file \<FileName> is locked.

    **Note:** This error occurs while Teams is uploading the file to your OneDrive cloud storage.

- **Error Message 2**

    > The file \<FileName> didn't upload.  
    > Your OneDrive isn't available.

- **Error Message 3**

    When you access your OneDrive cloud storage through the **Files** tab, you receive the following error message:

    > This item might not exist or is no longer available.  
    > This item might have been deleted, expired, or you might not have permission to view it.  
    > Contact the owner of this item for more information.

## Resolution

Error 1 can have multiple causes. To resolve Error 1, try each of the following resolutions in the order in which they're listed. Check whether the issue is resolved after you try each resolution before you go to the next one.

To resolve Error 2, try Resolution 2.

To resolve Error 3, try Resolution 1.

**Resolution 1**

Error 1 and Error 3 can occur if the name of the **Documents** folder (the default document library on the OneDrive site) was changed to something else.

To fix the error, you must revert the folder name to **Documents** by using an administrative account and following these steps:

1. Navigate to the [Microsoft 365 admin center](https://admin.microsoft.com/).
2. In the left pane, select **Support**, and then select **New Service Request**.
3. In the **Briefly describe your issue** field, type *OneDrive Document Library Path Modified*.
4. In the **Run diagnostics** section, type the **User Principal Name (UPN)** of the user who is seeing the error, and then select **Run Tests**.
5. If the test result indicates that the name of the default document library name is not Documents, select the checkbox to authorize the diagnostic to change it back to Documents, and then select **Update Settings**.

    You'll see a confirmation notice that states that the document library was successfully renamed to **Documents**.

**Note:** Although you can use SharePoint Designer to change the name of the default document library, we don't recommend this option.

**Resolution 2**

Error 1 can occur if your OneDrive site is set as ReadOnly.

Error 2 can occur if your OneDrive site is set as NoAccess.

Both these settings indicate that your OneDrive site is locked. To fix the error, [unlock the site](/sharepoint/manage-lock-status).

**Resolution 3**

Error 1 can occur if a user is deleted and then re-created by using the same User Principal Name (UPN). This situation will cause a user ID mismatch on the OneDrive site.

To resolve this error, [delete the re-created user, and restore the original user](/sharepoint/troubleshoot/sharing-and-permissions/access-denied-sharepoint-error#accessing-a-onedrive-site).

## Contact Support

If none of the resolutions fix the error, create a new service request. Use the following description: "files upload failing to teams chat." Attach the Teams desktop logs and a browser trace to it. For information about how to collect the desktop logs and browser trace, see [Collect logs to troubleshoot Teams issues](/microsoftteams/log-files#desktop-logs).

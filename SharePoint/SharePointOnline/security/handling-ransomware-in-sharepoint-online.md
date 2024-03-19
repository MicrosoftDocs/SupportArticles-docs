---
title: Handling ransomware in Sharepoint Online
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Backup and Restore\RansomWare
  - CI 113549
  - CSSTroubleshoot
ms.reviewer: salarson
description: Ways to handle ransomware issues in SharePoint Online.
---

# Handling ransomware in Sharepoint Online

## Summary

Ransomware is a malware that blocks access to various items on your computer and demands a ransom from you in order for the creator to release the lock they have imposed.  Once the ransom is paid, the creator of the ransomware will presumably provide the information needed to regain access.

## More information

### How does it work with SharePoint Online or OneDrive for Business?

Ransomware is an executable that is run locally on a user's computer.  The ransomware reviewed by Microsoft that affects SharePoint Online or OneDrive for Business manipulates individual files on the user's local machine by way of a OneDrive for Business connection or a mapped drive into a SharePoint Online library. 

Once the ransomware is placed, the infected files are then synchronized to the online environment by the sync client tool or by various Web DAV methods. Various manipulations of the files include (but are not limited to):

- Public/Private key encryption.
- Appending an unknown extension to the filename.
- Deleting existing files.

In addition, many new files are added to each directory that create display instructions regarding who to pay the ransom.

### How do I confirm the items of a library are actually being held for ransom?

Signs that a SharePoint Online library has been infected by ransomware include the following:
- Majority of the files within the library have the same **Modified By** timestamp.
- Files fail to open with a message stating that they are possibly corrupt.
- Each directory within the library contains several files named **HELP_DECRYPT**, **HELP_Recover, or similar random names. The files can be opened and contain instructions for paying the ransom.
- Files have been renamed or have an extension appended to the end.

### How is Microsoft able to help?

If you are affected by ransomware, try the following:
- Immediately stop OneDrive for Business Sync or disconnect the mapped drive to SharePoint library. 
- Ask your Company Administrator (or affected user) to attempt to restore files:
   - SharePoint: See [Restore a Document library](https://support.office.com/article/restore-a-document-library-317791c3-8bd0-4dfd-8254-3ca90883d39a)
   - OneDrive: See [Restore a OneDrive library](https://support.office.com/article/restore-your-onedrive-fa231298-759d-41cf-bcd0-25ac53eb8a15)

> [!NOTE]
> SharePoint Online retains backups of all content for 14 additional days beyond actual deletion. [If content cannot be restored](https://support.office.com/article/Restore-a-previous-version-of-an-item-or-file-in-SharePoint-F66DBDA0-81F4-4D1E-B08C-793265C58934), an administrator can contact Microsoft Support to request a restore any time inside the 14-day window. Be sure to note the following details:
> - What site collection URL(s) that have been affected by ransomware?
> - When was the last known time the files were not modified by the ransomware?

### Need more help?

For more information on ransomware, see the support article on [Ransom ware](https://www.microsoft.com/security/portal/mmpc/shared/ransomware.aspx). 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).

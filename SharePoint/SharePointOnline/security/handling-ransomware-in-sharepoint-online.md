---
title: Handling ransomware in Sharepoint Online
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 10/09/2024
audience: ITPro
ms.topic: troubleshooting
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
description: Methods to handle ransomware issues in SharePoint.
---

# Handling ransomware in Sharepoint Online

## Summary

Ransomware is malware that blocks access to various items on your computer. The creator then demands that you pay a ransom before they will, presumably, provide the necessary information to release the lock and let you regain access.

## More information

### How ransomware works with SharePoint Online or OneDrive

Ransomware is an executable that runs locally. The specific ransomware that's been reviewed by Microsoft that affects SharePoint or OneDrive manipulates individual files on the user's computer through a mapped drive into a SharePoint library or a OneDrive connection.

After the ransomware is established, the infected files are synchronized to the online environment by the sync client tool or by various WebDAV methods. Various manipulations of the files include but aren't limited to:

- Public or private key encryption
- Appending an unknown extension to the filename
- Deleting existing files

Additionally, many new files are added to each directory that contains instructions regarding who to pay the ransom to.

### How to verify that library items are being held for ransom

The signs that a SharePoint library is infected by ransomware include:

- Most library files have the same **Modified By** timestamp.
- Files don't open, and they return a message that states that they're possibly corrupted.
- Each directory within the library contains several files that have such random names as **HELP_DECRYPT** and **HELP_Recover**. These files can be opened, and they contain instructions for paying the ransom.
- Files are renamed or have a file name extension appended.

### How Microsoft can help

If you're affected by ransomware, try the following methods:

- Immediately stop OneDrive sync or disconnect the mapped drive to a SharePoint library. 
- Ask your company administrator (or affected user) to try to restore the files by using the appropriate procedure:

   - SharePoint: See [Restore a document library](https://support.office.com/article/restore-a-document-library-317791c3-8bd0-4dfd-8254-3ca90883d39a)
   - OneDrive: See [Restore a OneDrive library](https://support.office.com/article/restore-your-onedrive-fa231298-759d-41cf-bcd0-25ac53eb8a15)
 
Customers can also use Microsoft 365 Backup for data recovery. [Microsoft 365 Backup](/microsoft-365/backup/backup-overview) offers a longer protection time and provides uniquely fast recovery from common business continuity and disaster recovery (BCDR) scenarios such as ransomware or accidental or malicious employee content overwrite or deletion. Additional BCDR scenario protections are also built directly into the service to provide an enhanced level of data protection.

> [!NOTE]
> SharePoint retains backups of all content for 14 additional days beyond actual deletion. [If content cannot be restored](https://support.office.com/article/Restore-a-previous-version-of-an-item-or-file-in-SharePoint-F66DBDA0-81F4-4D1E-B08C-793265C58934), an administrator can contact Microsoft Support to request a restoration any time inside the 14-day window. Make sure to note the following details:
> - Which site collection URLs have been affected by ransomware?
> - When was the last known time that the files were not modified by the ransomware?

### Need more help?

For more information about ransomware, see [What is ransomware?](https://www.microsoft.com/security/portal/mmpc/shared/ransomware.aspx)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).

---
title: Unable to sync a notebook from SharePoint
description: Fixes an issue in which you cannot sync a notebook in OneNote and you receive error codes 0xE40200B4 and 0x800700DF.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Sync
  - CI 114993
  - CSSTroubleshoot
ms.reviewer: subhbasu
appliesto: 
  - OneNote for Microsoft 365
  - OneNote 2016
  - OneNote 2013
  - OneNote 2010
search.appverid: MET150
ms.date: 06/06/2024
---
# "0xE40200B4" and "0x800700DF" errors when you sync a notebook in OneNote

## Symptoms

In Microsoft SharePoint with the OneNote 2016 desktop client, you can't sync a notebook by selecting **View Sync Status** > **Sync All**. Additionally, you receive error messages that mention the "0xE40200B4" and "0x800700DF" error codes.

## Resolution

> [!WARNING]
> Follow the steps in this section carefully. Serious problems can occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) in case problems occur.

1. Right-click the notebook that's opened in OneNote 2016, and then select View Notebook Sync status.
2. Verify that the error code is 0xE40200B4.
3. Locate the affected section, and then try to do a forced sync. To do this, point to the unsynchronized page, and select the page to give it focuses and force the sync.
4. Determine whether any notebook section exceeds 50 MB. (Each section is a separate .one file.)
5. If a section exceeds 50 MB, locate any file that was saved in SharePoint and exceeds 50 MB, and try to copy and paste the file to your local computer.

   > [!NOTE]
   > Before you copy the file, open the SharePoint site in Windows Explorer view (Explorer web client view). For more information about how to do this, see [Open in Explorer or View with File Explorer in SharePoint](https://support.office.com/article/open-in-explorer-or-view-with-file-explorer-in-sharepoint-66b574bb-08b4-46b6-a6a0-435fd98194cc).

6. If error code 0x800700DF is returned when you do step 5, follow these steps to set the file size limit in bytes for web client.  

   1. Locate the following registry subkey:

      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters`

   2. Edit the **Decimal** value for the following 32-bit DWORDs:

      - Change the `FileAttributesLimitInBytes` value data from **1000000** to **10000000** to support file attributes up to 10 MB.
      - Change the `FileSizeLimitInBytes` value data from **50000000** to **4294967295** (4.75 GB) is the max limit for a 32-bit DWORD.

7. Restart your computer.

> [!NOTE]
> In Windows XP SP2 and later Windows versions, a security change was introduced that affects the Web Distributed Authoring and Versioning (WebDAV) redirector. This security change makes sure that an unauthorized server cannot force a client computer into a denial of service attack. If you try to download a file that's larger than 50,000,000 bytes, the client computer interprets this download as a denial of service attack. Therefore, the download process stops. For more information, see [Folder copy error message when downloading a file that is larger than 50000000 bytes from a Web folder](https://support.microsoft.com/help/900900).

## References

- [Error 0xE40200B4, 0xE401065D, 0xE000145C, or 0xE4010640 when syncing notes in OneNote 2016](https://support.microsoft.com/en-us/office/error-0xe40200b4-0xe401065d-0xe000145c-or-0xe4010640-when-syncing-notes-in-onenote-2016-92aff2e1-9696-42e5-a9bd-15c2ec10870a)
- [Error 0x800700DF: The file size exceeds the limit allowed and cannot be saved](https://answers.microsoft.com/en-us/ie/forum/ie8-windows_xp/error-0x800700df-the-file-size-exceeds-the-limit/d208bba6-920c-4639-bd45-f345f462934f)

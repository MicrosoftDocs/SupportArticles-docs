---
title: Refresh Your PC without affecting your file deletes profile
description: The Refresh Your PC without affecting your file option deletes your Outlook profile in Windows 8.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Surface RT
- Office Home and Student 2013 RT
- Microsoft Office Outlook 2007
- Microsoft Outlook 2010
- Outlook 2013
search.appverid: MET150
ms.reviewer: aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# The "Refresh Your PC without affecting your file" option deletes your Outlook profile in Windows 8

## Symptoms

After you run the "Refresh Your PC without affecting your files" feature in Microsoft Windows 8 and Windows RT, the Microsoft Outlook profile is deleted, and the data files are deleted or moved.

> [!NOTE]
> This feature is also known as the Push-Button Reset option.

## More information

In this situation, you must re-create the Outlook profile and then manually import the Outlook Data (.pst) file or files from the following locations:

C:\Users\\\<Your User Name>\Documents\Outlook Files

C:\Windows.old\Users\\\<Your User Name>\AppData\Local\Microsoft\Outlook

The follow table summarizes the Outlook data files that are affected during the refresh:

| Account type| Data file type| Default Folder path| Moved to Windows.old |
|---|---|---|---|
|Exchange Server|.ost|C\Users\\\<Your User Name>\AppData\Local\Microsoft\Outlook|Yes|
|IMAP|.ost|C:\Users\\\<Your User Name>\AppData\Local\Microsoft\Outlook|Yes|
|`Outlook.com` account/Exchange ActiveSync (EAS)|.ost|C:\Users\\\<Your User Name>\AppData\Local\Microsoft\Outlook|Yes|
|POP|.pst|C:\Users\\\<Your User Name>\Documents\Outlook Files|No, this location is preserved during refresh|
|SharePoint list|.pst|C:\Users\\\<Your User Name>\AppData\Local\Microsoft\Outlook|Yes|
|Internet Calendars|.pst|C:\Users\\\<Your User Name>\AppData\Local\Microsoft\Outlook|Yes|

> [!NOTE]
> Because you cannot import the cached email messages from an Offline Outlook Data (.ost) file that was associated with an Exchange account or an IMAP account, you must synchronize your email messages to the server before you refresh your PC. When you re-create the Outlook profile after the PC refresh, Outlook creates new .ost files.

Any user data files that are in the following folders are deleted during the refresh:

- C:\Program Files
- C:\ProgramData
- C:\Windows

> [!NOTE]
>
> - Outlook 2013 creates archive and additional .pst files in the C:\Users\\\<Your User Name>\Documents\Outlook Files folder. This folder is preserved during the refresh, as shown in the preceding table.
> - After the new profile is configured and is working correctly, you can delete the old .ost files to free up disk space. (These old files may use up a significant volume of disk space.) To recover this disk space, delete the .ost files that are located in the C:\Windows.old\\<**Your User name**>\profile\AppData\Local\Microsoft\Outlook folder.
> - Outlook 2013 RT is included in Office Home & Student 2013 RT on Windows RT 8.1.

---
title: Terminated in error found in Sync Issues log files
description: Documenting an issue for OffCAT rule where errors appear in the Sync Issues folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Terminated in error found in Outlook Sync Issues log files

_Original KB number:_ &nbsp; 2991453

## Symptoms

Using a Cached Mode profile, in Microsoft Outlook you see the following error in messages with the subject Synchronization Log in the Sync Issues folder:

> Terminated in error  
[80040600-501-80040600-560]  
The client operation failed.

This error may appear alone, or accompany other actions or conditions, such as Send/Receive, missing email, or slow synchronization with Exchange Server.

## Cause

This error has been associated with Outlook Data File (OST) corruption. The cause of corruption has never been determined.

## Resolution

The error may be resolved in Outlook 2016, Outlook 2013 or Outlook 2007 by deleting and recreating the Outlook Cached Mode OST file. If that fails, then creating a new Outlook profile will resolve the issue.

Delete and recreate the OST file

- Outlook 2019, 2016, 2013, or Outlook for Microsoft 365
  1. On the **File** tab, select **Account Settings**, and then select **Account Settings**.
  2. In the **Account Settings** dialog, select **Data Files**.
  3. Locate the OST file for your email address, and note the path and filename of the OST file.

      :::image type="content" source="media/terminated-in-error-found-in-sync-issues-log-files/data-files.png" alt-text="Screenshot of the Data Files tab in Account Settings in Outlook." border="false":::

  4. Close all dialog boxes, and then close Outlook.
  5. With Outlook closed, in Windows Explorer, navigate to the path and file determined in step 3, and then delete the .OST file.
  6. Restart Outlook and allow a new OST to be created.

- Outlook 2007
  1. On the **Tools** menu in Outlook, select **Account Settings**.
  2. In the **Account Settings** dialog, select **Data Files**, and select the file for Mailbox-<*username*>.
  3. Select **Settings**, and then in the Microsoft Exchange dialog, select **Advanced**.
  4. Select **Offline Folder File Settings** and note the path and filename of the OST file.
  5. Close all dialog boxes, and then close Outlook.
  6. With Outlook closed, in Windows Explorer, navigate to the path and file determined in step 4, and delete the .OST file.
  7. Restart Outlook and allow a new OST to be created.

Create a new Outlook profile

Outlook 2019, Outlook 2016, Outlook 2013, Outlook 2007, or Outlook for Microsoft 365

1. Launch Control Panel.

    In Windows 10, Windows 8.1 and Windows 8: Type Control Panel at the **Start** screen, and then select **Control Panel** in the search results.

    In Windows 7 and Windows Vista: select **Start**, type *Control Panel* in the **Start Search** box, and then press Enter.

2. In Control Panel, locate and double-select Mail.
3. Select **Show Profiles**, and then select **Add**.
4. Enter a profile name, and then select **OK**.
5. Configure your Exchange email settings as needed, select **Next**, and then select **Finish**.
6. In the Mail Control Panel, select either **Prompt for a profile to be used**, or **Select Always use this profile** and select the new profile from the dropdown.
7. Select **OK**, and launch Outlook using the new profile.

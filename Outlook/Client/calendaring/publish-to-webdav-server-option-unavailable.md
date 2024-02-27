---
title: The Publish to WebDAV Server option is unavailable
description: Work around an issue in which the Publish to WebDAV Server option is unavailable for a calendar after you install the October cumulative update 2825825 for Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Publish to WebDAV Server option is unavailable for a calendar in Outlook 2010

_Original KB number:_ &nbsp; 2909318

## Symptoms

After you install the October cumulative update [2825825](https://support.microsoft.com/help/2825825) for Microsoft Outlook 2010, the **Publish to WebDAV Server** option is unavailable for a calendar.

## Cause

This issue occurs if you have published the calendar to Office.com.

## Workaround

To work around this issue, follow these steps:

1. Do one of the following:

   - Windows 7 and Windows Vista

     - Click **Start**, point to **All Programs**, click **Accessories**, and then click **Run**.
  
   - Windows XP

     - Click **Start**, and then click **Run**.

2. In the **Run** dialog box, type and run the following command:

    ```console
    C:\Program Files\Microsoft Office\Office14\outlook.exe /cleansharing
    ```

    > [!WARNING]
    > This command removes all RSS, Internet Calendar, and Microsoft SharePoint subscriptions from Account Settings, but leaves all previously downloaded content on your computer. This is useful if you delete one of these subscriptions within Outlook 2010.

## More information

For more information about other available switches in Outlook 2010, see [Command-line switches for Outlook 2010](https://support.microsoft.com/office/command-line-switches-for-microsoft-office-products-079164cd-4ef5-4178-b235-441737deb3a6).

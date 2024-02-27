---
title: Windows Search service setting results in no matches
description: This article details problems in Outlook that can result from having the Allow Service to Interact with Desktop option enabled for the Windows Search service. You may see 0 items indexed or No matches found messages when searching in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Windows Search service setting results in no matches found in Outlook

_Original KB number:_ &nbsp; 2768662

## Symptoms

When you use Instant Search in Microsoft Office Outlook, you receive the following message:

> No matches found.

This occurs even if you include search criteria for items that do match items in your mailbox and Windows Desktop Search (WDS) is configured to index the Outlook Data (.pst) file or Offline Outlook Data (`.ost`) file.

Additionally, if you view the **Indexing Status** dialog in Outlook, you receive one of the following messages:

> 0 items indexed.

> Outlook is currently indexing your items.  
> **#** items remaining to be indexed.

> [!NOTE]
> The number of items remaining to be indexed represented by the **#** placeholder in this message never decreases.
>
> This same message is shown if you open **Indexing Options** in Windows Control Panel.

## Cause

The **Allow service to interact with desktop** option is enabled for the Windows Search service.

## Resolution

To resolve this issue, disable the **Allow service to interact with desktop** option on the Windows Search service. To do this, follow these steps:

1. Exit Outlook.

    > [!NOTE]
    > Also exit Microsoft Lync or Communicator if it is running.

2. Run services.msc.
3. Right-click the **Windows Search** service, and then select **Properties**.
4. Select **Stop** and wait for the service to stop.
5. Select the **Log On** tab.
6. Clear the **Allow service to interact with desktop** option.
7. Select **Apply**.
8. Select the **General** tab.
9. Select **Start** and wait for the service to start.
10. Select **OK**.
11. Start Outlook.

## More information

If the Windows Search service is configured to have the **Allow service to interact with desktop** option enabled, the following Error event is also logged in the Application log:

> Source: Microsoft-Windows-Search  
Event ID: 3100  
Task Category: Gatherer  
Level: Error  
Description:  
Unable to initialize the filter host process. Terminating.  
Details:  
This operation returned because the timeout period expired. (0x800705b4)

To view the **Indexing Status** dialog in Outlook 2010 or later versions, follow these steps:

1. Press Ctrl+E or put your cursor in the Search text box to enable **Search Tools**.
2. On the **Search** tab, select the **Search Tools** button, and then select **Indexing Status**.

To view the **Indexing Status** dialog in Outlook 2007, select the **Tools** menu, select **Instant Search**, and then select **Indexing Status**.

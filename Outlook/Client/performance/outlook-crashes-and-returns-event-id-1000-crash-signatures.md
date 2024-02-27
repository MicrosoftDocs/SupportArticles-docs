---
title: Crashes with event ID 1000 crash signatures
description: Discusses an issue that causes Outlook to crash and returns event ID 1000 crash signatures after you add RSS feeds. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook crashes and returns event ID 1000 crash signatures after RSS feeds are added

_Original KB number:_ &nbsp; 3201500

## Symptoms

Microsoft Outlook 2016 crashes, and you see one or more of the following crash signatures entered under event ID 1000 in the Application log.

|Application name|Application version|Module name|Module version|Offset|
|---|---|---|---|---|
|Outlook.exe|16.0.4266.1001|Outlook.exe|16.0.4266.1001|0x00e16007|
|Outlook.exe|16.0.4432.1001|Outlook.exe|16.0.4432.1001|0x00e1974a|
|Outlook.exe|16.0.4456.1003|Outlook.exe|16.0.4456.1003|0x00000000013e8c5b|
|Outlook.exe|16.0.6741.2047|Outlook.exe|16.0.6741.2047|0x0101afca|
|Outlook.exe|16.0.7167.2040|Outlook.exe|16.0.7167.2040|0x00000000015244eb|
|Outlook.exe|16.0.7369.2038|Outlook.exe|16.0.7369.2038|0x00fc31fd|
|Outlook.exe|16.0.7528.1000|Outlook.exe|16.0.7528.1000|0x01005bff|

> [!NOTE]
>
> - This issue occurs after you add RSS feeds to Outlook.
> - In the Application log, the Application and Module versions of Outlook.exe and the Offset may differ from those listed here.

## Cause

This issue occurs because an empty RSS feed was added to Outlook 2016.

## Workaround

To work around this issue, remove the empty RSS feed from Outlook 2016. To do this, follow these steps.

1. In Outlook, on the **File** tab, select **Account Settings**, and then select **Account Settings**.
2. On the **RSS Feeds** tab, select the empty RSS feed, and then select **Remove**.
3. Select **Yes** to confirm that you want to remove the RSS feed.
4. Select **Close**.

## More information

To review the Application log, follow these steps:

1. In Control Panel, open the **Administrative Tools** item.
2. Double-click **Event Viewer**.
3. In the details pane, select **Application** under **Windows Logs**.
4. In the **Actions** pane, select **Filter Current Log**.
5. In the **Filter Current Log** dialog box, enter *1000* (as shown in the following screenshot), and then select **OK**.

   :::image type="content" source="media/outlook-crashes-and-returns-event-id-1000-crash-signatures/filter-current-log.png" alt-text="Screenshot of the Filter Current Log dialog box." border="false":::

---
title: Outlook crashes when you open a meeting that contains Lync meeting details
description: Describes an issue that causes Outlook to crash. Occurs when you open a meeting that contains details from a Lync meeting or from another online meeting. A resolution is provided.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Outlook 2016 for Mac 
- Outlook for Microsoft 365 for Mac 
- Outlook 2013 
- Microsoft Outlook 2010
search.appverid: MET150
ms.reviewer: aruiz, robevans, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---

# Outlook crashes when you open a meeting that contains Lync meeting details

## Symptoms

When you open a meeting that contains details from a Lync meeting or another online meeting in Microsoft Outlook 2013 or Outlook 2010, Outlook crashes. Additionally, in the Application log, you may find one or more of the following crash signatures in event ID 1000:

|Application name|Application version|Module name|Module version|Offset |
|---|---|---|---|---|
|**Outlook 2013**|
|Outlook.exe|15.0.4641.1001|Outlook.exe|15.0.4641.1001|0x00A131B7|
|Outlook.exe|15.0.4659.1000|Outlook.exe|15.0.4659.1000|0x00A13EBF|
|Outlook.exe|15.0.4667.1000|Outlook.exe|15.0.4667.1000|0x00A176C7|
|Outlook.exe|15.0.4649.1000|Outlook.exe|15.0.4649.1000|0x0000000000B66F59|
|Outlook.exe|15.0.4659.1000|Outlook.exe|15.0.4659.1000|0x0000000000B65D9D|
|Outlook.exe|15.0.4667.1000|Outlook.exe|15.0.4667.1000|0x0000000000B6C839|
|Outlook.exe|15.0.4753.1002|Outlook.exe|15.0.4753.1002|0x00011F82|
|Outlook.exe|15.0.4727.1000|Outlook.exe|15.0.4727.1000|0x00011F7F|
|**Outlook 2010**|
|Outlook.exe|14.0.7149.5000|Outlook.exe|14.0.7149.5000|0x0000A0CF|
|Outlook.exe|14.0.7153.5000|Outlook.exe|14.0.7153.5000|0x0004916A|
|Outlook.exe|14.0.7109.5000|Outlook.exe|14.0.7109.5000|0x0000000000007B94|
|Outlook.exe|14.0.7113.5000|Outlook.exe|14.0.7113.5000|0x0000A0B5|
|Outlook.exe|14.0.7157.5000|Outlook.exe|14.0.7157.5000|0x0000A0CF|
|Outlook.exe|14.0.7157.5000|Outlook.exe|14.0.7157.5000|0x0000000000007BA8|
|Outlook.exe|14.0.7160.5000|Outlook.exe|14.0.7160.5000|0x00013A98|
|Outlook.exe|14.0.7162.5003|Outlook.exe|14.0.7162.5003|0x0000000000007B60|

## Cause

This problem occurs when the following conditions are true:

- The organizer who created the meeting is using Outlook 2013 or Outlook 2010 for Windows.
- The meeting includes Lync or other online meeting details.
- The meeting is updated later through Outlook 2016 for Mac.

This is a common scenario in a manager/delegate configuration. For example, the delegate creates the meeting in the first bullet point, includes Lync or other online meeting details in the second, and then the manager updates the meeting in the third bullet.

## Resolution

To fix this issue, install the latest update for your version of Outlook for Mac which updates the meeting in bullet 3 in the Cause section.

To resolve this issue for Outlook 2016 for Mac, install the August 11, 2015, update for Office 2016 for Mac, or a later update. For information about this update, see [MS15-081: Description of the security update for Office 2016 for Mac: August 11, 2015](https://support.microsoft.com/en-us/topic/ms15-081-description-of-the-security-update-for-office-2016-for-mac-august-11-2015-2e959ede-6b6a-cfe9-1964-fa35858f0804).

## More information

To review the Application log, follow these steps:

1. In Control Panel, open **Administrative Tools**.
2. Double-click **Event Viewer**.
3. In the navigation pane on the left side, select **Application** under **Windows Logs**.
4. In the **Actions** pane on the right side, select **Filter Current Log**.
5. In the **Filter Current Log** dialog box, type _1000_ in the **Includes/Excludes Event IDs** field, as shown in the following screen shot, and then select **OK**.

    :::image type="content" source="media/outlook-crashes-when-open-meeting-contains-lync-meeting-details/event-ids-field.png" alt-text="Screenshot of the Filter Current Log dialog box, type 1000 in the Includes/Excludes Event IDs field.":::

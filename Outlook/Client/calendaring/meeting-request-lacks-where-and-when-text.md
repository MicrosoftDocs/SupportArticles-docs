---
title: Meeting request lacks Where and When text in body
description: Provides a resolution to make sure where and when test will be shown in the meeting request body in Outlook 2010.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: devmore, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Meeting request sent in Outlook 2010 lacks Where and When text in body

## Symptoms

When you send a meeting request in Microsoft Outlook 2010, where and when information about the meeting is not added to the body of the meeting request.

## Cause

Because most email clients now include a calendar feature and can send and receive meetings, Outlook 2010 does not add meeting details to the body of meeting requests.

## Resolution

On the sender's client, you can use the following registry value to make Outlook 2010 revert to the behavior found in earlier Outlook versions.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

1. Start Registry Editor.

2. Locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Options\Calendar`

3. Add the following registry data to this key:

   Value type: DWORD  
   Value name: **EnableMeetingDownLevelText**  
   Value data: 1

4. Exit Registry Editor.

   > [!NOTE]
   > Administrators may choose to create the registry value in the policy key of the registry:  
   > `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Options\Calendar`

## More information

In earlier versions of Outlook, this meeting details text is added to the body of a meeting when it is sent.

Some potential meeting attendees that you invite may be using text-based email client programs or web applications that do not support all the controls in the meeting request. In those cases, the body text provides the meeting details to the user. When Outlook 2010 is used to create the meeting and send the request, this body text is no longer generated.

The following screenshot shows a meeting request as it is displayed in Outlook 2007. The body of the meeting request includes the automatically generated body text.

:::image type="content" source="media/meeting-request-lacks-where-and-when-text/meeting-request-in-outlook-2007.png" alt-text="A screenshot showing a meeting request as it is displayed in Outlook 2007." border="false":::

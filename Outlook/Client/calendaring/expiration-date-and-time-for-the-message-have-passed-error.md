---
title: Expiration date and time for the message have passed error
description: Describes an issue that triggers an error when you try to update meetings in Outlook. This issue occurs when the .
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Expiration date and time for the message have passed error when you try to update meetings

_Original KB number:_ &nbsp; 3091334

## Symptoms

When you try to update a meeting in Microsoft Outlook 2010 or Outlook 2013, you receive the following error message:

> The expiration date and time for the message have passed. Do you still want to send it?

:::image type="content" source="media/expiration-date-and-time-for-the-message-have-passed-error/error.png" alt-text="Screenshot of expiration date and time error details." border="false":::

> [!NOTE]
> Select **Yes** does not actually send a meeting update.

## Cause

This issue occurs when the **Expires After** option has been enabled for the meeting.

## Resolution

To resolve this issue, follow these steps:

1. Open the meeting.
2. Select **File**.
3. Select **Properties**.
4. Clear the **Expires After** check box, or change the expiration date.

   :::image type="content" source="media/expiration-date-and-time-for-the-message-have-passed-error/clear-expires-after-checkbox.png" alt-text="Screenshot of the Expires After check box." border="false":::

5. Select **Close**.

## More information

The **Expires After** setting is managed by the following registry settings.

> [!NOTE]
> You can also set an expiration date on an individual item. In that situation, there may be no registry data involved.

- In Outlook, this registry setting is controlled by the **Mark messages as expired after this many days** option. To change this setting, follow these steps:

  1. On the **File** menu in Outlook, click **Options**.
  2. In the navigation pane on the left, click **Mail**.
  3. Scroll down to Send Messages pane, and then clear the **Mark messages as expired after this many days** setting.

     :::image type="content" source="media/expiration-date-and-time-for-the-message-have-passed-error/mark-messages-as-expired-after-this-many-days.png" alt-text="Screenshot of the clear the Mark messages as expired after this many days setting check box." border="false":::

- Without Group Policy:

  Key: `HKEY_CURRENT_USER\software\Microsoft\Office\x.0\Outlook\Options\General`  
  DWORD: NumDaysExpire  
  Value: 0-3652

- With Group Policy:

  Key: `HKEY_CURRENT_USER\software\Policies\Microsoft\Office\x.0\Outlook\Options\General`  
  DWORD: NumDaysExpire  
  Value: 0-3652

> [!NOTE]
> The x.0 placeholder represents your version of Office (15.0 = Office 2013, 14.0 = Office 2010).

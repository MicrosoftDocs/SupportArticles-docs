---
title: Outlook shows Disconnected in status bar
description: Describes the error messages that are caused by the trailing space in the legacyExchangeDN attribute in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans, Eduardo.Oliveira, sfellman
appliesto: 
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook shows Disconnected in status bar if the last character in legacyExchangeDN is a space

_Original KB number:_ &nbsp; 3068991

## Symptoms

In Outlook 2016 or Outlook 2013, you experience one or several of the following symptoms:

- You receive the following error message:

    > The Microsoft Exchange Administrator has made a change that requires you quit and restart Outlook.

    :::image type="content" source="media/outlook-displays-disconnected-in-status/require-you-quit-and-restart-outlook.png" alt-text="Screenshot of the error message, which shows the Microsoft Exchange Administrator has made a change that requires you quit and restart Outlook.":::

- You receive the following error message when you start Outlook:

    > Cannot start Microsoft Outlook. Cannot open the Outlook window. The set of folders cannot be opened. The file C:\Users\<username>\AppData\Local\Microsoft\Outlook\user@doamin.com.ost is not an Outlook data file (ost).

- Outlook displays one of the following messages in the status bar:

    > Trying to connect...

    > Disconnected

## Cause

This issue occurs if there is a trailing space (that is, if a space is the last character) in the `legacyExchangeDN` attribute.

## Resolution

To resolve this issue, remove the trailing space from the `legacyExchangeDN` attribute by using ADSIEdit.msc. To do this, follow these steps.

> [!IMPORTANT]
> After you make this change in the legacyExchangeDN attribute, recipients who previously received an email message from this user will receive a non-delivery report (NDR) message if they try to reply to an email message that they received from this user before the change was made. This problem will not occur for replies to new email messages that the user sends after the change was made.

1. Open the **Run** dialog box. To do this, use one of the following methods, as appropriate for your situation:
   - Windows 10, Windows 8.1, or Windows 8: Press the Windows key+R.
   - Windows 7 or Windows Vista: Select **Start**, and then select **Run**.
2. Type *ADSIEdit.msc*, and then press Enter.
3. Expand the **Default naming** context to **CN=Users**.
4. Select the user account whose mailbox is prompting the error.
5. Right-click this account, and then select **Properties**.
6. Locate the `legacyExchangeDN` attribute, and then select **Edit**.

    :::image type="content" source="media/outlook-displays-disconnected-in-status/edit-legacyexchangedn.png" alt-text="Screenshot of the administrator properties window with the legacyExchangeDN attribute selected.":::

7. Remove the trailing space at the end of the username.
8. Select **OK**, select **Apply**, and then exit ADSIEdit.msc.
9. Have the user exit and then restart Outlook.

## More information

For more information, see [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)).

---
title: Attendees get cancellation followed by meeting update
description: Describes an issue that triggers a meeting cancellation to external recipients followed by a meeting update that corrects the cancellation. Occurs in Microsoft Exchange. Provides a workaround.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: jmartin
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
search.appverid: MET150
---
# Attendees receive a meeting cancellation followed by a meeting update shortly before the start time

_Original KB number:_ &nbsp; 3165413

## Symptoms

Consider the following scenario:

- A meeting organizer creates a meeting that includes one or more external recipients.
- One or more of the external recipients has a hidden mail contact in the global address list.
- The organizer closes the reminder on the Apple iOS device.

In this scenario, the external attendee receives a meeting cancellation followed by a meeting update that corrects the original cancellation. Internal users may receive an additional meeting update.

## Cause

An update to Exchange ActiveSync (EAS) that was intended to improve general protocol functionality exposed a pre-existing issue with the underlying system code, which causes this calendar synchronization issue.

## Workaround

Make the hidden contact visible in the global address list by using the [Set-MailContact](/powershell/module/exchange/set-mailcontact?view=exchange-ps&preserve-view=true) cmdlet. To do this, do one of the following:

- In Exchange Online, follow these steps:

  1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
  2. Run the following command:

        ```powershell
        Set-MailContact <alias> -HiddenFromAddressListsEnabled:$False
        ```

- In on-premises Exchange Server 2016 and in an Exchange hybrid environment, open the Exchange Management Shell, and then run the following command:

  ```powershell
  Set-MailContact <alias> -HiddenFromAddressListsEnabled:$False
  ```

You can also work around this issue by using [Microsoft Outlook for iOS](https://apps.apple.com/app/microsoft-outlook/id951937596).

Microsoft is researching this issue and will post more information in this article when the information becomes available.

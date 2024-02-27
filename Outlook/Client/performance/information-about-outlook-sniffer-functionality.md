---
title: Information about Outlook Sniffer functionality
description: This article provides information about the Sniffer functionality of Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Information about the Outlook Sniffer functionality

_Original KB number:_ &nbsp; 2699725

## Summary

Microsoft Outlook has a feature, nicknamed the *sniffer*, that automatically processes certain types of messages that are sent to you. For example, if you send an e-mail message with voting buttons and a recipient of that message responds with their *vote*, their response is processed after it arrives in your Inbox. After this processing occurs, the vote tally is updated in the original message in your **Sent Items** folder. This automatic processing is done by the sniffer process.

In Outlook versions earlier than Outlook 2007, the sniffer process does not run immediately after these messages arrive in your Inbox. There is always a small processing delay (up to a few minutes) as the sniffer process runs as an *idle time* task. This means Outlook waits for inactivity before kicking-off the sniffer process. In Outlook 2007 and later versions of Outlook, the sniffer process will run on items *before* they are *displayed* in your Inbox if you are using a profile configured with Cached Exchange mode. So, there is no processing delay in this configuration. However, these later versions of Outlook still exhibit a processing delay by the sniffer if you are using an Online mode profile with an Exchange mailbox.

> [!IMPORTANT]
> In Exchange Online, Exchange Server 2010 and later versions, the Calendar Attendant processes these messages by default, negating the need for the Outlook Sniffer functionality. For more information, see the `AutomateProcessing` parameter section of [Set-CalendarProcessing](/powershell/module/exchange/set-calendarprocessing).

The sniffer process can be controlled by the Automatically process meeting requests and responses to meeting requests and polls setting in the **Options** dialog box, as shown in the following figure from Outlook 2010.

:::image type="content" source="media/information-about-outlook-sniffer-functionality/outlook-options.png" alt-text="Screenshot for the Outlook Options dialog box.":::

If you disable this option, Outlook will not automatically process these items and processing of the items will only occur if you manually view the items (either by opening the item or viewing it in the Reading Pane). Therefore, it is not recommended you disable this option unless you prefer to manually process items.

## More information

The following items are the messages that are automatically processed by sniffer:

- Meeting invites and updates
- Meeting responses

  > [!NOTE]
  > If you have a mailbox on Exchange 2007 or later, the Exchange Calendar Assistant processes meeting invites, updates, and responses when they arrive in your Inbox. They are only processed by sniffer if you have the Calendar Assistant disabled on your mailbox (not a recommended configuration).

- Voting responses
- Message Recall notices
- Task updates
- Delivery receipts
- Read receipts

By default, the Automatically process meeting requests and responses to meeting requests and polls option is enabled. If you disable this option, the following data is written into the Windows registry.

Key: `HKEY_CURRENT_USER\software\Microsoft\Office\<x.0>\Outlook\Options\General`  
DWORD: AutoProcReq  
Value: 0

> [!NOTE]
> The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010, 12.0 = Office 2007, 11.0 = Office 2003).

> [!NOTE]
> If the `AutoProcReq` registry value is either missing or set to a value of 1, the sniffer feature is enabled.

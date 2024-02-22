---
title: Messages do not include default email signature
description: This article describes why Outlook autosignatures are not added when new email messages are created from a program other than Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# Messages that are created outside Outlook do not include the default Outlook email signature

_Original KB number:_ &nbsp; 2544665

## Symptoms

When you use a MAPI-compliant program to create a new email message, the message may not contain the default Microsoft Outlook email signature. This includes, but is not limited to, the following scenarios:

- You use **Send As** or other **Send** commands from another Microsoft Office application, such as Microsoft Word, Microsoft Excel, or Microsoft PowerPoint. This scenario typically occurs when you use a command to send the current file as an attachment.
- You use **Email** or **Send to Mail Recipient** in Windows Explorer.
- You use the `SendObject` method or command from Microsoft Access, and you use the `EditMessage` parameter to display the message instead of sending it immediately.
- A custom solution programmatically creates a new email message window by using Simple MAPI or Extended MAPI.

## Cause

Any of these scenarios may use Simple MAPI to generate the email message. In this case, whereas Outlook is handling the MAPI calls and generating the message, Outlook does not handle this scenario in the same manner as it does if you create a new message directly in Outlook.

## Workaround

Use the **Signature** button on the **Message** tab of the Ribbon to insert the signature manually.

> [!NOTE]
> There are no plans to change this behavior in Microsoft Outlook 2019 or in earlier versions of Outlook.

## More information

Generally, it is easy to tell if a new message is created by using Simple MAPI. In these cases, the window is modal, and this means that the focus cannot be taken away from the email message window until the window is closed, or the message is sent.

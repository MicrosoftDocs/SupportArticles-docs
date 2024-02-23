---
title: NDR error 554 5.6.0 Invalid message content
description: Describes an issue in which a Microsoft 365 user receives an 554 5.6.0 Invalid message content NDR.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 167832
  - CSSTroubleshoot
  - 'Associated content asset: 4555315'
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
ms.reviewer: v-six
---
# "554 5.6.0 Invalid message content" when sending a message that contains an Excel or Word attachment

_Original KB number:_&nbsp;2984127

## Problem

A Microsoft 365 user creates an Excel spreadsheet (.xlsx file) or a Word document (.docx file), and then sends it as an attachment to an email message. However, the message and the attachment aren't delivered to the recipient, and the sender receives a nondelivery report (NDR) that contains the following error code:

> 554 5.6.0 Invalid message content

## Cause

This issue may occur if the following conditions are true:

- A transport rule is set up that has the **Defer the message if rule processing doesn't complete** option enabled.
- During text extraction, the scanning process timed out when inspecting the attachment.

## Workaround

To work around this issue, do one of the following:

- Password-protect the message before you send it.
- Disable the **Defer the message if rule processing doesn't complete** option in the transport rule. This option may be set on any rule in the rules list. For more info about how to modify transport rules in Exchange Online, see [Manage transport rules](/exchange/security-and-compliance/mail-flow-rules/manage-mail-flow-rules).
- Review the message itself (obtain it if you are troubleshooting for someone else) and obtain a message trace to see if that provides additional insight.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

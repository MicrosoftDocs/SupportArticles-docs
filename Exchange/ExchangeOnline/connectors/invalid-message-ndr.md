---
title: 554 5.6.0 Invalid message content in Office 365
description: Describes an issue in which an Office 365 user receives an "554 5.6.0 Invalid message content" NDR.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
---

# "554 5.6.0 Invalid message content" NDR when an Office 365 user sends a message that contains an Excel attachment

_Original KB number:_&nbsp;2984127

## Problem

An Office 365 user creates an Excel spreadsheet (.xlsx file) and then sends it as an attachment to an email message. However, the message and the attachment aren't delivered to the recipient, and the sender receives a nondelivery report (NDR) that contains the following error code:

> 554 5.6.0 Invalid message content' content

## Cause

This issue may occur if the following conditions are true:

- A transport rule is set up that has the **Defer the message if rule processing doesn't complete** option enabled.
- During text extraction, the scanning process timed out when inspecting the attachment.

## Workaround

To work around this issue, do one of the following:

- Password-protect the message before you send it.
- Disable the **Defer the message if rule processing doesn't complete** option in the transport rule. Be aware that this option may be set on any rule in the rules list. For more info about how to modify transport rules in Exchange Online, see [Manage transport rules](https://technet.microsoft.com/library/jj657505%28v=exchg.150%29.aspx).
- Review the message itself (obtain it if you are troubleshooting for someone else) and obtain a message trace to see if that provides additional insight.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

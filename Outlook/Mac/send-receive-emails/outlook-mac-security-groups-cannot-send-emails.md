---
title: Can't send emails from security groups, distribution lists, or mail-enabled Public Folders in Outlook for Mac
description: You receive error code 19991, 19992 or 21999 when you try to send email messages from a distribution list, a security group, or a mail-enabled Public Folder in Outlook for Mac.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Outlook for Mac
- CSSTroubleshoot
ms.reviewer: tsimon, tasitae
appliesto:
- Outlook for Mac for Office 365
- Outlook 2019 for Mac
- Outlook 2016 for Mac
search.appverid: MET150
---
# Errors when sending emails from security groups, distribution lists, or mail-enabled Public Folders in Outlook for Mac

_Original KB number:_ &nbsp;2739937

## Symptoms

When you try to send email messages from a distribution list, a security group, or a mail-enabled Public Folder, Outlook for Mac 2011, Outlook 2016 for Mac, or Outlook for Mac 2019 times out, and you receive one of the following error messages:

```console
Error: An unknown error has occurred in Outlook.
Details: Mail could not be sent. The message has been moved to your Drafts folder.
Error code: -19991

Error: An unknown error has occurred in Outlook.
Error code: -19992

Error: An unknown error has occurred in Outlook.
Details: Mail could not be sent.
Error code: -21999
```

## Cause

Outlook for Mac has the following limitations:

- You can't send email messages from a distribution list, a security group, or a mail-enabled Public Folder.
- You can't use a distribution list, a security group, or a mail-enabled Public Folder as a delegate.

## Workaround

To work around these limitations, take the following actions:

- Send email messages from a single account instead of from a distribution list, a security group, or a mail-enabled Public Folder.
- Use single accounts as delegates instead of using distribution lists, security groups, or mail-enabled Public Folders as delegates.
- Use an Office 365 Group instead. For more information about Office 365 Groups, see [Learn about Office 365 Groups](https://support.office.com/article/Learn-about-Office-365-groups-b565caa1-5c40-40ef-9915-60fdb2d97fa2).

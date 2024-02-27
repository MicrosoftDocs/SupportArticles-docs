---
title: Email not delivered at scheduled time if Do not deliver before enabled
description: Describes a by design behavior that emails may not be delivered at the scheduled time in Cached Exchange Mode even if the Do not deliver before option is enabled. Provides a workaround.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Email may not be delivered at the scheduled time when the "Do not deliver before" option is enabled in an Outlook message

## Symptoms

When you enable the **Do not deliver before** option to defer the delivery of a Microsoft Office Outlook e-mail message, the message may not be delivered at the scheduled time.

## Cause

This behavior may occur if the following conditions are true:

- Outlook is running in Cached Exchange Mode.
- Outlook is not running at the scheduled time of the deferred delivery.

## More information

When Outlook is running in Cached Exchange Mode, it uses a local offline folder file (.ost). This file is periodically synchronized with the server. When you enable the **Do not deliver before** option to defer the delivery of a message, the message is deferred to the local Outbox, not to the server. Therefore, the message will not be delivered from the local .ost file unless Outlook is running when the message is scheduled to be delivered. This behavior does not occur in when Outlook is running in online mode.

## Workaround

To work around this behavior, enable the **Do not deliver before** option to defer delivery of the message when Outlook is running in online mode.

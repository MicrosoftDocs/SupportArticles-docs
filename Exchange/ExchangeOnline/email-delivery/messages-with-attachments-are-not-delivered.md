---
title: Messages with attachments not delivered
description: Describes an issue in which messages are delayed by several hours or are never displayed in the recipient's mailbox. Occurs in an Office 365 environment where Exclaimer is used. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: marcn
appliesto:
- Exchange Online
search.appverid: MET150
---
# Messages with attachments are not delivered when ATP Dynamic Delivery and Exclaimer are used

_Original KB number:_ &nbsp; 4014438

## Symptoms

Consider the following scenario:

- An Office 365 tenant is set up to route messages to Exclaimer for signature or disclaimer services.
- The Advanced Threat Protection (ATP) Safe Attachment feature is enabled.
- Under the **Safe attachments unknown malware response** option, the Dynamic Delivery feature is selected.

In this scenario, messages may be delayed by several hours or may never be displayed in the recipient's mailbox.

## Cause

Exclaimer installs a transport rule that routes mail originating inside the organization to the Exclaimer cloud through an outbound connector. As soon as the signature is applied, the message is routed back into Office 365 for delivery. Because attachment scanning begins before the message leaves Office 365, the attachment cannot be added back to the message correctly when the message returns.

## Resolution

To resolve this issue, edit the Exclaimer rule to bypass attachment scanning until Exclaimer has processed the message. To do this, follow these steps:

1. Sign in to Exchange Admin Center.
2. Locate **mail flow**, select **rules**, and then open the Exclaimer rule.
3. Under the **Do the following** field, select **modify the message properties**, and then set a message header as follows:

    Header: **X-MS-Exchange-Organization-SkipSafeAttachmentProcessing**  
    Value: **1**
4. Save the transport rule.

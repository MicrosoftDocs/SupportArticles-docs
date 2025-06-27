---
title: Messages with attachments not delivered
description: Describes an issue in which messages are delayed by several hours or are never displayed in the recipient's mailbox. Occurs in a Microsoft 365 environment where Exclaimer is used. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: marcn, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Messages with attachments are not delivered when MDO Dynamic Delivery and Exclaimer are used

_Original KB number:_ &nbsp; 4014438

## Symptoms

Consider the following scenario:

- A Microsoft 365 tenant is set up to route messages to Exclaimer for signature or disclaimer services.
- The Microsoft Defender for Office 365 (MDO) Safe Attachment feature is enabled.
- Under the **Safe attachments unknown malware response** option, the Dynamic Delivery feature is selected.

In this scenario, messages may be delayed by several hours or may never be displayed in the recipient's mailbox.

## Cause

Exclaimer installs a transport rule that routes mail originating inside the organization to the Exclaimer cloud through an outbound connector. As soon as the signature is applied, the message is routed back into Microsoft 365 for delivery. Because attachment scanning begins before the message leaves Microsoft 365, the attachment cannot be added back to the message correctly when the message returns.

## Resolution

To resolve this issue, edit the Exclaimer rule to bypass attachment scanning until Exclaimer has processed the message. To do this, follow these steps:

1. Sign in to Exchange Admin Center.
2. Locate **mail flow**, select **rules**, and then open the Exclaimer rule.
3. Under the **Do the following** field, select **modify the message properties**, and then set a message header as follows:

    Header: **X-MS-Exchange-Organization-SkipSafeAttachmentProcessing**  
    Value: **1**
4. Save the transport rule.

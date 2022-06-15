---
title: Messages with large HTML body can't be saved to a PST file
description: The RopFastTransferSourceCopyTo operation fails on messages with large HTML body.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 163448
  - CSSTroubleshoot
ms.reviewer: bilong, liantan, batre
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 6/15/2022
---
# Messages with large HTML body can't be saved to a PST file

## Symptoms

In Microsoft Outlook online mode, some messages with a large HTML message body (such as an HTML table) can't be saved to a PST file. If you diagnose the issue, you find that the [RopFastTransferSourceCopyTo](/openspecs/exchange_server_protocols/ms-oxcfxics/0e419747-0420-4780-9682-3ea3d4081349) operation fails on these messages. Additionally, the diagnostic context indicates the following error message:

> Microsoft.Exchange.Data.TextConverters.TextConvertersException: Input document is too complex.

## Cause

This behavior is by design. For an HTML message body, the `RopFastTransferSourceCopyTo` operation requests the Exchange server to perform a content conversion. To prevent performance impact from such conversions, there are limits on the complexity of the conversion that the Exchange server will attempt. For example, if the HTML message body is extremely large and has tables with thousands of elements, the `RopFastTransferSourceCopyTo` operation may fail on the messages.

## Workaround

Instead of including the HTML content in the messages body, attach it to the messages as an attachment. In this case, the `RopFastTransferSourceCopyTo` operation will be successful because attachments won't be converted.

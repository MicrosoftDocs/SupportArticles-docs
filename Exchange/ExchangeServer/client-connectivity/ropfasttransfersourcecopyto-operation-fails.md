---
title: RopFastTransferSourceCopyTo operation fails on messages
description: The RopFastTransferSourceCopyTo operation fails on the messages with a large HTML message body because input document is too complex.
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
ms.date: 6/23/2022
---
# RopFastTransferSourceCopyTo operation fails on messages

## Symptoms

When a MAPI email client sends a [RopFastTransferSourceCopyTo](/openspecs/exchange_server_protocols/ms-oxcfxics/0e419747-0420-4780-9682-3ea3d4081349) request to a Microsoft Exchange server, the operation might fail on messages that have a large section of HTML content such as a complex table, embedded in the message body. For example, if you're using Microsoft Outlook in online mode to copy a message which has an HTML table that includes a large number of elements, to a PST file, the copy operation might not be executed.

When you check the diagnostic context returned by the Exchange server for the failed operation, it lists the following reason for the failure:

> Microsoft.Exchange.Data.TextConverters.TextConvertersException: Input document is too complex.

## Cause

This behavior is by design. When the `RopFastTransferSourceCopyTo` operation is called on the Exchange server, the server performs content conversion on the message body. If the body is a large and complex block of HTML, the Exchange server doesn't perform the conversion. This is because there are limits to the complexity of the conversion that the server will attempt to ensure that its performance is not impacted. In this scenario the [RopFastTransferSourceCopyTo](/openspecs/exchange_server_protocols/ms-oxcfxics/0e419747-0420-4780-9682-3ea3d4081349) operation will fail.

## Workaround

Save the large HTML content to a file and attach the file as an attachment to the message instead of including it in the message body. Attachments don't need to be converted, so the `RopFastTransferSourceCopyTo` operation will succeed.

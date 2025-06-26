---
title: RopFastTransferSourceCopyTo operation fails on messages
description: The RopFastTransferSourceCopyTo operation fails on messages that have a large HTML message body because the input document is too complex.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with Outlook
  - Exchange Server
  - CI 163448
  - CSSTroubleshoot
ms.reviewer: bilong, liantan, batre
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# RopFastTransferSourceCopyTo operation fails on messages

## Symptoms

When a MAPI email client sends a [RopFastTransferSourceCopyTo](/openspecs/exchange_server_protocols/ms-oxcfxics/0e419747-0420-4780-9682-3ea3d4081349) request to a server that's running Microsoft Exchange Server, the operation fails on messages that have a large section of HTML content, such as a complex table, embedded in the message body. For example, if you're using Microsoft Outlook in online mode to copy a message that has an HTML table that includes many elements to a PST file, the copy operation isn't completed.

When you check the diagnostic context that's returned by the server for the failed operation, the diagnostic lists the following reason for the failure:

> Microsoft.Exchange.Data.TextConverters.TextConvertersException: Input document is too complex.

## Cause

This behavior is by design. When the `RopFastTransferSourceCopyTo` operation is called by Exchange Server, the server runs a content conversion on the message body. But if the body is a large and complex block of HTML, the server skips the conversion to avoid errors. The server is limited in the complexity of conversion that it will try to run. In this scenario, the [RopFastTransferSourceCopyTo](/openspecs/exchange_server_protocols/ms-oxcfxics/0e419747-0420-4780-9682-3ea3d4081349) operation fails.

## Workaround

Save the large HTML content to a file, and attach the file to the message instead of including it in the message body. Attachments don't have to be converted. If a complex conversion attempt is avoided, the `RopFastTransferSourceCopyTo` operation should succeed.

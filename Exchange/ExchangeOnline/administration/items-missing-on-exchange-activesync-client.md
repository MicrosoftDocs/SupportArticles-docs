---
title: Items missing on Exchange ActiveSync client
description: Addresses an issue in which items are missing on an Exchange ActiveSync client. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Email items are missing on an Exchange Server ActiveSync client
  
_Original KB number:_ &nbsp; 4058179

## Symptoms

In Microsoft Exchange ActiveSync, some email messages are missing even though the client continues to receive messages.

## Cause

When the server that's running Exchange Server responds to a **Sync** command for one or more new items, the client either does not receive the response or cannot process the response. The ActiveSync client sends a **Ping** command for the affected folder before it sends another **Sync** command to retrieve the items that failed in the first response. Because the **Ping** command was sent, the server believes that the message was already added to the device.

## Workaround

To work around this behavior, disable email synchronization on the Exchange ActiveSync client, and then re-enable email for the client.

## Status

This behavior is by design. The **Ping** command is an acknowledgment of the **Sync** response.

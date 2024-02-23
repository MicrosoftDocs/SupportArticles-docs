---
title: Object reference not set to instance of object
description: Describes that Exchange Server does not support tracing a message that is sent from on-premises to the cloud in a hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: bilong, ninob, v-six
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# Object reference not set to an instance of an object error and message trace fails in an Exchange hybrid environment

_Original KB number:_ &nbsp; 4481099

## Symptoms

Considering this scenario:

- You're working in a Microsoft Exchange Server hybrid environment.
- A message is sent from an on-premises mailbox to an Exchange Online mailbox.
- You try to trace the message in Delivery Reports in the on-premises Exchange organization.

In this scenario, the trace fails, and you receive this error message:

> Object reference not set to an instance of an object.

## Cause

This is by design. Exchange Server does not support tracing a message that's sent from on-premises to the cloud in a hybrid environment.

## Workaround

To work around this problem, run the message trace from Microsoft 365 to get a partial trace on the cloud side. Be aware that this does not show the on-premises path.

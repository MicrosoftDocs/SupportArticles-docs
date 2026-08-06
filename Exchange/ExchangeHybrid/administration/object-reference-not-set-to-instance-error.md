---
title: Object reference not set to instance of object
description: Describes that Exchange Server doesn't support tracing a message that is sent from on-premises to the cloud in a hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Message Tracking, Transport server logs
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: bilong, ninob, v-six, v-kccross
appliesto: 
  - Exchange Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 08/06/2026
---

# Object reference not set to an instance of an object error and message trace fails in an Exchange hybrid environment

_Original KB number:_ &nbsp; 4481099

## Summary

In an Exchange hybrid environment, message tracing from the on-premises Exchange organization can fail with an "Object reference not set to an instance of an object" error when you trace a message sent from an on-premises mailbox to an Exchange Online mailbox. This behavior is by design because Exchange Server doesn't support tracing messages across the on-premises-to-cloud boundary. To investigate message delivery, run a message trace in Microsoft 365, which provides visibility into the cloud portion of the message path but doesn't show the on-premises routing path.

## Symptoms

Considering this scenario:

- You're working in a Microsoft Exchange Server hybrid environment.
- A message is sent from an on-premises mailbox to an Exchange Online mailbox.
- You try to trace the message in Delivery Reports in the on-premises Exchange organization.

In this scenario, the trace fails, and you receive this error message:

> Object reference not set to an instance of an object.

## Cause

This result is by design. Exchange Server does not support tracing a message that's sent from on-premises to the cloud in a hybrid environment.

## Workaround

To work around this problem, run the message trace from Microsoft 365 to get a partial trace on the cloud side. Be aware that this does not show the on-premises path.

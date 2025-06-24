---
title: Delegates accept meetings automatically
description: Describes behavior in which a meeting request that's created by a delegate is automatically accepted and added to the delegate's calendar when the delegate is an attendee.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Meeting is automatically accepted when a delegate is added as an attendee

_Original KB number:_ &nbsp; 3209427

## Symptoms

Consider the following scenario:

- A user has one or more delegates assigned to their mailbox.
- The delegates create new meeting requests, and include themselves as attendees.

In this scenario, the meeting is automatically added to each delegate's calendar as accepted, and an "accepted" response is sent.

## More information

This behavior is by design in Microsoft Exchange Server and Exchange Online. When delegates add themselves to a meeting, Exchange considers this as a confirmation that the delegates want to attend. Therefore, Exchange automatically accepts the meeting on behalf of the delegates.

---
title: MAPI is the only way to change profiles
description: You can only use Extended MAPI to programmatically change profiles.
ms.date: 03/25/2025
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
---

# MAPI is the only supported way to programmatically change profiles

_Original KB number:_ &nbsp; 266352

The only supported way to modify MAPI profiles programmatically is through Extended MAPI. The values that are written into the registry by MAPI aren't documented, and direct manipulation of these values through the registry application programming interfaces (APIs) isn't supported.

**Note**: The keys and values that make up a MAPI profile depend on the various providers that make up the profile. Because providers aren't required to document the properties that they write or the relationship of the properties to one another, modifying these values directly can have unpredictable and adverse effects.

---
title: Event 6010 entries fill the Application event log in Exchange Server 2016
description: Describes an issue in Exchange Server 2016 in which many entries of event 6010 are logged in the Application event log.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nasira, ninob, v-trisshores
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Event 6010 entries fill the Application event log in Exchange Server 2016

## Symptoms

After you install Cumulative Update 23 for Microsoft Exchange Server 2016, event 6010 entries are continuously logged in the Application event log. These entries contain the following information:

```output
Event ID: 6010
Source: MSExchangeApplicationLogic
Description: Failed to read in memory manifest validation XSD schemas for version '1.1'.
```

This issue occurs only on Exchange 2016-based servers that aren't connected to the internet.

## Status

You can safely ignore all the instances of event 6010 that are logged. Microsoft is investigating this issue and will update this article when more information becomes available.

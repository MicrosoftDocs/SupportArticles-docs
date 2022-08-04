---
title: Event 6010 entries fill the Application event log on Exchange Server 2016
description: Describes an issue where numerous entries of event 6010 are logged in the Application event log in Exchange Server 2016.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nasira, ninob
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 08/04/2022
---
# Event 6010 entries fill the Application event log in Exchange Server 2016

## Symptoms

After you install Cumulative Update 23 for Microsoft Exchange Server 2016, numerous entries of event 6010 are logged per minute in the Application event log. These entries contain the following information:

Event ID: 6010
Source: MSExchangeApplicationLogic
Description: Failed to read in memory manifest validation XSD schemas for version '1.1'.

This issue occurs only on Exchange servers that are not connected to the internet.

## Status

You can safely ignore all the instances of event 6010 that are logged. Microsoft is investigating this issue and will update this article when more information becomes available.

---
title: Event ID 6010 floods the Application log on a server with Exchange 2016 CU23
description: Describes an issue where Event ID 6010 warnings occur after you install Cumulative Update 23 (CU23) for Microsoft Exchange Server 2016.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: meerak, ninob
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 08/03/2022
---
# Event ID 6010 floods the Application log on a server with Exchange 2016 CU23

## Symptoms

After you install Cumulative Update 23 (CU23) for Microsoft Exchange Server 2016, the Application log receives hundreds of "6010" events per minute. This problem occurs only if the affected server has no internet connection. The event entries contain the following information:

Event ID: 6010
Source: MSExchangeApplicationLogic
Description: Failed to read in memory manifest validation XSD schemas for version '1.1'.

## Status

You can safely ignore the "6010" event. Microsoft is working to resolve this issue and will post more information in this article when the information becomes available.

---
title: Event ID 2142 when Exchange services don't start
description: Describes an issue that prevents Microsoft Exchange services from starting. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Event ID 2142 when Exchange services don't start

_Original KB number:_ &nbsp; 3090811

## Symptom

When you try to start Exchange services, the services don't start, and the following event is logged in the Application log:

> Log Name: Application  
> Source: MSExchangeADTopology  
> Date: 3/18/2016 4:15:00 PM  
> Event ID: 2142  
> Task Category: Topology  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: EXCH2013.contoso.com  
> Description:  
> Process Microsoft.Exchange.Directory.TopologyService.exe (PID=1376) Forest contoso.com. Topology discovery failed, error details  
> No Minimal Required Number of Suitable Directory Servers Found in Forest contoso.com Site Default-First-Site-Name and connected Sites..

## Cause

This issue may occur if the total number of available domain controllers across multiple Active Directory sites is less than the `MinSuitableServer` value (the default value is 3).

## Resolution

To resolve this issue, restore the number of available domain controllers to a number equal to or greater than the `MinSuitableServer` value.

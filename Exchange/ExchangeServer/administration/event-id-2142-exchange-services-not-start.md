---
title: Event ID 2142 when Exchange services don't start
description: Describes an issue that prevents Microsoft Exchange services from starting. Provides a resolution.
author: AmandaAZ
ms.author: v-weizhu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CSSTroubleshoot
search.appverid:
- MET150
appliesto:
- Exchange Server 2013 Standard Edition
---
# Event ID 2142 when Exchange services don't start

This article helps you resolve the problem that Microsoft Exchange services don't start.

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

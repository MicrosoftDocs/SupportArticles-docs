---
title: AD replication isn't working with event 1865 logged
description: Fixes an issue where Active Directory replication doesn't work and event IDs 1865 and 1311 are logged.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory replication
ms.technology: ActiveDirectory
---
# AD replication isn't working with event 1865 logged

This article helps fix an issue where Active Directory replication doesn't work and event IDs 1865 and 1311 are logged.

_Original product version:_ &nbsp;Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp;944351

## Symptoms

You have multiple sites in the forest. On some sites, you find that AD replication isn't working.

On the Inter-Site Topology Generator (ISTG) Domain Controllers, the following events are logged every 15 minutes.

> Event Type: Warning  
Event Source: NTDS KCC  
Event Category: Knowledge Consistency Checker  
Event ID: 1865  
Date: \<date>  
Time: \<time>  
User: NT AUTHORITY\ANONYMOUS LOGON  
Computer: \<computername>  
Description:  
The Knowledge Consistency Checker (KCC) was unable to form a complete spanning tree network topology. As a result, the following list of sites cannot be reached from the local site.
>
> Sites:
CN=\<sitename>,CN=Sites,CN=Configuration,DC=\<domain>,DC=com
>
> Event Type: Error  
Event Source: NTDS KCC  
Event Category: Knowledge Consistency Checker  
Event ID: 1311  
Date: \<date>  
Time: \<time>  
User: NT AUTHORITY\ANONYMOUS LOGON  
Computer: \<computername>  
Description:  
The Knowledge Consistency Checker (KCC) has detected problems with the following directory partition.
>
> Directory partition:  
CN=Configuration,DC=\<domain>,DC=com

## Cause

This may happen when there are connectivity issues between the ISTG servers. For example, if a firewall has blocked the ports, the issue would occur.

## Resolution

Use the portqry tool to troubleshoot the connectivity issues to the Bridgehead servers of the sites that are listed in Event 1865. If the ports are blocked by the firewall, configure the firewall to open the ports.

[!INCLUDE [Third-party disclaimer](../../includes/community-solutions-content-disclaimer.md)]

---
title: AD replication isn't working with event 1865 logged
description: Fixes an issue where Active Directory replication doesn't work and event IDs 1865 and 1311 are logged.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# AD replication isn't working with event 1865 logged

This article helps fix an issue where Active Directory replication doesn't work and event IDs 1865 and 1311 are logged.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 944351

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

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if microsoft or any of its suppliers has been advised of the possibility of damages.
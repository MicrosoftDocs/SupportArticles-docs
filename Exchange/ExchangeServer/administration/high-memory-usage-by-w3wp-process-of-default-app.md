---
title: High memory usage by W3wp.exe of default app
description: Resolves an issue in which the W3wp.exe consumes too much memory. This issue occurs if you have more than 64 Client Access servers in a single Active Directory site in an Exchange Server 2010 environment.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Server Performance Issue (high CPU, high Memory, Disk Utilization)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: arindamt, shashikg, ketandp, nasira, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
---
# High memory usage by W3wp process of default application pool in an Exchange Server 2010 environment

_Original KB number:_ &nbsp; 3007848

## Symptoms

Consider the following scenario:

- You have more than 64 Exchange Server 2010 Client Access servers in one Active Directory site in an Exchange Server 2010 environment.
- Outlook Anywhere is enabled in the environment.

In this scenario, the W3wp.exe process that belongs to the default application pool on all Client Access servers consumes lots of event handles and memory. Then, the W3wp.exe process eventually runs out of handles and freezes, and you have to restart the default application pool to recover from this issue.

## Cause

This issue occurs because the number of Client Access servers in one Active Directory site is limited to 64 servers.

## Workaround

To work around this issue, reduce the number of servers. Or, segregate the servers onto different Active Directory sites.

## More information

For more information, download [this document about Multi-Tenancy and Hosting Guidance for Exchange Server 2010 SP2](https://www.microsoft.com/download/details.aspx?id=28192).

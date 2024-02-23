---
title: Can't manage virtual directories from Exchange Management Console in Exchange Server 2010
description: Describes an issue in which you can't manage certain virtual directories from Exchange Server 2010 Management Console in a native Exchange Server 2010 environment or in a mixed Exchange Server 2010 and Exchange Server 2007 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: bpeterse, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't manage OWA, Exchange ActiveSync, ECP, or OAB virtual directories from Exchange Management Console in Exchange Server 2010

_Original KB number:_ &nbsp;977966

## Symptoms

Consider the following scenario:

- You're working in a native Microsoft Exchange Server 2010 environment or in a mixed Exchange Server 2010 and Exchange Server 2007 environment.
- You can't manage the following virtual directories from Exchange Management Console (EMC):
  - Outlook Web App (OWA)
  - Exchange ActiveSync
  - Exchange Control Panel (ECP)
  - Offline Address Book (OAB)
- When you expand the server configuration list in EMC, you see a list of Client Access Server (CAS) servers on the right side.
- When you try to select an Exchange Server 2007 CAS server or an Exchange Server 2010 CAS server, you discover that it's inaccessible.

In this scenario, you receive an error message like this one:

> The task wasn't able to connect to IIS on the server \<CAS server name>. Make sure that the server exists and can be reached from this computer. The RPC server is unavailable. It was running the command 'Get-OwaVirtualDirectory'.

## Cause

When you try to select the CAS in EMC, the Exchange Server 2010 server runs a `Get-OwaVirtualDirectory` command in the Exchange Server background. However, you can't manage any of the virtual directories for the Exchange Server CAS servers if the command can't access any one of the Exchange Server CAS servers.

## Workaround

To work around this issue, wait until the Exchange Server CAS server that's not responding comes back on line, or, use Exchange Management Shell to manage the virtual directories explicitly.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

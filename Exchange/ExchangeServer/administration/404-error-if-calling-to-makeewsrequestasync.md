---
title: 404 error if calling makeEwsRequestAsync
description: Describes an issue that you receive a 404 error message when a modern add-in calls the makeEwsRequestAsync function in Exchange Server 2013.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dabarre, mhaque, v-six
appliesto: 
  - Exchange Server 2013
search.appverid: MET150
---
# 404 error and a call to makeEwsRequestAsync fails from a server that has split CAS/MBX roles in Exchange Server 2013

_Original KB number:_ &nbsp; 4476965

## Summary

Consider the following scenario:

- You're running Exchange Server 2013 Cumulative Update 19 (CU19) or a later version.
- The server that's running Exchange Server is configured to have split Client Access server (CAS) and Mailbox server (MBX) roles.
- A Modern add-in calls the **makeEwsRequestAsync** function from any supported client, such as the [Outlook client](/office/dev/add-ins/outlook/web-services).

In this scenario, the call fails and returns a **404** error message.

## Resolution

To fix this issue, install the CAS role on each Mailbox server. This is the preferred architecture for Exchange Server 2013.

## Status

This is a known issue in Exchange 2013 CU19 and later versions.

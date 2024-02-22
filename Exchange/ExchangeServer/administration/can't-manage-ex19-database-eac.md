---
title: Your request couldn't be completed. Please try again in a few minutes error when Exchange 2013 Administrator can't manage Exchange 2019 databases in EAC
description: This article describes an issue in which Exchange 2013 Administrator can't manage Exchange 2019 databases in EAC. Provides two solutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 106436
  - CSSTroubleshoot
ms.reviewer: sasta, EXOL_Triage, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013
  - Exchange Server 2019
ms.date: 01/24/2024
---

# "Your request couldn't be completed. Please try again in a few minutes" error when Exchange 2013 Administrator can't manage Exchange 2019 databases in EAC

## Symptoms

Consider the following scenario:

- You are working in a Microsoft Exchange Server 2013 and Exchange Server 2019 coexistence organization.
- You are the Exchange administrator.
- Your mailbox is located on Exchange Server 2013.

In this scenario, you can't manage the Exchange Server 2019 databases by using the Exchange Admin Center (EAC). Also, you receive an error message that resembles the following:

```
"Your request couldn't be completed. Please try again in a few minutes"
```

## Resolution

To fix this issue, use either of the following methods:

- Use `https://<Exchange Server 2019>/ecp/?ExchClientVer=15.2` to access Exchange Server 2019 EAC, and then log on by using an Exchange Server 2013 administrator account.
- Move the administrator mailbox to Exchange Server 2019 so that it uses the `https://<Exchange 2019 Server>/ecp` address.

---
title: Cannot get child of ADObjectId error
description: Describes an issue that prevents the Edge Transport server role from being installed on a domain-joined computer that runs Exchange Server. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: suku, dpaul, meerak, v-six, v-kccross
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11998
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 06/05/2026
---

# Cannot get child of ADObjectId error when you install the Edge Transport server role on a domain-joined Exchange server

_Original KB number:_ &nbsp; 3205799

## Summary

Microsoft Exchange Server Setup fails and returns a "Cannot get child of ADObjectId" error message when you install the Edge Transport server role on a domain-joined server. The operation fails because Setup runs a PowerShell task that tries to access a GUID-based Active Directory object that doesn’t contain the expected configuration path. To work around the problem, run Setup by using the setup UI, or remove the server from the domain, install the Edge Transport server role, and then rejoin the server to the domain.

## Symptoms

Exchange Server Setup fails, and you see the following error entry in the Setup log:

```console
   Error:
   The following error was generated when "$error.Clear(); new-ExchangeServer" was run: "System.ArgumentNullException: Value cannot be null.  
   Parameter name: Cannot get child of ADObjectId: this is a GUID based ADObjectId.
```

## Workaround

To work around this problem, use one of the following methods:

- Run Setup again by using the setup UI instead of PowerShell.
- Remove the server from the domain, install the Edge Transport server role, and then rejoin the computer to the domain.

## Status

Microsoft confirms that this problem exists in Microsoft Exchange Server.

---
title: Active Directory error 0x52 if you install Edge Transport server role
description: Provides a workaround to solve the Active Directory 0x52 error that occurs when you install Edge Transport server role.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11997
ms.reviewer: v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/05/2026
---

# Active Directory error 0x52 at Microsoft Exchange Server Edge Transport server role installation

_Original KB number:_ &nbsp; 4093253

## Summary

You receive "Active Directory error 0x52" when you install the [Edge Transport server role](/exchange/architecture/edge-transport-servers/edge-transport-servers) in a multi-domain environment. This issue occurs because you use an account from a different domain than the one that the Edge Transport server is joined to in order to install the role. Therefore, Exchange can’t validate the local server against Active Directory. To resolve the issue and sign in, use an account from the same domain that the server is joined to. Then, run the Edge Transport server role installation again.

## Symptoms

Consider the following scenario:

- An Active Directory forest contains multiple domains.
- You sign in to a domain-joined server by using a user account from another domain.
- You install the Edge Transport server role on this computer.

In this scenario, the installation fails and returns the following error message. The PowerShell execution also fails and generates a similar error.

```console
The following error was generated when "$error.Clear();  
Set-TopologyMode;  
Start-Sleep -s 5;  
" was run: "Microsoft.Exchange.Data.Directory.NoSuitableServerFoundException: An Active Directory error 0x52 occurred when trying to check the suitability of server 'localhost'. Error: 'Active directory response: A local error occurred.' ---> Microsoft.Exchange.Data.Directory.SuitabilityDirectoryException: An Active Directory error 0x52 occurred when trying to check the suitability of server 'localhost'. Error: 'Active directory response: A local error occurred.' ---> System.DirectoryServices.Protocols.LdapException: A local error occurred.
```

## Workaround

To install the Edge Transport server role, use an account from the same domain as the domain that's joined to the server.

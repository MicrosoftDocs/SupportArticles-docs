---
title: Active Directory error 0x52 when installing Edge role
description: Provides a workaround to solve the Active Directory 0x52 error that occurs when installing Exchange Server 2016 Edge role.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Active Directory error 0x52 at Exchange Server 2016 Edge role installation

_Original KB number:_ &nbsp; 4093253

## Symptoms

Consider this scenario:

- There are multiple domains in a forest.
- You sign in to a domain-joined server by using a user account from another domain.
- You try to install Microsoft Exchange Server 2016 Edge role with Cumulative Update 8 or Cumulative Update 7 on this server.

In this scenario, the installation fails with the following error. The PowerShell execution also fails with a similar error.

> The following error was generated when "$error.Clear();  
Set-TopologyMode;  
Start-Sleep -s 5;  
" was run: "Microsoft.Exchange.Data.Directory.NoSuitableServerFoundException: An Active Directory error 0x52 occurred when trying to check the suitability of server 'localhost'. Error: 'Active directory response: A local error occurred.' ---> Microsoft.Exchange.Data.Directory.SuitabilityDirectoryException: An Active Directory error 0x52 occurred when trying to check the suitability of server 'localhost'. Error: 'Active directory response: A local error occurred.' ---> System.DirectoryServices.Protocols.LdapException: A local error occurred.

## Workaround

Install the Edge server by using an account from the same domain.

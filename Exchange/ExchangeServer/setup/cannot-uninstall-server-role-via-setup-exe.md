---
title: Cannot use Setup.exe to uninstall server role
description: Describes an issue in which you cannot uninstall the Exchange Server 2013 server role by using Setup.exe. When this issue occurs, you receive an error.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, serdars, v-six
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
---
# The parameter roles is not valid error message when trying to uninstall Exchange Server 2013 server role

_Original KB number:_ &nbsp; 2801813

## Symptoms

Assume that you try to uninstall the Exchange Server 2013 server role by running this command:

```console
Setup.exe /Mode:Uninstall /Roles:ClientAccess /IAcceptExchangeServerLicenseTerms
```

However, you receive this error message:

> Welcome to Microsoft Exchange Server 2013 Unattended Setup  
> The parameter 'roles' is not valid for current operation 'Uninstall'.  
> Setup checks failed: Invalid command line arguments.
>
> Please type 'setup.exe /help' for more information.

## Cause

This behavior is by design. The `/Roles` parameter is not valid for uninstallation operations. Therefore, you cannot uninstall individual roles from Exchange Server 2013.

## Resolution

To resolve this issue, run the following command to uninstall Exchange Server 2013:

```console
Setup /Mode:Uninstall /IAcceptExchangeServerLicenseTerms
```

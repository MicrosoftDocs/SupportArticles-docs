---
title: SendAs permission not shown in Send As Permission
description: SendAs permission granted to users in forests trusted by Exchange forest aren't visible in the SendAs wizard in Exchange Management Console (EMC).
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
ms.reviewer: jcoiffin, v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# SendAs permissions granted to users in forests are not visible in Send As Permission Wizard in EMC

_Original KB number:_ &nbsp; 2401524

## Symptoms

The Send As permissions that are granted to users in forests trusted by Exchange Server forest aren't visible in the Send As Permission Wizard in Exchange Management Console (EMC).

## Cause

It is the current design in Exchange Server 2010.

## Workaround

To view all accounts that have SendAs rights on a mailbox, you can use the following PowerShell command instead:

```powershell
Get-ADPermission <mailboxname> | where {($_.extendedrights -like "*send-as*") -or ($_.accessrights -like "*Generical*")} |fl *
```

For more information, see [Manage Send As Permissions for a Mailbox](/previous-versions/office/exchange-server-2010/bb676368(v=exchg.141)).

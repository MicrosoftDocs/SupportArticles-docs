---
title: The term New-Mailbox is not recognized error occurs when you create a mailbox in Exchange Server
description: Describes the term New-Mailbox is not recognized error that occurs when you create a new mailbox that uses RBAC split permissions or Active Directory split permissions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipient Management
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11983
ms.reviewer: charray, russwill, v-9sidal, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/03/2026
---

# The term New-Mailbox is not recognized error occurs when you create a mailbox in Microsoft Exchange Server

_Original KB number:_ &nbsp;2795751

## Summary

In environments that use RBAC split permissions or Active Directory split permissions, mailbox creation can fail in Exchange Management Console (EMC) or Exchange Management Shell (EMS) and return an error message that states that `New-Mailbox` isn’t recognized. This issue occurs because the split permissions model prevents Exchange administrators from creating user objects in Active Directory. To resolve the issue, switch to the default Exchange shared permissions model by modifying role-based access control (RBAC) or Active Directory split permissions settings by using EMS or Setup commands.

## Symptoms

Assume that a server is configured to use RBAC or Active Directory split permissions in a Microsoft Exchange Server environment. When you create a mailbox by using Exchange Management Console (EMC) or by running the `New-Mailbox` cmdlet in Exchange Management Shell (EMS), the operation fails, and you receive the following error message:

```console
   Error:  
   The term 'New-Mailbox' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

> [!NOTE]
> When this issue occurs, you can still mail-enable an existing user account that was created in Active Directory.

## Cause

This issue occurs because split permissions separate the management tasks between Exchange administrators and Active Directory administrators.

By default, Exchange uses the Exchange shared permissions model. This method enables Exchange administrators to create user objects in Active Directory. In some organizations, this behavior is unacceptable. Instead, these organizations have to use the [split permissions model](/exchange/permissions/split-permissions/split-permissions). You can configure split permissions by using RBAC (recommended) or through Active Directory (configured during the Exchange setup process).

## Resolution

To resolve this issue, use EMS to change the RBAC split permissions. Or, run the `setup.com` command at a command prompt to change the Active Directory split permissions to the default Exchange shared permissions.

For more information about how to change from RBAC split permissions or Active Directory split permissions to shared permissions, see [Split permissions in Exchange Server](/exchange/permissions/split-permissions/split-permissions).

> [!NOTE]
> You can't use EMC to change the RBAC split permissions or the Active Directory split permissions to shared permissions.

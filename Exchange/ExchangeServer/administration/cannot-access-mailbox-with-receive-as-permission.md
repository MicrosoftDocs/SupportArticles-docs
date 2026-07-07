---
title: Can't open a mailbox with Receive-As permission on a mailbox database
description: Provides solutions for an issue where you can't open another user's mailbox on a database with Receive-As permissions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Need help with RBAC, Role Groups, Role Assignment policy
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 12201
ms.reviewer: yusenko, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 07/07/2026
---
# Unable to access a mailbox with Receive-As permissions on a mailbox database

_Original KB number:_ &nbsp;3176596

## Summary

This article describes an issue in which an account that has Receive-As permissions on a mailbox database can't open another user's mailbox in Exchange Server. The issue occurs because Exchange Server restricts mailbox access for members of the Organization Management role group unless Full Access permissions are explicitly assigned. To resolve the issue, use an account that isn't a member of the Organization Management group or grant explicit Full Access permissions to the mailbox.

## Symptoms

Consider the following scenario:

- Administrator/service account is a member of the Organization Management group.
- User mailboxes are located in Database1.
- Administrator/service account is granted the Receive-As permission to Database1.

In this scenario, the administrator/service account is unable to open another user's mailbox on Database1.

## Cause

The security model was changed in Microsoft Exchange Server 2013. A user that's a member of the Organization Management group can only have access to other mailboxes when Full Access is explicitly provided.

## Resolution

There are two possible solutions for this issue:

- Use an account that's not a member of the Organization Management group.
- Provide explicit Full Access permissions to the mailbox.

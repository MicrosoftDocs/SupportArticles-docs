---
title: The term New-Mailbox is not recognized error when creating a mailbox in Exchange Server 2010
description: Describes an issue in which The term New-Mailbox is not recognized error occurs when you create a new mailbox that uses RBAC split permissions or Active Directory split permissions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: charray, russwill, v-9sidal, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you create a mailbox in Exchange Server 2010: The term New-Mailbox is not recognized

_Original KB number:_ &nbsp;2795751

## Symptoms

Assume that a server is configured to use role-based access control (RBAC) or Active Directory split permissions in a Microsoft Exchange Server 2010 environment. When you try to create a new mailbox by using Exchange Management Console (EMC) or by running the `New-Mailbox` cmdlet in Exchange Management Shell (EMS), the operation fails, and you receive the following error message:

> Error:  
The term 'New-Mailbox' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

> [!NOTE]
> When this issue occurs, you can still mail-enable an existing user account that was created in Active Directory.

## Cause

This issue occurs because split permissions separate management tasks between Exchange administrators and Active Directory administrators.

> [!NOTE]
> By default, Exchange 2010 uses the Exchange shared permissions model, which enables Exchange administrators to create user objects in Active Directory. In some organizations, this behavior is unacceptable. Therefore Exchange 2010 introduced the split permissions model. Split permissions can be configured by using RBAC (recommended) or through Active Directory (configured during the Exchange setup process).

## Resolution

To resolve this issue, use EMS to change the RBAC split permissions. Or, run the `Setup.com` command at a command prompt to change the Active Directory split permissions to the default Exchange 2010 shared permissions.

For more information about how to change from RBAC split permissions or Active Directory split permissions to shared permissions, see [How to configure Exchange 2010 to use shared permissions](/exchange/configure-exchange-2013-for-shared-permissions-exchange-2013-help).

> [!NOTE]
> You can't use EMC to change the RBAC split permissions or the Active Directory split permissions to shared permissions.

## More information

For more information about split permissions, see [General information about split permissions](/previous-versions/office/exchange-server-2010/dd638106(v=exchg.141)#split).
---
title: Cannot access archive mailbox in Outlook
description: Fixes an issue in which the MAPI/HTTP protocol is disabled in an Exchange organization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robwhal, jmartin, excontent, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Users can't access their archive mailbox in Outlook

_Original KB number:_ &nbsp; 3098940

## Symptoms

Consider the following scenario:

- The MAPI/HTTP protocol is disabled in an Exchange Server 2016 or Exchange Server 2013 organization.
- The MAPI/HTTP protocol is enabled at the mailbox level for one or more users.

In this scenario, users who have MAPI/HTTP enabled can't access their archive mailbox in Outlook.

> [!NOTE]
> The issue may occur even after the MAPI/HTTP protocol is enabled for the organization.

## Cause

This issue occurs because Exchange Server returns RPC/HTTP information for a MAPI/HTTP autodiscover request when the MAPI/HTTP protocol is disabled in the Exchange organization.

## Workaround - Method 1

Use Microsoft Outlook Web App or Microsoft Outlook on the web instead of using Outlook.

## Workaround - Method 2

Disable the MAPI/HTTP protocol for the affected users by running the [Set-CASMailbox](/powershell/module/exchange/set-casmailbox) cmdlet as follows:

```powershell
Set-CASMailbox <Alias> -MapiHttpEnabled $False
```

## Workaround - Method 3

Enable the MAPI/HTTP protocol for the organization by running the [Set-OrganizationConfig](/powershell/module/exchange/set-organizationconfig) cmdlet as follows:

```powershell
Set-OrganizationConfig -MapiHttpEnabled $True
```

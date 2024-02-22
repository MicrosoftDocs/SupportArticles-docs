---
title: LitigationHoldEnabled property differs between on-premises and Exchange Online
description: After you onboard an on-premises mailbox to Exchange Online, you notice that the LitigationHoldEnabled value for a mailbox does not match.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CI 109236
  - CSSTroubleshoot
ms.reviewer: alinastr, ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# LitigationHoldEnabled property differs between on-premises and Exchange Online

## Symptoms

You are in a hybrid Microsoft Exchange deployment environment. After you onboard an on-premises mailbox to Exchange Online, and you enable Litigation Hold, you notice that the `LitigationHoldEnabled` value for a mailbox does not match between the cloud and on-premises locations.

For example, you run the following commands to check the mailbox Litigation Hold status in Exchange Online and Exchange Server.

Example 1: The Litigation Hold is turned **ON** for User A's mailbox in Exchange Online.

```powershell
Get-Mailbox UserA | FL *LitigationHoldEnabled*
```

> LitigationHoldEnabled : True

Example 2: The Litigation Hold is turned **OFF** for the remote mailbox for User A.

```powershell
Get-RemoteMailbox UserA | FL *LitigationHoldEnabled*
```

> LitigationHoldEnabled : False

## Cause

This behavior is by design. When the mailbox is moved from Exchange Server to Exchange Online, the `msExchUserHoldPolicies` attribute isn't written back from cloud to on-premises during synchronization. This is true unless the value of the `msExchUserHoldPolicies` attribute in the source is not **Null**.

## More information

For more information about attributes that are written from on-premises to Microsoft 365 and from Microsoft Entra ID to on-premises, see [Microsoft Entra Connect Sync: Attributes synchronized to Microsoft Entra ID](/azure/active-directory/hybrid/reference-connect-sync-attributes-synchronized).

---
title: UsageLocation validation error about Enable-UMMailbox
description: Discusses an issue in which you receive an Enable-UMMailbox... cannot be performed error in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Skype for Business Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Enable-UMMailbox... cannot be performed error in Exchange Online

_Original KB number:_ &nbsp; 4096172

## Symptoms

The `Enable-UMMailbox` command fails in Microsoft Exchange Online and returns the following error message:

> UsageLocation validation error: the action 'Enable-UMMailbox', 'Extensions,Identity,SIPResourceIdentifier,UMMailboxPolicy', cannot be performed on user 'username'.  
This feature is not available in the location indicated in this user's UsageLocation.

## Cause

The issue occurs if user's `UsageLocation` attribute is set to one of the following values:

- India (IN)
- Macao (MO)
- Myanmar (MM)
- South Sudan (SS)
- Western Sahara (EH)

These countries/regions are blocked for the Unified Messaging online feature.

## More information

For the complete list of countries/regions in which Exchange Online Core Features are available, see [International availability](https://www.microsoft.com/microsoft-365/business/international-availability).

---
title: Upgrade the legacy email address policy
description: Describes an issue that occurs if you don't upgrade the legacy email address policy before you try to run the Hybrid Configuration wizard. Provides a resolution. [HCW8055].
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# The Legacy Email Address Policy cannot be automatically updated and must be manually upgraded

_Original KB number:_ &nbsp; 2821224

## Problem

When you try to run the Hybrid Configuration wizard, you receive the following error message:

> The Legacy Email Address Policy cannot be automatically updated and must be manually upgraded.

## Cause

This issue occurs if you don't upgrade the legacy email address policy before you try to run the Hybrid Configuration wizard.

## Solution

To resolve this issue, upgrade the legacy email address policy. To do this, run the following cmdlet in Microsoft Exchange Management Shell (EMS):

```powershell
Get-EmailAddressPolicy | Update-EmailAddressPolicy
```

## More information

For more information about how to upgrade the legacy email address policy, go to [How to Upgrade the Default E-Mail Address Policy from LDAP Filters to OPATH Filters](/previous-versions/office/exchange-server-2007/cc164351(v=exchg.80)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).

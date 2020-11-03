---
title: Upgrade the legacy email address policy
description: Describes an issue that occurs if you don't upgrade the legacy email address policy before you try to run the Hybrid Configuration wizard. Provides a resolution. [HCW8055].
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
search.appverid: MET150
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
get-emailaddesspolicy|update-emailaddresspolicy
```

## More information

For more information about how to upgrade the legacy email address policy, go to [How to Upgrade the Default E-Mail Address Policy from LDAP Filters to OPATH Filters](/previous-versions/office/exchange-server-2007/cc164351(v=exchg.80)).

## References

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).

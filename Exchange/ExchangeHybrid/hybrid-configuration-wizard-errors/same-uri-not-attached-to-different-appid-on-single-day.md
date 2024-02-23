---
title: Same URI cannot be attached to different AppId on a single day
description: Describes an issue that triggers a Same URI cannot be attached to different AppId on a single day error when you run the Hybrid Configuration Wizard in Exchange Online.
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
# Same URI cannot be attached to different AppId on a single day when you run HCW

_Original KB number:_ &nbsp; 3027942

## Problem

When you run the Hybrid Configuration Wizard in an Exchange Online environment, you receive the following error message:

> An error occurred while attempting to provision Exchange to the Partner STS.
>
> Detailed Information "An unexpected result was received from Windows Live.  
> Detailed information: "MaxUriReached MaxUriReached: Same URI cannot be attached to different AppId on a single day."
>
> An unexpected result was received from Windows Live.  
> Detailed information: "MaxUriReached MaxUriReached: Same URI cannot be attached to different AppId on a single day."
>
> MaxUriReached: Same URI cannot be attached to different AppId on a single day.

## Cause

This problem occurs if there were too many failed attempts to create a federation trust. To prevent malicious behavior, we limit the number of failed attempts to federate a domain. The counter for this action is reset within 24 hours.

## Solution

Wait 24 hours from when you receive the error message, and then rerun the Hybrid Configuration Wizard to create the federation trust.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).

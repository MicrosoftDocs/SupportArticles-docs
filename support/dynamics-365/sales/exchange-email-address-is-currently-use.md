---
title: Exchange email address is currently in use
description: Provides a solution to an error that occurs when viewing mailbox alerts in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "Exchange email address in [mailbox name] is currently in use for mailbox" warning alert appears in Microsoft Dynamics 365

This article provides a solution to an error that occurs when viewing mailbox alerts in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4341898

## Symptoms

When viewing mailbox alerts in Dynamics 365, you see the following warning:

> "Exchange email address in [mailbox name] is currently in use for mailbox [other mailbox]. Change email address in [mailbox name] or the email address in the mailbox [other mailbox] as only one mailbox can be configured for each email address."

## Cause

This warning is logged if the same email address exists in multiple mailbox records. For email integration to work correctly in Dynamics 365, the same email address shouldn't exist in more than one mailbox record.

## Resolution

While viewing the mentioned alert within the mailbox record in Dynamics 365, use the links within the alert to open the different mailbox records with the same email address. Change or remove the email address from one of the mailbox records so that the email address only exists in one mailbox record.

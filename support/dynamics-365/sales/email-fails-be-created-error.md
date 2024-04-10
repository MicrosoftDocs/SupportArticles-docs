---
title: An email fails to be created with error
description: Provides a solution to an issue where an email message that failed to be created in Dynamics 365 with a InvalidSender sync error.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An email fails to be created in Microsoft Dynamics 365 with an InvalidSender sync error

This article provides a solution to an issue where an email message that failed to be created in Dynamics 365 with a InvalidSender sync error.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339847

## Symptoms

When reviewing email messages that were analyzed for automatic promotion by Dynamics 365, you see an email message that failed to be created in Dynamics 365 with a InvalidSender sync error.

## Cause

When Dynamics 365 evaluates an email in your mailbox, multiple conditions are evaluated to determine if the message should automatically be created as an email activity in Dynamics 365. If the evaluation results in an InvalidSender error, it indicates there wasn't a valid email address in the From field of the message.

## Resolution

To fix this issue, follow these steps:

1. Locate the corresponding email in the mailbox.
2. Verify there's a valid email address in the From field.

## More information

Some applications send automated emails that don't include a valid email address in the From field. For example, the Clutter feature in Outlook sends messages that result in the following informational alert:  

> "An error occurred while creating the incoming email "Clutter moved new and different messages" in Microsoft Dynamics 365 for the mailbox"  

This alert can safely be ignored.

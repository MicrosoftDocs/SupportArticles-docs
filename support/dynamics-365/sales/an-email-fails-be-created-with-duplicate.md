---
title: An email fails to be created as the sync error
description: Provides a solution to an error that occurs when you review email messages that were analyzed for automatic promotion by Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An email fails to be created in Microsoft Dynamics 365 with Duplicate shown as the sync error

This article provides a solution to an error that occurs when you review email messages that were analyzed for automatic promotion by Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339987

## Symptoms

When reviewing email messages that were analyzed for automatic promotion by Dynamics 365, you see an email message that failed to be created in Dynamics 365 with Duplicate shown as the sync error.

## Cause

When Dynamics 365 evaluates an email in your mailbox, multiple conditions are evaluated to determine if the message should automatically be created as an email activity in Dynamics 365. One of the conditions evaluated is if the email is already tracked in Dynamics 365. This check prevents two users or queues from promoting the same received e-mail.

## Resolution

If the same email was already created in Dynamics 365 because it was processed from another user's mailbox who also received the email, this event can be ignored. If you aren't sure if the email is already tracked in Dynamics 365, you can search for it using the Message ID. The Message ID property of the email is used as a unique identifier.

1. Open the Microsoft Dynamics 365 web application.
2. Open Advanced Find using the button available in the upper-right corner of the navigation bar (funnel icon).
3. Change the **Look for** dropdown to **Email Messages**.
4. Select the dropdown under Email Messages and choose **Message ID**  
5. From the Server-Side Synchronization Failures dashboard, copy the full Message ID value from the Exchange ID column in the Incoming Emails Failed to Sync.
6. Using the Equals condition paste the Message ID into the **Enter Text** part of the condition for Message ID.
7. Select the **Results** button to run the query.
8. View the results to verify if the same email is already tracked as an email in Dynamics 365.

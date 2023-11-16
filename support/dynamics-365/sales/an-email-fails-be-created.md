---
title: An email fails to be created with the InternalEmailReject error
description: An email fails to be created in Dynamics 365 with an InternalEmailReject sync error.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An email fails to be created in Microsoft Dynamics 365 with an InternalEmailReject sync error

This article provides a solution to an issue where an email fails to be created in Microsoft Dynamics 365 with an InternalEmailReject sync error.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339844

## Symptoms

When reviewing email messages that were analyzed for automatic promotion by Dynamics 365, you see an email message that failed to be created in Dynamics 365 with an InternalEmailReject sync error.

## Cause

When Dynamics 365 evaluates an email in your mailbox, multiple conditions are evaluated to determine if the message should automatically be created as an email activity in Dynamics 365. If the evaluation results in an InternalEmailReject error, it indicates that the email was determined to be internal communication from one user to another user in Dynamics 365. There's a System Setting (Track emails sent between Dynamics 365 users as two activities), which determines if both the sent and received email should be tracked resulting in two email activities for the same email message. If this setting is disabled and the email is between users, the received email won't be tracked.

## Resolution

If you want to track both the sent and received email, enable the System Setting for Track emails sent between Dynamics 365 users as two activities:

1. Navigate to **Settings**, select **Email Configuration**, and then select **Email Configuration Settings**.
2. The **Email** tab should be selected by default. Locate the **Set tracking options for emails between Microsoft Dynamics 365 users** section.
3. Check the **Track emails sent between Dynamics 365 users as two activities** option and select **OK**.

---
title: We cannot open the app
description: Provides a solution to an error that occurs when attempting to open the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "We can't open the app because the user's mailbox is inactive" error appears in Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when attempting to open the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4229640

## Symptoms

When attempting to open the Dynamics 365 App for Outlook, you see the following error:

> "We can't open the app because the user's mailbox is inactive."

## Cause

This error will appear if your mailbox record in Dynamics 365 is deactivated.

## Resolution

1. Access your Dynamics 365 organization as a user with the System Administrator role.
2. Navigate to **Settings**, **Email Configuration**, and then select **Mailboxes**.
3. Locate the mailbox for the user receiving this error. You may need to switch the view to **Inactive Mailboxes**.
4. Open the mailbox record and view the Status value at the bottom of the form. If it appears as Inactive, select the **Activate** button.
5. After the mailbox is activated, select the **Test & Enable Mailbox** button and wait for the tests to complete.

> [!NOTE]
> You may need to refresh the form to see the results. If any of the tests are not successful, view the Alerts section within the mailbox record.

---
title: Failure when selecting Test&Enable Mailbox
description: After you select the Test & Enable Mailbox button, one or more of the test results shows as Failure.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Failure after selecting Test & Enable Mailbox in Microsoft Dynamics 365

This article provides a solution to a failure that occurs after you select the **Test & Enable Mailbox** button.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4091246

## Symptoms

After you select the **Test & Enable Mailbox** button, one or more of the test results shows as Failure.

## Cause

One of the tests necessary to enable the mailbox for Server-Side Sync didn't complete successfully.

## Resolution

1. Open the mailbox record.

    > [!NOTE]
    > Mailbox records can be found by navigating to **Settings**, **Email Configuration**, **Mailboxes**, and changing the view to **Active Mailboxes**.

2. Review any notifications that appear in the yellow notification banner at the top of the form.

    > [!NOTE]
    > If a message appears indicating the mailbox won't be processed until it's approved by an Office 365 administrator, which indicates a user with the Office 365 Global Administrator role needs to select the **Approve** button. For more information, see[Email cannot be sent because the email address of the mailbox requires an approval by an Office 365 administrator](https://support.microsoft.com/help/4052727).

3. Select the **Alerts** section on the left side of the mailbox form.
4. Look for any errors and review the message that is displayed.

    > [!NOTE]
    > If no errors appear, navigate to **Settings**, **Email Configuration**, and then **Email Configuration Settings**. In the **Configure alerts** section, verify the **Error** option is selected. If it wasn't already selected, enable this option and select **OK**. Then select the **Test & Enable Mailbox** button again and check for any errors.

    > [!IMPORTANT]
    > When doing the **Test & Enable Mailbox** action, make sure to select the checkbox that appears in the dialog.

5. Select the **Learn more** link if it appears. If there's an article designed to help with that specific error, this link will direct you to it.

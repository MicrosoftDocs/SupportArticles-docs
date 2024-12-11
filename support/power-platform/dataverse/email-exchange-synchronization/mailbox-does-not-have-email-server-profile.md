---
title: Mailbox doesn't have email server profile error
description: Provides a solution to an email server error code InvalidIncomingEmailServerProfile that occurs after selecting the Test & Enable Mailbox button in Dynamics 365.
ms.reviewer: 
ms.date: 12/11/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "Mailbox does not have an email server profile or the email server profile is inactive" error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4484702

## Symptoms

When you select the [Test & Enable Mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) button in Dynamics 365, the test results show as **Failure**. The following error message is logged in the **Alerts** section of the mailbox:

> Email cannot be received because the mailbox [Mailbox Name] does not have an email server profile associated with it or the email server profile is inactive.  
> **Email Server Error Code:** InvalidIncomingEmailServerProfile

## Cause

This error occurs if the user's mailbox record in Dynamics 365 either lacks a value specified for the **Server Profile** field or if the associated server profile is deactivated.

## Resolution

> [!NOTE]
> To manage security roles and mailbox settings, you need to sign in to your Dynamics 365 organization as a user with the "System Administrator" role.

1. Open the mailbox record in Dynamics 365 and verify that a value is selected for the **Server Profile** field.

2. If a value is already selected, open the associated server profile and review its **Status** at the bottom of the page.

3. If the email Sserver profile shows a status of **Inactive**, follow these steps:
    1. Navigate to **Settings** > **Email Configuration** > **Email Server Profiles**.
    2. Switch the view to **Inactive Email Server Profiles**.
    3. Select the email Sserver profile, select **Activate**, and then select **OK**.

4. Switch back to the mailbox record, and then select the **Test and Enable Mailbox** button.
5. If any test results still show as **Failure**, check under the **Alerts** section for more information.

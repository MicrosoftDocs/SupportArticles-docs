---
title: Mailbox doesn't have email server profile
description: Provides a solution to an error that occurs after selecting the Test & Enable Mailbox button in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "Mailbox does not have an email server profile associated with it or the email server profile is inactive" error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs after selecting the **Test & Enable Mailbox** button in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4484702

## Symptoms

After selecting the **Test & Enable Mailbox** button in Dynamics 365, the test results show as Failure and the following error appears on the Alerts tab of the mailbox:

> "Email cannot be received because the mailbox [Mailbox Name] does not have an email server profile associated with it or the email server profile is inactive.  
**Email Server Error Code:** InvalidIncomingEmailServerProfile"

## Cause

This error will appear if the user's mailbox record in Dynamics 365 either doesn't have a value specified for the Server Profile field or the associated server profile is deactivated.

## Resolution

1. Open the mailbox record in Dynamics 365 and verify the **Server Profile** field has a value selected.
2. If a value is already selected, open the associated server profile and review the **Status** shown at the bottom of the page.
3. If the Email Server Profile shows a status of **Inactive**, follow these steps:
    1. Navigate to **Settings**, **Email Configuration**, and **Email Server Profiles**.
    2. Switch the view to **Inactive Email Server Profiles**.
    3. Select the Email Server Profile, select **Activate**, and then select **OK**.
4. Switch back to the mailbox record, and then select the **Test and Enable Mailbox** button.
5. If any test results show as Failure, view the Alerts section.

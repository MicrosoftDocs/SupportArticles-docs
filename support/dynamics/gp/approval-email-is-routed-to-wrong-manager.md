---
title: Approval email is routed to wrong manager
description: Provides a solution to an issue where the approval email for a Timecard isn't routed to the correct manager in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The approval email for a Timecard isn't routed to the correct manager in Microsoft Dynamics GP

This article provides a solution to an issue where the approval email for a Timecard isn't routed to the correct manager in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4341197

## Issue

Consider this example:

- User A signed into Windows.
- User B signed into Dynamics GP and entered a timecard for User C.
- User A reports to Mgr A. User B reports to Mgr B. User C reports to Mgr C.
- Users D and E are the listed as the workflow managers.

We expected the Approval email for the timecard to route to **Mgr C**, however, it didn't happen:
Scenario 1 - **Mgr A** received the approval e-mail communication.  Why?
Scenario 2 - **Users D and E** received the approval email communication.  Why?

## Cause

The current design is:

- Workflow is designed to route the email according to the hierarchy for the **WINDOWS USER LOGIN** that is used when the timecard was entered.  It doesn't use the credentials for the user that signed in Dynamics GP or the employee ID that the timecard was entered for.  It uses the Windows credentials for the person who entered the timecard.
- If the system can't find the manager who is supposed to get the email, then it sends the email to the **Workflow Managers** by default.

## Resolution

Scenario 1 - It's the design that the email will always be went to the hierarchy for the Windows sign-in that was used. So the user entering the timecard should also be using their own Windows sign-in credentials, so it gets routed to their own manager.

Scenario 2 - Make sure the manager who the email is supposed to go to is set up correctly in Active Directory and has an email alias on the **GENERAL** tab in **AD** Properties. Then the email should be routed to the manager, and not the workflow managers.

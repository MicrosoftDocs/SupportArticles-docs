---
title: User doesn't have a service plan error
description: Provides a solution to an error that occurs when doing any of these actions on a flow that uses premium connectors.
ms.reviewer: wifun
ms.date: 03/31/2021
ms.custom: sap:Connections\Creating and managing connections
---
# User doesn't have a service plan adequate for the non-Standard connection error

This article provides a solution to an error that occurs when doing any of these actions on a flow that uses **premium** connectors.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4552636

## Symptoms

You might receive this error when doing any of these actions on a flow that uses **premium** connectors:

- Importing the flow
- Enabling/disabling the flow
- Saving/Save as on the flow
- Any other permanent modification to the flow

> The user does not have a service plan adequate for the non-Standard connection.

:::image type="content" source="media/user-does-not-have-a-service-plan-error/error-on-flow.png" alt-text="Screenshot of the error when doing any of these actions on the flow." lightbox="media/user-does-not-have-a-service-plan-error/error-on-flow.png":::

## Cause

This error means a Power Automate license is required for the current user to do the action (a Power Apps, Dynamics 365, or Office 365 license isn't sufficient).

Users who are shared a flow with premium connectors (not belonging to a **Per Flow** plan) will each need a **Per User** plan to edit or manually trigger the flow.

If saving/modifying the flow was possible for the same user previously, it's possible that their license has expired.

## Resolution

- Purchase a **Per User** plan or **Per Flow** plan for Power Automate
- Instead, you can start a trial for the **Per User** plan lasting 90 days after which you'll require a paid plan to run/edit flows using premium connectors.

All these options (with more information) are available at [Power Automate pricing](https://flow.microsoft.com/pricing/).

## Resources

- [Power Apps/Power Automate Licensing FAQs](/power-platform/admin/powerapps-flow-licensing-faq#power-automate)
- [Download Power Apps, Power Automate and Power Virtual Agents Licensing Guide - Dec 2020](https://go.microsoft.com/fwlink/?linkid=2085130)

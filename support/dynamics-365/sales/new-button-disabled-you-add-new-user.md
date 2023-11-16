---
title: New button is disabled when you add a new user
description: This article provides a resolution for the problem that occurs when you try to add a user to Microsoft Dynamics CRM Online.
ms.reviewer: kenakamu, chanson
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-apps-addons
---
# The New button is disabled when trying to add a new user in Microsoft Dynamics CRM Online

This article helps you resolve the problem that occurs when you try to add a user to Microsoft Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2503043

## Symptoms

When trying to add a user to Microsoft Dynamics CRM Online, the **New** button is disabled.

## Cause

This occurs when all user licenses that have been purchased are being used. For example, if five licenses were purchased during activation and four users have been invited to your CRM Online organization, all licenses have been consumed (you + four new users). At this point, the **New** button in the Users page will be disabled.

## Resolution

To invite new users to the CRM Online organization, other user licenses must be purchased. Only the Billing Administrator of the Microsoft Dynamics CRM Online organization can purchase other licenses.

1. Click **Settings**, click **Administration** and click **Subscription Management**.
2. Click the **Add Licenses** button.
3. After other licenses are purchased the **New** button on the **Users** page will be enabled to invite more users.

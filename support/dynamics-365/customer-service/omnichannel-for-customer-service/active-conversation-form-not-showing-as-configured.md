---
title: The Active Conversation form doesn't display as configured
description: Solves the problems such as repeated sections, incorrect content, missing custom fields, or missing SLA timers when the Active Conversation form isn't properly configured.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/25/2025
ms.custom: sap:Customer summary and Closed conversation form, DFM
---
# The Active Conversation form doesn't display as configured

This article provides guidance on resolving issues related to customizing and displaying the [Active Conversation form](/dynamics365/customer-service/administer/add-customer-summary-settings) in Microsoft Dynamics 365 Customer Service.

## Symptoms

You might encounter the following issues in the **Active Conversation** form:

- Repeated sections or incorrect content.
- Custom fields are missing.
- SLA timers are missing.

## Cause

The issue could be caused by the **Customize Active Conversation form** setting being disabled.

## Resolution

To ensure the **Active Conversation** form displays as configured,

1. Open the Customer Service admin center.
2. Navigate to **Workspaces** > **Active conversation form settings**.
3. Ensure the **Customize Active Conversation form** toggle is turned on.
4. Save the changes.
5. Perform a hard refresh twice by pressing <kbd>CTRL</kbd>+<kbd>F5</kbd>.
6. Test the scenario again to confirm the resolution.

For more information, see [Active Conversation form](/dynamics365/customer-service/administer/add-customer-summary-settings).

---
title: Cases Are Auto-created Even If ARC Rule is Deactivated or Deleted
description: Resolves an issue where cases continue to be auto-created from emails even if the ARC rule has been deactivated or deleted in Microsoft Dynamics 365 Customer Service.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/14/2025
ms.custom: sap:Automatic Record Creation (ARC), DFM
---
# Cases are auto-created even if the automatic record creation rule is deactivated

This article addresses an issue where cases are automatically created from emails even after the Automatic Record Creation (ARC) rule has been deactivated or deleted in Dynamics 365 Customer Service.

## Symptoms

Cases continue to be auto-created from emails even if the ARC rule has been deactivated or deleted.

## Cause

The ARC rule depends on a child flow in Power Automate that remains active. Even after the main rule is deactivated or removed, the active child flow continues to trigger automatic case creation.

## Resolution

To stop the automatic case creation, follow these steps:

1. Identify the associated child flow:

   - Go to **Customer Service Admin Center** > **Case settings** > **Automatic record creation and update rules**.
     - Locate the ARC rule that was previously deactivated or deleted.
     - Check for any associated child flows that may still be active.
   - If the flow was created as part of a Dynamics 365 solution, navigate to **Power Automate** > **Solutions**. Review all flows related to record creation.

2. Deactivate the associated child flow:

   - Open the identified flow in Power Automate.
   - Select **Edit** to inspect the flow structure.
   - Turn off the flow by selecting the toggle button at the top of the flow editor or from the flow list.

3. Verify the fix:

   - Send a test email or trigger the condition that previously generated cases.
   - Confirm that cases are no longer being automatically created.

Once the associated child flow is deactivated, the automatic case creation will stop.

## More information

- [Set up rules to automatically create or update records](/dynamics365/customer-service/administer/automatically-create-update-records)

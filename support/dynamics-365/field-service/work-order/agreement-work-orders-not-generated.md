---
title: Work orders are not generated from agreement booking setup
description: Resolves issues where work orders are not automatically generated from agreement booking dates in Dynamics 365 Field Service.
author: vhorvathms
ms.author: vhorvath
ms.reviewer: puneetsingh
ms.date: 03/04/2026
ms.custom: sap:Agreements, SLA's, and Entitlements
---

# Work orders are not generated from agreement booking setup

This article helps resolve issues where work orders aren't automatically generated from agreement booking setup records in Microsoft Dynamics 365 Field Service.

## Symptoms

You have an active agreement with a configured Agreement Booking Setup and recurrence pattern. On the expected generation date, one or more of the following issues occur:

- No work orders are generated for the agreement booking date.
- Work orders are generated for some agreement booking dates but not others.
- The agreement booking date record exists but its status remains **Not Generated**.

## Cause

### Cause 1: Agreement status is not Active

The agreement record must be in an **Active** system status and the agreement sub-status must also be **Active** for work order generation to trigger.

### Cause 2: The system job for agreement processing failed or is disabled

Agreement work order generation runs as a background system job. If the async service is paused or the job fails, work orders won't be generated.

### Cause 3: Agreement booking date is in the past

Field Service won't generate work orders for agreement booking dates that have already passed. The generation typically runs a configurable number of days before the booking date.

### Cause 4: User who activated the agreement is disabled

The agreement processing runs in the context of the user who activated the agreement. If that user account is disabled or has lost required privileges, generation fails silently.

## Resolution

### Resolution for Cause 1: Verify agreement status

1. In the Dynamics 365 Field Service app, navigate to **Service** area, then go to **Service Delivery** > **Agreements** and open the **Agreement** record.
2. Verify the **System Status** is **Active** (not Draft or Canceled).
3. Verify the **Sub-Status** is also set to an active value.
4. If the agreement is in **Draft**, select **Activate** from the command bar.

### Resolution for Cause 2: Check system jobs

1. In the Dynamics 365 Field Service app, select the **Settings** (gear icon) > **Advanced Settings**. In the advanced settings area, go to **System** > **System Jobs**.
2. Filter by "Agreement" or look for the system job named **Field Service - Process Agreement Booking Dates**.
3. If the job shows as **Failed**, open it to review the error details.
4. If the job shows as **Waiting**, verify the async service is running in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
5. You can manually trigger work order generation by updating the Agreement Booking Date record status or by reactivating the agreement.

### Resolution for Cause 3: Adjust generation window

1. In the Dynamics 365 Field Service app, select the **Settings** area from the bottom-left corner (change area selector).
2. Under **General**, select **Field Service Settings**, and then select the **Agreement** tab.
3. Check the **Generate Work Order X Days in Advance** setting. This determines how many days before the booking date the system generates the work order.
3. If the booking date has passed the generation window, manually create the work order or adjust the next booking date.

### Resolution for Cause 4: Re-activate with an active user

1. In the Dynamics 365 Field Service app, open the agreement record. Select **Related** > **Audit History** to identify the user who activated the agreement. It takes few seconds to load the screen.
2. To check if that user is disabled, sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), go to **Manage** and select your environment. Then, go to **Settings** (gear icon at top) > **Users + permissions** > **Users**, and search for the user.
3. If the user is disabled, re-enable the user temporarily, or deactivate the agreement and reactivate it with an active administrator user.
4. Verify the activating user has the **Field Service - Administrator** or **Field Service - Dispatcher** security role assigned.

## More information

- [Set up customer agreements](/dynamics365/field-service/set-up-customer-agreements)
- [Agreement sub-statuses](/dynamics365/field-service/set-up-agreement-sub-statuses)

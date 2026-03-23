---
title: Work orders aren't generated from an agreement booking setup
description: Resolve issues where work orders aren't automatically generated from agreement booking dates in Dynamics 365 Field Service.
author: vhorvathms
ms.author: vhorvath
ms.reviewer: puneetsingh
ms.date: 03/19/2026
ms.custom: sap:Agreements, SLA's, and Entitlements
---

# Work orders aren't generated from an agreement booking setup

This article helps you troubleshoot and resolve scenarios where expected work orders aren't automatically generated from agreement booking dates in Microsoft Dynamics 365 Field Service.

## Symptoms

You set up an agreement with an Agreement Booking Setup and a recurrence pattern, but on the expected generation date, you notice one or more of the following issues:

- No work orders are generated for the agreement booking date.
- Work orders are generated for some agreement booking dates but not others.
- The agreement booking date record exists but its status remains **Not Generated**.

## Cause 1: The agreement isn't active

Work orders are only generated when the agreement has an **Active** system status and an **Active** sub-status. If the agreement is still in **Draft** or has been **Canceled**, the system skips work order generation.

### Resolution: Verify agreement status

1. In the Dynamics 365 Field Service app, go to the **Service** area.
1. Go to **Service Delivery** > **Agreements**, and open the agreement record.
1. Confirm that the **System Status** is **Active** and the **Sub-Status** is set to an active value.
1. If the agreement is in **Draft**, select **Activate** from the command bar.

## Cause 2: The background system job failed or isn't running

Work order generation relies on a background system job. If the asynchronous service is paused or the job fails, work orders aren't created.

### Resolution: Check system jobs

1. In the Dynamics 365 Field Service app, select **Settings** (gear icon) > **Advanced Settings**.
1. Go to **System** > **System Jobs**.
1. Search for the system job named **Field Service - Process Agreement Booking Dates**.
    - If the job shows as **Failed**, open it to review the error details.
    - If the job shows as **Waiting**, verify the asynchronous service is running in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. To manually trigger generation, update the Agreement Booking Date record status or reactivate the agreement.

## Cause 3: The booking date passed the generation window

Dynamics 365 Field Service generates work orders a configurable number of days before the booking date. If that window has passed, the work order isn't created.

### Resolution: Adjust the generation window

1. In the Dynamics 365 Field Service app, select the **Settings** area from the bottom-left corner (change area selector).
1. Under **General**, select **Field Service Settings**, and then select the **Agreement** tab.
1. Review the **Generate Work Order X Days in Advance** value. This value controls how many days before the booking date the system creates the work order.
1. If the booking date already passed the generation window, manually create the work order or adjust the next booking date to a future date within the window.

## Cause 4: The user who activated the agreement is disabled

The system processes agreements in the security context of the user who activated the agreement. If that user account is disabled or no longer has the required security roles, work order generation fails silently.

### Resolution: Reactivate with an active user

1. In the Dynamics 365 Field Service app, open the agreement record.
1. Select **Related** > **Audit History** to identify the user who activated the agreement.
1. Check whether that user is disabled:
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    1. Select **Manage**, and then select your environment.
    1. Go to **Settings** (gear icon) > **Users + permissions** > **Users**, and search for the user.
1. If the user is disabled, use one of these options:
    - Re-enable the user account temporarily so the system can process the agreement.
    - Deactivate the agreement and reactivate it with an active user who has the **Field Service - Administrator** or **Field Service - Dispatcher** security role.

## Related content

- [Set up customer agreements](/dynamics365/field-service/set-up-customer-agreements)
- [Agreement sub-statuses](/dynamics365/field-service/set-up-agreement-sub-statuses)

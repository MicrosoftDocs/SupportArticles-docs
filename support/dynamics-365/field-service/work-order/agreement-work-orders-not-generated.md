---
title: Resolve Agreement Work Order Generation Failures
description: Fix work orders not generating from agreement booking setups in Dynamics 365 Field Service. Check agreement status, system jobs, and generation windows to resolve the issue.
ms.date: 04/01/2026
ms.reviewer: vhorvath, puneetsingh, v-shaywood
ms.custom: sap:Work Order Management\Issues creating work orders
---

# Agreement booking setup doesn't create work orders

## Summary

This article helps you troubleshoot scenarios where expected [work orders](/dynamics365/field-service/create-work-order) aren't automatically created from [agreement booking dates](/dynamics365/field-service/create-work-order-from-agreement) in Microsoft Dynamics 365 Field Service. It covers common checks for inactive agreements, background system job failures, missed generation windows, and user access issues that can prevent automatic work order creation.

## Symptoms

You [set up an agreement](/dynamics365/field-service/set-up-agreements-work-orders) with an **Agreement Booking Setup** and a recurrence pattern, but on the expected generation date, you notice one or more of the following issues:

- No work orders are generated for the agreement booking date.
- Work orders are generated for some agreement booking dates but not others.
- The agreement booking date record exists but its status remains **Not Generated**.

## Verify that the agreement is active

The agreement must have both its **System Status** set to **Active** and its **Sub-Status** set to an active value before the system generates work orders. Agreements that are still in **Draft** or **Canceled** don't trigger work order generation.

To check and update the agreement status:

1. In the Dynamics 365 Field Service app, go to the **Service** area.
1. Go to **Service Delivery** > **Agreements**, and open the agreement record.
1. Confirm that the **System Status** is **Active** and the **Sub-Status** is set to an active value. For more information about substatuses, see [Set up agreement substatuses](/dynamics365/field-service/set-up-agreement-sub-statuses).
1. If the agreement is in **Draft**, select **Activate** from the command bar.

## Check the background system job for errors

Work order generation relies on a background system job. If the asynchronous service is paused or the job encountered an error, work orders aren't created on schedule.

To check the system job status:

1. In the Dynamics 365 Field Service app, select **Settings** (gear symbol) > **Advanced Settings**.
1. Go to **System** > **System Jobs**.
1. Search for the system job named **Field Service - Process Agreement Booking Dates**.
    - If the job shows as **Failed**, open it to review the error details.
    - If the job shows as **Waiting**, check that the asynchronous service is running in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. To manually trigger generation, update the **Agreement Booking Date** record status or reactivate the agreement.

## Confirm the booking date is within the generation window

Dynamics 365 Field Service generates work orders a configurable number of days before the booking date. If that window already passed, the system doesn't create the work order.

To review and adjust the generation window:

1. In the Dynamics 365 Field Service app, select the **Settings** area from the bottom-left corner (change area selector).
1. Under **General**, select **Field Service Settings**, and then select the **Agreement** tab.
1. Review the **Generate Work Order X Days in Advance** value. This setting controls how many days before the booking date the system creates the work order. For more information, see [Agreement settings](/dynamics365/field-service/configure-default-settings#agreement-settings).
1. If the booking date already passed the generation window, [manually create the work order](/dynamics365/field-service/create-work-order-from-agreement#manually-generate-a-work-order-from-a-booking-date) or adjust the next booking date to a future date within the window.

## Verify that the activating user has the required access

The system processes agreements in the security context of the user who activated the agreement. If that user's account is disabled or no longer has the required [security roles](/dynamics365/field-service/users-licenses-permissions#assign-security-roles), work orders might not generate.

To check and resolve user access issues:

1. In the Dynamics 365 Field Service app, open the agreement record.
1. Select **Related** > **Audit History** to identify the user who activated the agreement.
1. Check whether that user is disabled:
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    1. Select **Manage**, and then select your environment.
    1. Go to **Settings** (gear symbol) > **Users + permissions** > **Users**, and search for the user.
1. If the user is disabled, use one of these options:
    - Re-enable the user account temporarily so the system can process the agreement.
    - Deactivate the agreement and reactivate it with an active user who has the **Field Service - Administrator** or **Field Service - Dispatcher** security role.

## Related content

- [Customer agreements overview](/dynamics365/field-service/agreements-overview)
- [Manage customer agreements](/dynamics365/field-service/manage-agreements)
- [Work order architecture](/dynamics365/field-service/field-service-architecture)

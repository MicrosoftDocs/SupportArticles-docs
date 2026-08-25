---
title: Troubleshoot Work Order Save or Creation Errors
description: Learn how to troubleshoot work order save and creation errors in Dynamics 365 Field Service. Fix plug-in failures, required fields, and incident type issues.
ms.date: 08/24/2026
ms.reviewer: vhorvath, puneetsingh, v-shaywood
ms.custom: sap:Work Order Management\Issues setting up system records such as incident types or work order types
ai-usage: ai-assisted
---

# Work order doesn't save or create successfully

## Summary

This article helps you troubleshoot common errors that occur when you try to save or [create work orders](/dynamics365/field-service/create-work-order) in Microsoft Dynamics 365 Field Service. It covers plug-in and business rule failures, required field errors that custom scripts cause, conditional required fields like the price list and work order type, and incident type behavior such as auto-population delays, duplicate work order incidents, and primary incident selection.

## Symptoms

When you try to save or create a work order, you notice one of the following issues:

- After you fill in the work order fields and select **Save**, you receive the following error message:

  > Business Process Error: An error has occurred. Please contact your system administrator.

  In this situation, you can save successfully on the second attempt.

- You receive the following "required field" error message even though the field appears to be populated:

  > You must provide a value for \<FieldName\>.

- After you select an **Incident Type** on the work order, the expected work order products, services, and service tasks don't automatically populate.

- After you add the same incident type more than once, the work order contains duplicate child records.

- Field Service marks a work order incident as primary unexpectedly.

- After you complete or deactivate a work order incident, the work order system status doesn't change.

## Check for a failing plug-in or business rule

A synchronous plug-in or business rule on the work order table might encounter an error during the save operation. If the error occurs only on the first attempt, this condition typically indicates a timing issue where the plug-in depends on related records that don't exist yet.

To identify and fix the issue of a failing plug-in or business rule, follow these steps:

1. Identify the failing job:
    1. In the Dynamics 365 Field Service app, select **Settings** (gear symbol) > **Advanced Settings**.
    1. In the advanced settings area, go to **System** > **System Jobs**.
    1. To find the failing job, filter by work order entity errors.
1. Inspect plug-in registrations:
    1. Go to [Power Apps](https://make.powerapps.com), and select your environment.
    1. Go to **Tables** > **Work Order** > **Plug-in steps**.
    1. Look for custom plug-ins that are registered on the **Pre-Operation** or **Post-Operation** step of the work order **Create** message.
    1. If a plug-in references related records (such as service tasks or products), it might run before those records exist. Move the plug-in to an asynchronous step, or add a null check.
1. If a business rule causes the error:
    1. Go to [Power Apps](https://make.powerapps.com), and select your environment.
    1. Go to **Tables** > **Work Order** > **Business rules**.
    1. Temporarily disable custom rules to isolate the issue.

## Check whether custom scripts override a required field

A custom form script or business rule might clear or override a field value after the form populates it. Or, a mapped field from the [incident type](/dynamics365/field-service/configure-incident-types) might not transfer the value correctly.

To check form scripts and field mappings:

1. Open the browser developer tools (<kbd>F12</kbd>), and check the **Console** tab for JavaScript errors that occurred during the save operation.
1. Go to [Power Apps](https://make.powerapps.com), and select your environment.
1. Go to **Tables** > **Work Order** > **Forms**.
1. Open the relevant form, and check whether any **On Save** event scripts clear or override the field.
1. If the required field is a lookup, open the referenced record in the Dynamics 365 Field Service app to verify that it still exists and is in an **Active** state.
1. Test in a clean environment without customizations to check whether the issue is caused by custom logic.

## Check conditional required fields

Some work order fields are required only under specific conditions. The selected work order type determines whether the service account and primary incident type are required, and the work order type itself is required. When **Calculate Price** is enabled, Field Service plug-in validation requires a price list, and the price list currency must match the work order currency.

To check the conditional required fields:

1. In the Dynamics 365 Field Service app, go to **Settings** > **Work Orders** > **Work Order Types**, open the selected work order type, and review its service account and incident requirements.
1. In the Dynamics 365 Field Service app, open the work order and populate the fields that the selected work order type requires.
1. In the Dynamics 365 Field Service app, verify that the work order has a price list when **Calculate Price** is enabled.
1. In the Dynamics 365 Field Service app, verify that the price list currency matches the work order currency.

## Check the incident type configuration and user privileges

The incident type might be misconfigured or inactive. The user might also lack the **Create** privilege on the child entities. For more information about incident types, see [Work order incident type overview](/dynamics365/field-service/incident-type-overview).

To check the incident type configuration and user privileges:

1. In the Dynamics 365 Field Service app, go to **Settings**.
1. Select **Work Orders** > **Incident Types**.
1. Open the incident type record and verify that **Products**, **Services**, and **Service Tasks** appear under the related tabs.
1. Verify that each product or service that's referenced in the incident type is **Active** in the product catalog. Go to **Settings** > **General** > **Products** to check the product status.
1. On the work order form, verify that the **Price List** field is populated by using a valid price list that contains the products. Go to **Settings** > **General** > **Price Lists** to check the price list.
1. Verify the user has the required [security roles and privileges](/dynamics365/field-service/security-permissions):
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    1. Select **Manage**, and then select your environment.
    1. Go to **Settings** (gear symbol) > **Users + permissions** > **Security roles**.
    1. Verify that the user's role has the **Create** privilege on:
         - Work Order Product (`msdyn_workorderproduct`)
         - Work Order Service (`msdyn_workorderservice`)
         - Work Order Service Task (`msdyn_workorderservicetask`)
1. If you use custom business rules that hide or lock the **Incident Type** field, verify that they allow the system to trigger the auto-population logic.

## Review delayed or unexpected incident type behavior

For work orders that aren't generated from agreements, an asynchronous background job copies incident type items to the work order. The job creates service tasks first, products second, and services third, so the records can take a short time to appear. Agreement-generated work orders don't use this background job. Field Service separately creates requirement characteristics from the incident type when it creates the work order incident. Each time you add an incident type, Field Service creates a work order incident and its associated child records, and it doesn't prevent you from adding the same incident type more than once. When no active incident exists, Field Service marks the newly created work order incident as primary. The primary setting belongs to the work order incident, not the incident type. Deactivating or reactivating a work order incident cascades its state to the associated service tasks, products, services, and characteristics, but it doesn't change the work order system status.

To review delayed or unexpected incident type behavior:

1. In the Dynamics 365 Field Service app, open the work order, wait briefly for the asynchronous job to finish, and then refresh the form.
1. In the Dynamics 365 Field Service app, review the work order incidents before you add an incident type again. Remove an unwanted work order incident and its associated records according to your organization's process.
1. In the Dynamics 365 Field Service app, review the active work order incidents to determine which incident became primary.
1. In the Dynamics 365 Field Service app, update the work order system status separately when you deactivate or reactivate an incident.
1. In the Dynamics 365 Field Service app, review the agreement booking incident configuration for agreement-generated work orders because they don't use the asynchronous copy job.

## Related content

- [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
- [Work order architecture](/dynamics365/field-service/field-service-architecture)

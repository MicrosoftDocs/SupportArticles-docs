---
title: Troubleshoot work order save or creation errors in Field Service
description: Troubleshoot work order save and creation errors in Dynamics 365 Field Service. Fix plug-in failures, required field errors, and incident type issues by using these step-by-step solutions.
ms.date: 04/01/2026
ms.reviewer: vhorvath, puneetsingh, v-shaywood
ms.custom: sap:Work Order Management\Issues setting up system records such as incident types or work order types
---

# Work order isn't saved or created successfully

## Summary

This article helps you troubleshoot common errors that occur when you try to save or [create work orders](/dynamics365/field-service/create-work-order) in Microsoft Dynamics 365 Field Service. It covers plug-in and business rule failures, required field errors that are caused by custom scripts, and incident-type auto-population issues.

## Symptoms

When you try to save or create a work order, you notice one of the following issues:

- After you fill in the work order fields and select **Save**, you receive the following error message:

  > Business Process Error: An error has occurred. Please contact your system administrator.

    In this situation, you can save succesfully on the second attempt.

- You receive the following "required field" error message even though the field appears to be populated:

  > You must provide a value for \<FieldName\>.

- After you select an **Incident Type** on the work order, the expected work order products, services, and service tasks don't automatically populate.

## Check for a failing plug-in or business rule

A synchronous plug-in or business rule on the work order table might experience an error during the save operation. If the error occurs on only the first attempt, this condition typically indicates a timing issue in which the plug-in depends on related records that don't exist yet.

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
    1. Temporarily disable custom rules in order to isolate the issue.

## Verify that custom scripts aren't overriding a required field

A custom form script or business rule might clear or override a field value after the form populates it. Or, a mapped field from the [incident type](/dynamics365/field-service/configure-incident-types) might not transfer the value correctly.

To check form scripts and field mappings:

1. Open the browser developer tools (<kbd>F12</kbd>), and check the **Console** tab for JavaScript errors that occurred during the save operation.
1. Go to [Power Apps](https://make.powerapps.com), and select your environment.
1. Go to **Tables** > **Work Order** > **Forms**.
1. Open the relevant form, and check whether any **On Save** event scripts clear or override the field.
1. If the required field is a lookup, open the referenced record in the Dynamics 365 Field Service app to verify that it still exists and is in an **Active** state.
1. Test in a clean environment without customizations to check whether the issue is caused by custom logic.

## Verify the incident type configuration and user privileges

The incident type might not be configured correctly or might be inactive. The user might also lack the **Create** privilege on the child entities. For more information about incident types, see [Work order incident type overview](/dynamics365/field-service/incident-type-overview).

To check the incident type configuration and user privileges:

1. In the Dynamics 365 Field Service app, go to **Settings**.
1. Select **Work Orders** > **Incident Types**.
1. Open the incident type record and verify that **Products**, **Services**, and **Service Tasks** appear under the related tabs.
1. Verify that each product or service that's referenced in the incident type is **Active** in the product catalog. To do this, go to **Settings** > **General** > **Products** to check the product status.
1. On the work order form, verify that the **Price List** field is populated by using a valid price list that contains the products. To do this, go to **Settings** > **General** > **Price Lists** to check the price list.
1. Verify the user has the required [security roles and privileges](/dynamics365/field-service/security-permissions):
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    1. Select **Manage**, and then select your environment.
    1. Go to **Settings** (gear symbol) > **Users + permissions** > **Security roles**.
    1. Verify that the user's role has the **Create** privilege on:
         - Work Order Product (`msdyn_workorderproduct`)
         - Work Order Service (`msdyn_workorderservice`)
         - Work Order Service Task (`msdyn_workorderservicetask`)
1. If you use custom business rules that hide or lock the **Incident Type** field, verify that they allow the system to trigger the auto-population logic.

## Related content

- [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
- [Work order architecture](/dynamics365/field-service/field-service-architecture)

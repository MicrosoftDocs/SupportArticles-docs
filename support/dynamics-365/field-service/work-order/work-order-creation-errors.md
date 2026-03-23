---
title: Errors when creating or saving a work order
description: Resolve common errors that occur when you create or save work orders in Dynamics 365 Field Service.
author: vhorvathms
ms.author: vhorvath
ms.reviewer: puneetsingh
ms.date: 03/19/2026
ms.custom: sap:Work Order Management
---

# Errors when creating or saving a work order

## Summary

This article helps you troubleshoot common errors that occur when you create or save work orders in Microsoft Dynamics 365 Field Service.

## Symptoms

When you try to create or save a work order, you notice one of the following issues:

- After you fill in the work order fields and select **Save**, the following error appears, but saving a second time succeeds:

  > Business Process Error: An error has occurred. Please contact your system administrator.

- A required field error appears even though the field looks populated:

  > You must provide a value for \<field name\>.

- After you select an **Incident Type** on the work order, the expected work order products, services, and service tasks don't automatically populate.

## Cause 1: A plug-in or business rule fails on the first save

A synchronous plug-in or business rule on the work order table throws an error during the save operation. If the error only happens on the first attempt, it typically indicates a timing issue where the plug-in depends on related records that don't exist yet.

### Solution: Identify and fix the failing plug-in or business rule

1. In the Dynamics 365 Field Service app, select **Settings** (gear icon) > **Advanced Settings**.
    1. In the advanced settings area, go to **System** > **System Jobs**.
    1. Filter by work order entity errors to find the failing job.
1. To inspect plug-in registrations, go to [make.powerapps.com](https://make.powerapps.com), select your environment, and then go to **Tables** > **Work Order** > **Plug-in steps**.
    1. Look for custom plug-ins registered on the **Pre-Operation** or **Post-Operation** step of the work order **Create** message.
    1. If a plug-in references related records (like service tasks or products), it might run before those records exist. Move the plug-in to an asynchronous step or add a null check.
1. If a business rule causes the error, go to [make.powerapps.com](https://make.powerapps.com), select your environment, and then go to **Tables** > **Work Order** > **Business rules**. Temporarily disable custom rules to isolate the issue.

## Cause 2: A custom script or business rule overrides a required field

A custom form script or business rule clears or overrides a field value after the form populates it, or a mapped field from the incident type doesn't transfer the value correctly.

### Solution: Check form scripts and field mappings

1. Open the browser developer tools (**F12**) and check the **Console** tab for JavaScript errors during the save operation.
1. Verify the field mapping: go to [make.powerapps.com](https://make.powerapps.com), select your environment, and then go to **Tables** > **Work Order** > **Forms**.
    1. Open the relevant form and check whether any **On Save** event scripts clear or override the field.
1. If the required field is a lookup, open the referenced record in the Dynamics 365 Field Service app and verify that it still exists and is in an **Active** state.
1. Test on a clean environment without customizations to confirm whether the issue is caused by custom logic.

## Cause 3: Incident type records are missing, inactive, or the user lacks privileges

The incident type's associated products, services, or service tasks might not be configured, might be inactive, or the user might not have the **Create** privilege on the child entities.

### Solution: Verify incident type configuration and user privileges

1. In the Dynamics 365 Field Service app, go to the **Settings** area and select **Work Orders** > **Incident Types**.
    1. Open the incident type record and verify that **Products**, **Services**, and **Service Tasks** appear under the related tabs.
    1. Verify that each product or service referenced in the incident type is **Active** in the product catalog. Go to **Settings** area > **General** > **Products** to check product status.
1. On the work order form, verify that the **Price List** field is populated with a valid price list that contains the products. To check the price list contents, go to **Settings** area > **General** > **Price Lists**.
1. Confirm the user has the required privileges:
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    1. Select **Manage**, and then select your environment.
    1. Go to **Settings** (gear icon) > **Users + permissions** > **Security roles**.
    1. Verify the user's role has **Create** privilege on:
         - Work Order Product (`msdyn_workorderproduct`)
         - Work Order Service (`msdyn_workorderservice`)
         - Work Order Service Task (`msdyn_workorderservicetask`)
1. If you use custom business rules that hide or lock the **Incident Type** field, verify that they allow the system to trigger the auto-population logic.

## Related content

- [Create a work order](/dynamics365/field-service/create-work-order)
- [Work order architecture](/dynamics365/field-service/field-service-architecture)

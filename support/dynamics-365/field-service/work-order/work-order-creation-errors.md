---
title: Errors when creating or saving a work order
description: Resolves common errors that occur when creating or saving work orders in Dynamics 365 Field Service.
author: vhorvathms
ms.author: vhorvath
ms.reviewer: puneetsingh
ms.date: 03/19/2026
ms.custom: sap:Work Order Management
---

# Errors when creating or saving a work order

## Summary

This article helps administrators and dispatchers resolve common errors that occur when creating or saving work orders in Microsoft Dynamics 365 Field Service.

## Symptoms

When you try to create or save a work order, you experience one of the following errors:

### Symptom 1: "Business Process Error" on save

After filling in work order fields and selecting **Save**, the following error appears:

> Business Process Error: An error has occurred. Please contact your system administrator.

The work order isn't saved on the first attempt, but saving again succeeds.

### Symptom 2: Missing required field error

A required field error appears even though the field appears to be populated:

> You must provide a value for \<field name\>.

### Symptom 3: Incident type products and services don't populate

After selecting an **Incident Type** on the work order, the expected work order products, services, and service tasks don't automatically add.

## Cause

### Cause 1: Business process error on first save

A synchronous plug-in or business rule on the work order entity throws an error during the save operation. The intermittent nature (succeeds on retry) typically indicates a timing issue with a plug-in that depends on related records not yet created.

### Cause 2: Missing required field despite being populated

A custom form script or business rule overrides the field value after the form populates it, or a mapped field from the incident type doesn't transfer the value correctly.

### Cause 3: Incident type products and services don't populate

The incident type's associated products, services, and service tasks are either not configured, inactive, or the user lacks **Create** privilege on the child entities.

## Solutions

### Solution 1: Business process error on first save

1. Identify the failing plug-in: in the Dynamics 365 Field Service app, select the **Settings** (gear icon at top-right) > **Advanced Settings**. 
    1. In the advanced settings area, go to **System** > **System Jobs**.
    1. Filter by work order entity errors.
1. To inspect plug-in registrations, open the [Plugin Registration Tool](/power-apps/developer/data-platform/download-tools-nuget) or go to [make.powerapps.com](https://make.powerapps.com).
    1. Select your environment, and navigate to **Tables** > **Work Order** > **Plug-in steps**. 
    1. Check for custom plug-ins registered on the **Pre-Operation** or **Post-Operation** step of the work order **Create** message.
1. If a plug-in references related records (like service tasks or products), it might execute before those records exist. Move the plug-in to an asynchronous step or add a null check.
1. If a business rule causes the error, go to [make.powerapps.com](https://make.powerapps.com).
    1. Select your environment.
    1. Navigate to **Tables** > **Work Order** > **Business rules**, and review the rules. Temporarily disable custom rules to isolate the issue.

### Solution 2: Missing required field despite being populated

1. Open the browser developer tools (**F12**) and check the **Console** tab for JavaScript errors during the save operation.
2. Verify the field mapping: go to [make.powerapps.com](https://make.powerapps.com).
    1. Select your environment.
    1. Navigate to **Tables** > **Work Order** > **Forms**.
    1. Open the relevant form, and check if any **On Save** event scripts clear or override the field.
1. If the required field is a lookup, open the referenced record in the Dynamics 365 Field Service app and verify it still exists and is in an **Active** state.
1. Test on a clean environment without customizations to confirm if the issue is related to custom logic.

### Solution 3: Incident type products and services don't populate

1. In the Dynamics 365 Field Service app.
    1. Go to the **Settings** area, select **Work Orders**.
    1. Select **Incident Types**. 
    1. Open the **Incident Type** record and verify that **Products**, **Services**, and **Service Tasks** appear under the related tabs.
    1. Verify each product or service referenced in the incident type is **Active** in the product catalog. 
    1. In the Dynamics 365 Field Service app, go to **Settings** area > **General** > **Products** to check product status.
1. On the work order form, verify the price list field is populated with a valid price list that contains the products. 
1. To check the price list contents, go to **Settings** area > **General** > **Price Lists** in the Field Service app.
1. To confirm the user's privileges:
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), 
    1. Go to **Manage** and select your environment. 
    1. Then, go to **Settings** (gear icon at top) > **Users + permissions** > **Security roles**.
    1. Verify the user's role has **Create** privilege on:
         - Work Order Product (`msdyn_workorderproduct`)
         - Work Order Service (`msdyn_workorderservice`)
         - Work Order Service Task (`msdyn_workorderservicetask`)
1. If you're using custom business rules that hide or lock the **Incident Type** field, verify they allow the system to trigger the auto-population logic.

## Related content

- [Create a work order](/dynamics365/field-service/create-work-order)
- [Work order architecture](/dynamics365/field-service/field-service-architecture)

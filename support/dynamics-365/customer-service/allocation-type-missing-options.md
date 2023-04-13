---
title: Unable to create entitlements because Allocation Type dropdown doesn't show any options
description: Provides a solution for when you can't create entitlements because Allocation Type dropdown doesn't show any options in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# Unable to create entitlements because Allocation Type dropdown doesn't show any options

This article provides a solution for when you can't create entitlements because the Allocation Type dropdown doesn't show any options in Customer Service.

## Symptom

Unable to create entitlement forms from either the Customer Service Hub or the Customer Service admin center app because of lack of data in the entitlement’s entity type mappings with the EntitlementEntityAllocationTypeMappingBase table.

## Scenario 1

### Cause
The **Allocation Type** field doesn't exist in the entitlement entity with **Case** option.

### Resolution

Add the **Allocation Type** field by performing the following steps:
1. In either of the apps, go to **Advanced Settings** > **Customizations** > **Customize the System** > **Expand Entitlement Entity** > **Fields** > **Check Allocation Type** field options.
1. Add the **Allocation Type** field.

## Scenario 2

### Cause

The entitlement's entity allocation type mapping records aren't present in the EntitlementEntityAllocationTypeMappingBase table when the **Entity Type** field from the entitlement entity has more than one option other than case.

### Resolution

**Entity Type** is a type of option set field in the Entitlement table that has **Case** as the default option. If **Case** is the only option available for **Entity Type**, then the Entitlement table automatically loads **Allocation Type** values for the **Case** option. In a case where more than one option is set for the **Entity Type** field, you'll need to select the **Entity Type** option so that the Entitlement table will load **Allocation Type** values based on that **Entity Type** selection.

Add the entitlement's entity allocation type mapping records to the EntitlementEntityAllocationTypeMappingBase table.

- Use the following query to insert missing mapping records and add a record for allocation type for the **Case** entity type:

    `Insert INTO [dbo].[EntitlementEntityAllocationTypeMappingBase]` 
`(entitlemententityallocationtypemappingid, statecode, statuscode, allocationtype, entitytype, OwnerId) Values('0C537E5C-13E8-410B-A65C-783A113D49FC', 0, 1, 0, 0, 'F5C0B9AD-E076-ED11-81B3-6045BDE41C7D')`

- Include the following information for the mandatory fields:
    - **Entitlemententityallocationtypemappingid**: New GUID. 
    - **Statecode**: Provide state code that explains the status.
    - **Statuscode**: Provide the reason code that explains the status.
    - **Allocationtype**: Provide type of entitlement terms.
    - **Entitytype**: Entity type for which the entitlement applies.
    - **OwnerId**: Owner Id

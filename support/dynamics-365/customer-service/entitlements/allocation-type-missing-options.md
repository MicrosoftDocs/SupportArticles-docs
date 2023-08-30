---
title: Can't create entitlements because no options in Allocation Type dropdown
description: Provides a resolution for the issue where you can't create entitlements because the Allocation Type dropdown doesn't show any options in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# Can't create entitlements because the Allocation Type dropdown doesn't show any options

This article provides a resolution for the issue where you can't create entitlements because there are no options shown in the **Allocation Type** dropdown in Dynamics 365 Customer Service.

## Symptoms

You can't create entitlement forms from either the Customer Service Hub or the Customer Service admin center app because of a lack of data in the entitlement's entity type mappings with the `EntitlementEntityAllocationTypeMappingBase` table.

## Cause 1

The **Allocation Type** field doesn't exist in the entitlement entity with the **Case** option.

### Resolution

To resolve this issue, add the **Allocation Type** field by taking the following steps:

1. In either of the apps, go to **Advanced Settings** > **Customizations** > **Customize the System** > **Expand Entitlement Entity** > **Fields** > **Check Allocation Type**.
1. Add the **Allocation Type** field.

## Cause 2

The entitlement's entity allocation type mapping records aren't present in the `EntitlementEntityAllocationTypeMappingBase` table when the **Entity Type** field from the entitlement entity has more than one option other than **Case**. **Entity Type** is a type of option set field in the `Entitlement` table that has **Case** as the default option. If **Case** is the only option available for **Entity Type**, then the `Entitlement` table automatically loads **Allocation Type** values for the **Case** option. In a case where more than one option is set for the **Entity Type** field, you'll need to select the **Entity Type** option so that the `Entitlement` table will load **Allocation Type** values based on that **Entity Type** selection.

### Resolution

To resolve this issue, you can add the entitlement's entity allocation type mapping records to the `EntitlementEntityAllocationTypeMappingBase` table.

- Use the following query to insert missing mapping records and add a record for allocation type for the **Case** entity type:
  
  ```sql
  Insert INTO [dbo].[EntitlementEntityAllocationTypeMappingBase]
  (entitlemententityallocationtypemappingid, statecode, statuscode, allocationtype, entitytype, OwnerId) Values('0C537E5C-13E8-410B-A65C-783A113D49FC', 0, 1, 0, 0, 'F5C0B9AD-E076-ED11-81B3-6045BDE41C7D')
  ```

- Include the following information for the mandatory fields:

  - **Entitlemententityallocationtypemappingid**: New GUID.
  - **Statecode**: Provides a state code that explains the status.
  - **Statuscode**: Provides the reason code that explains the status.
  - **Allocationtype**: Provides the type of entitlement terms.
  - **Entitytype**: The entity type for which the entitlement applies.
  - **OwnerId**: Owner Id.

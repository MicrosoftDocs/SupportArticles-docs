---
title: Can't create entitlements because no options in Allocation Type dropdown
description: Provides a resolution for the issue where you can't create entitlements because the Allocation Type dropdown doesn't show any options in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
ms.custom: sap:Entitlements\Unable to create or reactivate entitlements
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

To resolve this issue, Customer can mitigate by either finding where these records were dropped or recreating them. If they have an org where entitlement is working, they can export the values.

:::image type="content" source="media/allocation-type-missing-options/entitlement-entity-allocation-type-mapping.png" alt-text="Entitlement Entity Allocation Type Mapping.":::

Customer can recreate these by going to the powerapps admin like in below screenshot and adding row records to match the above screenshot. They should map from Case to the two remaining allocation type options. If they need to recreate (due to deletion) it's best to do this with a user with maximal permissions.

:::image type="content" source="media/allocation-type-missing-options/finging-entitlement-entity-allocation-type-mapping-table.png" alt-text="Finding Entitlement Entity Allocation Type Mapping Table.":::

If it doesn't work from the UI, they can try the below webAPI: 

```Xrm
Xrm.WebApi.createRecord("entitlemententityallocationtypemapping", 
{name: "incident_numberofcases", entitytype: 0, allocationtype:0}) Xrm.WebApi.createRecord("entitlemententityallocationtypemapping", 
{name: "incident_numberofhours", entitytype: 0, allocationtype:1})
```

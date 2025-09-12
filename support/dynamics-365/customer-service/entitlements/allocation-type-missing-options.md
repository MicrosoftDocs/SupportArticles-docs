---
title: Can't create entitlements because no options in Allocation Type dropdown
description: Provides a resolution for the issue where you can't create entitlements because the Allocation Type dropdown doesn't show any options in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 07/30/2024
ms.custom: sap:Entitlements\Unable to create or reactivate entitlements
---
# Can't create entitlements because the Allocation Type dropdown doesn't show any options

This article provides a resolution for the issue where you can't create entitlements because there are no options shown in the **Allocation Type** dropdown in Dynamics 365 Customer Service.

## Symptoms

You can't create entitlement forms from the Customer Service admin center app because of lack of data in the entitlement's entity type mappings with the `EntitlementEntityAllocationTypeMappingBase` table.

## Cause 1

The **Allocation Type** field doesn't exist in the entitlement entity with the **Case** option.

### Resolution

To resolve this issue, add the **Allocation Type** field by taking the following steps:

1. In either of the apps, go to **Advanced Settings** > **Customizations** > **Customize the System** > **Expand Entitlement Entity** > **Fields** > **Check Allocation Type**.
1. Add the **Allocation Type** field.

## Cause 2

The entitlement's entity allocation type mapping records aren't present in the `EntitlementEntityAllocationTypeMappingBase` table when the **Entity Type** field from the entitlement entity has more than one option other than **Case**. **Entity Type** is a type of option set field in the `Entitlement` table that has **Case** as the default option. If **Case** is the only option available for **Entity Type**, then the `Entitlement` table automatically loads **Allocation Type** values for the **Case** option. In a case where more than one option is set for the **Entity Type** field, you'll need to select the **Entity Type** option so that the `Entitlement` table loads the **Allocation Type** values based on that **Entity Type** selection.

### Resolution

To resolve this issue, find where the allocation type mapping records are dropped or re-create them. If you have an organization where the entitlement works, you can export the allocation type values.

Here's an example of the **Entitlement Entity Allocation Type Mapping** table that contains the **Number of cases** (`incident_numberofcases`) and **Number of hours** (`incident_numberofhours`) allocation type options.

:::image type="content" source="media/allocation-type-missing-options/entitlement-entity-allocation-type-mapping.png" alt-text="Screenshot that shows the Entitlement Entity Allocation Type Mapping table." lightbox="media/allocation-type-missing-options/entitlement-entity-allocation-type-mapping.png":::

To re-create the records, follow these steps:

1. In [Power Apps](https://make.powerapps.com/), select **Dataverse** > **Tables**.
1. Find the **Entitlement Entity Allocation Type Mapping** table.
1. Select **Edit** to add row records to match the preceding screenshot. You should map from **Case** to the remaining two allocation type options. If you need to re-create the records (due to record deletion), it's best to do so using a user with maximal permissions.

:::image type="content" source="media/allocation-type-missing-options/find-entitlement-entity-allocation-type-mapping-table.png" alt-text="Screenshot that shows how to find the Entitlement Entity Allocation Type Mapping table to add records in Power Apps." lightbox="media/allocation-type-missing-options/find-entitlement-entity-allocation-type-mapping-table.png":::

If it doesn't work from the UI, you can try the following Web API to re-create the records:

```javascript
Xrm.WebApi.createRecord("entitlemententityallocationtypemapping", 
{name: "incident_numberofcases", entitytype: 0, allocationtype:0}) Xrm.WebApi.createRecord("entitlemententityallocationtypemapping", 
{name: "incident_numberofhours", entitytype: 0, allocationtype:1})
```

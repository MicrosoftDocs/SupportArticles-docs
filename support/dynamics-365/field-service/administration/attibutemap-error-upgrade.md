---
title: Error with AttributeMap when upgrading
description: Provides a resolution to resolve the AttributeMap errors in Dynamics 365 Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 11/25/2024
ms.custom: sap:Administration
---
# Error with AttributeMap when upgrading Dynamics 365 Field Service

This article helps resolve the "AttributeMap" error messages when upgrading Microsoft Dynamics 365 Field Service.

## Error with customerid and msdyn_serviceaccount

> An AttributeMap, with ID: GUID, between attribute customerid and *msdyn_serviceaccount* of entity incident and msdyn_workorder, has an unmanaged base instance and therefore cannot be updated by a managed solution.

#### Resolution

You can follow these steps to resolve this issue. The attribute map is automatically re-created by upgrading to a newer version. Review the attribute map and delete it in your environment.

1. [View mappable columns](/power-apps/maker/data-platform/map-entity-fields#view-mappable-columns) for the **Work Order** entity that has an N:1 relationship with **msdyn_account_msdyn_workorder_ServiceAccount**.
1. Select **Mappings**.
1. Select the **Service Account** mapping and delete it.
1. Run upgrade again.

## Error with customerid and msdyn_billingaccount

> An AttributeMap, with ID: GUID, between attribute customerid and *msdyn_billingaccount* of entity incident and msdyn_workorder, has an unmanaged base instance and therefore cannot be updated by a managed solution.

#### Resolution

You can follow these steps to resolve this issue. The attribute map is automatically re-created by upgrading to a newer version. Review the attribute map and delete it in your environment.

1. [View mappable columns](/power-apps/maker/data-platform/map-entity-fields#view-mappable-columns) for the **Work Order** entity that has an N:1 relationship with **msdyn_account_msdyn_workorder_BillingAccount**.
1. Select **Mappings**.
1. Select the **Billing Account** mapping and delete it.
1. Run upgrade again.

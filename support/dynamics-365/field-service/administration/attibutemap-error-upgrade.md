---
title: Error with AttributeMap when upgrading
description: Provides a resolution to resolve the AttributeMap errors in Dynamics 365 Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 10/19/2023
---
# Error with AttributeMap when upgrading Dynamics 365 Field Service

This article helps resolve the "AttributeMap" error messages when upgrading Microsoft Dynamics 365 Field Service.

## Error with customerid and msdyn_serviceaccount

> An AttributeMap, with ID: GUID, between attribute customerid and *msdyn_serviceaccount* of entity incident and msdyn_workorder, has an unmanaged base instance and therefore cannot be updated by a managed solution.

#### Resolution

You can follow these steps to resolve this issue. The attribute map will be automatically re-created by upgrading to a newer version. Review the attribute map and delete it in your environment.

1. Go to **Settings** > **Customization** > **Customize the System**.
2. Go to **Entities** > **Work Orders** > **N:1 Relationships**.
3. Double-click the **msdyn_account_msdyn_workorder_ServiceAccount** row.
4. Select **Mappings**.
5. Select the **Service Account** mapping and delete it.
6. Run upgrade again.

## Error with customerid and msdyn_billingaccount

> An AttributeMap, with ID: GUID, between attribute customerid and *msdyn_billingaccount* of entity incident and msdyn_workorder, has an unmanaged base instance and therefore cannot be updated by a managed solution.

#### Resolution

You can follow these steps to resolve this issue. The attribute map will be automatically recreated by upgrading to a newer version. Review the attribute map and delete it in your environment.

1. Go to **Settings** > **Customization** > **Customize the System**.
2. Go to **Entities** > **Work Orders** > **N:1 Relationships**.
3. Double-click the **msdyn_account_msdyn_workorder_BillingAccount** row.
4. Select **Mappings**.
5. Select the **Billing Account** mapping and delete it.
6. Run upgrade again.

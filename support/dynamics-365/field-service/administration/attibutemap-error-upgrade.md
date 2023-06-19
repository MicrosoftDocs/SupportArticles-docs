---
title: Error with AttributeMap when upgrading
description: Resolve AttributeMap errors in Field Service by following the steps outlined in this article.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Error with AttributeMap when upgrading

This article helps resolve issues with AttributeMap errors in Dynamics 365 Field Service.

## Symptoms

You get an "AttributeMap" error when upgrading Field Service.

There are two types of errors:

- "An AttributeMap, with ID: GUID, between attribute customerid and *msdyn_serviceaccount* of entity incident and msdyn_workorder, has an unmanaged base instance and therefore cannot be updated by a managed solution."
- "An AttributeMap, with ID: GUID, between attribute customerid and *msdyn_billingaccount* of entity incident and msdyn_workorder, has an unmanaged base instance and therefore cannot be updated by a managed solution."

## Resolution

You can resolve this issue by following the steps outlined below. The attribute maps will be automatically recreated by upgrading to a newer version. Review these two attribute maps and delete them in your environment.

### Error with customerid and msdyn_serviceaccount

1. Go to **Settings** > **Customization** > **Customize the System**.
2. Go to **Entities** > **Work Orders** > **N:1 Relationships**.
3. Double-click on the row called **msdyn_account_msdyn_workorder_ServiceAccount**.
4. Select **Mappings**.
5. Select the **Service Account** mapping and delete it.
6. Run upgrade again.

### Error with customerid and msdyn_billingaccount

1. Go to **Settings** > **Customization** > **Customize the System**.
2. Go to **Entities** > **Work Orders** > **N:1 Relationships**.
3. Double-click on the row called **msdyn_account_msdyn_workorder_BillingAccount**.
4. Select **Mappings**.
5. Select the **Billing Account** mapping and delete it.
6. Run upgrade again.

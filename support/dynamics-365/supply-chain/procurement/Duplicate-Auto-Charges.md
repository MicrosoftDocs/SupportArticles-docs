---
title: Duplicate Charges Calculation with Auto Charges in Purchase Order
description: When multiple auto charges criteria (Table, Group, All) are configured, Dynamics 365 applies all matching charges cumulatively, which can result in duplicate charges if overlapping setups exis
author: 
ms.date: 
ms.search.form: PurchTable
audience: Application User
ms.reviewer: 
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 
ms.dyn365.ops.version: 
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---

# Duplicate Charges Calculation with Auto Charges in Purchase Order

## Symptom

When configuring auto charges in Accounts Payable in Dynamics 365 Finance, users may experience duplicate charge calculations if auto charges are set up for both specific vendors (Table) and for all vendors (All). This occurs because the system applies all relevant auto charge configurations, regardless of hierarchy, whenever a purchase order is created.
Auto Charges Criteria:
Table: Assigns charges to a specific vendor.
Group: Assigns charges to a vendor group.
All: Assigns charges to all vendors.

## Cause
If auto charges are configured for both an individual vendor (Table) and for all vendors (All), the charges from both configurations will be applied to the purchase order. The system does not prioritize or exclude charges based on a hierarchy of account code, item code, or mode of delivery code. Instead, all applicable charges are accumulated.
For example, if a charge code is set up with account code "All," it will be applied to every purchase order, regardless of any other specific vendor or group configurations that may also exist.

## Resolution
To avoid duplicate or unintended charges:
Use the "Group" option in the account code and item code fields to target specific vendor or item groups.
Map relevant item or vendor groups to the appropriate charge codes.
Avoid using the "All" option unless the charge truly applies to all vendors or items, regardless of other configurations.
Scenario Example:
If different charges are required for a few items and a standard charge for all remaining items, configure auto charges using the "Group" option for the specific items and reserve "All" only for truly universal charges.

---
title: 2147217833 The statement has been terminated error when adding items to Purchase Order, Transfer In, or Transfer Out 
description: When adding items to a Purchase Order, Transfer In, or Transfer Out, RMS will generate the 2147217833 statement has been terminated error. Provides a resolution.
ms.reviewer: theley, randyh
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# "2147217833 The statement has been terminated" error when you add items to a Purchase Order, Transfer In, or Transfer Out

This article provides a resolution for the issue that you can't add items to a Purchase Order, Transfer In, or Transfer Out in Microsoft Dynamics RMS Feature Pack 1 (FP1).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2447570

## Symptoms

When you add items to a Purchase Order, Transfer In, or Transfer Out in Microsoft Dynamics RMS Feature Pack 1 (FP1), you receive the following error:

> Error # - 2147217833 The statement has been terminated. (Source: Microsoft OLE DB Provider for SQL Server) (SQL State: 01000) (NativeError: 3621)

## Cause

This problem can be caused by item having an overly large positive or negative inventory quantity and the new **Details** view in the Transfer and Purchase Order with FP1 when you try to query the details for the items linked to a supplier, but cannot because while processing the query the quantity is greater than the field size. The overly large quantity can normally be caused by scanning the barcode into the item's quantity field.

## Resolution

To resolve this issue, use the script below as a starting point to find the trouble item. Then update the quantity of the trouble item to a smaller inventory quantity.

```sql
SELECT * FROM Item WHERE Quantity > 10000 OR WHERE Quantity < -10000
```

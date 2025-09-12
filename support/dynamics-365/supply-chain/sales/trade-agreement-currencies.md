---
title: Trade agreement currency conversion issues
description: Provides a resolution for currency conversion issues when the currency differs on a purchase order.
author: Henrikan
ms.date: 05/16/2024
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Sales order processing\Issues with trade agreements
---
# Trade agreement currency conversion issues

## Symptoms

Trade agreement prices aren't recalculated according to the currency when the currency differs on a purchase order.

## Resolution

The *Generic currency* feature lets you define prices and discounts in only one currency. You can then convert to other currencies as you require. Furthermore, after the conversion is done, the feature can automatically apply smart rounding.

---
title: The purchase agreement maximum limit isn't effective on a purchase requisition
description: Introduces a by-design behavior where the purchase agreement maximum limit isn't effective on a purchase requisition.
author: Henrikan
ms.date: 05/16/2024
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase requisitions
---
# The purchase agreement maximum limit isn't effective on a purchase requisition

## Symptoms

When a purchase requisition is linked to a purchase agreement, the maximum limit from the purchase agreement isn't effective on the purchase requisition. The default price information is correctly entered, but more than the maximum limit from the purchase agreement can be ordered in the purchase requisition.

## Resolution

This behavior is expected. Because requisitions aren't always approved, a quantity or amount should not be reserved on the purchase agreement. Therefore, you won't meet the maximum limit from the purchase agreement.

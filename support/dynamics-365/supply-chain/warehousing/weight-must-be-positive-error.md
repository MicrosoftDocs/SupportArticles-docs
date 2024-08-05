---
title: Weight must be positive
description: Provides a resolution for specifying a weight when you receive a Weight must be positive error.
author: Mirzaab
ms.date: 04/15/2021
ms.topic: troubleshooting
ms.search.form: WHSContainerCloseDiag_canClose
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: mirzaab
ms.search.validFrom: 2021-05-15
ms.dyn365.ops.version: 10.0.18
ms.custom: sap:Warehouse management
---

# Weight must be positive

Error code: WeightMustBePositive

## Symptoms

The system shows the following error message:

> Weight must be positive.

## Cause

The **Gross Weight** field is set to **0** (zero) or a negative value.

## Resolution

To specify a weight, follow one of these steps.

- In the **Gross weight** field, set a value. Then select a unit in the drop-down list.
- Select **Get system weight** to calculate the **Gross weight** value.

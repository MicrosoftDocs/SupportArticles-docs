---
title: Item can't have a BOM or formula
description: Provides a resolution for the item cannot have a BOM or formula error that occurs when you firm an order during item validation.
author: t-benebo
ms.date: 06/10/2021
ms.topic: troubleshooting
ms.search.form: ReqTransPO
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: benebotg
ms.search.validFrom: 2021-06-10
ms.dyn365.ops.version: 10.0.20
ms.custom: sap:Master planning
---

# Item can't have a BOM or formula

Error code: PRO2614

## Symptoms

When you try to firm an order, you receive the following error message during item validation:

> Item cannot have a BOM or formula

## Resolution

Items that have a bill of materials (BOM) or formula must be of the **Planning item**, **BOM**, or **formula** type. To change the type of an item, follow these steps.

1. Go to **Product information management** > **Products** > **Released products**.
1. Open the relevant product.
1. On the **Engineer** FastTab, set the **Production type** field to **Planning item**, **BOM**, or **formula**.

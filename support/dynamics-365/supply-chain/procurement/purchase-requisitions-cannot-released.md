---
title: Purchase requisitions cannot be released
description: Purchase requisitions created before the current fiscal year cannot be released.
author: Shubham
ms.reviewer: shubhamshr
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 02/25/2025
---
# Purchase requisitions created before the current fiscal year cannot be released

## Symptoms

Unable to release Purchase requisitions created before the current fiscal year

### Casue

Purchase requisitions created in the previous fiscal year are not eligible for releasing in the current fiscal year.

Purchase requisition line was pre-encumbered in a fiscal year that is different from the accounting date of the purchase order, in such scenarios the PR cannot be released, and purchase order cannot be generated.

## Resolution

Currently after evaluating the issue, we understand this is a design limitation. An extension could be added as part of the manually releasing purchase requisitions after completing the year end close process to avoid validating the accounting date of Purchase order.
Alternatively based on the purchase requisition created date from previous fiscal year, users can delete and create new purchase requisitions in the current fiscal year as a workaround to resolve this issue.

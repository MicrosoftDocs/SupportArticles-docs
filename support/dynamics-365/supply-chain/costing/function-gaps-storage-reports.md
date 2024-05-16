---
title: Functional gaps between inventory value/aging reports and their storage versions
description: Introduces the functional gaps between the non-storage versions of the reports (Inventory value storage report and Inventory aging report storage report) and their storage versions.
author: JennySong-SH
ms.date: 05/16/2024
ms.topic: troubleshooting
ms.search.form: InventAgingStorage, InventAgingStorageChart, InventAgingStorageDetails
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: yanansong
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.15
ms.custom: sap:Cost management\Issues with inventory value and aging report
---

# Functional gaps between inventory value/aging reports and their storage versions

The [Inventory aging report storage](/dynamics365/supply-chain/cost-management/inventory-aging-report-storage) and [Inventory value storage report](/dynamics365/supply-chain/cost-management/inventory-value-report-storage) features enable Supply Chain Management to display large volumes of inventory transactions. In each case, the report results are saved for browsing and exporting, unlike with the non-storage versions of these reports. However, some functionality that exists in the non-storage versions of these reports doesn't exist in the storage versions. The following subsections summarize the differences and provide workarounds.

## Storage reports don't include subtotals, even if they are enabled in the report layout

Subtotals can cause issues when the result is exported, especially if users change the record sequence.

To check the subtotals, you can export the result into Microsoft Excel. Alternatively, if you want to check subtotals within Supply Chain Management, use [Feature management](/dynamics365/fin-ops-core/fin-ops/get-started/feature-management/feature-management-overview) to enable the *New grid control* and *Grouping in grids* features, which provide a much more flexible way to see the subtotal for any group by column. For more information, see [Grid capabilities](/dynamics365/fin-ops-core/fin-ops/get-started/grid-capabilities).

## Inventory value storage report doesn't support ledger account information

You can run the trial balance to get the inventory accounts balance and compare that to the **Inventory value storage** report.

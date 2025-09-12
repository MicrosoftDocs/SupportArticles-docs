---
title: Warnings or errors on changing ledger period status without closing inventory
description: Provides a resolution for the warnings or errors that occur when you change the ledger period status without closing inventory.
author: JennySong-SH
ms.date: 05/16/2024
ms.topic: troubleshooting
ms.search.form: InventAgingStorage, InventAgingStorageChart, InventAgingStorageDetails, InventValueProcess, InventValueReportSetup, InventClosing
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: yanansong
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.15
ms.custom: sap:Cost management\Issues with inventory closing and recalculation
---

# Warnings or errors on changing ledger period status without closing inventory

Microsoft introduced the following validations to prevent issues caused by an incorrect period-end process around costing. for more information about how to resolve these error messages, see [KB 4561987](https://fix.lcs.dynamics.com/Issue/Details?kb=4561987&bugId=445351&dbType=3&qc=f514f2adcddcddceec43af58c26ae8a9020effdc7cdfe085d9d0deeb8cc7b6a3).

- You're about to execute a Recalculation with a date %1 (10-02-2019). The last registered Recalculation was executed in a previous period with a date %2 (20-01-2019). No execution of an inventory close with a date %3 (31-01-2019) matching period end has been registered. Remember to execute an inventory close as of %3 (31-01-2019) matching the period end. The valuation of inventories, cost of goods sold, and variances may not be correct in subledger or general ledger until this has been executed.

- You're about to change the status of ledger period %1 to %2. No execution of inventory close with a date %3 matching period end has been registered. Execute an inventory close as of %3 matching the period end before changing the status. The valuation of inventories, cost of goods sold, and variances may not be correct in subledger or general ledger until this has been executed. Reported from legal entity %4. For now, it's informational, but you'll be required to perform such action in future.

- The Account structure %1 has been changed. One or more main accounts %2 no longer exist. These Main accounts are required by the %3 with a date %4. Add these Main accounts to the Account structure %1 before you can resume the %3 job. For now, it's informational, but you'll be required to perform such action in future.

- You're about to execute an inventory close with a date %1 (31-01-2019). No execution of backflush costing calculation with a date %2 (31-01-2019) matching period end has been registered. Remember to execute a backflush costing calculation with a date of %3 (31-01-2019) matching period end. The valuation of inventories, cost of goods sold, and variances may not be correct in subledger or general ledger until this has been executed.

- You're about to execute a backflush costing calculation with a date %1 (28-02-2019). The last registered backflush costing calculation was executed in a previous period with a date %2 (31-01-2019). No execution of an inventory close with a date %3 (31-01-2019) matching a period end has been registered.

Remember to execute an inventory close as of %3 (31-01-2019) matching a period end. The valuation of inventories, cost of goods sold and variances may not be correct in subledger or general ledger until the inventory close has been executed.

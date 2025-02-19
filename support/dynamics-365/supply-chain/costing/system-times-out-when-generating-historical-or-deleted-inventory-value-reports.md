---
title: System times out when generating historical or deleted inventory value reports
description: Provides a resolution for an issue where the system times out when generating or regenerating a historical inventory value report based on older transactions.
author: JennySong-SH
ms.date: 05/16/2024
ms.search.form: 
audience: Application User
ms.reviewer: yanansong
ms.search.region: Global
ms.author: yanansong
ms.search.validFrom: 2022-11-25
ms.dyn365.ops.version: 
ms.custom: sap:Cost management\Issues with inventory value and aging report
---
# System times out when generating historical or deleted inventory value reports

## Symptoms

When you are trying to generate or regenerate a historical inventory value report based on older transactions, the system times out before the report is fully generated. This may occur when regenerating older reports that have been deleted, or when generating new reports based on transaction data that was recorded relatively far in the past.

## Cause

When you generate an inventory value report, the system works backwards from today and processes each inventory transaction record in reverse order as it goes. If you try to look too far back, then there could be a very large number of transactions to consider. The volume of transactions to be processed may eventually grow so large that the system times out before it's able to finish generating the report. The distance into the past that you can generate new reports for depends on how many inventory transactions you have in your system for the relevant time span.

## Resolution

To prevent timeouts from happening in a production environment, try to generate the report on a synchronized user acceptance testing (UAT) instance. If the report succeeds, then export and archive it.

To prevent this issue from happening again, we recommend that you generate inventory value report storage reports at a regular interval and keep each of them in your external storage for future reference. If you do need to delete one or more historical reports from the **Inventory value report storage** page, or if you want to clean up several old inventory reports using the **Inventory value report data clean up** function, then we strongly recommend that you first export and archive the reports before you delete them. Any time you try to delete one or more reports, the system will show a warning reminding you to make backups first.

For more information, see [Inventory value reports](/dynamics365/supply-chain/cost-management/inventory-value-report-storage).

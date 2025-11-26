---
title: Unable to edit a record in table
description: SQL error while updating/inserting data in a table related to the inventory closing or journal posting procedures
author: Soumyamoy Das
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing, SQLError, JournalPosting
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Issues with inventory value and aging report
---

# Unable to edit a record in table

## Symptoms

Inventory closing, recalculation or reverse errors out with the following message as "Unable to edit a record in InventSettlement table". The same can be traced with multiple other processes like inventory journal, sales order, production or purchase order postings, or with different other tables like InventTrans, AssetTrans, ProdTable, etc. 

## Resolution

This message signifies that some SQL issues have prevented further execution, due to which any process or batch job failed. Normally these issues can be deadlocks as multiple other processes are also executing at the same time, or SQL Server Availability issues due to increased traffic, or due to insufficient and inappropriate indexing resulting to query timeouts for long running queries. Generally, these SQL issues are mostly transient and shall be done away with retries. 

Sometimes, it is observed that customizations also result in deadlocks and blockings due to inappropriate transaction scope and error handling. Please try to trace the error message from the batch job (or related processes), call stack, SQL statement, verify whether any customizations are poresent, check the indexes and index fragmentations. 

In case the issue persists after retrying, please feel free to contact Microsoft Support or your Partner. 

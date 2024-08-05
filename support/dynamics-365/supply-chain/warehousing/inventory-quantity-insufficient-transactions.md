--- 
title: Inventory quantity not updated due to insufficient transactions 
description: Provides a resolution for the inventory quantity can't be updated error that occurs if there aren't enough inventory transactions that have the specified dimensions.
author: Mirzaab 
ms.date: 06/24/2021 
ms.topic: troubleshooting 
# ms.search.form:  
audience: Application User 
ms.reviewer: kamaybac 
ms.search.region: Global 
ms.author: mirzaab 
ms.search.validFrom: 2021-06-24 
ms.dyn365.ops.version: 10.0.20 
ms.custom: sap:Warehouse management
--- 
# System can't update inventory quantity because of insufficient transactions

## Symptoms

This issue can occur if the system can't update an inventory quantity because there aren't enough inventory transactions that have the specified dimensions. You will receive the following error message:

> Inventory quantity -%1 could not be updated due to insufficient inventory transactions for item %2 with dimensions Size=%3, Color=%4, Additions=%5, Site=%6, Warehouse=%7, Location=%8, Inventory status=Available, License plate=%9, Batch number=%10 for reference ID %11 on Lot ID %12.

## Resolution

Make sure that no inventory transactions are physically reserving the quantity. For example, these transactions might open quality orders, inventory blocking records, or output orders.

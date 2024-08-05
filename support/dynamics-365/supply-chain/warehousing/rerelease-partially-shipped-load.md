--- 
title: Can't re-release partially shipped load to warehouse 
description: In earlier versions, you couldn't re-release a partially shipped load when using certain functionalities with incomplete reservations. This issue has been fixed. 
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

# Can't re-release a partially shipped load to the warehouse

## Symptoms

You can't release a partially shipped load to the warehouse. When you do the release to the warehouse, an "Operation complete" message appears but nothing happens, and no work is created for the remaining quantity. This issue occurs when you use transport load functionality and there's an incomplete reservation.

## Resolution

This issue has been fixed in [release 10.0.15](/dynamics365/supply-chain/get-started/whats-new-scm-10-0-15). For more information, see [KB issue 470069](https://fix.lcs.dynamics.com/Issue/Details?kb=4574490&bugId=470069&dbType=3&qc=84ce1e09d7032d8b8ef86f5a0c68b86badf3dfaf29686c5ebbe97c53c0957b5f) ("Partially shipped loads can be rewaved and reprocessed").

---
title: Batch task failed. Cannot select a record in Current client sessions
description: Error during inventory closing, recalculation or reverse -- Batch task failed. Cannot select a record in Current client sessions (SysClientSessions). Sessionld. 0, 0. The SQL database has issued an error.
author: soumyamoydas
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Batch task failed. Cannot select a record in Current client sessions
---

# Batch task failed. Cannot select a record in Current client sessions (SysClientSessions). Sessionld: 0, 0. The SQL database has issued an error.

## Symptoms

Inventory closing, recalculation or reverse errors out with "Batch task failed: Cannot select a record in Current client sessions (SysClientSessions). Sessionld: 0, 0. The SQL database has issued an error.".

## Resolution

This issue can occur due to SQL database unavailability, deadlocks, blockings or any other generic SQL limitation/error. Most of the time, these issues are transient and never cause any data corruption. Please retry the operation again. If the issue persists, please reach out to Microsoft Support or your Partner. 

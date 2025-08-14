---
title: Source Document Lines Cannot Be Finalized
description: Provides a resolution for the issue that a Source Document Lines Cannot Be Finalized.
author: Sumit
ms.date: 08/14/2025
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: sugaur
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---
# Troubleshooting Guide: Source Document Lines Cannot Be Finalized

## Symptom
The source document lines cannot be finalized until the status is **Confirmed**.  
The state of the source document or source document line could not be updated.

## Resolution
1. Navigate to:  
   **Procurement and sourcing > Periodic tasks > Clean up > Purchase order distribution reset**
2. Input the **Purchase Order (PO) number**.
3. Click **OK**.
4. The status of the PO updates to **Draft**.
5. Submit the workflow and confirm the PO again.

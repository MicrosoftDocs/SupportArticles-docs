---
title: Purchase Order Can't Be Finalized
description: Provides a resolution for the issue that a Source Document Lines Can't Be Finalized.
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
# Troubleshooting Guide: Source Document Lines Can't Be Finalized

## Cause 
Document accounting status in the related Purchase Requisition (PR) is not completed or confirmed.

## Symptom
An error message is shown in F&O stating that the source document lines cannot be finalized until the status is Confirmed' encountered when trying to finalize a purchase order.

## Resolution
1. Navigate to:  
   **Procurement and sourcing > Periodic tasks > Clean up > Purchase order distribution reset**
2. Input the **Purchase Order (PO) number**.
3. Click **OK**.
4. The status of the PO updates to **Draft**.
5. Submit the workflow and confirm the PO again.

## More information 
 Triggering Purchase order distribution reset initiates a data check to ensure that the selected purchase order is in the correct state for the tool to run.

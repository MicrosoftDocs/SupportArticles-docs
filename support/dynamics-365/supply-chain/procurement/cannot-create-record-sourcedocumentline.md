---
title: Source Document Line Error During PO Confirmation
description: Fix the "Cannot create a record in Source document line" error when you confirm a purchase order in Dynamics 365 Supply Chain Management.
ms.reviewer: shubhamshr
ms.date: 07/30/2026
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---

# PO confirmation fails with "Cannot create a record in Source document line"

## Summary

Purchase order (PO) confirmation can fail when a temporary source document line record already exists. Run the purchase order consistency check to fix the record, and then confirm the PO again.

## Symptoms

When confirming a purchase order (PO), the following error appears:

> Cannot create a record in Source document line (SourceDocumentLineTmpJournalize). Reference table ID: 0, None. The record already exists.

## Resolution

To fix the error, run the consistency check and confirm the PO again:

1. Go to **System administration** > **Periodic tasks** > **Consistency check**.
1. Set the following values.

   | Field | Value |
   | --- | --- |
   | **Module** | **Purchase order** |
   | **Check/Fix** | **Fix error** |
   | **From date** | A date before the affected PO was created |

1. Under **Purchase order**, select **Purchase order accounting distributions**.
1. Select **OK**.
1. Wait for the task to finish.
1. Confirm the PO again. The error should no longer occur.

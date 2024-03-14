---
title: Cannot process EFT batches in Payables or Receivables
description: When you try to process EFT batches in Payables or Receivables in Microsoft Dynamics GP, you receive an error message that states the bank country/region assigned to the vendor's remit-to address can't be the same as the bank country/region assigned to the checkbook that's assigned to the batch.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# "The bank country/region assigned to vendor's remit-to address can't be the same as the bank..." error when processing EFTs

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4044032

## Symptom

When processing an EFT batch (in Payables or Receivables), the following error occurs:

> The bank country/region assigned to the vendor's remit-to address can't be the same as the bank country/region assigned to the checkbook that's assigned to the batch.

## Cause

This issue occurs because of the mismatched field between vendor and checkbook Banking information.

## Resolution

Verify that the following three banking information fields match between the Checkbook and the Vendors included the EFT batch:

- Currency ID
- Bank Country/Region
- Country/Region code

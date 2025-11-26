---
title: Account number for transaction type does not exist
description: Error during inventory closing or recalculation -- Account number for transaction type does not exist
author: Soumyamoy Das
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Account number for transaction type does not exist
---

# Account number for transaction type does not exist

## Symptoms

Inventory closing or recalculation errors out with "Account number for transaction type XXX does not exist".

## Resolution

Verify whether Main Account is correctly setup for the specified transaction type under proper head in Inventory Management -> Setup -> Posting -> Posting. Also, verify the financial dimensions' in the Accounting Structure Setup for the corresponding Main Accounts from General Ledger -> Ledger setup -> Ledger. 
Once all the setup are verified, try resuming calculation for the corresponding voucher.

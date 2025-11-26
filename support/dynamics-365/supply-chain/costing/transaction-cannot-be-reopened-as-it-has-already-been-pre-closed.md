---
title: Transaction cannot be reopened as it has already been pre-closed
description: Error during inventory closing or recalculation -- Transaction cannot be reopened as it has already been pre-closed
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
ms.custom: sap:Cost management\Transaction cannot be reopened as it has already been pre-closed
---

# Transaction cannot be reopened as it has already been pre-closed

## Symptoms

Inventory closing or recalculation errors out with "Transaction XXX cannot be reopened as it has already been pre-closed".

## Resolution

This issue can rarely occur if there are any data corruptions in the inventory transactions/adjustments, when pre-closing has posted settlements to financial transactions and closed them, instead of the non-financial transactions. Pre-closing is executed implicitly in the inventory closing/recalculation process for the non-financial transfers against which we have any markings. This issue might have most likely occurred in that process. 

This can be traced directly from the database in InventTrans table. The records agianst which we have some values posted in QtySettled and CostAmountSettled fields but again ValueOpen is false and NonFinancialTransferInventClosing has got some record id of a closing/recalculation voucher. 

One of the mitigations is to explicitly reset the ValueOpen, NonFinancialTransferInventClosing and DateClosed in those records in InventTrans and retry the closing process again. In case of any direct database data modifications, please carry out first in any lower replica and check whether everything is correct as per the business and calculation procedures.

In case of any further assisstance, please reach out to Microsoft Support or your Partner to fix this issue. 

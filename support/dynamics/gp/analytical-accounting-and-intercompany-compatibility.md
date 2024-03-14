---
title: Analytical Accounting and Intercompany compatibility
description: This article describes how to post intercompany transactions in Analytical Accounting in Microsoft Dynamics GP.
ms.reviewer: theley, jaredha
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Financial - Analytical Accounting
---
# Analytical Accounting and Intercompany compatibility in Microsoft Dynamics GP

This article provides steps to post intercompany transactions in Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 941056

## Introduction

Analytical Accounting does not completely integrate with Intercompany in Microsoft Dynamics GP. The GL batch is created, byt the AA setup may not be the same in the destination company as it is in the originating company. Therefore, you will need to make AA dimension assignments in both the originating and destination companies separately.

After you post a batch of intercompany transactions in the originating company, the assignment for Analytical Accounting data will be not carried over to the destination company. You must access the GL batch in the destination company and manually add the AA data to the transaction.

To post intercompany transactions that contain Analytical Accounting assignments, follow these steps:

1. Create an intercompany batch that contains assignments of Analytical Accounting transaction dimension codes in the originating company.  
2. **Post** the batch in the originating company.
3. In the destination company, select the **Transactions** menu, point to **Financial**, and then select **General**.
4. Open the batch that was created in the destination company, and drill into the transactions in the batch.
5. Select an account number in the Distributions window.
6. On the **Extras** menu, point to **Additional**, and then select **Analytical Transaction** to open the Analytical General Transaction Entry window.
7. Make the appropriate assignments for Analytical Accounting transaction dimension codes for the destination company.
8. **Save** the batch in the Analytical General Transaction Entry window.
9. **Post** the batch in the destination company.

> [!NOTE]
> You must follow these steps even if Analytical Accounting transaction dimension codes are set up identically for both companies.

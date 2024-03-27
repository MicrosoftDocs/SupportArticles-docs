---
title: Analytical Accounting information missing for transactions error
description: During the Write Off routine or Finance Charge Routine in Receivables Management, the batch is going to Batch Recovery, the account used is not linked to Analytical Accounting. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Analytical Accounting
---
# "Analytical Accounting information missing for transactions..." during Write Off or Finance Charge Routine

This article provides a resolution for the error **Analytical Accounting information is missing for the transactions included in this batch** and other related issues during Write Off or Finance Charge Routine in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2542226

## Symptoms

During the Write Off routine or Finance Charge routine in Receivables Management, the batch is going to Batch Recovery, the account used is not linked to Analytical Accounting (AA), and this message appears:

> Analytical Accounting information is missing for the transactions included in this batch. Please enter the information before posting.

## Cause

Analytical Accounting data does not flow through to the GL entry created for the write-off or finance charge routines, and so if you have any *required* dimensions, the GL batch will error out and go to Batch Recovery if you are posting through to GL. The system is designed to have any batch stop in GL so the AA data can be edited, if the originating window does not have any access to the AA window.

## Resolution

### To correct the current batch

Get the batch out of Batch Recovery. Then print an Edit List for the GL batch and an error report will print immediately after the edit list titled *AA Validation Log*. The report will list exactly which GL account(s) in the batch the system is having an issue with and will need to be edited. The AA data can be added to the transactions in the GL batch and then post the batch.

## To prevent this message from happening going forward

Option 1: It is suggested to set the posting to *Post To General Ledger*, instead of *Post Through General Ledger Files* when using AA. This way, the batch will stop in GL so you can review and edit the AA data on it before posting to GL.

The Posting Setup window can be found by selecting Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Posting** and select **Posting**.

Option 2: If you wish to continue to Post Through to GL, then you can define *default* dimension codes in the Accounting Class in AA for any *required* dimensions. The system will use the default codes for the required dimensions and not error out when posting. (Or you can set the required codes to Optional and not use a default code.) After the batch has successfully posted to GL, you can use the Edit Analysis window to go back and modify the AA data if needed.

The Edit Analysis window can be found by selecting **Transactions**, point to **Financial**, point to **Analytical Accounting** and selecting **Edit Analysis**. This window allows you to edit the AA data on any posted transaction in an open year. (You are not allowed to edit AA data on historical years by design.)

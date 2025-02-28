---
title: Document Already Exists error when entering document in Payables Transaction Entry
description: When you try to enter a document in the Payables Transaction Entry window in Microsoft Dynamics GP, you receive a Document Already Exists error. Provides a resolution.
ms.reviewer: theley, lmuelle, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# "Document Already Exists" error when entering a document in the Payables Transaction Entry window

This article provides a resolution for the **Document Already Exists** error that occurs when you enter a document in the Payables Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 863247

## Symptoms

When you try to enter a document in the Payables Transaction Entry window in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> Document Already Exists.

This problem occurs if the following conditions are true:

- You are interrupted when you try to add a document in the Payables Transaction Entry window.
- After the interruption, the document is not displayed in the Payables Transaction Inquiry window.
- Then, you try to type the same document number in the Payables Transaction Entry window.

## Cause

This problem occurs because a record for this document was added to the PM Key Master table (PM00400). But, a record for this document was not added to the PM Transaction Work table (PM10000).

## Resolution

To resolve this problem, remove the record from the PM00400 table. To do this, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Use the appropriate step, depending on whether you are using Microsoft SQL Server or Microsoft SQL Server Desktop Engine (also known as MSDE 2000):

   - If you are using Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, select **All Programs**, select **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - If you are using Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, select **Programs**, select **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you are using MSDE 2000, start Support Administrator Console. To do this, select **Start**, select **Programs**, select **Microsoft Administrator Console**, and then select **Support Administrator Console**.
   - If you are using Microsoft SQL Server 2008, start SQL Query Analyzer. To do this, select **Start**, select **Programs**, select **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
   - If you are using Microsoft SQL Server 2008 R2, start SQL Server Management Studio. To do this, select **Start**, select **All Programs**, select **Microsoft SQL Server 2008 R2** and then select **SQL Server Management Studio**.
   - If you are using Microsoft SQL Server 2012, start SQL Server Management Studio. To do this, select **Start**, select **All Programs**, select **Microsoft SQL Server 2012**, and then select **SQL Server Management Studio**.

2. Run the following statements against the company database to verify what table the document exists in:

   ```sql
   select * from PM00400 where CNTRLNUM = 'XXXX' and VENDORID = 'VVVV'
   select * from PM10000 where VCHRNMBR = 'XXXX' and VENDORID = 'VVVV'
   ```

   > [!NOTE]
   > Replace the XXXX placeholder with the voucher number. Replace the VVVV placeholder with the vendor ID.

3. Confirm that the results are for the transaction that was interrupted. and that the condition exists where the document exists in the PM00400 PM Keys table and not in the PM10000 Transaction Work table.

4. Once you have confirmed that the problem is that the document exists in the PM Keys table and not the PM Transaction work table, you can run the following statement against the company database to remove it from the PM Keys table:

   ```sql
   delete PM00400 where CNTRLNUM = 'XXXX' and VENDORID = 'VVVV'
   ```

   > [!NOTE]
   > Replace the XXXX placeholder with the voucher number. Replace the VVVV placeholder with the vendor ID.

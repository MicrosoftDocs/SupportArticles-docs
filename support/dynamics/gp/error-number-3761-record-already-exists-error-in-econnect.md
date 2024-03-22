---
title: 3761 Record already exists cannot insert error in eConnect
description: When you try to use eConnect to pass in a transactional document, you may receive error 3761 record already exists error in eConnect for Microsoft Dynamics GP.
ms.reviewer: theley, dclauson
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Inventory
---
# "Error Number = 3761 Record already exists, cannot insert" occurs in eConnect for Microsoft Dynamics GP

This article provides a resolution for the issue that you can't use eConnect to pass in a transactional document because of the error 3761 **Record already exists, cannot insert** in eConnect for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954009

## Symptoms

When you try to use eConnect to pass in a transactional document, eConnect for Microsoft Dynamics GP logs the following error message:

> Error Number = 3761  
"Record already exists, cannot insert"

This problem occurs if multidimensional analysis (MDA) isn't registered.

## Cause

This problem occurs because MDA data exists in the company database. This can occur when the Registration window is used to turn off MDA after transactions have already been created that contain MDA records.

## Resolution

To resolve this problem, follow these steps:

1. Make a backup of the company database.

2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or Microsoft SQL Server Management Studio. To do this, use one of the following methods, depending on the program that you're using.

    - SQL Server Desktop Engine (also known as MSDE 2000): Start the Support Administrator Console. To do this, select **Start**, select **All Programs**, select **Microsoft Administrator Console**, and then select **Support Administrator Console**.
    - SQL Server 2000: Start **SQL Query Analyzer**. To do this, select **Start**, select **All Programs**, select **Microsoft SQL Server**, and then select **Query Analyzer**.
    - SQL Server 2005: Start **SQL Server Management Studio**. To do this, select **Start**, select **All Programs**, select **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

3. Run the following SQL statements against the company database:

   ```sql
   delete DTA00100 delete DTA00200 delete DTA00300 delete DTA00301 delete DTA00700 delete DTA10100 delete DTA10200
   ```

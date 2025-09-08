---
title: Checks are not printed in Payables Management
description: This article provides a resolution for the problem that occurs when you process a batch in the Print Payables Checks window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.
ms.topic: troubleshooting
ms.reviewer: theley, kriszree
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# Checks are not printed in Payables Management in Microsoft Dynamics GP

This article helps you resolve the problem that occurs when you process a batch in the Print Payables Checks window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 848247

## Symptoms

When you process a batch in the Print Payables Checks window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0, the alignment form is printed correctly. However, the checks are not printed.

## Cause

This problem occurs for one or more of the following reasons:

- A damaged record exists in the PM Key Master File (PM00400) table.
- A damaged user ID exists.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, follow these steps:

1. If the **Batch ID** has a status of **Posting**, follow these steps:
    1. Follow the steps in the following Knowledge Base article: [KB850289 - A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/topic/850289)</br>An Automated Solution script may be available to perform this task.
    1. On the **Transactions** menu, point to **Purchasing**, and then click **Batches**.
    1. In the Payables Batch Entry window, click the appropriate batch in the **Batch ID** list, and then click **Delete**. When you are prompted to delete the batch, click **Delete**.
    1. On the **Transactions** menu, point to **Purchasing**, and then click **Select Checks**.
    1. In the Select Payables Checks window, create a new batch ID, and then process the check batch. If the checks are not printed, go to step 2.
2. Log on to Microsoft Dynamics GP by using a different user ID. Try to print the checks in the Select Payables Checks window.
    - If the checks are printed, the original user ID may be damaged. Create a new user ID.
    - If the checks are not printed, delete the user ID that you created, and then go to step 3.
3. Delete the records in the PM Key Master File (PM00400) table. To do this, follow these steps:
    1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.
        - **Method 1: For SQL Server Desktop Engine**</br>If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.
        - **Method 2: For SQL Server 2000**</br>If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.
        - **Method 3: For SQL Server 2005**</br>If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
    1. Run the following script against the company database.</br> `Select * from PM00400 where CNTRLNUM in (select PMNTNMBR from PM10300 where BACHNUMB = '<X>') and DOCTYPE = 6`
       > [!NOTE]
       > Replace the placeholder \<X> by using the appropriate batch ID.
    1. Verify that the results display only the records for the checks that you want to print. If the results do not display only the records for the checks that you want to print, contact your partner or technical support for more information. You can contact Microsoft Dynamics Technical Support by telephone at 888-477-7877.
    1. If the results display only the records for the checks that you want to print, run the following script against the company database. </br>`Delete PM00400 where CNTRLNUM in (select PMNTNMBR from PM10300 where BACHNUMB = '<X>') and DOCTYPE = 6`
       > [!NOTE]
       > Replace the placeholder \<X> by using the appropriate batch ID.
    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then click **Check Links**.
        - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Maintenance** on the **File** menu, and then click **Check Links**.
    1. Click **Purchasing** in the **Series** list, click **Payables Transaction Logical File** in the **Logical Tables** list, click **Insert**, and then click **OK**. When you are prompted to print the Error Log report, select a destination.

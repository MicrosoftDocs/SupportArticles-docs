---
title: Cannot use Electronic Reconcile in Bank Reconciliation
description: Describes a problem where you receive the error message Bank Account Number from text file could not be matched when using Electronic Reconcile in Bank Reconciliation in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Bank Reconciliation
---
# "Bank Account Number from text file could not be matched..." error when using Electronic Reconcile in Bank Reconciliation

This article provides a resolution for the issue that you can't download the text file from the bank using Electronic Reconcile in Bank Reconciliation in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2504850

## Symptoms

When you try to download the text file from the bank using Electronic Reconcile in Bank Reconciliation in Microsoft Dynamics GP, you receive the following error message:

> Bank Account Number from text file could not be matched to a Checkbook Account Number

## Cause

1. The bank account number has the leading zeroes stripped off, so it does not match between the text file and the bank account number assigned in the Checkbook Maintenance window. To resolve this problem, see Resolution 1.

2. The same bank account number is assigned to more than one checkbook, so the system does not know which Checkbook ID to match. To resolve this problem, see Resolution 2.

## Resolution 1

Review the bank account number in the text file to make sure it matches the Bank Account Number assigned to the checkbook. Make sure the leading zeroes were not stripped off.

1. To open the Checkbook Maintenance window, select **Cards**, point to **Financial** and select **Checkbook**.
2. Select the appropriate Checkbook ID and compare the Bank Account field against the bank account number in the text file from the bank.

## Resolution 2

Compare the Bank Account numbers assigned to all the checkbooks to make sure it is not assigned to more than one checkbook, even if it is inactive. To do this, follow these steps:

1. Select **Cards**, point to **Financial** and select **Checkbook** to open the Checkbook Maintenance window.

2. In the Checkbook Maintenance window, select the right scroll button in the bottom-left corner of the window. Scroll through each checkbook to make sure the Bank Account number is not assigned to more than one checkbook, even if it is inactive.

    > [!NOTE]
    > If you have numerous checkbooks, you may also review this information by looking at the CM Checkbook Master (CM00100) table using a SQL Query tool. To do this, follow these steps:

    1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

        - **Method 1:** For SQL Server Desktop Engine

          If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

        - **Method 2:** For SQL Server 2000

          If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

        - **Method 3:** For SQL Server 2005

          If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

        - **Method 4:** For SQL Server 2008

          If you are using SQL Server 2008, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**. SQL Server Management Studio. In a query window, execute this script against the company database to review the `BNKACTNM` field for all the checkbooks at once:

    2. Execute the following statement against the company database:

        ```sql
        select * from CM00100 order by BNKACTNM desc
        ```

3. If you find the Bank Account number used on multiple checkbooks, remove the Bank Account from the inactive or incorrect checkbook in the Checkbook Maintenance window and Save.
4. Test the Electronic Reconcile import again.

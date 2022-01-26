---
title: Unable to generate next payment number or Unable to generate next voucher number error when entering a payables transaction
description: Describes an error may occur when you enter a payables transaction in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/22/2021
---
# "Unable to generate next payment number" or "Unable to generate next voucher number" error when entering a payables transaction

This article provides a resolution for the issue that you can't enter a payables transaction in Microsoft Dynamics GP due to the **Unable to generate next voucher number** or **Unable to generate next payment number** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 863399

## Symptoms

When you try to enter a payables transaction in Microsoft Dynamics GP, you receive one of the following error messages:

Error message 1

> Unable to generate next voucher number.

Error message 2

> Unable to generate next payment number.

## Cause

This problem can have any of the following causes.

- Cause 1

  The **Next Payment Number/Voucher Number** field is not populated. See Resolution 1.

- Cause 2

  The **Next Payment Number/Voucher Number** field does not have a large enough number. See Resolution 2.

- Cause 3

  The **Next Payment Number/Voucher Number** field does not start with leading zeros. See Resolution 3.

- Cause 4

  The **Next Payment Number/Voucher Number** field contains letters. See Resolution 4.

- Cause 5

  Data in the Payables Transaction Logical File group is missing or is corrupted. See Resolution 5.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

> [!NOTE]
> Resolutions 1, 2, 3, and 4 will make use of the Payables Setup Options window. To access the Payables Setup Options window, select the **Options** button after launching the Payables Management Setup window. To launch this window, please use the appropriate option:

- In Microsoft Dynamics GP 10.0, point to Tools on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Purchasing**, and then select **Payables**.
- In Microsoft Dynamics GP 9, point to Setup on the **Tools** menu, point to **Purchasing**, and then select **Payables**.

### Resolution 1

To resolve this problem, type a number in the **Next Payment Number/Voucher Number** field in the Payables Setup Options window. To access this window, follow the appropriate method:

- In Microsoft Dynamics GP 10.0, point to **Tools** on the Microsoft Dynamics GP menu, point to **Setup**, point to **Purchasing**, and then select **Payables**. Next, select the **Options** button.

- In Microsoft Dynamics GP 9.0, select on **Tools**, point to **Setup**, point to **Purchasing**, and then select **Payables**. Next, select the **Options** button.

> [!NOTE]
> Document types of Invoice, finance charge, miscellaneous charge, return and credit memo use voucher numbers, while checks (whether manual payments or computer checks) use payment numbers.

### Resolution 2

To resolve this problem, enter a larger number in the **Next Payment Number/Voucher Number** field in the Payables Setup Options window that is higher than the maximum number already used. To determine the voucher number or highest payment number of the highest value that has already been used, use the steps below:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using:

   - Method 1: For SQL Server Desktop Engine. If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.
   - Method 2: For SQL Server 2000. If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - Method 3: For SQL Server 2005. If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - Method 4: For SQL Server 2008. If you are using SQL Server 2008, start SQL Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

2. Select on New Query and select the company database.
3. Run the following the appropriate script against the company database to identify the record that has the highest voucher / payment number.

    - To determine the highest **voucher number**, proceed with running this script:

      ```sql
      select max (CNTRLNUM) from PM00400 where CNTRLTYP = 0
      ```

    - To determine the highest payment number, proceed with running this script:

      ```sql
      select max (CNTRLNUM) from PM00400 where CNTRLTYP = 1
      ```

### Resolution 3

To resolve this problem, make sure that the number in the **Next Payment Number/Voucher Number** field in the Payables Setup Options window starts with leading zeros. For example, if the number starts with 999, change the number to 0000000999.

### Resolution 4

To resolve this problem, make sure that the number in the **Next Payment Number/Voucher Number** field in the Payables Setup Options window has no letters or alpha-numeric characters.

### Resolution 5

To resolve this problem, perform the Check Links routine on the Payables Transaction Logical File. Have all users sign out of Microsoft Dynamics GP before proceeding. To do this, follow these steps.

> [!WARNING]
> If you use Microsoft Dynamics GP 9.0, you must install Service Pack 2 before you follow these steps. The Check Links process may incorrectly remove applied records if you run Check Links in Microsoft Dynamics GP 9.0 or in Microsoft Dynamics GP 9.0 Service Pack 1.

1. Follow the appropriate step:

   - In Microsoft Dynamics GP 10.0, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
   - In Microsoft Dynamics GP 9.0, point to **Maintenance** on the **File** menu, and then select **Check Links**.
2. In the **Series** list, select **Purchasing**.
3. Select **Payables Transaction Logical File**, select **Insert**, and then select **OK**.
4. When you are prompted to print the error log, select a destination, and then select **OK**.

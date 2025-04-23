---
title: Unable to generate next payment number or Unable to generate next voucher number error when entering a payables transaction
description: Describes an error may occur when you enter a payables transaction in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# "Unable to generate next payment number" or "Unable to generate next voucher number" error when entering a payables transaction

This article provides a resolution for the issue that you can't enter a payables transaction in Microsoft Dynamics GP due to the **Unable to generate next voucher number** or **Unable to generate next payment number** error.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 863399

## Symptoms

When you try to enter a payables transaction in Microsoft Dynamics GP, you receive one of the following error messages:

Error message 1

> Unable to generate next voucher number.

Error message 2

> Unable to generate next payment number.

## Cause 1

The **Next Payment Number/Voucher Number** field isn't populated.

#### Resolution 

To resolve this problem, type a number in the **Next Payment Number/Voucher Number** field in the **Payables Setup Options** window.

> [!TIP]
> To open the **Payables Setup Options** window, on the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **Purchasing**, select **Payables**, and then select the **Options** button.

> [!NOTE]
> Document types of Invoice, finance charge, miscellaneous charge, return and credit memo use voucher numbers, while checks (whether manual payments or computer checks) use payment numbers.

## Cause 2

The **Next Payment Number/Voucher Number** field doesn't have a large enough number.

#### Resolution

To resolve this problem, enter a larger number in the **Next Payment Number/Voucher Number** field in the **Payables Setup Options** window that is higher than the maximum number already used. To determine the voucher number or highest payment number of the highest value that has already been used, use the steps below:

> [!TIP]
> To open the **Payables Setup Options** window, on the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **Purchasing**, select **Payables**, and then select the **Options** button.

1. Start Microsoft SQL Server Management Studio.

   To do this, select **Start**, point to **All Programs** > **Microsoft SQL Server**, and then select **SQL Server Management Studio**.

2. Select on New Query and select the company database.

3. Run the following the appropriate script against the company database to identify the record that has the highest voucher or payment number.

    - To determine the highest **voucher number**, proceed with running this script:

      ```sql
      select max (CNTRLNUM) from PM00400 where CNTRLTYP = 0
      ```

    - To determine the highest payment number, proceed with running this script:

      ```sql
      select max (CNTRLNUM) from PM00400 where CNTRLTYP = 1
      ```

## Cause 3

The **Next Payment Number/Voucher Number** field does not start with leading zeros.

#### Resolution

To resolve this problem, make sure that the number in the **Next Payment Number/Voucher Number** field in the **Payables Setup Options** window starts with leading zeros. For example, if the number starts with 999, change the number to 0000000999.

> [!TIP]
> To open the **Payables Setup Options** window, on the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **Purchasing**, select **Payables**, and then select the **Options** button.

## Cause 4

The **Next Payment Number/Voucher Number** field contains letters.

#### Resolution

To resolve this problem, make sure that the number in the **Next Payment Number/Voucher Number** field in the **Payables Setup Options** window has no letters or alpha-numeric characters.

> [!TIP]
> To open the **Payables Setup Options** window, on the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **Purchasing**, select **Payables**, and then select the **Options** button.

## Cause 5

Data in the Payables Transaction Logical File group is missing or is corrupted.

### Resolution 

To resolve this problem, perform the Check Links routine on the Payables Transaction Logical File. Have all users sign out of Microsoft Dynamics GP before proceeding. To do this, follow these steps.

1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
2. In the **Series** list, select **Purchasing**.
3. Select **Payables Transaction Logical File**, select **Insert**, and then select **OK**.
4. When you are prompted to print the error log, select a destination, and then select **OK**.

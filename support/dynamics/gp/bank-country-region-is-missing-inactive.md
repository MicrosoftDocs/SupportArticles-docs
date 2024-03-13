---
title: Bank country or region is missing or inactive
description: Provides a solution to an error that occurs when you generate an EFT file for Payables Management.
ms.reviewer: Lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "The bank country/region assigned to the vendor's remit-to address is missing or inactive" Error message when you generate an EFT file for Payables Management in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you generate an EFT file for Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 944441

## Symptoms

When you generate an Electronic Funds Transfer (EFT) file for Payables Management in Microsoft Dynamics GP after you upgrade from an earlier version, you receive the following error message:
> The bank country/region assigned to the vendor's remit-to address is missing or inactive. Assign the bank country/region to the address or activate the format.

## Cause

This error message can occur for the following reasons:

- The checkbook ID that you use doesn't have a prenote generated. See [Method 1](#method-1) to resolve.
- The vendor doesn't have a default remit-to address ID populated in the Vendor Maintenance window. This remit-to address ID is referred to as the VADCDTRO field. See [Method 2](#method-2) to resolve.
- The VADCDTRO (Vendor Address Code - Remit To) field doesn't match the VADCDTRO that is used for this vendor in the PM00200 (PM _Vendor_Master) or PM20100 (PM_Apply_to_OPEN_OPEN_temporary tables. See [Method 3](#method-3) to resolve.

## Resolution

To resolve this problem, use one of the following methods.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Method 1

This error message can occur if the checkbook ID that you use hasn't had a prenote generated. To resolve the problem, follow these steps:

1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
2. In the Checkbook Maintenance window, select the checkbook ID by using the **Lookup** button in the **Checkbook ID** field.
3. In the Checkbook Maintenance window, select **EFT Bank** button.
4. In the Checkbook EFT Bank Maintenance window, select the **Payables Options** button.
5. In the Checkbook EFT Payables Options window, follow one of the following options:

    1. If the **Payables Prenote Required** check box is selected, go to step 6.
    2. If the **Payables Prenote Required** check box isn't selected, go to [Method 2](#method-2).
6. In the Checkbook EFT Payables Options window, select **Generate Prenotes**.
7. In the Generate EFT Prenotes window, select the checkbook ID in the **Checkbook ID** field, select the **Vendors Only** option in the **Prenotes For** section, select the prenote format ID in the **Prenote Format ID** field, and then select **Process**.

### Method 2

This error message can occur if you don't have a default remit to address ID populated in the Vendor Maintenance window. To resolve this problem, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Vendor**.
2. In the Vendor Maintenance window, select the vendor ID by using the **Lookup** button in the **Vendor ID** field.
3. In the Vendor Maintenance window, select the **Lookup** button in the **Remit To** field, and then select your remit to address ID that is set up as EFT.
4. Select **Save**.

> [!NOTE]
> Beginning in Microsoft Dynamics GP 9.0, a new field was added to the PM Transaction Open File table (PM20000). This field is the VADCDTRO (Vendor Address Code - Remit To) field. Every time that an Electronic Funds Transfer (EFT) invoice is entered into the system, the VADCDTRO field is populated to record the remit-to information for the invoice.

### Method 3

This error message can occur if the VADCDTRO (Vendor Address Code - Remit To) field in the PM20000 table for your posted invoices doesn't match the address ID that you've mapped to EFT. Check the PM20000 (PM_Transaction_Open) table to make sure that the vendor addresses in the VADCDTRO column are the same addresses for the vendors in an earlier version of Microsoft Dynamics GP if you recently upgraded. The VADCDTRO column in the PM20000 table must match the VADCDTRO column in the PM00200 (PM_Vendor_Master) table for each vendor. To resolve this problem, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 2**: For SQL Server 2005

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

    **Method 3**: For SQL Server 2008

    If you're using SQL Server 2008, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.

2. Run the following script against the company database to update the VADCDTRO field for the records in the PM20000 table.

    ```sql
    UPDATE PM20000 SET VADCDTRO = PM00200.VADCDTRO FROM PM20000 INNER JOIN PM00200 ON PM20000.VENDORID = PM00200.VENDORID
    ```

    > [!NOTE]
    > This script will assign the value in the VADCDTRO field for all the posted invoices to be the same as the remit to address ID in the Vendor Maintenance window. This script assumes that the remit to address ID in the Vendor Maintenance window is the address ID that you have mapped to EFT.

    > [!NOTE]
    > Or, you can use the following script to update the VADCDTRO field for a specific vendor in the PM20000 transaction table.

    ```sql
    UPDATE PM20000 SET VADCDTRO = 'XXX' WHERE VENDORID = 'YYY'
    ```

    > [!NOTE]
    > XXX is a placeholder for the remit-to address code. YYY is a placeholder for the vendor ID.

3. Additionally, if there are records for this vendor in the PM20100 remittance table, make sure that the VADCDTRO column in the PM20100 (PM_Apply_To_OPEN_OPEN_temporary) remittance table matches the VADCDTRO column in the PM00200 table and the PM20000 (PM_Transaction_Open) table. Use the following script against the company database to update the VADCDTRO field for a specific vendor in the PM20100 remittance table.

    ```sql
    Update PM20100 set VADCDTRO='XXX' where VENDORID='YYY'
    ```

    > [!NOTE]
    > XXX is a placeholder for the remit-to address code. YYY is a placeholder for the vendor ID.
4. Test generating the EFT file again. When the VADCDTRO field matches between the PM00200, PM20000 and PM20100 tables for this vendor, you shouldn't receive the error message.

## References

For more information and troubleshooting tips to generate the EFT file for Payables Management in Microsoft Dynamics GP 10.0, see [KB - Guidelines to follow when you generate EFT files or EFT prenote files in Electronic Funds Transfer for Payables Management or Receivables Management in Microsoft Dynamics GP](https://support.microsoft.com/help/945955).

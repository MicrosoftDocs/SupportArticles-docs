---
title: Error when you print checks in Payables Management in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you print checks in Payables Management in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Error when you print checks in Payables Management in Microsoft Dynamics GP: A Get/Change Operation on Table PM_Key_Mstr Could Not Find A Record

This article provides a solution to an error that occurs when you print checks in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852208

## Symptoms

When you print checks in Payables Management after you update to Microsoft Dynamics, you receive the following error message:

> A Get/Change Operation On Table PM_Key_Mstr Could Not Find A Record.

## Cause

This problem may occur when one of the following is true:

- The check run process was interrupted.
- One or more transactions that are associated with the check run have no corresponding PM Key record.

    The PM Key Master table (PM00400) tracks all transactions within Payables Management. Each transaction has a corresponding PM Key record. A corresponding PM Key record is generated for every Payables Management transaction that is entered, regardless of status. Payables Management transactions include the following:
  
  - Debit documents such as invoices, finance charges, and miscellaneous charges that are being paid for by a check
  - Computer checks in the check batch
  - Returns, credit memos, and manual payments that are automatically applied during the Select Checks process

    > [!NOTE]
    > This process refers to the "Automatically Apply Existing Unapplied" section at the bottom of the Select Checks window.

> [!NOTE]
> This problem may also occur if the reports.dic file is missing or is corrupted.

For more information, see [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-reports-dic-file-in-microsoft-dynamics-gp-8a85339e-92ed-03ed-5ca8-f538a5c502a7).

## Resolution

To resolve this issue, regenerate the PM Key records by running Check Links on the following Logical Table Groups:

- Payables Transaction Logical File
- Payables History Logical FileTo do this, follow these steps:

1. Determine whether the issue is caused by missing PM Key records. To do this, follow these steps:

    1. Run the following script to determine whether there are debit documents that have no corresponding PM Key record.

        ```sql
        select VCHRNMBR as 'voucher number', DOCTYPE, * from PM20000 where DOCTYPE in (1, 2, 3)
         and VCHRNMBR not in (select CNTRLNUM from PM00400 where DOCTYPE in (1, 2, 3))
        ```

    2. Run the following script to determine whether there are computer checks in a check batch that have no corresponding PM Key record.

        ```sql
        select PMNTNMBR as 'computer check pmt#', * from PM10300 where DOCTYPE in (6)
         and PMNTNMBR not in (select CNTRLNUM from PM00400 where DOCTYPE = 6)
        ```

    3. Run the following script to determine whether there are unapplied returns, credit memos, or manual payments that have no corresponding PM Key record.

        ```sql
        select VCHRNMBR as 'voucher number', DOCTYPE, * from PM20000 where DOCTYPE in (4, 5)
         and VCHRNMBR not in (select CNTRLNUM from PM00400 where DOCTYPE in (4, 5))
        ```

2. If any records are returned when you run the scripts in step 1, run Check Links against the Payables Transaction Logical File. To do this, follow these steps:

    1. Do one of the following, depending on your version of the program:

      - Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 2013

        On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.

      - Microsoft Dynamics GP 9.0 and earlier versions

        On the **File** menu, point to **Maintenance**, and then click **Check Links**.

    1. In the **Series** list, click **Purchasing**.
    1. In the **Logical Tables** list, select the **Payables Transaction Logical File** table or the **Payables History Logical File** table.

        > [!NOTE]
        > These tables involve WORK and OPEN tables only.

    1. Click **Insert**, and then click **OK**.
    1. When you are prompted, click to select the **Screen** check box to generate the error log report to the screen, and then click **OK**.

        > [!NOTE]
        > After the check links process is complete, a report is generated.

3. If the issue persists, you may have to address the following scenarios for check run interruptions:
   - Checks were not printed.
   - Checks were printed.
   - Checks in the check run were printed. However, the checks were only partly posted.
   - Checks in the check run were printed. However, the checks were not posted. For more information about how to address the different scenarios for check run interruptions, see [How to continue a check run that was interrupted in Payables Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-how-to-continue-a-check-run-that-was-interrupted-in-payables-management-in-microsoft-dynamics-gp-314ce082-14a8-9834-765b-fb4bcb9af849).

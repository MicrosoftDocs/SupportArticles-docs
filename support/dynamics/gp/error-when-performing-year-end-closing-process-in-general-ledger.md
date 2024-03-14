---
title: Error when you perform the year-end closing process in General Ledger in Microsoft Dynamics GP
description: Discusses that you receive an error when you perform the year-end closing process in General Ledger in Microsoft Dynamics GP. Provides solutions.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# Error when you try to perform the year-end closing process in General Ledger in Microsoft Dynamics GP: Retained Earnings account not found

This article provides solutions to an error that occurs when you perform the year-end closing process in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850741

## Symptoms

When you try to perform the year-end closing process in General Ledger in Microsoft Dynamics GP, you receive the following error message:

> Retained Earnings account not found.
>
> The retained earnings account was not found.

## Cause

This problem occurs if you click to select the **Close to Divisional Account Segments** check box in the **General Ledger Setup** window.

Additionally, the error message may occur because of one of the following causes:

### Cause 1

Only one Retained Earnings account is set up. However, the **Close to Divisional Account Segments** check box is selected in the General Ledger Setup window. See [Resolution 1](#resolution-1).

### Cause 2

Retained Earnings accounts are set up without a common segment to close to. See [Resolution 2](#resolution-2).

### Cause 3

The **Close to Divisional Account Segments** check box is selected. However, the Retained Earnings account is not set up for each segment division. See [Resolution 3](#resolution-3).

### Cause 4

The Retained Earnings accounts have blank spaces in them. See [Resolution 4](#resolution-4).

### Cause 5

The GL00105 Account Index table has a damaged record. See [Resolution 5](#resolution-5).

### Cause 6

If using closing to divisional RE accounts, it is looking for unit accounts.  See [Resolution 6](#resolution-6).

## Resolution

Before you perform any of these resolutions, make sure that you have all other users log out of Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains. Also make sure that you create a restorable backup of the company database.

### Resolution 1

To resolve this problem, clear the **Close to Divisional Account Segments** check box in the General Ledger Setup window. To do this, follow these steps:

1. Open the General Ledger Setup window, click Tools on the **Microsoft Dynamics GP**  menu, point to **Setup**, point to **Financial**, and then click **General Ledger**.
2. In the General Ledger Setup window, click to clear the **Close to Divisional Account Segments** check box.
3. Click **OK** to save the changes.

### Resolution 2

To resolve this problem, close to only one segment of the different Retained Earnings account numbers. You cannot close to more than one segment of the account numbers.

### Example

In this example, the following Retained Earnings account numbers exist:

- A-000-3030-00
- B-100-3030-00
- C-200-3030-00

In this example, you cannot close by using the second segment of the account numbers. The second segments are 000, 100, and 200. After you decide on that segment that you want to close by, the rest of the segments must be the same. Therefore, in this example, you have the following options:

- If you want to close by using the second segment, you must change the first segment (the letter) so that it is the same for all accounts. For example, to close by using the second segment and by using the divisional retained earnings, change the first segments as follows:
  - A-000-3030-00
  - A-100-3030-00
  - A-200-3030-00
- If you want to close by using the first segment, you must change the second segment so that it is the same for all accounts. You can change the second segment by using one of the following options:
  - A-000-3030-00, B-000-3030-00, C-000-3030-00
  - A-100-3030-00, B-100-3030-00, C-100-3030-00
  - A-200-3030-00, B-200-3030-00, C-200-3030-00

### Resolution 3

Verify that no segment division has a Retained Earnings account that was created for it. To do this, follow these steps:

1. Open the **Account Segment Setup** window, click **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Financial**, and then click **Segment**.
2. Click the lookup button next to the **Segment** field, and then note the account segment that is assigned in the **General Ledger Setup** window.
3. Use the lookup button next to the **Number** field.
4. Note the segment numbers that you can view by using the segment lookup button.
5. Open the Account Maintenance window. To do this, click **Cards**, point to **Financial**, and then click **Account**.
6. Make sure that all segments noted in step 4 have corresponding Retained Earnings accounts set up.

    Example:

    The following conditions are true:
   - You have a Retained Earnings account number of 000-3030-00.
   - The first segment of the account number is set up as the divisional account segment.
   - You noted that the first segment has these numbers set up: 000, 100, 200, 300, and 400.

    In this example, you have to verify that the following Retained Earnings account numbers are also set up:
    - 100-3030-00
    - 200-3030-00
    - 300-3030-00
    - 400-3030-00

7. If all segments are not set up, set them up now in the **Account Maintenance** window. To do this, click **Cards**, point to **Financial**, and then click **Account**.

### Resolution 4

To resolve this problem, determine whether the Retained Earnings account numbers have blank spaces in them. To do this, follow these steps:

1. Open the Account Maintenance window. To do this, click **Cards**, point to **Financial** and then click **Account**.
2. Select one of the Retained Earnings accounts, and then examine the account number to make sure that it has no spaces in it.

    Example:

    - You have a Retained Earnings account number of 000-3030-00.
    - The first segment of the account number is set up as the divisional account segment.
    - You noted that the first segment has these numbers set up: 000, 100, 200, 300, and 400.

    In this example, you have to verify that the following Retained Earnings account numbers are also set up:
    - 100-3030-10
    - 200-3030-20
    - 300-3030-30
    - 400-3030-40

    However, you may have unintentionally increased the segment length of the first segment to four characters, and Microsoft Dynamics GP will not recognize the Retained Earnings accounts that you originally created. If you increase the first segment, the account numbers would resemble the following:

    - 100X-3030-10
    - 200X-3030-20
    - 300X-3030-30
    - 400X-3030-40

    > [!NOTE]
    > In these numbers, X represents a blank space.

    If there are spaces in the account numbers, continue with the following steps.

3. Open the Reconcile window. To do this, click Tools on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **System**, and then click **Reconcile**.

    > [!NOTE]
    > The Reconcile command reverts the account segment format to the original segment lengths. The reconciliation works only if no accounts that have an actual first segment length of four characters,excluding spaces. That is, no accounts that have a first segment such as 1000 as in the example, 1000-1100-00. If this is the case, the segment lengths revert to three characters.

4. Select **Account Format Setup**, and then click **Insert**.
5. Click **Reconcile**, and then print the error log to the screen.

    > [!NOTE]
    > The Account Index Master (GL00105) table would probably still contain the accounts that use the account length of four characters. Therefore, you have to rebuild the table by using SQL Maintenance.

6. Open the SQL Maintenance window. To do this, on the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **SQL**.

7. Select the company database, and then select **Microsoft Dynamics GP** under **Product**.

8. Select the Account Index Master table under **Financial Series**.

9. Click to select all the check boxes, and then click **Process**.

    > [!NOTE]
    > After the GL00105 table is re-created, you have to restore the data by using Check Links.

10. Open the Check Links window. To do this, on the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.

11. Select **Financial** as the **Series**, and then insert the Account Master logical tables.

12. Click **OK** to start the process.

    > [!NOTE]
    > The information found in the Account Master (GL00100) table should now populate the GL00105 table.

### Resolution 5

1. Open SQL Server Management Studio.
2. In a query window, run this script against the company database:

    ```sql
    Delete GL00105
    ```

3. Open Microsoft Dynamics GP. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.

4. Select **Financial series**.

5. In the **Logical Tables** list, click to select **Account Master**. Click **Insert**.

6. Then click **OK** to run check links. Print the Error Log to the screen.

7. Test again.

### Resolution 6

You may need to set up additional divisional RE accounts with blank segments to account for "unit accounts" to be able to close successfully. (View the structure of your unit accounts compared to how your Divisional RE accounts should look and what segment you are closing to.) A quality issue has been logged for this as the system should not be looking at unit accounts during the RE process.

---
title: The Bin field and Quantity Selected field are unavailable in the Bin Quantity Entry window
description: Describes an issue that occurs if the MOP_Bin_Issue table (MOP1027) contains an invalid-quantity unposted entry. Provides a resolution.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
---
# The "Bin" field and the "Quantity Selected" field are unavailable in the "Bin Quantity Entry" window when you enter a "Reverse Issue" transaction in Manufacturing in Microsoft Dynamics GP or Microsoft Great Plains

This article provides a solution to an issue where the **Bin** field and the **Quantity Selected** field are unavailable in the **Bin Quantity Entry** window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918952

## Symptoms

When you enter a Reverse Issue transaction in Manufacturing in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains, the **Bin** field and the **Quantity Selected** field are unavailable in the **Bin Quantity Entry** window.

This issue occurs when the following conditions are true:

- The **Enable Multiple Bins** check box is selected in the Inventory Control Setup window. To view this check box, point to **Setup** on the **Tools** menu, point to **Inventory**, and then click **Inventory Control**.

- There are no unposted Reverse Issue pick documents for the component or for the manufacturing order in the Component Transaction Entry window.

## Cause

This issue occurs if the MOP_Bin_Issue table (MOP1027) contains an invalid-quantity unposted entry.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that there are no unposted Reverse Issue pick documents for the component or for the manufacturing order. To do this, follow these steps:
    1. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **Component Trx Entry**.
    2. Click the lookup button next to **Manufacturing Pick Number** to open the **Manufacturing Pick Number Lookup** window.
    3. In the **Restrict to** list, click **Saved**.
    4. Review the returned pick numbers to make sure that there are no unposted Reverse Issue pick documents for the component or for the manufacturing order.

2. Back up the company database.

3. Start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.
4. In the database list, click your company database.
5. Copy the following SQL statement to the **Query** window.

    ```sql
    SELECT * FROM MOP1027 WHERE ITEMNMBR = 'xxxx' AND MANUFACTUREORDER_I = 'moxxxx'
    ```

    In this statement, replace the *xxxx* placeholder with the component item number. Replace the **moxxxx** placeholder with the manufacturing order number.

6. On the **Query** menu, click **Execute**.

7. Review the returned results. If a quantity other than 0 (zero) is displayed in the **QTYPENDING** column, note the corresponding value that is displayed in the **DEX_ROW_ID** column.

8. Copy the following SQL statement to the **Query** window.

    ```sql
    UPDATE MOP1027 SET QTYPENDING = '0' WHERE DEX_R0W_ID = 'XX'
    ```

    In this statement, replace the *XX* placeholder with the value in the **DEX_ROW_ID** column that you noted in step 7.

9. On the **Query** menu, click **Execute**.
10. Exit SQL Query Analyzer.

> [!NOTE]
> The **Bin** field and the **Quantity Selected** field in the Bin Quantity Entry window should now be available.

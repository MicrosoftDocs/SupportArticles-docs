---
title: Violation of PRIMARY KEY constraint
description: Describes a problem that occurs when you try to do the year-end closing routine in General Ledger. Resolutions are provided.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Violation of PRIMARY KEY constraint" Error message when you try to do the year-end closing routine in General Ledger in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to do the year-end closing routine in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856553

## Symptoms

When you try to do the year-end closing routine in General Ledger in Microsoft Dynamics GP, you receive the following error message:
> [Microsoft][ODBC SQL Server Driver][SQL Server]Violation of PRIMARY KEY constraint 'PKGL10110'. Cannot insert duplicate key in object 'GL10110'.

## Resolution

To resolve this problem, use the steps below:

1. Have all users exit Microsoft Dynamics GP.
2. Restore a **backup** of the company database that was made before you tried to do the General Ledger year-end closing routine.
3. Start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 20XX (XX=your version)**, and then select **SQL Server Management Studio**.
4. Run the following scripts against the company database to delete the GL Account Summary tables:

    ```sql
    DELETE GL10110
    
    DELETE GL10111
    ```

5. Run **Check Links** on the Financial Series. To do it:
    1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then select **Check Links**.
    2. In the **Series** list, select **Financial**, and then select **All** to insert all the Logical Tables to the **Selected Tables** list.
    3. Select **OK**.
6. Run reconcile for all the years in the **Year** list to rebuild the summary tables. To do it,

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Financial**, and then select **Reconcile**.
        > [!NOTE]
        > Select the **Year** check box and then select the year.
    2. Select the **Year** check box.
    3. Select the **History** option, and then select the oldest year in the **Year** list.
    4. Select **Reconcile**.
    5. Repeat steps c and d for each year that is listed in the **Year** list. Start with the oldest year, and end with the current year.
7. Do the year-end closing routine in General Ledger.

## More information

For more information, see [KB -Year-end closing procedures for General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/help/888003).

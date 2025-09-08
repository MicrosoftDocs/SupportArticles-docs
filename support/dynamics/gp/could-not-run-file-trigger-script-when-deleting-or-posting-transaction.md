---
title: Could not run file trigger script error when deleting or posting a transaction that has an Extender window associated with the transaction
description: You receive the Could not run file trigger script error message when you delete or post a transaction with an Extender window associated with the Microsoft Dynamics GP window, if you add a Work table as a Table Link to the Extender window. Provides a resolution.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# "Could not run file trigger script" error when you delete or post a transaction that has an Extender window associated with the transaction

This article provides a resolution for the issue that you can't delete or post a transaction that has an Extender window associated with the transaction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2508025

## Symptoms

If you have an Extender window linked to a transaction window and you delete the transaction or post the transaction, you receive the following error message in Microsoft Dynamics GP:

Error 1:

> Unhandled script exception:  
Invalid data for string operation: 26.
>
> EXCEPTION_CLASS_SCRIPT_BAD_TYPE  
SCRIPT_CMD_ADD

Error 2:

> Could not run file trigger script.

## Cause

This issue occurs because there is a Work table link that is linked to the Extender Window. We do not recommended that you use Work tables with an Extender Table Link because if the transaction is posted, the Extender data will be deleted.

## Resolution

To resolve these errors, go into Microsoft Dynamics GP and follow these steps.

1. Select **Tools**, select **Extender**, and then select **Extender**.
2. In the Extender Object area, select **Window**, and then select the Extender window in which is linked to your transaction window that you are receiving the error.
3. In the Extender Window, select the **Options** menu.
4. Select **Table Links**.
5. In the Table Links window, select the work table in the Table Links section.
6. Select the **Remove Selected Table Link** icon, the **-** icon.
7. Select **Delete** to remove the Table Link.
8. Select **Save** in the Extender Windows.
9. Exit Microsoft Dynamics GP and start back into Microsoft Dynamics GP.
10. Delete your transaction.

## More information

If you still receive the **Could not run file trigger script**, check the EXT44200 and EXT44300 tables for your Extender Window ID. Run the following SQL script (Replace XXX with your Extender Window ID) to verify that your Extender Window does not exist in the tables:

```sql
select * from EXT44200 where Extender_ID = 'XXX'
select * from EXT44300 where Extender_ID = 'XXX'
```

---
title: Error when entering Transactions in Project Accounting
description: This article provides a resolution for the problem that occurs when you enter a transaction in Project Accounting in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Project Accounting
---
# Error (Violation of PRIMARY KEY Constraint XXXXXXXX. Cannot Insert Duplicate Key in object XXXXXXXX) when entering Transactions in Project Accounting in Microsoft Dynamics GP

This article helps you resolve a problem that occurs when you enter a transaction in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 859302  

## Symptoms

When you enter a transaction in Project Accounting in Microsoft Dynamics GP, you receive the following errors.

> [Microsoft][ODBC SQL Server Driver][SQL Server]Violation of PRIMARY KEY constraint "XXXXXXXX". Cannot insert duplicate key in object "XXXXXXXX".  
[Microsoft][ODBC SQL Server Driver][SQL Server] Violation of PRIMARY KEY constraint "XXXXXXXX". Cannot insert." occurs when entering Transactions.

> [!NOTE]
> XXXXXXXX in the above error couldbe PA00511, PA01121, PA01221 and/or PA01304.

## Resolution

This error is a result of missing periodic records. Typically, when periodic records are created, they are created for an entire Fiscal Year. For some reason, only a portion of the periodic records for this Contract/Project/Budget exists. It is trying to insert the whole years worth of periodic records again. Since part of the year already exists, this error regarding duplicates is being generated.

To resolve the error, the missing periodic records need to be created. To create the missing periodic records, perform the following steps:

1. Have all users exit the application.

2. Make a BACKUP of the database that can be restored in case an undesired data loss occurs.

3. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, and then click **PA Recreate Periodic**.

4. If this is happening for a limited number of customers, select a customer range. If it is random or all customers, do not enter a customer range.

5. Leave the options set to **Recreate Periodics** and click **Process**.

6. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Project**, and then click **PA Reconcile Periodic**.

7. Enter customer range (if needed) and click **Process**.

    > [!NOTE]
    > Both the recreate and reconcile periodic processes can be very intense and may take a while to process. The best indication of performance is past performance. Please allocate sufficient time for the processes to complete.

---
title: Error when you post in General Ledger in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you post in General Ledger in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
ms.custom: sap:Financial - General Ledger
---
# Error message when you post in General Ledger in Microsoft Dynamics GP: Arithmetic overflow error for data type smallint, value = 35001

This article provides a solution to an error that occurs when you post in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2443620

## Symptoms

When posting in General Ledger (GL) or posting through to GL in a sub-module, you receive the following error:

> [Microsoft][SQL Native Client][SQL Server]Arithmetic overflow error for data type smallint, value = 35001.

> The stored procedure aagDelSubledgerHdr returned the following results: DBMS: 220, Microsoft Dynamics GP: 0.

## Cause

The @HdrID variable is beting set to a 0 which the stored procedure aaDelSubledgerHdr then interprets that it should pass a value of 35001. Because the data type on the field is set to a small integer, the 35001 value exceeds the 32767 value allowed by a small integer data type. This causes an overflow error message, but most users don't actually get the message because the default SQL settings have the arithmetic abort option disabled. If the customer has one of the arithmetic abort options enabled, then the above error messages will display in Microsoft Dynamics GP.

## Resolution

Check to see if the **Arithmetic Abort Enable** option is marked or enabled at the company level or the server level in SQL Server Management Studio as follows:

1. Open SQL Server Management Studio. To do this, follow the appropriate method below:

    If you are using SQL Server 2008, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

    If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    If you are using SQL Server 2000, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

2. In the Object Explorer margin, right-click on the company database name and select **Properties**.

3. Click on **Options** section listed in the top-left margin.

4. In the options section at the right, you will find a section called  **Miscellaneous**.

5. Scroll down to find a parameter called **Arithmetic Abort Enable**. By default the setting is set to **False (Off)**. If you find it **True (On)**, then set it to be **FALSE (Off)**.

6. Click **OK**. (If you made a change in step 5, then restart Microsoft Dynamics GP and test again. If not, then proceed to the next step.)

7. In the Object Explorer margin, right-click on the **Server Instance** and select **Properties**.

8. Click on **Connections** in the top-left margin.

9. In the **Default connection options:** section, verify that arithmetic abort isn't marked.

10. Click **OK**. Restart Microsoft Dynamics GP and test again.

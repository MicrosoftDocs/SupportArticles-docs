---
title: How to import Excel spreadsheets into General Ledger
description: This article describes how to import a budget using Excel-Based Budgeting.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# How to import Excel spreadsheets into Microsoft Dynamics GP General Ledger

This article describes how to import a budget to Microsoft Dynamics GP or to Microsoft Business Solutions - Great Plains 8.0 by using Excel-Based Budgeting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866372

When you import a budget to Microsoft Dynamics GP, the budget must be in the following format:

- Column A must be the account.
- Column B must be the description.
- Column C must be the beginning balance.
- Column D and the following columns must be your periods.
- You must include the column headings in Row 3.

You do not have to have descriptions in the **Description** column. But you must have data in all the other columns. You do not have to have a **Total** column for Microsoft Excel to import correctly.

> [!NOTE]
>
> - You must use the same account separator in Excel that is used in Microsoft Dynamics GP. If a different separator is used, you can import data, but the data will not appear.
> - Data is rounded to two decimal positions by cell. For example, if you have period 4 as 500.143 and period 5 as 500.143, the total of the two columns in Excel will be 1000.29. The total of the two columns in Microsoft Dynamics GP will be 1000.28.
> - Blank data or string characters are interpreted as 0 in Microsoft Dynamics GP. A number that is entered as a string in Excel will appear as that number in Microsoft Dynamics GP.
> - You can import a budget even if all the accounts are not created in Microsoft Dynamics GP. The import will be successful, and the existing accounts will be able to see their budget information.  
> However, if you import to an account that does not exist and then add that account later, you will be unable to see the account's budgeted data.
> - Microsoft Dynamics GP will pick up two decimal positions regardless of the format in Excel.

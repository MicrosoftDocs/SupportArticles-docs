---
title: Information about the Check Links process
description: Provides information about the Check Links process in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Information about the Check Links process in Microsoft Dynamics GP

This article contains information about the Check Links process in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850391

## More information

We recommend that you run the Check Links process after the Rebuild process is complete. The Check Links process analyzes the relationships between physical files to find data that exists in one file but is missing from other files. The Check Links process makes sure that the appropriate records or links exist in a logical file group. If they do not exist in a logical file group, the process adds them.

When you run the Check Links process, one of the physical files in the logical file group is designated as the main file. The data in this main file is used to update the other related physical files within the logical file group. The Check Links process runs as a background task. Therefore, other users can continue to work in any company other than the company on which the Check Links process is running.

A report is printed after the Check Links process is complete regardless if data is missing. If data is missing and if it can be replaced, the data is replaced automatically. The report will contain the information about what data was replaced.

Many of the Check Links processes add a comment that resembles the following:

> Checklinks *XXXX* Comment to the file that was checked.

> [!NOTE]
> The XXXX placeholder represents the file that was checked.

## General Ledger logical files

The following examples show which files are affected when the Check Links process runs in each type of Microsoft Dynamics GP logical file.

### Account Master file

The Account Master file is used as the main file against which the other physical files are checked. If you have an account in the Account Master file, the file for this account does not have to exist in the Account Summary file. However, if you have an account in the Account Summary file, the file for this account must exist in the Account Master file. Additionally, if you have an account in the Account Master file, the file for this account must exist in the Account Index Master file.

### Budget Master file

The Budget Master file is used as the main file against which the other physical files are checked. The Check Links process checks whether a Budget ID exists in the Budget Summary Master file. If a Budget ID exists in the Budget Summary Master file, the Budget ID must exist in the Budget Master file. However, if you have a Budget ID in the Budget Master file, this Budget ID does not necessarily have to exist in the Budget Summary Master file.

### Financial Setup file

The Check Links process verifies that the following is true:

- Each record in the Financials Layouts Setup file has a corresponding header record in the Financials Setup file.
- Each record in the Financials Header and in the Footer Setup file has a corresponding header record in the Financials Setup file.
- Each record in the Financials Column Setup file has a corresponding header record in the Financials Setup file.
- Each record in the Financials Column Infix Calculation Setup file has a corresponding header record in the Financials Setup file.
- Each record in the Financials Column Infix Calculation Setup file has a corresponding column header record in the Financials Setup file.
- Each record in the Financials Column Postfix Calculation Setup file has a corresponding header record in the Financials Setup file.
- Each record in the Financials Column Postfix Calculation file has a corresponding column header record in the Financials Column Setup file.
- Each record in the Financials Row Setup file has a corresponding header record in the Financials Setup file.
- Each record in the Financials Row Range Setup file has a corresponding row header record in the Financials Setup file.
- Each record in the Financials Row Range Setup file has a corresponding row header record in the Financials Row Setup file.
- Each record in the Financials Row Totals Setup file has a corresponding row header record in the Financials Setup file.
- Each record in the Financials Row Totals Setup file has a corresponding row header record in the Financials Row Setup file.

### Quick Journal Setup file

The Check Links process verifies that each record in the Quick Journal Account Setup file has a corresponding header record in the Quick Journal Setup file.

### Quick Journal Work file

The Check Links process verifies that each record in the Quick Journal Amounts Work file has a corresponding header record in the Quick Journal Work file.

### Transaction Work file

The Check Links process verifies that each record in the Transaction Amounts Work file has a corresponding header record in the Transaction Work file. Additionally, the process verifies that each record in the Transaction Clearing Amounts Work has a corresponding header record in the Transaction Work file.

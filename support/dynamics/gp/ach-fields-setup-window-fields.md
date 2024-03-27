---
title: Fields in the ACH Fields Setup window in Microsoft Dynamics GP
description: You can use the ACH Fields Setup window to enter basic information about the files that banks use to make fund transfers to employees.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# Description of the fields in the ACH Fields Setup window in Microsoft Dynamics GP

This article describes each field in the ACH Fields Setup window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865563

You can use the ACH Fields Setup window to enter basic information about the files that banks use. Banks use these files to make fund transfers to employees. The following fields are in the ACH Fields Setup window.

> [!NOTE]
> You may have to contact the bank to obtain many of the numbers for the fields.

- **Company Identification**: This field contains the 10-digit company ID.
- **Name**: This field contains the name of the company.
- **Immediate Origin**: This field contains the routing number of the bank or of the credit union that's sending the file.
- **Name**: This field contains the name of the bank or the name of the credit union.
- **Immediate Destination**: This field contains the routing number of the bank or of the credit union that's receiving the file.
- **Name**: This field contains the name of the financial institution.
- **Originating Institution**: This field contains the routing number of the originating financial institution. If the routing number is too long, you can omit the first zero.
- **Discretionary Data**: Leave this field blank unless you're otherwise advised by the financial institution.
- **Description**: The text that's entered here appears on employee statements.
- **Identify Employee By**: This field determines which employee ID is used in the ACH file.
- **Include Auto-Settle Line**: Select this column if you want to include the debit line, and if you want to balance the ACH file.
- **Routing Number (ASL)**: This field contains the routing number for the Auto-Settle line.
- **Account Number (ASL)**: This field contains the payroll account number for the company.
- **Account Type (ASL)**: This field contains the type of account that's used for the company's payroll.
- **Company Name (ASL)**: This field contains the name of the company.
- **ACH File Location**: This field contains the physical location of the ACH file on the computer system.
- **Next ACH Filename**: This field contains the name of next ACH file that's generated.
- **Increment ACH Filename**: Select this column if you want the system to generate a file name every time that you create an ACH file.

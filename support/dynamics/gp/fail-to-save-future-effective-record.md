---
title: Error when you save a future effective record in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you save a future effective record in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: dbader
ms.date: 03/31/2021
---
# Error when you save a future effective record in Microsoft Dynamics GP: "Unhandled script exception: Illegal address for field 'APR GoTo' in script 'Accounting_Trigger'. Script terminated"

This article provides a solution to an error that occurs when you save a future effective record in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 945201

## Symptoms

When you save a future effective record in the Deduction Setup (FUTURE EFFECTIVE) window or in the Benefit Setup (FUTURE EFFECTIVE) window in Microsoft Dynamics GP, you receive the following error message:

> Unhandled script exception: Illegal address for field 'APR GoTo' in script 'Accounting_Trigger'. Script terminated. EXCEPTION_CLASS_SCRIPT_ADDRESSING SCRIPT_CMD_LOAD_ATSI12

## Cause

This problem occurs if you do not have security set to the HRM Solution Series windows after you install Advanced Human Resources and Payroll in Microsoft Dynamics GP.

## Resolution

To resolve this issue, set security to the Alternate Dynamics GP Windows.

### Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** list, click an ID.
3. In the **Product** list, click **HRM Solution Series**.
4. In the **Type** list, click **Windows**.
5. Expand the **Payroll** folder.
6. Expand the **Benefit Setup** folder.
7. Click to select **HRM Solution Series**.
8. Expand the **Deduction Setup** folder.
9. Click to select **HRM Solution Series**.
10. Expand the **Employee Deduction Setup** folder.
11. Click to select **HRM Solution Series**.
12. Click **Save**.

### Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **Setup**, point to **System** and click **Security**. If you are prompted to Advanced Security, click **No**.
2. In the **User ID** list, click a user ID.
3. In the **Company** list, click a company.
4. In the **Product** list, click **HRM Solution Series**.
5. In the **Type** list, click **Alternate Dynamics GP Windows**.
6. In the **Series** list, click **Payroll**.
7. Verify that the following windows are selected:
   - **Benefit Setup**  
   - **Deduction Setup**  
   - **Employee Deduction Maintenance**

    > [!NOTE]
    > an asterisk appears next to the window name if it is selected. If an asterisk does not appear next to the window name, double-click to select the window name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

---
title: Use Report Writer to create calculated field to mask the social security number
description: Describes how to block out the social security number on an employee checks report.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# How to use Report Writer in Microsoft Dynamics GP 9.0 to create a calculated field to mask the social security number on the Employee Checks report and on the "Direct Deposit Statement of Earnings" report

This article describes how to use Report Writer in Microsoft Dynamics GP 9.0 to create a calculated field to mask the social security number on the Employee Checks report and on the "Direct Deposit Statement of Earnings" report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 935619

To create a calculated field to mask the social security number on the Employee Checks report or on the "Direct Deposit Statement of Earnings" report, follow these steps.

> [!NOTE]
> The following example uses the employee check stub on the Top-D report.

## Step 1: Open the report

1. On the **Tools** menu, click **Customize**, and then click **Report Writer**.
2. Click **Microsoft Dynamics GP**, and then click **OK**.
3. Click **Reports**.
4. In the **Modified Reports** list, click the report, and then click **Open**.

> [!NOTE]
>
> - If the report is not in the **Modified Reports** list, click the report in the **Original Reports** list, and then click **Insert**. Then, perform step 4.
> - You can follow these steps to modify any Employee Checks report that uses the **Social Security Number** field.

## Step 2: Create a calculated field

1. In the Report Definition window, click **Layout**.
2. In the Toolbox window, click **Calculated Fields**, and then click **New**.
3. In the **Name** field, type *SSN*.
4. In the **Result Type** list, click **String**.
5. In the **Expression Type** area, click **Calculated**.
6. Click the **Constants** tab, and then click **String** in the **Type** list.
7. In the **Constant** field, type the text that you want to mask the social security number. For example, type \***-\**-, or type XXX-XX-.
8. Click **Add**.
9. In the **Operators** area, click **CAT**.
10. Click the **Functions** tab.
11. Click **User-Defined**, and then click **System** in the **Core** list.
12. In the **Function** list, click **RW_Substring**, and then click **Add**.
13. Click the **Fields** tab.
14. In the **Resources** list, click **Payroll Work Check**.
15. In the **Field** list, click **Social Security Number**, and then click **Add**.
16. Set the first character of the substring. Then, set the length of the substring. When you add the **Social Security Number** field, use the constant integer 6 and the constant integer 4, respectively. To do this, follow these steps.

    > [!NOTE]
    > You must add this information when you use the RW_Substring function.

    1. Click the **Constants** tab.
    2. In the **Type** list, click **Integer**.
    3. In the **Constant** field, type 6, and then click **Add**.
    4. In the **Constant** field, type 4, and then click **Add**.

    The calculated expression that you create resembles the following:

    "XXX-XX-" # FUNCTION SCRIPT( RW_Substring UPR_WORK_Check.Social Security Number 6 4)

17. To save the calculated field, click **OK**.

## Step 3: Add the calculated field to the report

1. In the **Body** section of the report, delete the **Social Security Number** field.
2. In the Toolbox window, click **SSN** in the **Resources** list.
3. Drag **SSN** to the **Body** section of the report.
4. You can change the size of the font in the report. To do this, click **Drawing Options** on the **Tools** menu.

## Step 4: Save the modified report

1. Close the report.
2. When you are prompted to save the changes, click **Save**.
3. In the Report Definition window, click **OK**.
4. On the **File** menu, click **Microsoft Dynamics GP**.

### Step 5: Assign security permissions to the modified report

- Method 1: By using the Advanced Security tool

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
    2. If you are prompted, type the system password.
    3. Click **View**, and then click **by Alternate, Modified and Custom**.
    4. Expand **Microsoft Dynamics GP**.
    5. Expand **Reports**, expand **Payroll**, and then click one of the following items:
       - **Direct Deposit Statement of Earnings**  
       - **Employee Checks**
    6. Click **Microsoft Dynamics GP (Modified)**.
    7. Click **Apply**, and then click **OK**.

        > [!NOTE]
        > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are applied only to the current user and to the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can also select additional companies in the **Company** area of the Advanced Security window.

- Method 2: By using Microsoft Dynamics GP security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
    2. If you are prompted, type the system password.
    3. In the **User ID** list, click the user ID of the user who will access the report.
    4. In the **Type** list, click **Modified Reports**.
    5. In the **Series** list, click **Payroll**.
    6. In the **Access List** list, double-click **Direct Deposit Statement of Earnings** or **Employee Checks**. Then, click **OK**.

        > [!NOTE]
        > After you click **OK**, an asterisk appears next to the report name.

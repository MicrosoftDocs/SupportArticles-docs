---
title: Change amount is incorrect when you run the Historical Trial Balance report
description: This article provides a workaround for the problem that occurs when you run the Historical Trial Balance report in Microsoft.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# The net change amount is incorrect when you run the Historical Trial Balance report in Microsoft

This article helps you work around the problem that occurs when you run the Historical Trial Balance report in Microsoft.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 863465

## Symptoms

When you run the Historical Trial Balance report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, the net change amount is incorrect. This problem occurs if the value in the **Subtotal By** field is **Period**.

When this problem occurs, the net change amount in the report does not match the net change amount in the Historical Summary window.

## Workaround

To work around this problem, follow these steps.

### Step 1: Change the Net Change Sub field by using the Report Writer

To do this, follow these steps:

1. Print the report again by setting the report destination to **Screen**.
2. In the report, click **Modify** to open the Report Writer.
3. In the Report Layout window, double-click in the **Net Change Sub** field in the **F2** section.
4. In the Reports Field Options window, click **Last Occurrence** in the **Display Type** pane.
5. Close the Report Layout window, and then click **Yes** when you are prompted to save the changes.
6. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

### Step 2: Grant access to the report

If you use Microsoft Dynamics GP 10.0, follow these steps:

1. Create an identifier (ID) to print the changed report. To do this, follow these steps:
    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**. If you are prompted for the system password, type the system password.
    1. In the Alternate/Modified Forms and Reports window, enter the identifier in the **ID** field, and then type a description in the **Description** field.
    1. In the **Product** list, click **Microsoft Dynamics GP**.
    1. In the **Type** list, click **Reports**.
    1. Expand **Financial**, expand **Trial Balance History Per Period**, and then click **Microsoft Dynamics GP (Modified)**.
    1. Click **Save**.
2. Assign the security to print the changed report to the ID. To do this, follow these steps:
    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**. If you are prompted for the system password, type the system password.
    1. In the **User** field, enter the user account that you use.
    1. In the **Company** field, enter the company that you use.
    1. Click the drop-down arrow in the **Alternate/Modified Forms and Reports ID** field, and then click the ID that you created in step 1.
    1. Click **Save**.

If you use Microsoft Dynamics GP 9.0 or Microsoft Great Plains 8.0, use one of the following methods.

#### Method 1: Use the Advanced Security tool

To use this method, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. If you are prompted for the system password, type the system password.
2. Click **View**, and then click **by Alternate, Modified and Custom**.
3. Expand **Microsoft Dynamics GP** or **Microsoft Great Plains**, expand **Reports**, and then expand **Financial**.
4. Expand the **Trial Balance** node that you changed.
5. Click **Microsoft Dynamics GP (Modified)** or click **Microsoft Great Plains (Modified)**.
6. Click **Apply**, and then click **OK**.

> [!NOTE]
> By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

#### Method 2: Use the Standard Microsoft Dynamics GP Security tool

To use this method, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. If you are prompted for the system password, type the system password.|
2. In the **User ID** list, click the user ID for the user who you want to have access to the report.
3. In the **Type** list, click **Modified Reports**.
4. In the **Series** list, click **Financial**.
5. In the **Access List** box, double-click the report that you changed, and then click **OK**.</br></br>When you do this, an asterisk (*) appears next to the report name.

## Steps to reproduce the problem

1. On the **Inquiry** menu, point to **Financial**, and then click **History Summary**.
2. In the **Account** field, enter **000-1100-00**.
3. In the **Year** list, click a historical year. For example, click **2000**.
4. Notice the listed net changes.
5. On the **Reports** menu, point to **Financial**, and then click **Trial Balance**.
6. In the **Reports** list, click **Detailed**.
7. In the **Options** pane, click the option that you want to use, and then click **Modify**.
8. In the Trial Balance Report Options window, click to select the **Posting Accounts** check box under **Include**, click **History** in the **Year** pane, set the historical year that you use, and then click **Period** in the **Subtotal By** field.
9. Set segment 1 of the report to **000**, set segment 2 of the report to **1100**, and then set segment 3 of the report to **00**.
10. Click **Print**.
11. Compare the net changes in the report with the net changes in the History Summary Inquiry window that you noticed in step 4.</br></br>When you do this, you may notice that the net change for the period that you selected is equal to the first recorded journal entry amount of the next period.

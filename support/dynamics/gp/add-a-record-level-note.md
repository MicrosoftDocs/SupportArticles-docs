---
title: Add a record-level note
description: Describes how to add a record-level note for the Voucher No. field to the PM Paid Transaction History Detail report.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add a record-level note to the "PM Paid Transaction History Detail" report in Microsoft Dynamics GP

This article describes how to add a record-level note for the **Voucher No.** field to the PM Paid Transaction History Detail report. This record-level note can be added in the Payables Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925972

## Introduction

Although this article specifically describes how to add a record-level note to the PM Paid Transaction History Detail report, you can follow these steps to add a record-level note for the **Voucher No.** field in any report that uses the PM_Paid_Transaction_HIST table.

## Step 1: Back up and then open Report Writer

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    1. If you're prompted for the password, type the system password.
    1. Use the appropriate step:
        - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window. Note the path that appears in the **Reports** box.
    1. Select **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.

## Step 2: Create the table relationship

1. In Report Writer, select **Tables**, and then select **Tables**.
2. Select **PM_Paid_Transaction_HIST**, and then select **Open**.
3. Select **Relationships**.
4. Select **New**.
5. Select the ellipsis button (...), select **Record Notes Master**, and then select **OK**.
6. Select the **Secondary Table Key** list, and then select **SY_Record_Notes_MSTR_Key_1**.
7. Select the **Primary Table** list, select **Note Index**, and then select **OK**.
8. Close the Table Relationship window. In the Table Relationship Definition window, select **OK**, and then close all windows.

## Step 3: Open and then modify the report

1. Select **Reports** to open the Report Writer window.
2. In the **Original Reports** list, select **PM Transaction History Detail**, and then select **Insert**.
3. In the **Modified Reports** list, select **PM Transaction History Detail**, and then select **Open**.
4. In the **Report Definition** window, select **Tables**.
5. Select **PM Paid Transaction History File**, and then select **New**.
6. Select **Record Notes Master**, select **OK**, and then select **Close**.
7. In the **Report Definition** window, select **Layout**.
8. In the **Toolbox** list, select **Record Notes Master**.
9. Drag the **Text Field** field from the Toolbox window to the **H1** section of the report.
10. Close the report layout. When you're prompted to save your changes, select **Save**.

## Step 4: Exit Report Writer

1. In the Report Definition window, select **OK**.
2. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

## Step 5: Grant security to the modified report

**Method 1**: Use Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. Type the system password if you're prompted.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
4. Expand the following nodes:- **Reports** - **Purchasing** - **PM Transaction History Detail**  
5. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.
6. Select **Apply**, and then select **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the Advanced Security window.

**Method 2**: Use standard Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you're prompted, type the system password.
2. In the **User ID** list, select the user ID for the user to whom you want to grant access.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Purchasing**.
5. In the **Access List** box, double-click **PM Transaction History Detail**, and then select **OK**.
    > [!NOTE]
    > An asterisk appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

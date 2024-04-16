---
title: Add the purchase order number
description: Describes how to add the purchase order number to the Open Sales Order report in Microsoft Dynamics GP.
ms.reviewer: theley, kfrankha, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to add the purchase order number to the Open Sales Order report in Microsoft Dynamics GP

This article describes how to add the purchase order number to the Open Sales Order report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929603

## Introduction

To add the purchase order number to the Open Sales Order report in Microsoft Dynamics GP, follow these steps.

## Step 1: Back up and then open the report

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    1. If you're prompted for the password, type the system password.
    1. Use the appropriate step:
        - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.
    1. The path that appears in the **Reports** box.
    1. Select **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.

## Step 2: Create the table relationship

1. Start Report Writer. To do it, select **Tools**, point to **Customize**, and then select **Report Writer**.
2. Select **Tables**, and then select **Tables**.
3. Select **SOP_LINE_WORK**, and then select **Open**.
4. Select **Relationships**, and then select **New**.
5. Select the ellipsis button (...) next to the **Secondary Table** field.
6. Select **SOP_POPLink**, and then select **OK**.
7. Select **SOP_POPLinkidxSO** in the **Secondary Table Key** list.
8. Select **SOP Type** in the **SOP Type** list.
9. Select **SOP Number** in the **SOP Number** list.
10. Select **Line Item Sequence** in the **Line Item Sequence** list.
11. Select **Component Sequence** in the **Component Sequence** list, and then select **OK**.
12. Close the Table Relationship window, select **OK** in the **Table Definition** window, and then close the Tables window.
13. Select **Reports**.
14. Select **SOP Activity Order Detail Report** in the **Original Reports** area, and then select **Insert**.
15. Select **SOP Activity Order Detail Report** in the **Modified Reports** area, and then select **Open**.
16. In the **Report Definition** window, select **Tables**.
17. Select **Sales Transaction Amounts Work**, and then select **New**.
18. In the **Related Tables** window, select **SOP_POPLink**, and then select **OK**.
19. Close the Report Table Relationships window.
20. Select **Layout** to open the report layout.
21. Select **SOP_POPLink** in the toolbox list.
22. Drag the **PO Number** field into the H4 section of the report.
23. Close the report layout.
24. When you're prompted to save the changes, select **Save**.

## Step 3: Exit Report Writer

Use the appropriate step:

- In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** on the **File** menu.
- In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

> [!NOTE]
> To print this report, select **Sales** on the **Reports** menu, select **Activity**, and then select **Sales Open Order** in the **Reports** list. The report that prints is the Sales Open Order Report.

## Step 4: Grant security to the modified report

**Method 1**: By using Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. Type the system password if you're prompted.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand Microsoft Dynamics GP.
    - In Microsoft Business Solutions - Great Plains 8.0, expand Great Plains.
4. Expand the following nodes:
    - Reports
    - Sales
    - SOP Activity Order Detail Report
5. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.
6. Select **Apply**, and then select **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users in the **User** area of the Advanced Security window. You can select additional companies in the **Company** area of the Advanced Security window.

**Method 2**: By using Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
    > [!NOTE]
    > If you're prompted to type the system password, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Sales**.
5. In the **Access List** box, double-click **SOP Activity Order Detail Report**, and then select **OK**.

    > [!NOTE]
    > After you select **OK**, an asterisk appears next to the report name.

---
title: Print the Short Description field for an item on the POP Purchase Order Blank Form
description: Describes how to print the Short Description field for an item on the POP Purchase Order Blank Form in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to print the "Short Description" field for an item on the "POP Purchase Order Blank Form" in Microsoft Dynamics GP

This article describes how to print the Short Description field for an item on the POP Purchase Order Blank Form in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926391

To print the "Short Description" field for an item on the POP Purchase Order Blank Form, follow these steps.

## Step 1: Back up and then open the report

1. Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    2. If you are prompted for the password, type the system password.
    3. Use the appropriate step:

        - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.- In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    4. Note the path that appears in the **Reports** box.
    5. Click **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.

## Step 2: Create the table relationship

1. In Report Writer, click **Tables** on the toolbar, and then click **Tables**.
2. Click **popPOLineRollupTemp**, and then click **Open**.
3. Click the **Relationships** button.
4. Click **New**.
5. Click the ellipsis button (...), click **Item Master**, and then click **OK**.
6. Click the **Secondary Table Key** list, and then click **IV_Item_MSTR_Key1**.
7. In the **Relationship** area, match the **Item Number** field to the **Item Number** field.
8. Click **OK**, and then close all windows.

## Step 3: Add the Short Description field to the report

1. Click **Reports** to open Report Writer.
2. In the **Original Reports** list, click **POP Purchase Order Blank Form**, and then click **Insert**.
3. In the **Modified Reports** list, click **POP Purchase Order Blank Form**, and then click **Open**.
4. In the **Report Definition** window, click **Tables**.
5. Click **Purchase Order Line Rollup Temp**, and then click **New**.
6. Click **Item Master**, click **OK**, and then click **Close**.
7. In the **Report Definition** window, click **Layout**.
8. In the **Toolbox** window, click **Item Master**.
9. Drag the **Item Short Name** field into the **H4** section of the report.
10. Close the report layout.
11. When you are prompted to save your changes, click **Save**.

## Step 4: Exit Report Writer

1. In the **Report Definition** window, click **OK**.
2. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

## Step 5: Grant security to the modified report

- Method 1: By using Advanced Security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. Type the system password if you are prompted.
    2. Click **View**, and then click **by Alternate, Modified and Custom**.
    3. Use the appropriate step:

        - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
        - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
    4. Expand the following nodes:

        - **Reports**
        - **Purchasing**
        - **POP Purchase Order Blank Form**
    5. Use the appropriate step:

        - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.

    6. Click **Apply**, and then click **OK**.

        > [!NOTE]
        > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users and companies in the **Company** area and in the **User** area of the Advanced Security window.

- Method 2: By using standard Microsoft Dynamics GP security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. If you are prompted, type the system password.
    2. In the **User ID** list, click the user ID for the user to whom you want to grant access.
    3. In the **Type** list, click **Modified Reports**.
    4. In the **Series** list, click **Purchasing**.
    5. In the **Access List** box, double-click **POP Purchase Order Blank Form**, and then click **OK**.

        > [!NOTE]
        > An asterisk appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

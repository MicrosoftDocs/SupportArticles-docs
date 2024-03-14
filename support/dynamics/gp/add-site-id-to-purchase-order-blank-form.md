---
title: Add the Site ID field to the Purchase Order Blank Form
description: Describes how to add the Site ID field to the Purchase Order Blank Form in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to add the Site ID field to the Purchase Order Blank Form in Microsoft Dynamics GP

This article describes how to add the Site ID field to the POP Purchase Order Blank Form in Report Writer in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857146

## Add the Site ID field to the POP Purchase Order Blank Form

To add the Site ID field to the POP Purchase Order Blank Form in Report Writer, follow these steps:

1. If you changed any reports in Microsoft Dynamics GP, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

    1. In Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then click **Edit Launch File**.

        In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, click **Tools**, point to **Setup**, point to **System**, and then click **Edit Launch File**.

    2. Type the password if it is necessary.
    3. In Microsoft Dynamics GP, click **Microsoft Dynamics GP** in the Edit Launch File window.

        In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Edit Launch File** window.
    4. Note the path in the **Reports** box.
    5. Click **OK** to close the Edit Launch File window.

2. Create a new table relationship in Microsoft Dynamics GP. To do this, follow these steps:

    1. In Microsoft Dynamics GP 10.0, click **Microsoft Dynamics GP**, point to **Tools**, point to **Customize**, and then click **Report Writer**.

        In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, click **Tools**, point to **Customize**, and then click **Report Writer**.

    2. In Microsoft Dynamics GP, click **Microsoft Dynamics GP** in the **Product** box, and then click **OK**.

        In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** box, and then click **OK**.
    3. Click **Tables**, and then click **Tables**.
    4. Click **popPOLineRollupTemp**, and then click **Open**.
    5. Click **Relationships**, and then click **New**.
    6. Click the ellipsis button (...).
    7. In the **Relationships Table Lookup** window, click **Purchase Order Line**, and then click **OK**.
    8. In the **Secondary Table Key** box, click **POP_POLineIdxID**.
    9. Click to match all the fields, and then click **OK**.
    10. Close all the windows. Click **Save** when you are prompted to save the changes to the table.

3. Open the report. To do this, follow these steps:

    1. Click **Reports**.
    2. In the **Original Reports** area, click **POP Purchase Order Blank Form**, and then click **Insert**.
    3. In the **Modified Reports** area, click **POP Purchase Order Blank Form,**, and then click **Open**.
    4. In the Report Definition window, click **Tables**.
    5. Click **Purchase Order Line Rollup Temp**, and then click **New**.
    6. Double-click **Purchase Order Line**.
    7. Click **Close**.

4. Add new fields to the report. To do this, follow these steps:

    1. In the Report Definition window, click **Layout**.
    2. In the **Toolbox**, click **Purchase Order Line** in the table box.
    3. Use a drag-and-drop operation to add **Location Code** to the H3 section of the report.

5. Save the modified report. To do this, follow these steps:

    1. Close the report. Click **Save** when you are prompted to save the changes to the report.
    2. In the Report Definition window, click **OK**.
    3. In Microsoft Dynamics GP, click **File**, and then click **Microsoft Dynamics GP**.

        In Microsoft Business Solutions - Great Plains 8.0, click **File**, and then click **Microsoft Business Solutions - Great Plains**.

6. Assign security permissions to the modified report.

To assign security permissions to the report, use one of the following methods.

### Method 1: Use Microsoft Dynamics GP security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate Modified Forms and Reports**.
2. In the **ID** box, type the name of the user who will print the report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand **Purchasing**.
6. Expand **POP Purchase Order Blank Form**.
7. Click **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.

### Method 2: Use Advanced Security in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

1. Click **Tools**, point to **Tools**, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. Type the password if it is necessary.
3. Click **View All**, and then click **by Alternate, modified, and Custom**.
4. In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.

    In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
5. Expand **Reports**, expand **Purchasing**, and then expand **POP Purchase Order Blank Form**.
6. In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.

    In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
7. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, the current user and the current company are selected when you start the Advanced Security tool. Any changes that you make apply only to the current user and the current company. However, you can select additional users in the **User** area of the Advanced Security window. Additionally, you can select additional companies in the **Company** area of the Advanced Security window.

### Method 3: Use Microsoft Dynamics GP security in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

1. Click **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. Type the password if it is necessary.
3. In the **User ID** box, click the user ID of the user who will view the report.
4. In the **Type** box, click **Modified Reports**.
5. In the **Series** box, click **Purchasing**.
6. In the **Access List** box, click **POP Purchase Order Blank Form**, and then click **OK**.

    > [!NOTE]
    > After you click **OK**, an asterisk appears next to the report name.

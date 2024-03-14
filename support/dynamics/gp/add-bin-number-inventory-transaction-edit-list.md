---
title: Add the bin number to the Inventory Transaction Edit List
description: This article describes how to add the bin number to the Inventory Transaction Edit List report with multiple bins enabled in Report Writer in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# Add the bin number to the Inventory Transaction Edit List report with multiple bins enabled in Report Writer in Microsoft Dynamics GP

This article describes how to add the bin number to the Inventory Transaction Edit List report with multiple bins enabled in Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 862214

## Introduction

This article describes how to add the bin number to the Inventory Transaction Edit List when multiple bins are enabled in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

## Step 1: Back up the report

If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

1. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then click **Edit Launch File**.
2. If you are prompted, type the system password.
3. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
4. Note the path that appears in the **Reports** box.
5. Click **OK** to close the Edit Launch File window.

## Step 2: Open the report

1.|Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
2. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.
3. Click **Reports**.
4. In the **Original Reports** area, click **Inventory Adjustments Edit List**, and then click **Insert**.
5. In the **Modified Reports** area, click **Inventory Adjustments Edit List**, and then click **Open**.

## Step 3: Create the table relationship

1. On the main menu, click **Tables**, and then click **Tables**.
2. Click **IV_TRX_WORK_LINE**, and then click **Open**.
3. Click **Relationships**, and then click **New**.
4. Click the ellipsis button (...) next to the **Secondary Table** field, click **Inventory Transaction Bin Quantities Work**, and then click **OK**.
5. In the **Secondary Table Key** list, click **ivTrxBinWorkIdx_ID**. Then, click **IV Document Type, IV Document Number** and **Line SEQ Number** in the **Primary Table** list.</br></br>**Note** This step links the **IV Document Number** field to the **IV Document Number** field. This step also links the **Line SEQ Number** field to the **Line SEQ Number** field in the **Relationships** table.
6. In the Report Table Relationships window, click **Close**.

## Step 4: Modify the report

1. Click **Open**, and then click **Tables**.
2. Click **Inventory Serial and Lot Number Work**, and then click**Remove**. Click **OK** when you are prompted to continue.|
3. Click **Inventory Transaction Amounts Work**, and then click **New**.
4. Click **Inventory Transaction Bin Quantities Work**, and then click **OK**.
5. Click **Close**.
6. Click **Restrictions**, and then click **Serial**.
7. Click **Delete**. Click **Yes** when you are prompted to delete.
8. Click **New**, and then type Bin in the **Restriction Name** field.
9. In the **Report Table** list, click **Inventory Transaction Bin Quantities Work**.
10. In the **Table Fields** list, click **IV Document Number**, and then click **Add Field**.
11. In the **Operators** area, click the equal sign (**=**).
12. Click **Add Field**. The restriction resembles the following:ivTrxBinWork.IV Document Number = ivTrxBinWork.IV Document Number
13. Click **OK**, and then close the Report Restrictions window.

## Step 5: Modify a calculated field and the report layout

1. Click **Layout**.
1. In the layout, delete the following fields in the **B** section:
    - **Serial**
    - **Serial/Lot Qty**
1. In the layout, change the **Serial/Lot Number** text to **Bin Number** in the **RH** section.
1. In the toolbox, click **Calculated Fields**, click **Serial**, and then click **Open**.
1. Click in the **Calculated Expression** box, and then click **Remove**.
1. In the **Resources** list, click **Inventory Transaction Bin Quantities Work**.
1. In the **Fields** list, click **Bin**, click **Add**, and then click **OK**.
1. In the toolbox, click **Inventory Transaction Bin Quantities Work**.
1. Drag the **Bin** field and the **Qty** field to the **B** section of the layout.

## Step 6: Save the modified report

1. Close the report. Click **Save** when you are prompted to save your changes.
2. In the Report Definition window, click **OK**.|
3. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 7: Assign security permissions to the modified report

### Method 1: By using Microsoft Dynamics GP security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID of the user who will print this modified report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand the **Inventory** folder.
6. Expand the **Inventory Adjustments Edit List** folder.
7. Click **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.

### Method 2: By using the Advanced Security tool in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.</br></br>**Note** If you are prompted, type the system password.
2. Click **View**, and then click **by Alternate, Modified and Custom**.
3. Follow the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
4. Expand the following nodes:
    - **Reports**
    - **Inventory**
    - **Inventory Adjustments Edit List**
5. Follow the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
6. Click **Apply**, and then click **OK**.</br></br>**Note** By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are only for the current user and for the current company. However, you can select other users in the **User** area of the Advanced Security window. You can select more companies in the **Company** area of the Advanced Security window.

### Method 3: By using Microsoft Dynamics GP security in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.</br></br>**Note** If you are prompted, type the system password.
2. In the **User ID** list, click the user ID of the user who will access the report.
3. In the **Type** list, click **Modified Reports**.
4. In the **Series** list, click **Inventory**.
5. In the **Access List** box, double-click **Inventory Adjustments Edit List**, and then click **OK**.</br></br>**Note** After you click **OK**, an asterisk appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

---
title: How to add User Category Values to POP Purchase Order Blank Form
description: Introduces how to add the add User Category Values field to the POP Purchase Order Blank Form report by using Report Writer in Purchase Order Processing in Microsoft Dynamics GP.
ms.reviewer: dclauson
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add User Category Values to the "POP Purchase Order Blank Form" report by using Report Writer in Purchase Order Processing

This article describes how to add the **User Category Values** field for an item to the POP Purchase Order Blank Form report in Purchase Order Processing in Microsoft Dynamics GP. You can add the **User Category Values** field by using Report Writer.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922054

To use Report Writer to add the **User Category Values** field to the POP Purchase Order Blank Form report, follow these steps.

## Back up the Reports.dic file

1. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
2. Type the system password if you are prompted to type a password.
3. Select **Microsoft Dynamics GP**. The path of the Reports.dic file is displayed in the Reports box.
4. Back up the Reports.dic file.

## Open Report Writer

1. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Customize**, and then select **Report Writer**.
    - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Customize**, and then select **Report Writer**.
2. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.

## Create a table relationship between the popPOLineRollupTemp table and the Item Master table

1. On the **Toolbar**, select **Tables**, and then select **Tables**.
2. In the Tables window, select **popPOLineRollupTemp**, and then select **Open**.
3. In the Table Definition window, select **Relationships**, and then select **New**.
4. In the Table Relationship Definition window, select the lookup button on the right of the **Secondary Table** box.

   > [!NOTE]
   > The lookup button has an ellipsis on it.
5. In the Relationship Table Lookup window, select **Item Master**, and then select **OK**.
6. In the **Secondary Table Key** list, select **IV_Item_MSTR_Key1**.
7. In the Primary Table column, select **Item Number** to match the Item Number field that is listed in the Secondary Table column.
8. Select **OK**, and then close the Table Relationship window.
9. Select **OK** to close the Table Definition window.
10. Close the Tables window.

## Open the report

1. On the toolbar, select **Reports**.
2. In the **Original Reports** list, select **POP Purchase Order Blank Form**, and then select **Insert**.
3. In the **Modified Reports** list, select **POP Purchase Order Blank Form**, and then select **Open**.

## Link the Item Master table to the Purchase Order Line Rollup Temp table

1. In the Report Definition window, select **Tables**, and then select **Purchase Order Line Rollup Temp**.
2. Select **New**. The Item Master table is selected in the Related Tables window.
3. Select **OK**.
4. In the Report Table Relationships window, select **Close**.

## Add the User Category Values field to the report

1. In the Report Definition window, select **Layout**.
2. In the Toolbox window, select **Item Master** in the resource list.
3. Drag the **User Category Values** field onto the H3 section of the report. The Report Field Options window opens automatically.
4. In the Report Field Options window, type 1 in the **Array Index** field.
5. Select **OK**.

   > [!NOTE]
   > You have to drag the **User Category Value** field onto the report one time for each value that you want to print. You must change the **Array Index** field to correspond to the value. For example, type 1 to print the first user category, type 2 to print the second user category.

## Save the report

1. Close the Report Layout window.
2. Select **Save** when you receive the following message:

   > Do you want to save the changes to this report layout?
3. In the Report Definition window, select **OK**.
4. On the **File** menu, select **Microsoft Dynamics GP**.

## Grant access to the report

### Method 1 - By using security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID that will print this modified report.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Reports**.
5. Expand the **Purchasing** folder.
6. Expand folder for the report you modified.
7. Select **Microsoft Dynamics GP (Modified)**.
8. Select **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **User Security**.
10. In the **User** list, select a user ID.
11. In the **Company** list, select a company.
12. In the **Alternate/Modified Forms and Reports ID** list, select the ID from step 2.

### Method 2 - By using Advanced Security in Microsoft Dynamics GP 9.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
   > [!NOTE]
   > If you are prompted to type the system password, type the system password.

2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. SelectExpand the following nodes:
    - Microsoft Dynamics GP
    - Reports
    - Purchasing
    - POP Purchase Order Blank Form
4. Select **Microsoft Dynamics GP (Modified)**.
5. Select **Apply**, and then select **OK**.

   > [!NOTE]
   > By default, the current user and the current company are selected when you start Advanced Security. Any changes that you make are for the current user and for the current company. However, you can select additional users in the Advanced Security window in the User area. You can select additional companies in the Advanced Security window in the Company area.

### Method 3 - By using Microsoft Dynamics GP 9.0 standard security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you are prompted to type the system password, type the system password.
2. In the **User ID** list, select the user ID of the user who is accessing the report.
3. In the **Type** list, select **Modified Reports**.
4. In the **Series** list, select **Purchasing**.
5. In the **Access List** box, double-click **POP Purchase Order Blank Form**, and then select **OK**. An asterisk appears next to the report name.

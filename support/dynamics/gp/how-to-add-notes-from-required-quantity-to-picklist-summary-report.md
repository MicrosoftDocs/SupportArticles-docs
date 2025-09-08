---
title: How to add notes from Required Quantity to Picklist Summary Report
description: Describes how to create a relationship between the Picklist file (MOP_Item_Master) and the MFG_Notes table.
ms.reviewer: theley, aeckman, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# How to add notes from the Required Quantity field in the Picklist window to the "Picklist Summary Report" form in Manufacturing

This article describes how to add notes to the Picklist Summary Report form in Manufacturing in Microsoft Dynamics GP. Specifically, this article describes how to add the notes from the **Required Quantity** field in the Picklist window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925325

## More information

The information that you enter in the **Notes** field is stored in the MFG_Notes (MN010000) table. You can print the notes by creating a relationship between the Picklist file (MOP_Item_Master) and the MFG_Notes table. To do this, follow these steps.

### Back up the Reports.dic file

Back up the Reports.dic file if you have any modified Microsoft Dynamics GP reports. To do this, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
2. If you are prompted for the password, type the system password.
3. In the **Edit Launch File** window, select **Manufacturing**.

    > [!NOTE]
    > Note the path that appears in the **Reports** box.
4. Select **OK** to close the **Edit Launch File** window.

### Open Report Writer

1. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
2. Select **Manufacturing** in the **Product** list, and then select **OK**.

### Create a table relationship

1. Select the **Tables** button, select **Tables**, select **MOP_Item_MSTR**, and then select **Open**.
2. Select **Relationships**, and then select **New** in the **Table Relationship** window to create a new relationship.
3. Select the ellipsis button (...) to the right of **Secondary Table**, select **MFG_Notes**, and then select **OK**.
4. Select **MFG_Notes_Index_Key1** in the **Secondary Table Key** list.
5. In the **Primary Table** list, select **MFG Note Index**, and then select **OK**.
6. Select **OK** to close each window until you are at the main Report Writer window.

### Modify the Picklist Summary report

1. On the toolbar, select the **Reports** button, select **Picklist Summary Report** in the **Original Reports** list, and then select **Insert**.
2. In the **Modified Reports** list, select **Picklist Summary Report**, and then select **Open**.
3. In the **Report Definition** window, select **Tables**, select **02.-Picklist File***, and then select **New**.
4. In the **Related Tables** window, select **MFG_Notes**, and then select **OK**. Notice that **03.-MFG_Notes** is now displayed in the **Report Table Relationships** window.
5. In the **Report Table Relationships** window, select **Close**.
6. In the **Report Definition** window, select **Layout**.
7. In the Toolbox, select **MFG_Notes**.
8. Drag the **Note Text** field to the H2 section of the report layout.
9. Close the layout window, and then select **Save** when you are prompted to save changes.

### Save the report

1. In the **Report Definition** window, select **OK**.
2. Use one of the following methods, depending on which version you are running:
   - In Microsoft Dynamics GP 9.0, 925325 **Microsoft Dynamics GP** on the **File** menu.
   - In Microsoft Business Solutions - Great Plains 8.0, select **Microsoft Business Solutions - Great Plains** on the **File** menu.

### Grant access to the report

To grant access to the report, use one of the following methods.

#### Method 1 - Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**. If you are prompted for the password, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand **Manufacturing**, expand **Reports**, expand **3rd Party**, and then expand the node for the Picklist Summary report form.
4. Select **Manufacturing (Modified)**, select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, the current user and the current company are selected when you start Advanced Security. Any changes that you make are for the current user and for the current company. However, you can select additional users in the User area of the Advanced Security window. You can select additional companies in the Company area of the Advanced Security window.

#### Method 2 - Use Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**. If you are prompted for the password, type the system password.
2. In the **User ID** list, select the user ID of the user who will access the report.
3. In the **Product** list, select **Manufacturing**.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **3rd Party**.
6. In the **Access List** box, double-click the Picklist Summary Report form that you modified, and then select **OK**. An asterisk appears next to the report name.

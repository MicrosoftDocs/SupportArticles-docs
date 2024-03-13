---
title: Add SOP information to the POP Purchase Order Blank Form in Microsoft Dynamics GP
description: Describes how to add Sales Order Processing information to the POP Purchase Order Blank Form in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add Sales Order Processing information to the POP Purchase Order Blank Form in Microsoft Dynamics GP

This article describes how to add Sales Order Processing (SOP) information to the Purchase Order Processing (POP) Purchase Order forms in Microsoft Dynamics GP.

> [!NOTE]
> You must use the SOP to POP link functionality in Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 9.0, or Microsoft Business Solutions - Great Plains 8.0 to perform the steps in this article.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917729

## Summary

This article contains step-by-step instructions for how to modify the POP Purchase Order Blank Form. To successfully modify this report, you must delete some existing tables and some existing fields from the report. You must also create new table relationships. After you create the new relationships, you can add fields from the SOP_POPLink table and from the Sales Order Processing tables to the report layout and then save the changes. Finally, you must assign security permissions to the report. Detailed instructions are included for each of these steps.

To add the SOP information to POP Purchase Order forms when you use the SOP to POP link functionality, follow these steps.

> [!NOTE]
> The following steps describe how to modify the POP Purchase Order blank form. However, you can follow these steps to modify any of the POP Purchase Order forms.

## Step 1: Start Report Writer

1. Open Report Writer.

    For Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.

    For Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.

2. In the **Product** list, click **Microsoft Dynamics GP** or **Microsoft Great Plains**, and then click **OK**.

3. Click **Reports**.

## Step 2: Remove purchasing manufacturer numbers from the report

1. In the **Report Writer** window, click **POP Purchase Order Blank Form** in the **Original Reports** list, and then click **Insert >>** to move this report to the **Modified Reports** list.
2. In the **Modified Reports** list, click **POP Purchase Order Blank Form**, and then click **Open**.
3. In the **Report Definition** window, click **Tables**.
4. In the **Report Table Relationships** window, click **Purchasing Manufacturer Numbers**, and then click **Remove**. Click **OK** if you are prompted to remove this table and its related tables.
5. Click **Close**.
6. Click **OK**.

## Step 3: Create a table relationship to the popPOLineRollupTemp table

1. Click **Tables**, and then click **Tables**.
2. In the **Tables** window, click **popPOLineRollupTemp**, and then click **Open**.
3. In the **Table Definition** window, click **Relationships**, and then click **New** in the **Table Relationship** window.
4. In the **Table Relationship Definition** window, click the ellipsis button (...) that appears next to the **Secondary table** box.
5. In the **Relationship Table Lookup** window, click **SOP_POPLink**, and then click **OK**.
6. In the **Secondary Table Key** list, click **SOP_POPLinkIdxPO**.
7. Match the fields in the **Relationship** table by selecting values from the lists in the **Primary Table** column that correspond to the items that appear in the **Secondary Table** column. For example, click **PO Number** in the **Primary Table** column to correspond with **PO Number** in the **Secondary Table** column.
8. Click **OK**, and then close all windows by clicking **OK** in each window to return to the Tables window. Or, click the **Close** button if you cannot click **OK**.

## Step 4: Create a table relationship to the SOP_POPLink table

1. In the Tables window, click **SOP_POPLink**, and then click **Open**.
2. In the Table Definition window, click **Relationships**, and then click **New** in the Table Relationship window.
3. Click the ellipsis button that appears next to the **Secondary Table** box.
4. In the Relationship Table Lookup window, click **Sales Transaction Amounts Work**, and then click **OK**.
5. In the **Secondary Table Key** list, click **SOP_LINE_WORK_Key 1**.
6. In the **Relationship** table, select values from the list in the **Primary Table** column that correspond to the values that are displayed in the **Secondary Table** column. For example:

    - Select **SOP Number** in the **Primary Table** column to correspond to the **SOP Number** in the **Secondary Table** column.
    - Select **SOP Type** in the **Primary Table** column to correspond to the **SOP Type** in the **Secondary Table** column.
    - Select **Component Sequence** in the **Primary Table** column to correspond to **Component Sequence** in the **Secondary Table** column.
    - Select **Line Item Sequence** in the **Primary Table** column to correspond to **Line Item Sequence** in the **Secondary Table** column.
7. Click **OK**.
8. Click **Close**.
9. In the Table Definition window, click **OK**.
10. Click **Close**.

## Step 5: Open the modified report

1. In Report Writer, click **Reports**.
2. In the **Modified Reports** list, click **POP Purchase Order Blank Form**, and then click **Open**.

## Step 6: Add report table relationships

1. In the **Report Definition** window, click **Tables**.
2. In the **Report Table Relationships** window, click **Purchase Order Line Rollup Temp**, and then click **New**.
3. In the **Related Tables** window, click **SOP_POPLink**, and then click **OK**.
4. In the **Report Table Relationships** window, click **SOP_POPLink**, and then click **New**.
5. In the **Related Tables** window, click **Sales Transaction Amounts Work**, and then click **OK**.
6. In the **Report Table Relationships** window, click **Sales Transaction Amounts Work**, and then click **New**.
7. In the **Related Tables** window, click **Sales Transaction Work**, and then click **OK**.
8. In the **Report Table Relationships** window, click **Close**.

## Step 7: Add a restriction to the SOP_POPLink table

1. In the **Report Definition** window, click **Restrictions**.
2. In the **Report Restrictions** window, click **New**.
3. In the **Report Restriction Definition** window, type SOP Number in the **Restriction Name** box.
4. In the **Report Table** list, click **SOP_POPLink**, click **SOP Number** in the **Table Fields** list, and then click **Add Field**. The SOP_POPLink.SOP number appears in the **Restriction Expression** box.
5. In the **Operators** area, click **=** (the equal sign button).
6. In the **Report Table** list, click **SOP_POPLink**, click **SOP Number** in the **Table Fields** list, and then click **Add Field**. The following entry appears in the **Restriction Expression** box:

    **SOP_POPLink.SOP Number = SOP_POPLink.SOP Number**
7. Click **OK**.
8. In the **Report Restrictions** window, click **MFG PO**, click **Delete**, and then click **Yes** when you are prompted to remove this restriction.
9. Click **Close**.

## Step 8: Modify the report layout

1. In the **Report Definition** window, click **Layout**.
2. On the **Tools** menu, click **Section Options**.
3. In the **Report Section Options** window, click to clear the **Body** check box.
4. In the **Additional Headers** list, click **MFG Item Header**, click **Remove**, click **Yes** when you are prompted to confirm the removal of this header, and then click **OK** to close the **Report Section Options** window.
5. In the **Toolbox** window, click **Calculated Fields** in the list that appears on the **Layout** tab.|
6. In the list of calculated fields, click **nSuppressMFGHeader**, click **Open**, click **Delete** in the **Calculated Field Definition** window, and then click **OK** when you are prompted to confirm the removal of this calculated field.
7. In the list of calculated fields, click **nSuppressMFGItem**, click **Open**, click **Delete** in the **Calculated Field Definition** window, and then click **OK** when you are prompted to confirm the removal of this calculated field.
8. In the Report Layout window, click the **sLineNumber** field in the **H3** area of the report.

    > [!NOTE]
    > This field is the first field in the H3 area of this report. Also, this is a very small field.
9. Click **Delete** to remove this field.
10. In the **Toolbox** window, leave the **Calculated Fields** option selected in the list on the **Layout** tab. Drag the **nLineNumber** field from the list of calculated fields to the location in the **H3** area of the report from which you removed the **sLineNumber** field in step 8h.
11. Modify the size and the location of the **nLineNumber** field according to your requirements.

You can now add any fields that you require from the following tables to the report layout:

- SOP_POPLink
- Sales Transaction Amounts Work
- Sales Transaction Work

## Step 9: Save the changes to the report, and then exit Report Writer

1. On the **File** menu, click **Microsoft Dynamics GP**, or click **Microsoft Business Solutions - Great Plains**.
2. Click **Save** when you are prompted to save the changes to the report layout.
3. Click **Save** when you are prompted to save the changes to the modified report.

## Step 10: Assign security permissions to the modified report

- For Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0

  - Method 1: Use the Advanced Security functionality

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**. Type the system password if you are prompted.
    2. In the Advanced Security window, click **View**, and then click **by Alternate, Modified and Custom**.
    3. Expand the following nodes:

        - Great Plains
        - Reports
        - Purchasing
    4. Expand the purchase order form that you modified.
    5. Click **Great Plains (Modified)**.
    6. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, when you start the **Advanced Security** dialog box, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional companies in the **Company Name** area and in the **User** area of the **Advanced Security** dialog box.

  - Method 2: Use standard Microsoft Great Plains security

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**. Type the system password if you are prompted.
    2. In the **User ID** list, click the user ID for the user who will have access to the modified report.
    3. In the **Type** list, click **Modified Reports**.
    4. In the **Series** list, click **Purchasing**.
    5. In the **Access List** box, double-click the report that you modified, and then click **OK**. An asterisk (*) appears next to the report name.

- For Microsoft Dynamics GP 10.0

1. Create the ID to print the modified report.

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then click **Alternate/Modified Forms and Reports**. Type the system password if you are prompted.
    2. Enter the ID and the description.
    3. In the **Product** list, select **Microsoft Dynamics GP**, and then select **Reports** in the **Type** field.
    4. Expand **Series**, and then select the **Modified Report** radio option.
    5. Click **Save**.

2. Assign the security to print the modified report.

    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then click **User Security**.
    2. Select the user ID and the company database.
    3. In the **Alternate/Modified Forms and Reports ID** field, select the ID that you created in step 1.
    4. Save the changes, and then print the report.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

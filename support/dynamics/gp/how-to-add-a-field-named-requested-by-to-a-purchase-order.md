---
title: How to add a field named Requested by to a purchase order
description: Shows you how to add a field that is named Requested by to a purchase order in Microsoft Dynamics GP.
ms.reviewer: theley, kfrankha
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to add a field that is named "Requested by" to a purchase order in Microsoft Dynamics GP

This article describes how to add a field that is named **Requested by** to a purchase order in Microsoft Business Solutions - Great Plains 8.0. The **Requested by** field will be available for every line item in the purchase order.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 904052

To add a **Requested by** field to a purchase order so that it is available for every line item in the purchase order, follow these steps.

## Back up the Reports.dic file

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
2. If you are prompted to enter a system password, type your password, and then select **OK**.
3. Select **Great Plains**. The path of the Reports.dic file appears in the **Reports** box in the **Dictionary Locations** section.
4. Use Windows Explorer to make a backup copy of the Reports.dic file

## Remove the report table relationship

1. Select **Reports**.
2. In the **Original Reports** list, select **POP Purchase Order Blank Form**, and then select **Insert**.
3. In the **Modified Reports** list, select **POP Purchase Order Blank Form**, and then select **Open**.
4. In the **Report Definitions** dialog box, select **Tables**.
5. In the **Report Table Relations** list, select **Purchasing Manufacturer Numbers**, and then select **Remove**.
6. If you are prompted to confirm the removal of this table and related tables, select **OK**.
7. In the **Report Table Relationships** dialog box, select **Close**.

## Delete the manufacturing restrictions and the manufacturing fields from the report

1. In the **Report Definition** dialog box, select **Restrictions**, and then follow these steps:
    1. In the **Report Restrictions** list, select **MFG PO**, and then select **Delete**. If you are prompted to confirm the deletion, select **Yes**.
    2. Close the **Report Restrictions** dialog box.
2. In the **Report Definition** dialog box, select **Layout**.
3. On the **Tools** menu, select **Section Options**.
4. In the **Additional Headers** list, select **MFG Item Header**, and then select **Remove**. If you are prompted to confirm the deletion, select **Yes**.
5. Select to clear the **Body** check box, and then select **OK** to return to the layout.
6. On the **Layout** tab in the toolbox, select **Calculated Fields** in the **Resource** list.
7. In the list of resources, select **nSuppressMFGHeader**, and then select **Open**.
8. In the **Calculated Field Definition** dialog box, follow these steps:

   1. In the **Result Type** list, select **Integer**.
   2. In the **Expression Type** section, select **Conditional**. If you receive a message that says that this operation will destroy the current expression, select **Continue**.

   3. In the **Expression Type** section, select **Calculated**.
   4. Select the **Constants** tab.
   5. In the **Constant** box, type *0*, select **Add**, and then select **OK**.
9. In the list of resources, select **nSupressMFGItem**, and then select **Open**.
10. Repeat step 8a through step 8e.
11. Close the report layout. If you are prompted to save your changes, select **Save**.

## Create a new report table relationship

1. In Report Writer, select **Tables**, and then select **Tables**.
2. In the **Tables** list, select **popPOLineRolluptemp**, and then select **Open**.
3. In the **Table Definition** dialog box, select **Relationships**.
4. In the **Table Relationship** dialog box, select **New**.
5. Select the ellipsis button (...).
6. In the **RelationshipTable Lookup** list, select **Purchase Order Line**, and then select **OK**.
7. In the **Secondary Table Key** list, select **POP_POLineIdxID**.
8. In the **Primary Table** column, select the following fields in the order in which they are listed:

   - **PO Number**
   - **Ord**
   - **Break Field 1**

   The fields in the left column should match the fields in the right column. Select **OK**.

9. Close the **Table Relationship** dialog box.
10. Select **OK** to close the **Table Definition** dialog box.
11. Close the **Tables** dialog box.
12. If you are prompted to save your changes, select **Save**.

## Add the new table

1. In the **Report Definition** dialog box, select **Tables**.
2. In the **Report Table Relationships** dialog box, select **07.-Purchase Order Line Rollup Temp***, and then select **New**.
3. In the **Related Tables** dialog box, select **Purchase Order Line**, and then select **OK**.
4. Close the **Report Table Relationships** dialog box.

## Add the "Requested by" field to the report layout

1. In the **Report Definition** dialog box, select **Layout**.
2. On the **Layout** tab in the toolbox, select **Purchase Order Line** in the **Resource** list.
3. In the list of resources, drag **Requested by** to the H3 section of the report.
4. Close the report layout. If you are prompted to save changes, select **Save**.

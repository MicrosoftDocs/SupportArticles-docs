---
title: How to add the Requested By field to the POP Receivings Posting Journal report in Microsoft Dynamics GP
description: Describes steps to add the Requested By field to the POP Receivings Posting Journal report in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to add the "Requested By" field to the POP Receivings Posting Journal report in Microsoft Dynamics GP

This article describes how to add the **Requested By** field to the POP Receivings Posting Journal report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855927

To add the **Requested By** field to the POP Receivings Posting Journal report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, follow these steps.

## Open the report in Report Writer

Use the appropriate step:

- In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**. In the **Product** list, click **Microsoft Dynamics GP**.
- In Microsoft Dynamics GP 9.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**. In the **Product** list, click **Microsoft Dynamics GP**.
- In Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**. In the **Product** list, click **Great Plains**.

## Remove the Purchasing Posting Journal Temp table from the POP Receivings Posting Journal report

1. In Report Writer, click **Reports**.
1. In the **Original Reports** section, select the **POP Receivings Posting Journal** report, and then click **Insert**.
1. In the **Modified Reports** section, select the **POP Receivings Posting Journal** report, and then click **Open**.
1. In the Report Definition window, click **Tables**.
1. In the Report Table Relationships window, select the Purchasing Posting Journal TEMP table, and then click **Remove**. When you're prompted to remove the table and its related tables, click **OK**.
1. Click **Close** in the Report Table Relationships window, and then close the Report Definition window. When you're prompted to save changes to the report, click **Save**.

## Create table relationships

1. In Report Writer, click **Tables** > **Tables**.
1. Click to select the **POP_Receipt** table, and then click **Open**.
1. In the Table Definition window, click **Relationships**.
1. In the Table Relationship window, click **New**.
1. In the Table Relationship Definition window, click the ellipsis button (...) to the left of the **Secondary Table** field.
1. In the Relationship Table Lookup window, click the **Purchasing Receipt Line Quantities** table, and then click **OK**.
1. In the **Secondary Table Key** field, click to select **POP_PORcptApplyIdxID**.
1. In the **Primary Table** list, select **POP Receipt Number** in the first line.
1. Leave the second line, the third line, and the fourth line blank, and then click **OK**.
1. Close the Table Relationships window, click **OK** in the Table Definition window, and then close the Tables window.

## Link the tables on the POP Receivings Posting Journal report

1. In Report Writer, click **POP Receivings Posting Journal** in the **Modified Reports** section, click **Open** > **Tables**.
1. In the Report Table Relationships window, click to select the **Purchasing Receipt Work** table, and then click **New**.
1. In the Related Tables window, click to select the **Purchasing Receipt Line Quantities** table, and then click **OK**.
1. In the Report Table Relationships window, click to select the **Purchasing Receipt Line Quantities** table, and then click **New**.
1. In the Related Tables window, click to select the **Purchase Order Line** table, and then click **OK**. Now we have the table that contains the **Requested By** field.
1. Click **Close** in the Report Table Relationships window.

## Modify the restrictions of the POP Receivings Posting Journal report

1. In the Report Definition window, click **Restrictions**.
1. In the Report Restrictions window, click to select the **String2** restriction, and then click **Delete**. When you're prompted to delete the restriction, click **Yes**. You should delete the **String2** restriction because it references the Purchasing Posting Journal TEMP table that you removed from the report.
1. Close the Report Restrictions window.

## Modify the layout of the POP Receivings Posting Journal report

1. In the Report Definition window, click **Layout**.
1. In the Report Layout, remove all String fields (String 2 to String 6) from the body of the report.
1. Drag the **Item Number** field and the **Requested By** field from the Purchase Order Line table onto the body of the report.
1. Close the Report Layout window. Click **Save** when you're prompted to save the changes to this report layout.
1. In the Report Definition window, click **OK**.

## Exit Report Writer

Use the appropriate method:

- In Microsoft Dynamics GP 10.0 or in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
- In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Assign security permissions to the modified report

### Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

#### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
1. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
1. In the Advanced Security window, click **View** > **By Alternate, Modified and Custom**.
1. Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
1. Expand **Reports**, expand **Purchasing**, and then expand the **POP Receivings Posting Journal** report that you modified.
1. Use the appropriate method:
    - In Microsoft Dynamics GP 9.0, click to select the **Microsoft Dynamics GP (Modified)** option.
    - In Microsoft Business Solutions - Great Plains 8.0, click to select the **Great Plains (Modified)** option.
1. Click **Apply**, and then click **OK**.

> [!NOTE]
> By default, the current user and the current company are selected when you start the Advanced Security tool. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

#### Method 2: Use the Standard Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
1. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
1. In the **User ID** list, type the Alternative/Modified Forms and Reports ID that is associated with the ID of the user who will print this modified report.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Purchasing**.
1. In the **Access List** box, double-click the **POP Receivings Posting Journal** report that you modified, and then click **OK**.
    > [!NOTE]
    > An asterisk appears next to the report name.

### Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **Alternate/Modified Forms and Reports**.
1. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
1. In the **ID** box, type the Alternative/Modified Forms and Reports ID that is associated with the user who will print this modified report.
1. In the **Product** list, click **Microsoft Dynamics GP**.
1. In the **Type** list, click **Reports**.
1. Expand the **Purchasing** folder.
1. Expand the folder of the report that you modified.
1. Click to select the **Microsoft Dynamics GP (Modified)** option.
1. Click **Save**.
1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **User Security**.
1. In the **User** list, click a user ID.
1. In the **Company** list, click a company.
1. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step 3.
1. Click **Save**.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

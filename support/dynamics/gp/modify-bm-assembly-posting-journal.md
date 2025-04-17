---
title: Add the standard cost of a BOM component to the BM Assembly Posting Journal form in Microsoft Dynamics GP
description: Describes steps to add the standard cost of a BOM component to the BM Assembly Posting Journal form in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# How to add the standard cost of a BOM component to the BM Assembly Posting Journal form in Microsoft Dynamics GP

This article describes how to add the standard cost of a Bill of Materials (BOM) component to the BM Assembly Posting Journal form in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 924862

## Summary

This article contains step-by-step instructions that describe how to modify the BM Assembly Posting Journal. To successfully modify this report, you must start the Report Writer in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0. Then, you must create a new table relationship for the report. After you create this table relationship, you must insert the Standard Cost field into the BM Assembly Posting Journal report layout. Then, you must save the changes to the report. Finally, you must assign security permissions to the report. Detailed instructions for each of these steps are included in the "More information" section in this article.

## More information

If you use Standard Costing in Microsoft Dynamics GP, you can add the standard cost of a BOM component for a quantity of one to the BM Assembly Posting Journal form by following these steps.

## Step 1: Start Report Writer

1. In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
1. In the **Product** list, click **Microsoft Dynamics GP** or **Microsoft Great Plains**, and then click **OK**.

## Step 2: Create a new table relationship

1. In the Microsoft Dynamics GP window, click **Tables** on the **Tables** menu.
1. In the Tables window, click **bmTrxComp** > **Open**.
1. In the Table Definition window, click **Relationships**.
1. In the Table Relationship window, click **New**.
1. In the Table Relationship Definition window, click the lookup button that is next to the **Secondary Table** box.
    > [!NOTE]
    > The lookup button appears as an ellipsis.
1. In the Relationship Table Lookup window, click **Item Master** > **OK**.
1. In the Table Relationship Definition window, click **IV_Item_MSTR_Key1** in the **Secondary Table Key** list.
1. Under Relationship, click **Item Number** in the list that appears in the **Primary Table** column.
    > [!NOTE]
    > After you click **Item Number**, **One Record** appears in the **Relationship Type** box on the lower-right side of the Table Relationship Definition window.
1. Click **OK** to exit the Table Relationship Definition window, click the **Close** button to exit the Table Relationship window, click **OK** to exit the Table Definition window, and then click the **Close** button to exit the Tables window.

## Step 3: Modify the BM Assembly Posting Journal form

1. In the Microsoft Dynamics GP window, click **Reports**.
1. In the Report Writer window, click **BM Assembly Posting Journal** in the **Original Reports** list, and then click **Insert>>** to move this report to the **Modified Reports** list.
1. In the **Modified Reports** list, click **BM Assembly Posting Journal** > **Open**.
1. In the Report Definition window, click **Tables**.
1. In the Report Table Relationships window, click **03.--Assembly Component** > **New**.
1. In the Related Tables window, click **Item Master** > **OK**.
1. Click **Close** to exit the Report Table Relationships window.
1. In the Report Definition window, click **Layout**.
1. In the Toolbox window, click **Assembly Components** in the list on the **Layout** tab.
1. Drag the **Standard Cost** field from the list of assembly component fields to the **H2** area of the report.
1. Modify the size and the location of the **Standard Cost** field according to your requirements.

## Step 4: Save the changes to the report, and then exit Report Writer

1. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.
1. Click **Save** when you're prompted to save the changes to the report layout.
1. Click **Save** when you're prompted to save the changes to the modified report.

## Step 5: Assign security permissions to the modified report

Assign security permissions to the modified report by using one of the following methods.

### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
1. Type the system password in the **Please Enter Password** box if you're prompted, and then click **OK**.
1. In the Advanced Security window, click **View** > **by Alternate, Modified and Custom**.
1. Expand **Microsoft Dynamics GP** or **Microsoft Great Plains**, expand **Reports** > **Inventory** > **BM Assembly Posting Journal**.
1. Click **Microsoft Dynamics GP (Modified)** or **Microsoft Great Plains (Modified)**, click **Apply** > **OK**.

> [!NOTE]
> By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional companies in the **Company Name** area of the Advanced Security window. You can also select additional users in the **Users** area of the Advanced Security window.

### Method 2: Use the Standard Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
1. Type the system password in the **Please Enter Password** box if you're prompted, and then click **OK**.
1. In the **User ID** list, click the ID of the user to whom you want to give access to the modified report.
1. In the **Product** list, click **Microsoft Dynamics GP** or **Microsoft Great Plains**.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Inventory**.
1. In the **Access List** box, double-click **BM Assembly Posting Journal**. An asterisk (*) appears next to the report name.
1. Click **OK** to exit the Security Setup window.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

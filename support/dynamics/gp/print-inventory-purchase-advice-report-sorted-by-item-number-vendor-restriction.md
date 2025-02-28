---
title: Print Inventory Purchase Advice Report so that it is sorted by item number and by vendor restriction
description: How to print the Inventory Purchase Advice Report so that it is sorted by item number and by vendor restriction in Microsoft Dynamics GP and in Microsoft Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to print the Inventory Purchase Advice Report so that it is sorted by item number and by vendor restriction in Microsoft Dynamics GP and in Microsoft Great Plains

This article describes how to print the Inventory Purchase Advice Report so that it is sorted by item number and by vendor restriction in Microsoft Dynamics GP and in Microsoft Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912285

## Introduction

This step-by-step article describes the following processes in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains:

- How to modify the Inventory Purchase Advice Report to sort items by item number.
- How to print only the items that are assigned to particular vendors.

Current behavior is as in the following scenario:

- In the report options, you enter a restriction on the **Vendor ID** field.
- You set the sorting type to **Item Number**.

In this scenario, the report prints for all items instead of for only those items that are assigned to the vendors in the range that you specified.

To modify the Inventory Purchase Advice Report to sort items by item number and to print only the items that are assigned to particular vendors, follow these steps:

## Step 1: Open the Inventory Purchase Advice Report

1. Start the Report Writer tool in Microsoft Dynamics GP or in Microsoft Great Plains. To do this, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
2. In the **Product** list, click **Great Plains**, and then click **OK**.
3. Click **Reports**.
4. In the **Original Reports** list, click **Inventory Purchase Advice Report**, and then click **Insert >>**.
5. In the **Modified Reports** list, click **Inventory Purchase Advice Report**, and then click **Open**.

## Step 2: Create a calculated field definition

1. In the **Report Definition** dialog box, click to select the **Skip Blank Records** check box, and then click **Layout**.
2. In the **Toolbox** dialog box, click **Calculated Fields** in the list on the **Layout** tab, and then click **New**.
3. In the **Calculated Field Definition** dialog box, type Item Vendor in the **Name** box.
4. In the **Result Type** list, click **Integer**.
5. In the **Expression Type** box, click **Conditional**.
6. Configure the table fields. To do this, follow these steps:

    1. Click the **Fields** tab, click the **Conditional** box under **Expressions** to highlight this box, and then click **IV Purchase Advice TEMP** in the **Resources** list.
    2. In the **Field** list, click **Vendor ID**, and then click **Add**.
    3. In the **Operators** area, click **=** (equal sign).
    4. Click the **Constant** tab, and then click **String**.
    5. Click **Add** to add double quotation marks to the expression.

    The following information appears in the **Conditional** box under **Expressions**:

    IV_Purchase_Advice_TEMP.Vendor ID = ""

7. Configure the constant for the TRUE case. To do this follow these steps:

    1. Click the **True Case** box to highlight this box, and then click the **Constants** tab.
    2. In the **Type** list, click **Integer**.
    3. Click the **Constant** box, type 0 (zero) if this value does not automatically appear in the box, and then click **Add**.

8. Configure the constant for the FALSE case. To do this, follow these steps:

    1. Click the **False Case** box to highlight this box, and then click the **Constants** tab.
    2. In the **Type** list, click **Integer**.
    3. Click the **Constant** box, remove the default value of 0 (zero) that appears in this box, type 1 (one), and then click **Add**.

9. Click **OK** to save the changes to this calculated field definition.

## Step 3: Add the calculated field to the report header

1. On the **Tools** menu, click **Section Options**.
2. In the **Report Section Options** dialog box, add the **Item Vendor** field to the item header. (The **Item Vendor** field is the field that you created in [Step 2: Create a calculated field definition](#step-2-create-a-calculated-field-definition).) To do this, follow these steps:

    1. In the **Additional Headers** list, click **Item Header**, and then click **Open**.
    2. In the **Header Options** dialog box, click to select the **Suppress When Field Is Empty** check box.
    3. In the **Calculated Field** list, click **Item Vendor**, and then click **OK**.

3. Click **OK** to close the **Report Section Options** dialog box, and then click **Microsoft Business Solutions-Great Plains** on the **File** menu to return to Microsoft Dynamics GP or to Microsoft Great Plains.
4. Click **Save** when you are prompted to save the changes to the report layout, and then click **Save** when you are prompted to save the changes to this report.

## Step 4: Grant access to the report

To grant access to the report, use one of the following methods:

### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. In the **Please Enter Password** box, type your password, and then click **OK**.
3. In the **Advanced Security** dialog box, click **by Alternate, Modified and Custom** on the **View** menu.
4. Expand **Microsoft Dynamics GP** or **Great Plains**, depending on whether you are running Microsoft Dynamics GP or Microsoft Great Plains.
5. Expand **Reports**, expand **Inventory**, and then expand **Inventory Purchase Advice Report**.
6. Click **Microsoft Dynamics GP (Modified)** or **Great Plains (Modified)**, depending on whether you are running Microsoft Dynamics GP or Microsoft Great Plains.
7. Click **Apply**, and then click **OK**.

### Method 2: Use standard Microsoft Great Plains security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. In the **Please Enter Password** box, type your password, and then click **OK**.
3. In the **User ID** list, click the ID of the user to whom you want to give access to the report.
4. In the **Type** list, click **Modified Reports**.
5. In the **Series** list, click **Inventory**.
6. In the **Access List** box, double-click **Inventory Purchase Advice Report**. An asterisk appears next to this report.
7. Click **OK**.

## Step 5: Configure the reporting options for the modified report

1. On the **Reports** menu, point to **Inventory**, and then click **Analysis**.
2. In the **Inventory Analysis Reports** dialog box, click **Purchase Advice Report** in the **Reports** list, and then click **New**.
3. In the **Option** list, type a descriptive name for the reporting options that you are creating.
4. In the **Ranges** list, click **Vendor ID**.
5. Set the vendor ID range. To do this, follow these steps:

    1. In the **From** box, type or locate the vendor ID with which you want to start the report.
    2. In the **To** box, type or locate the vendor ID with which you want to end the report.
    3. Click **Insert >>** to insert this vendor ID range into the **Restrictions** box.
6. In the **Sort By** list, click **Item Number** if this option is not already selected, and then click **Save**.
7. Close the **Inventory Analysis Report Options** dialog box.

## Step 6: Print the report

1. In the **Options** list, click the object that represents the reporting options that you configured in [Step 5: Configure the reporting options for the modified report](#step-5-configure-the-reporting-options-for-the-modified-report), and then click **Insert >>**.
2. Click **Print** to print the modified report.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

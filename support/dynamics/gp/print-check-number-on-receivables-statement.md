---
title: Print Check Number on Receivables Statement in Dynamics GP
description: Describes how to print the Check Number on a Receivables Statement in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# How to print the Check Number on a Receivables Statement in Microsoft Dynamics GP

This article contains step-by-step instructions to print the payment Check Number on Receivables Management Customer Statements.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4086035

First, define a file relation with the RM Open File to add the payment check number on Receivables Management customer statements:

## Step 1: Start Report Writer

In Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**. Click **Microsoft Dynamics GP** in the **Product** list.

## Step 2: Create the table relationship

1. On the toolbar, click the **Tables** button.
2. In the **Tables** window, select the **RM_Statement_TRX_TEMP** table from the list, and then click **Open**.
3. In the **Table Definition** window, click **Relationships**, and then choose **New**.
4. In the **Table Relationship Definition** window, click the ellipsis button next to the **Secondary Table** box.
5. In the **Relationship Table Lookup** dialog box, choose the RM Open File as the **Secondary Table**, and click **OK**.
6. In the **Secondary Table Key** list, click **RM_OPEN_Key_1**.
7. Select and match the following fields between the two tables (Insert each field, in this order):
    - Customer Number
    - RM Document Type-All
    - Document Number
8. Then click **OK**.
9. In the **Table Definition** dialog box, click **OK**.

## Step 3: Save the changes to the report, and then exit Report Writer

1.On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Dynamics**.
2.Click **Save** when you are prompted to save the changes to the report layout.
3.Click **Save** when you are prompted to save the changes to the modified report.

## Step 4: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: Use security in Microsoft Dynamics GP release 10.0 and later versions

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the Alternate/Modified Forms and Reports ID associated with the user ID that will print this modified report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand the **Sales** folder.
6. Expand the folder for the report that you modified.
7. Click **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.
9. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.
10. In the **User** list, click a user ID.
11. In the **Company** list, click a company.
12. In the **Alternate/Modified Forms and Reports ID** list, click the ID that you typed in step 2 earlier in this section.

### Method 2: Use the Advanced Security tool in a version earlier than Microsoft Dynamics GP release 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the **Advanced Security** window, click **View**, and then click **By Alternate, Modified, and Custom**.
4. Use the appropriate step:
    - In Microsoft Dynamics GP release 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains release 8.0, expand **Great Plains**.
5. Expand **Reports**, expand **Sales** and then expand the report that you modified.
6. Use the appropriate step:  
    - In Microsoft Dynamics GP release 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains release 8.0, click **Great Plains (Modified)**.
7. Click **Apply**, and then click **OK**.

> [!NOTE]
> By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the Users area of the **Advanced Security** window. You can select additional companies in the Company Name area of the **Advanced Security** window.

### Method 3: Use the Standard Security tool in a version earlier than Microsoft Dynamics GP release 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the **User ID** list, click the ID of the user who you want to have access to the modified report.
4. In the **Type** list, click **Modified Reports**.
5. In the **Series** list, click **Sales**.
6. In the **Access List** box, double-click the report that you modified, and then click OK.

> [!NOTE]
> An asterisk (*) appears next to the report name.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

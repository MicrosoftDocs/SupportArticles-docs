---
title: Add the Discount Available amount to the RM Statement Side Form report in Microsoft Dynamics GP
description: Describes how to add the Discount Available amount to the RM Statement Side Form report in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Financial - Receivables Management
---
# How to add the Discount Available amount to the RM Statement Side Form report in Microsoft Dynamics GP

This article describes how to add the Discount Available amount to the Receivables Management (RM) Statement Side Form report in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850020

## Step 1: Create a table relationship

1. Use the appropriate method:

    - **Microsoft Dynamics 10.0**

        Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.

    - **Microsoft Dynamics 9.0**

        Point to **Customize** on the **Tools** menu, and then click **Report Writer**.

2. Select **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
3. On the **Tables** menu, click **Tables**.
4. Highlight the **RM_Statements_TRX_TMP** table, and then click **Open**.
5. Click **Relationships**.
6. In the **Table Relationship** window, click **New**.
7. In the **Table Relationship Definition** window, click **RM Open File** in the **Secondary Table** field.
8. In the **Secondary Table Key** field, click **RM_OPEN_Key_1**.
9. In the **Primary Table** column, specify the following information:

    - Line 1: **Customer Number**
    - Line 2: **RM Document Type-All**
    - Line 3: **Document Number**

10. Click **OK**.
11. Close all the **Table Relationship** windows.
12. Click **Reports** on the toolbar.
13. Highlight **RM Statement Side Form** that is listed in the **Original Reports** pane, and then click **Insert** to insert the RM Statement Side Form report into the **Modified Reports** pane.
14. Click **Open**.
15. In the **Report Definition** window, click **Tables**.
16. In the Report **Table Relationships** window, select **RM Statements Transactions Temporary File**, and then click **New**.
17. In the Related Tables window, select **RM Open File**, and then click **OK**.
18. In the Report **Table Relationships** window, click **Close**.

## Step 2: Add the Discount Available field to the RM Statement Side Form report

1. In the **Report Definition** window, click **Layout**.
2. In the **Toolbox** window, click **RM Open File** in the list. Then, drag the **Discount Available Amount** field from underneath **RM Open File** to the **Body** section of the report.

    > [!NOTE]
    > This action will print the discount available for each transaction.
3. Drag the **Discount Available Amount** field again, this time to the **F2** section.

    > [!NOTE]
    > This will print the total discount available for the customer.
4. Double-click the **Discount Available** field in the **F2** section, and then change the **Field Type** value to **Sum**.
5. Close the Layout window.
6. Save the changes.
7. In the **Report Definition** window, click **OK**.
8. On the **File** menu, click **Microsoft Dynamics GP**.

## Step 3: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: Use security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID of the user who will print this modified report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand the **Sales** folder.
6. Expand the folder that contains the RM Statement Side Form report.
7. Click **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.

### Method 2: Use the Advanced Security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.
4. Expand **Microsoft Dynamics GP**, expand **Reports**, expand **Sales**, and then expand **RM Statement Side Form**.
5. Click **Microsoft Dynamics GP (Modified)**.
6. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional entities. For example, you can select additional users in the Users area of the **Advanced Security** window. You can also select additional companies in the Company Name area of the **Advanced Security** window.

### Method 3: Use the standard security tool in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the **User ID** list, click the ID of the user who will access the modified report.
4. In the **Type** list, click **Modified Reports**.
5. In the **Series** list, click **Sales**.
6. In the **Access List** box, double-click **RM Statement Side Form**, and then click **OK**.

    > [!NOTE]
    > An asterisk (*) appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

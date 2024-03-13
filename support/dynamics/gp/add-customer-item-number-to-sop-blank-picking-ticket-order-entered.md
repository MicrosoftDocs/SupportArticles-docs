---
title: Add the customer item number to the "SOP Blank Picking Ticket Order Entered" report in Microsoft Dynamics GP
description: Describes steps to add the customer item number to the SOP Blank Picking Ticket Order Entered report in Microsoft Dynamics GP 9.0 or in Microsoft Great Plains 8.0.
ms.reviewer: krasmuss, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add the customer item number to the "SOP Blank Picking Ticket Order Entered" report in Microsoft Dynamics GP 9.0 or in Microsoft Great Plains 8.0

This article describes how to add the customer item number to the SOP Blank Picking Ticket Order Entered report in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919720

To add the customer item number to the SOP Blank Picking Ticket Order Entered report, follow these steps.

## Step 1: Back up the report, and then open the SOP Blank Picking Ticket Order Entered report

1. If the existing Microsoft Dynamics GP reports have been modified, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
    1. If you're prompted to enter the system password, type your password, and then click **OK**.
    1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    1. Note the path that appears in the **Reports** box.
    1. Click **OK** to close the Edit Launch File window.
1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.
1. Click **Reports**.
1. In the Report Writer window, click **SOP Blank Picking Ticket Order Entered** in the **Original Reports** list, and then click **Insert**.
1. In the **Modified Reports** list, click **SOP Blank Picking Ticket Order Entered**, and then click **Open**.

## Step 2: Create a relationship that links the Sales Customer Item Cross Reference file to the sopIndividualPickTicketTemp file

1. On the **Tables** menu, click **Tables**.
    > [!NOTE]
    > Don't click **Tables** in the Report Definition window.
1. In the Tables window, click **sopIndividualPickTicketTemp** > **Open**.
1. In the Table Definition window, click **Relationships**.
1. In the Table Relationship window, click **New**.
1. In the Table Relationship Definition window, click the lookup button next to the **Secondary Table** box.
1. In the Relationship Table Lookup window, click **Sales Customer Item Cross Reference** > **OK**.
1. In the **Secondary Table Key** list, click **sopCustomerItemXrefIdx_ID**.
    > [!NOTE]
    > This value is the first value that appears in this list.
1. In the **Primary Table** column, click **Item Number** in the list that appears in the first row.
1. In the **Primary Table** column, click **Customer Number** in the list that appears in the second row.
1. Click **OK** to close the Table Relationship Definition window.
1. Click the **Close** button to close the Table Relationship window.
1. Click **OK** to close the Table Definition window.
1. Click the **Close** button to close the Tables window.

## Step 3: Add the new table relationship to the report

1. In the Report Definition window, click **Tables**.
1. In the Report Table Relationships window, click **01.sopIndividualPickTicketTemp** > **New**.
1. In the Related Tables window, click **Sales Customer Item Cross Reference** > **OK**.
    > [!NOTE]
    > The list of items in the Report Table Relations list resembles the following:
    >
    > - **01. sopIndividualPickTicketTemp**
    > - **02. -Sales Transaction Work**
    > - **03. --Customer Master Address File**
    > - **04. -Sales Transaction Amounts Work**
    > - **05. -Sales Customer Item Cross Reference**

1. Click **Close** to close the Report Table Relationships window.

## Step 4: Add the Customer Item Number field to the B section of the report

1. In the Report Definition window, click **Layout**.
1. In the resource list of the Toolbox window, click **Sales Customer Item Cross Reference**.
1. Drag the **Customer Item Number** field to the **B** section of the Report Layout window.
    > [!NOTE]
    > You may want to remove the item number that is currently displayed in the report. The item number is represented by the **DisplayItemNumber** field.

## Step 5: Save the modified report

1. Click the **Close** button to close the Report Layout window.
1. When you receive the following message, click **Save**:
    Do you want to save the changes to this report layout?|
1. Click **OK** to close the Report Definition window.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 6: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
1. If you're prompted, type the system password in the **Please Enter Password** box. Then, click **OK**.
1. In the Advanced Security window, click **View** > **By Alternate, Modified and Custom**.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
1. Expand **Reports** > **Sales** > **SOP Blank Picking Ticket Order Entered**.
1. Use the appropriate step:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
1. Click **Apply** > **OK**.

> [!NOTE]
> By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users and companies in the **Company Name** area of the Advanced Security window and in the **Users** area of the Advanced Security window.

### Method 2: Use the Standard Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
1. If you're prompted, type the system password in the **Please Enter Password** box. Then, click **OK**.
1. In the **User ID** list, click the ID of the user who you want to have access to the modified report.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Sales**.
1. In the **Access List** box, double-click the report that you modified, and then click **OK**.

    > [!NOTE]
    > An asterisk (*) appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

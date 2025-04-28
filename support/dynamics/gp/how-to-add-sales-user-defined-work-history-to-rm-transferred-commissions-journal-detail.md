---
title: How to add Sales User-Defined Work History table to RM Transferred Commissions Journal Detail report
description: Introduces how to add the Sales User-Defined Work History (SOP10106) table to the RM Transferred Commissions Journal Detail report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Receivables Management
---
# How to add the Sales User-Defined Work History (SOP10106) table to the RM Transferred Commissions Journal Detail report in Microsoft Dynamics GP

This article describes how to add the Sales User-Defined Work History (SOP10106) table to the RM Transferred Commissions Journal Detail report in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926392

To add the Sales User-Defined Work History (SOP10106) table to the RM Transferred Commissions Journal Detail report, follow these steps:

## Step 1 - Back up and then open the report

1. If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    2. Type the system password if you are prompted.
    3. Take one of the following actions as appropriate:

       - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the Edit Launch File window.
       - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.
    4. Note the path that appears in the **Reports** box.
    5. Select **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
3. Take one of the following actions as appropriate:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP** in the **Product** list, and then select **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the **Product** list, and then select **OK**.

## Step 2 - Create the table relationship

1. In Report Writer, select **Tables** on the toolbar, and then select **Tables**.
2. Select **RM_Commissions_Journal_File**, and then select **Open**.
3. Select **Relationships**, and then select **New**.
4. Select the ellipsis button (...), select **Sales Transaction History**, and then select **OK**.
5. Select the **Secondary Table Key** list, and then select **SOP_HDR_HIST_Key1**.
6. Select the **Primary Table** list, and then select **Document Number** to match the **Document Number** field to the **SOP Number** field in the **Secondary Table** column.
7. Make sure that **SOP Number** and **SOP Type** are listed in the **Secondary Table** column.
8. Select **OK**, and then close all windows.
9. Select **Save** when you are prompted to save your changes.

## Step 3 - Add the Sales User-Defined Work History fields to the report

1. Select **Reports** to open Report Writer.
2. In the **Original Reports** list, select **RM Transferred Commissions Journal Detail**, and then select **Insert**.
3. In the **Modified Reports** list, select **RM Transferred Commissions Journal Detail**, and then select **Open**.
4. In the Report Definition window, select **Tables**.
5. Select **RM Commissions Journal File**, and then select **New**.
6. Select **Sales Transaction History**, and then select **OK**.
7. Select **Sales Transaction History**, and then select **New**.
8. Select **Sales User-Defined Work History**, select **OK**, and then select **Close**.
9. In the Report Definition window, select **Layout**.
10. Drag the user-defined fields from the Toolbox window to the report layout.
11. Close the report layout.
12. When you are prompted to save your changes, select **Save**.

## Step 4 - Exit Report Writer

1. In the **Report Definition** dialog box, select **OK**.
2. On the **File** menu, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

## Step 5 - Grant security to the modified report

### Method 1 - Use Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.
2. Type the system password if you are prompted.
3. Select **View**, and then select **by Alternate, Modified and Custom**.
4. Take one of the following actions as appropriate:

   - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
   - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.

5. Expand the following nodes:
    - **Reports**
    - **Sales**
    - **RM Transferred Commissions Journal Detail**

6. Take one of the following actions as appropriate:
    - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains (Modified)**.

7. Select **Apply**, and then select **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select additional users and companies in the **Company** and **User** areas of the Advanced Security window.

### Method 2 - Use standard Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
2. Type the system password if you are prompted.
3. In the **User ID** list, select the user ID for the user to whom you want to grant access.
4. In the **Type** list, select **Modified Reports**.
5. In the **Series** list, select **Sales**.
6. In the **Access List** box, double-click **RM Transferred Commissions Journal Detail**, and then select **OK**.

   > [!NOTE]
   > An asterisk appears next to the report name.

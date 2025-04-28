---
title: How to add the Pay Code YTD column to payroll checks in Microsoft Dynamics GP
description: Describes how to add the Pay Code YTD column to payroll checks in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Payroll
---
# How to add the "Pay Code YTD" column to payroll checks in Microsoft Dynamics GP

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

This article describes how to add the **Pay Code YTD** column to payroll checks in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950703

> [!NOTE]
> "YTD" is the abbreviation for "Year-To-Date".

## More information

This field must be added to the check by using Report Writer, and then setting must be changed in the Payroll Setup window. Follow these steps.

## Step 1: Back up the Reports.dic file, and then start Report Writer

1. If you have any modified Microsoft Dynamics GP reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. Use the appropriate step for your version:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then click **Edit Launch File**.
    1. If you're prompted, type the system password.
    1. Use the appropriate step:
        - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    1. Note the path to the Reports.dic file that appears in the **Reports** box.
    1. Click **OK** to close the Edit Launch File window.
2. Use the appropriate step for your version to start Report Writer:
   - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
   - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
3. Use the appropriate step:
   - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
   - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.

## Step 2: Open the report

1. Click **Reports**.
2. In the **Original Reports** section, click **Employee Checks Stub on Top and Bottom-L** or required report for editing, and then click **Insert**.
3. In the Modified Reports section, click **Employee Checks Stub on Top and Bottom-L** or required report for editing, and then click **Open**.
4. Click **Layout**.

## Step 3: Modify the report

1. In the Report Layout, select the fields in the top stub section of the report that have to be adjusted to allow more space for the "Pay Code YTD" fields to be added. To do it, click in the upper-left corner of the group of fields, drag the pointer to lower-right corner of the group of fields in the top stub section of the report.
2. Click in the same section, and then click the appropriate arrow key on the keyboard to move all the fields in the group.
3. In the Toolbox, select **Payroll Work Check YTD** in the drop-down list, click **Pay YTD Array** in the box, and then drag it onto the desired location of the report.
4. In the Report Field Options window, set the **Array Index** field to a value that matches the Pay Earnings Array that you want, and then set the **Visibility** field to **Hide When Empty**.
5. Repeat steps 3 to 4 until all array fields have been added to the report.
6. Repeat steps 1 to 5 for each stub on the check.

## Step 4: Save the changes to the report, and then exit Report Writer

1. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.
2. Click **Save** when you're prompted to save the changes to the report layout.
3. Click **Save** when you're prompted to save the changes to the modified report.

## Step 5: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: Use security in Microsoft Dynamics GP 10.0

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup** > **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID that will print this modified report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand the **Payroll** folder.
6. Expand folder for the report you modified.
7. Click to select **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **User Security**.
10. In the **User** list, click to select a user ID.
11. In the **Company** list, click to select a company.
12. In the **Alternate/Modified Forms and Reports ID** list, click to select the ID from step 2.

### Method 2: Use the Advanced Security tool in a version that is earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
2. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.
4. Use one of the following steps, depending on which version is installed:
   - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
   - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
5. Expand **Reports**, expand **Payroll**, and then expand the report that you modified.
6. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
7. Click **Apply** >  **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

### Method 3: Use the Standard Security tool in a version earlier than Microsoft Dynamics GP 10.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
3. In the **User ID** list, click the ID of the user who you want to have access to the modified report.
4. In the **Type** list, click **Modified Reports**. In the **Series** list, click **Payroll**.
5. In the **Access List** box, double-click the report you modified, and then click **OK**.

    > [!NOTE]
    > Note An asterisk (*) appears next to the report name.

## Step 6: Change the settings in the Payroll Setup window to include YTD Pay Codes on the check stub

1. On the **Tools** menu, point to **Setup**, point to **Payroll**, and then click **Payroll**.
2. In the Payroll Setup window, click **Options**. In the Payroll Setup Options window, select the **Pay Codes** check box in the **Include Codes with YTD Amounts** on **Checks** section of the window.
3. Click **OK** to close the Payroll Setup Options window, and then click **OK** again to close the Payroll Setup window.

> [!NOTE]
> These steps can be used to make the same changes to the other employee check formats in Microsoft Dynamics GP. Make sure that you select your desired check format in the **Reports** box in Report Writer.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

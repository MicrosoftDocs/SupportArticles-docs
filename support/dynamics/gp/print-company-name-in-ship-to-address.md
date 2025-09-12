---
title: Print the company name in the Ship To Address section of the POP Purchase Order Blank Form report in Microsoft Dynamics GP
description: Describes the steps to print the company name in the Ship To Address section of the POP Purchase Order Blank Form report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to print the company name in the Ship To Address section of the POP Purchase Order Blank Form report in Microsoft Dynamics GP

This article describes how to print the company name in the **Ship To Address** section of the Purchase Order Processing POP Purchase Order Blank Form report in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 886728

To print the company name in the **Ship To Address** section of the POP Purchase Order Blank Form report, you can modify the POP Purchase Order Blank Form report to print one purchase order by using the Ship-to-Address identifier (ID) by following these steps.

## Step 1: Start Report Writer

1. Use the appropriate method:
   - For Microsoft Dynamics GP 9.0 or for Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
   - For Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
2. In the **Product** list, click **Microsoft Dynamics GP** or **Microsoft Great Plains**, and then click **OK**.
3. Click **Reports**.

## Step 2: Open the Report Layout window for the POP Purchase Order Blank Form report

1. In the Report Writer window, click **POP Purchase Order Blank Form** in the **Original Reports** list, and then click **Insert** to move this report to the **Modified Reports** list.
2. In the **Modified Reports** list, click **POP Purchase Order Blank Form** > **Open**.
3. In the Report Definition window, click **Layout**.

## Step 3: Create the calculated field

1. In the **Toolbox** dialog box, click **Calculated Fields** in the drop-down list.
2. Click **New**.
3. In the **Name** field, type *Company Name*.
4. In the **Result Type** list, click **String**, and then click **Conditional** in the **Expression Type** area.
5. Click in the **Conditional Expressions** field.
6. On the **Fields** tab, click **Print Document List** in the **Resources** list, and then click **Company Name** in the **Field** list.
7. Click **Add**.
8. In the **Operators** area, click the equal sign (=).
9. On the **Constants** tab, click **String** in the **Type** list, and then click **Add**.

    The value in the **Conditional** field resembles the following one:

    `POP_PrintDocList_TEMP.Company Name = ""`
10. Click in the **True Case** field.
11. On the **Fields** tab, click **Globals** in the **Resources** list, and then click **Company Name** in the **Field** list.
12. Click **Add**.
    The value in the **True Case** field resembles the following one:

    `Company Name`
13. Click in the **False Case** field.
14. On the **Fields** tab, click **Print Documents List** in the **Resources** list, and then click **Company Name** in the **Fields** list.
15. Click **Add**.

    The value in the **False Case** field resembles the following one:

    `POP_PrintDocList_TEMP.Company Name`
16. Click **OK**.

## Step 4: Add the created calculated field to the layout

1. In the Report Layout window, make the current **Company Name** fields invisible in the **Page Header** section and in the **Report Header** section. To do it, double-click the **Company Name** field, click **Invisible** in the **Display Options** list or in the **Visibility** list, and then click **OK**.
2. In the **Toolbox** dialog box, click **Calculated Fields** in the drop-down list.
3. Drag the **Company Name** calculated field that you created to the **Page Header** section and to the **Report Header** section to replace the original **Company Name** fields that are invisible.

## Step 5: Save the modified report

1. Close the Report Layout window.
    If you're prompted to save the changes, click **Save**.
2. In the Report Definition window, click **OK**.
3. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.

## Step 6: Assign security permissions to the modified report

### For Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0

1. Create the ID to print the modified report by following these steps:
      1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System** > **Security**, and then click **Alternate/Modified Forms and Reports**. If you're prompted, type the system password.
      2. In the **ID** box, enter an ID, and then type the description in the **Description** box.
      3. In the **Product** list, click **Microsoft Dynamics GP**, and then click **Reports** in the **Type** list.
      4. Expand **Purchasing** > **POP Purchase Order Blank Form**, and then click **Microsoft Dynamics GP (Modified)**.
      5. Click **Save**.
2. Assign the security to print the modified report by following these steps:
      1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System** > **Security**, and then click **User Security**.
      2. In the **User ID** list, click the user ID that you want to use.
      3. In the **Company** list, click a company.
      4. In the **Alternate/Modified Forms and Reports ID** list, click the ID that you created in step 1.
      5. Click **Save**.

### For Microsoft Dynamics GP 9.0 or for Microsoft Business Solutions - Great Plains 8.0

Use one of the following methods.

Method 1: Use the Advanced Security functionality

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**. Type the system password if you're prompted.
2. In the Advanced Security window, click **View**, and then click **by Alternate, Modified and Custom**.
3. Use the appropriate method:
   - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
   - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
4. Expand **Reports**, and then expand **Purchasing**.
5. Expand **POP Purchase Order Blank Form**.
6. Use the appropriate method:
   - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
   - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
7. Click **Apply** > **OK**.

> [!NOTE]
> By default, when you open the Advanced Security window, the current user and the current company are selected. Any changes that you make are for the current user and for the current company. However, you can select more companies in the **Company Name** area. You can select more users in the **User** area of the Advanced Security window.

Method 2: Use standard Microsoft Great Plains security

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**. If you're prompted, type the system password.
2. In the **User ID** list, click the user ID for the user who will have access to the modified report.
3. In the **Type** list, click **Modified Reports**.
4. In the **Series** list, click **Purchasing**.
5. In the **Access List** box, double-click **POP Purchase Order Blank Form**, and then click **OK**.

    An asterisk (*) appears next to the report name.

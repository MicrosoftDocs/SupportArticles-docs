---
title: Use Report Writer to replace the Vendor Check Name field
description: This article describes how to use Report Writer to replace the Vendor Check Name field with the vendor note for a Payables Management check in Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Use Report Writer to replace the Vendor Check Name field with the vendor note for a Payables Management check in Microsoft Dynamics GP

This article describes how to use Report Writer to replace the Vendor Check Name field with the vendor note for a Payables Management check in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857745

## Introduction

This article describes how to replace the **Vendor Check Name** field with the vendor note in the Payables Management check. The Payables Management check is a report in Report Writer in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

## Step 1: Back up the Reports.dic file if you have any modified reports

1. To locate the Reports.dic file, follow these steps:
    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **System**, and then click **Edit Launch File**.
    1. If you are prompted for the password, type the system password.
    1. In the Edit Launch File window, click **Microsoft Dynamics GP** or **Great Plains**. The path of the Reports.dic file appears in the **Reports** box.
1. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Customize**, and then click **Report Writer**.
    - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
1. In the **Product** list, click **Microsoft Dynamics GP** or **Great Plains**, and then click **OK**.
1. Click **Reports**.
1. In the **Original Reports** column, click the appropriate check format, and then click **Insert**.
1. In the **Modified Reports** list, click the same report, and then click **Open**.

## Step 2: Create a table relationship

1. Click **Tables**, and then click **Tables**.
2. Click **PM_Vendor_MSTR**, and then click **Open**.
3. Click **Relationships**, and then click **New**.
4. Click the ellipsis button next to the **Secondary Table** field, click **Record Notes Master**, and then click **OK**.
5. In the **Secondary Table Key** list, click **SY_Record_Notes_MSTR_1**.
6. In the **Primary Table** list, click **Note Index**, and then click **OK**.
7. Close the Table Relationship window, click **OK**, and then close the Tables window.

## Step 3: Modify the check

1. Click **Tables**.
2. Click **PM Vendor Master File**, and then click **New**.
3. Click **Record Notes Master**, and then click **OK**.
4. Close the Report Table Relationships window, and then click **Layout**.
5. Create a new calculated field. To do this, follow these steps:
    1. In the Toolbox window, click **Calculated Fields** in the **Resources** list, and then click **New**.
    1. In the **Name** box, type the name that you want to use for the calculated field.
    1. In the **Result Type** list, click **String**, and then click **Conditional** in the **Expression Type** box.
    1. On the **Fields** tab, click **Records Notes Master**.
    1. In the **Field** list, click **Text Field**, and then click **Add**.
    1. In the **Operators** area, click the equality operator (**=**).
    1. Click the **Constants** tab. In the **Type** list, click **String**, and then click **Add**.
    1. Click the **True Case** box.
    1. In the **Resources** list, click **PM Vendor Master File**, and then click **Vendor Check Name** in the **Field** list.
    1. Click **Add**.
    1. Click the **False Case** box.
    1. Click the **Fields** tab, and then click **Record Notes Master**.
    1. In the **Field** list, click **Text Field**, and then click **Add**.
    1. Click **OK** to close the Calculated Field Definition window.
6. In the report layout, double-click **Vendor Check Name**, click **Invisible** in the **Invisibility** list, and then click **OK**.
7. In the Toolbox window, click **Calculated Fields** in the **Resources** list. Click the calculated field that you created, and then drag the calculated field onto the **Vendor Check Name** field.

## Step 4: Save the modified report

1. Close the check. Click **Save** when you are prompted to save your changes.
2. In the Report Definition window, click **OK**.
3. Use the appropriate method:
    - In Microsoft Dynamics GP, click **File**, and then click **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **File**, and then click **Microsoft Business Solutions - Great Plains**.

## Step 5: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: By using security in Microsoft Dynamics GP 10.0

1. Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID that will print this modified report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand the **Purchasing** folder.
6. Expand the folder for the report you modified.
7. Click to select **Microsoft Dynamics GP (Modified)**.
8. Click **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.
10. In the **User** list, click a user ID.
11. In the **Company** list, click a company.
12. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step 2.

### Method 2: by using the Advanced Security tool in Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
1. If you are prompted, type the system password in the Please Enter Password box, and then click **OK**.
1. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.
1. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
1. Expand **Reports**, expand **Purchasing**, and then expand the report that you modified.
1. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
1. Click **Apply**, and then click **OK**.</br></br> **Note** By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select other users in the **Users** area of the Advanced Security window. You can select other companies in the **Company Name** area of the Advanced Security window.

### Method 3: By using the Standard Security tool in Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted, type the system password in the Please Enter Password box, and then click **OK**.
3. In the **User ID** list, click the ID of the user who you want to have access to the modified report.
4. In the **Type** list, click **Modified Reports**.
5. In the **Series** list, click **Purchasing**.
6. In the Access List box, double-click the report you modified, and then click **OK**.</br></br> **Note** An asterisk (*) appears next to the report name.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

---
title: How to modify the Purchase Order Blank Form to display brackets around the Trade Discount Amount in Microsoft Dynamics GP
description: Describes steps to modify the Purchase Order Blank Form to display brackets around the Trade Discount Amount in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: how-to
ms.date: 03/13/2024
---
# How to modify the Purchase Order Blank Form to display brackets around the Trade Discount Amount in Microsoft Dynamics GP

This article describes how to modify the Purchase Order Blank Form to display brackets around the Trade Discount Amount by using Report Writer in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 908325

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]

To modify the Purchase Order Blank Form to display brackets around the Trade Discount Amount, follow these steps.

## Step 1: Back up and then open the report

1. If you have any modified reports, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. Follow the appropriate step:
        - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, on the **Tools** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
    1. If you're prompted for the password, type the system password.
    1. Follow the appropriate step:
        - In Microsoft Dynamics GP, click **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    1. Note the path that appears in the Reports box.
    1. Click **OK** to close the Edit Launch File window.
1. Follow the appropriate step:
    - In Microsoft Dynamics GP 10.0, on the Microsoft Dynamics GP menu, point to Tools, point to Customize, and then click Report Writer.
    - In Microsoft Dynamics GP 10.0 and in Microsoft Business Solutions - Great Plains 8.0, on the **Tools** menu, point to **Customize**, and then click **Report Writer**.
1. In the **Product** list, click **Microsoft Dynamics GP** or **Great Plains**.
1. On the toolbar, click **Reports**.
1. In the **Original Reports** list, click **POP Purchase Order Blank Form** > **Insert**.
1. In the **Modified Reports** list, click **POP Purchase Order Blank Form** > **Open**.
1. In the **Report Definition** dialog box, click **Layout**.

## Step 2: Create a calculated field

1. In the toolbox resource list, click **Calculated Fields** > **New**.
1. In the **Name** field, type *Negative Trade Discount*.
1. In the **Result Type** list, click **Currency**.
1. In the **Expression Type** area, click **Calculated**.
1. On the **Fields** tab, click **Calculated Fields** in the **Resources** list.
1. In the **Field** list, click **cyPrintTradeDisc** > **Add**.
1. In the **Operators** section, click *.
1. On the **Constants** tab, click **Currency** in the **Type** list.
1. In the **Constant Field**, type *-1.00000*, and then click **Add**.
1. Click **OK**.

## Step 3: Add the calculated field to the layout

1. In the **RF** section of the report layout, click **cyPrintTradeDisc**, and then press DELETE.
1. In the toolbox resource list, click **Calculated Fields** > **Negative Trade Discount**.
1. Drag the **Negative Trade Discount** calculated field to the **RF** section of the report.
1. Follow the appropriate step:
    - In Microsoft Dynamics GP, click **File** > **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **File** > **Microsoft Business Solutions - Great Plains.**
1. When you're prompted to save the changes to the layout, click **Save**.
1. When you're prompted to save the changes to the report, click **Save**.

## Step 4: Grant Security to the modified report

### Method 1: Use security in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **Alternate/Modified Forms and Reports**.
1. If you're prompted, type the system password in the Please Enter Password box, and then click **OK**.
1. In the **ID** box, type the Alternate/Modified Forms and Reports ID that is associated with the user ID that will print this modified report.
1. In the **Product** list, click **Microsoft Dynamics GP**.
1. In the **Type** list, click **Reports**.
1. Expand the **Purchasing** folder.
1. Expand the folder of the report that you modified.
1. Click **Microsoft Dynamics GP (Modified)** > **Save**.
1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **System**, and then click **User Security**.
1. In the **User** list, click a user ID.
1. In the **Company** list, click a company.
1. In the **Alternate/Modified Forms and Reports ID** list, click the ID from step 3.

### Method 2: Use Advanced Security in Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

> [!NOTE]
> By default, the current user and company are selected when you open the **Advanced Security** dialog box. Therefore, changes apply to the current user and company. If you want to select additional users and companies, click these users and companies in the **User** area and in the **Company** area in the **Advanced Security** dialog box.

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
1. If you're prompted for a password, type the system password.
1. Click **View** > **by Alternate, Modified and Custom**.
1. Expand the following nodes:
    - **Great Plains**
    - **Reports**
    - **Purchasing**
    - **POP Purchase Order Blank Form**
1. Click **Great Plains (Modified)**.
1. Click **Apply** > **OK**.

### Method 3: If you use standard security in Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
1. If you're prompted for a password, type the system password.
1. In the **User ID** list, click the user ID for the user to whom you want to grant access to the report.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Purchasing**.
1. In the **Access List**, double-click **POP Purchase Order Blank Form**, and then click **OK**.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

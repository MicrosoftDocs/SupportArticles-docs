---
title: Add the vendor ship-to address from the Purchasing Vendor Detail Entry window to the POP Purchase Order Blank Form in Microsoft Dynamics GP
description: Describes steps to add the vendor ship-to address from the Purchasing Vendor Detail Entry window to the POP Purchase Order Blank Form in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to add the vendor ship-to address from the Purchasing Vendor Detail Entry window to the POP Purchase Order Blank Form in Microsoft Dynamics GP

This article describes how to add the vendor ship-to address from the Purchasing Vendor Detail Entry window to the POP Purchase Order Blank Form in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927699

To add the vendor ship-to address from the Purchasing Vendor Detail Entry window to the POP Purchase Order Blank Form, follow these steps.

## Step 1: Back up the report and open the report

1. If the existing Microsoft Dynamics GP reports have been modified, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:
    1. On the **Tools** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
    1. If you're prompted to enter the system password, type the password, and then click **OK**.
    1. Use one of the following steps, depending on which version is installed:
        - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    1. Note the path that is displayed in the **Reports** box.
    1. Click **OK** to close the Edit Launch File window.
1. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
1. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the **Product** list, and then click **OK**.
1. Click **Reports**.
1. In the Report Writer window, click **POP Purchase Order Blank Form** in the **Original Reports** list, and then click **Insert**.
1. In the **Modified Reports** list, click **POP Purchase Order Blank Form** > **Open**.

## Step 2: Modify the report

1. In the Report Definition window, click **Layout**.
1. In the Toolbox window, click **Calculated Fields** in the **Resources** list.
1. Click **sShipToAddress1** > **Open**.
1. In the **Calculated Expressions** field, select **POP_PrintDocList_TEMP.Address1**, and then click **Remove**.
1. Click **Fields**.
1. In the **Resources** list, click **Purchase Order Work**.
1. In the **Field** list, click **Address 1** > **Add**.
1. Repeat steps 4 through 7 in this section. In step 4, replace **POP_PrintDocList_TEMP.Address1** with **POP_PrintDocList_TEMP_Address2**. In step 7, replace **Address 1** with **Address 2**.
1. Repeat steps 4 through 7 in this section. In step 4, replace **POP_PrintDocList_TEMP.Address1** with **POP_PrintDocList_TEMP_City**. In step 7, replace **Address 1** with **City**.
1. Repeat steps 4 through 7 in this section. In step 4, replace **POP_PrintDocList_TEMP.Address1** with **POP_PrintDocList_TEMP_State**. In step 7, replace **Address 1** with **State**.
1. Repeat steps 4 through 7 in this section. In step 4, replace **POP_PrintDocList_TEMP.Address1** with **POP_PrintDocList_TEMP_Zip Code**. In step 7, replace **Address 1** with **Zip Code**.
1. Click **OK**.
1. Repeat steps 2 through 9 in this section. In step 3, replace **sShipToAddress1** with **sShipToAddress2**.
1. Repeat steps 2 through 9 in this section. In step 3, replace **sShipToAddress1** with **sShipToAddress3**.

## Step 3: Save the modified report and exit Report Writer

1. Click the **Close** button to close the Report Layout window.
1. When you receive the following message, click **Save**:

    Do you want to save the changes to this report layout?
1. Click **OK** to close the Report Definition window.
1. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP** on the **File** menu.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

## Step 4: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

### Method 1: Use the Advanced Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Advanced Security**.
1. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
1. In the Advanced Security window, click **View** > **By Alternate, Modified and Custom**.
1. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, expand **Microsoft Dynamics GP**.
    - In Microsoft Business Solutions - Great Plains 8.0, expand **Great Plains**.
1. Expand **Reports** > **Purchasing** > **POP Purchase Order Blank Form**.
1. Use one of the following steps, depending on which version is installed:
    - In Microsoft Dynamics GP 9.0, click **Microsoft Dynamics GP (Modified)**.
    - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains (Modified)**.
1. Click **Apply** > **OK**.
    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users in the **Users** area of the Advanced Security window. You can select additional companies in the **Company Name** area of the Advanced Security window.

### Method 2: Use the Standard Security tool

1. On the **Tools** menu, point to **Setup** > **System**, and then click **Security**.
1. If you're prompted, type the system password in the **Please Enter Password** box, and then click **OK**.
1. In the **User ID** list, click the ID of the user who you want to have access to the modified report.
1. In the **Type** list, click **Modified Reports**.
1. In the **Series** list, click **Purchasing**.
1. In the Access List box, double-click **POP Purchase Order Blank Form**, and then click **OK**.
    > [!NOTE]
    > An asterisk (*) appears next to the report name.

## References

For more information about the ship-to address, click the following article number to view the article in the Microsoft Knowledge Base:

[887113](https://support.microsoft.com/help/887113) How the ship-to addresses for purchase orders work in Microsoft Dynamics GP

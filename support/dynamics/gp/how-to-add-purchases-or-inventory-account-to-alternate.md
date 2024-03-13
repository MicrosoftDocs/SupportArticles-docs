---
title: How to add Purchases or Inventory account to alternate
description: Describes how to add these accounts to the alternate POP Purchase Order Blank Form. By default, this report contains the Project Number and the Cost Category. You must be an administrator to complete these steps.
ms.reviewer: jchrist
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add Purchases account or Inventory account to the alternate "POP Purchase Order Blank Form" in Project Accounting

This article describes how to add the Purchases account or the Inventory account to the alternate POP Purchase Order Blank Form in Project Accounting in Microsoft Dynamics GP. By default, this report contains the Project Number and the Cost Category. You must be an administrator to add the Purchases account or the Inventory account to the alternate POP Purchase Order Blank Form.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918944

## Back up the report and open the report

1. Back up the Reports.dic file if you have existing, modified Microsoft Dynamics GP reports. To find the location of the Reports.dic file, follow these steps:
   1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.

        > [!NOTE]
        > If you are prompted to type the system password, type the system password.
   2. In the Edit Launch File window, select **Microsoft Dynamics GP**.

        > [!NOTE]
        > The Reports field shows the location of the Reports.dic file.
2. Select **Tools**, point to **Customize**, and then select **Report Writer**.
3. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.

> [!NOTE]
> Do not print the purchase order to the screen before you open Report Writer. If you do this, you will open the Project Accounting version of the report instead of the Microsoft Dynamics GP version of the report. In this step, you must open the Microsoft Dynamics GP version of the report.

## Create a relationship that links the popPOLineRollupTemp table to the Purchase Order Line table

1. On the **Menu**, select **Tables**, and then select **Tables**.
2. In the Tables window, select **popPOLineRollupTemp**, and then select **Open**.
3. In the Table Definition window, select **Relationships**, and then select **New**.
4. Select the lookup button (the ellipsis button) on the right side of the **Secondary Table** field, select **Purchase Order Line** in the Relationship Table Lookup window, and then select **OK**.
5. In the **Secondary Table Key** list, select **POP_POLineIdxID**.
6. Select the values in the **Primary Table** column that match the values in the **Secondary Table** column.
7. Select **OK**, and then close the Table Relationship window.
8. Select **OK** in the Table Definition window, and then close the Tables window.

## Close Microsoft Dynamics GP Report Writer and open Project Accounting Report Writer

1. On the **File** menu, select **Microsoft Dynamics GP**.
2. On the **Tools** menu, select **Customize**, and then select **Report Writer**.
3. In the **Product** list, select **Project Accounting**, and then select **OK**.

## Link the Purchase Order Line table to the popPOLineRollupTemp table

1. Select **Reports**, select **POP Purchase Order Blank Form** in the **Original Reports** list, and then select **Insert**.
2. In the **Modified Reports** list, select **POP Purchase Order Blank Form**, and then select **Open**.
3. In the Report Definition window, select **Tables**.
4. In the Report Table Relationships window, select **Purchase Order Line Rollup Temp**, and then select **New**.
5. Select **Purchase Order Line**, and then select **OK**.
6. In the Report Table Relationships window, select **Close**.

## Create a calculated field to add the account number

1. In the Report Definition window, select **Layout**.
2. In the toolbox resource list, select **Calculated Fields**, and then select **New**.
3. In the **Name** field, type *Account Number*.
4. In the **Result Type** list, select **String**, and then select **Calculated** in the **Expression Type** list.
5. In the **Expressions** section, select the **Calculated** field, select the **Functions** tab, and then select **User-Defined**.
6. In the **Core** list, select **System**.
7. In the **Function** list, select **RW_GetAccountNumber**, and then select **Add**.
8. Select the **Fields** tab, select **Purchase Order Line** in the **Resources** list, and then select **Inventory Index** in the **Field** list.
9. Select **Add**.

    > [!NOTE]
    > The Calculated Expression should read as follows:  
    > Function_Script(RW_GetAccountNumberPOP_POLine.Inventory Index)

10. Select **OK**.

## Add the Account Number calculated field and the Location Code field to the report

1. In the toolbox resource list, select **Calculated Fields**.
2. Drag the **Account Number** field into the H3 section of the report.
3. In the toolbox resource list, select **Purchase Order Line**.
4. Drag the **Location Code** field into the H3 section of the report.

## Save the report and exit Report Writer

1. Close the report layout, and then select **Save** after you receive the following message:

   > Do you want to save the changes to this report layout?

2. In the Report Definition window, select **OK**.
3. On the **File** menu, select **Microsoft Dynamics GP**.

## Grant access to the report

### Method 1 - Grant access to the report by using Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Advanced Security**.

    > [!NOTE]
    > If you are prompted to type the system password, type the system password.
2. Select **View**, and then select **by Alternate, Modified and Custom**.
3. Expand the following nodes:
   - **Project Accounting**
   - **Reports**
   - **Purchasing**
   - **POP Purchase Order Blank Form**
4. Select **Project Accounting (Modified)**.
5. Select **Apply**, and then select **OK**.

> [!NOTE]
> By default, the current user and the current company are selected when you start Advanced Security. Any changes that you make are for the current user and for the current company. However, you can select additional users in the Advanced Security dialog box in the User area. You can select additional companies in the in the Advanced Security dialog box in the Company area.

### Method 2 - Grant access to the report by using Microsoft Dynamics GP security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.

    > [!NOTE]
    > If you are prompted to type the system password, type the system password.
2. In the **User ID** list, select the user ID of the user for whom you want to grant access to the report.
3. In the **Product** list, select **Project Accounting**.
4. In the **Type** list, select **Modified Alternate Dynamics GP Reports**.
5. In the **Series** list, select **Purchasing**.
6. In the **Access List** box, double-click **POP Purchase Order Blank Form**, and then select **OK**.

> [!NOTE]
> An asterisk appears next to the report name.

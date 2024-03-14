---
title: Add Inventory Account or Purchases Account to POP Purchase Order form in Dynamics GP
description: Describes how to add the Inventory Account or Purchases Account to the POP Purchase Order form in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to add the Inventory Account or Purchases Account to the POP Purchase Order form in Microsoft Dynamics GP

This article describes how to add the account number to the POP Purchase Order Blank Form in Microsoft Dynamics GP. You can use the same process for Purchase Order Other form. Follow the following steps.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3197751

## Step 1: Back up the report (Reports.dic)

1. To locate the Reports.dic file, follow these steps:
   - Point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
   - If you are prompted, type the system password.
2. Click **Microsoft Dynamics GP** in the **Edit Launch File** window.
3. Note the path that appears in the **Reports** box.
4. Click **OK** to close the Edit Launch File window.

## Step 2: Modify the Purchase Order Blank form

1. Open Report Writer: Click **Microsoft Dynamics GP**, click **Tools**, click **Customize**, and then click **Report Writer**. Note if a Microsoft Dynamics GP window pops up you have multiple dictionaries loaded. Select **Microsoft Dynamics GP** for the **Product** and select **OK**.

## Step 3: Create a relationship that links the popPOLineRollupTemp table to the Purchase Order Line table

1. On the **Menu**, click **Tables**, and then click **Tables**.
2. In the **Tables** window, click **popPOLineRollupTemp**, and then click **Open**.
3. In the **Table Definition** window, click **Relationships**, and then click **New**.
4. Click the lookup button (the ellipsis button) on the right side of the **Secondary Table** field, click **Purchase Order Line** in the **Relationship Table Lookup** window, and then click **OK**.
5. In the **Secondary Table Key** list, click **POP_POLineIdxID**.
6. Click the values in the **Primary Table** column that match the values in the **Secondary Table** column.
7. Click **OK**, and then close the **Table Relationship** window.
8. Click **OK** in the **Table Definition** window, and then close the **Tables** window.

## Step 4: Link the Purchase Order Line table to the popPOLineRollupTemp table

1. Click **Reports**, click **POP Purchase Order Blank Form** in the **Original Reports** list, and then click **Insert**.
2. In the **Modified Reports** list, click **POP Purchase Order Blank Form**, and then click **Open**.
3. In the **Report Definition** window, click **Tables**.
4. In the **Report Table Relationships** window, click **Purchase Order Line Rollup Temp***, and then click **New**.
5. Click **Purchase Order Line**, and then click **OK**.
6. In the **Report Table Relationships** window, click **Close**.

## Step 5: Create a calculated field to add the account number

1. In the **Report Definition** window, click **Layout**.
2. In the toolbox resource list, click **Calculated Fields** from the drop down under the **Layout** tab, and then click **New**.
3. In the **Name** field, type Account Number.
4. In the **Result Type** list, click **String**, and then verify or click **Calculated** in the **Expression Type** list.
5. Click the **Functions** tab, and then click **User-Defined**.
6. In the **Core** list, click **System**.
7. In the **Function** list, click **RW_GetAccountNumber**, and then click **Add**.
8. Click the **Fields** tab, click **Purchase Order Line** in the **Resources** list, and then click **Inventory Index** in the **Field** list.
9. Click **Add**.

    > [!NOTE]
    > The **Calculated Expression** should read as follows:  
    > *Function_Script(RW_GetAccountNumberPOP_POLine.Inventory Index)*
10. Click **OK**.

## Step 6: Add the Account Number calculated field to the report

1. In the toolbox resource list, click **Calculated Fields** from the drop down under the **Layout** tab.
2. Drag the Account Number field into the H3 section of the report.

    > [!NOTE]
    > If the calculated field is larger than the current fields on the report, use the **Drawing** options to format the field. Click the **Calculated** field (putting dots around it), Click **Tools**, and then click **Drawing** options. Change the options to match other fields on the report and click **OK**.

## Step 7: Save the changes to the report

1. Close the report layout, and then click **Save** after you receive the following message:

    > Do you want to save the changes to this report layout?
2. In the **Report Definition** window, click **OK**.
3. On the **File** menu, click **Microsoft Dynamics GP**.

## Step 8: Grant access to the report

After you save the report, you will have to assign security permissions to the modified report in order to use the report in Microsoft Dynamics GP. To assign security permissions to the modified report, use the following steps.

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID that will print this modified report.
3. In the **Product** list, click **Microsoft Dynamics GP**.
4. In the **Type** list, click **Reports**.
5. Expand the **Purchasing** folder and then expand the folder that contains the report that you modified. Click **+** to select POP Purchase Order Blank form and then click the Microsoft Dynamics GP (Modified) report.
6. Click **Save**.
7. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.
8. In the **User** list, click a user ID that will print this modified report.
9. In the **Company** list, click a company.
10. In the **Alternate/Modified Forms and Reports ID** list, click the ID that you used in step 2.

> [!NOTE]
> If you are using the Purchase Order Other form, the steps are the same. Just pull up the POP Purchase Order Other Form in Report Writer to add the calculated field to.

## More information

The information above is published in this blog:

[How to add the Inventory account or Purchases account to the "POP Purchase Order" Forms in Microsoft Dynamics GP](https://community.dynamics.com/blogs/post/?postid=4ce4562a-48ad-4d51-89c7-ae6846a0ad24)

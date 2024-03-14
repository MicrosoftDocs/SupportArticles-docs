---
title: Add Internet information for an item to the SOP Blank Invoice form
description: How to add Internet information for an item to the SOP Blank Invoice form.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# How to add Internet information for an item to the "SOP Blank Invoice" form in Microsoft Dynamics GP

This article describes how to add Internet information for an item to the SOP Blank Invoice form in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 924538

## Summary

This article contains step-by-step instructions for how to modify the SOP Blank Invoice form. To successfully modify this form, you must open it by using Report Writer in Microsoft Dynamics GP. Then, you must create a new calculated field for the form.

After you create this calculated field, you must insert it into the report layout, and then save the changes to the report. Finally, you must assign security permissions to the report. This article includes detailed instructions for each of these steps.

To add Internet information for an item to the SOP Blank Invoice form, follow these steps.

## Step 1: Start Report Writer

1. In Microsoft Dynamics GP, point to **Customize** on the **Tools** menu, and then click **Report Writer**.
2. In the **Product** list, click **Microsoft Dynamics GP**, and then click **OK**.
3. Click **Reports**.

## Step 2: Open the SOP Blank Invoice form

1. In the Report Writer window, click **SOP Blank Invoice Form** in the **Original Reports** list.
2. To move this report to the **Modified Reports** list, click **Insert**.
3. In the **Modified Reports** list, click **SOP Blank Invoice Form**, and then click **Open**.
4. In the Report Definition window, click **Layout**.

## Step 3: Create a calculated field for the SOP Blank Invoice form

1. In the Toolbox window, click **Calculated Fields** in the list that appears on the **Layout** tab.
2. Click **New**.
3. In the Calculated Field Definition window, type Item Home Page in the **Name** box.
4. In the **Result Type** list, click **String**.
5. In the **Expression Type** box, click **Calculated**.
6. Click the **Expressions Calculated** box, click the **Functions** tab, and then click **User-Defined**.
7. In the **Core** list, click **System**.
8. In the **Function** list, click **RW_GetInternetInfo**, and then click **Add**.
9. Click the **Constants** tab, click **String** in the **Type** list, type ITM in the **Constant** box, and then click **Add**.
10. On the **Fields** tab, click **Sales Transaction Amounts Work** in the **Resources** list, click **Item Number** in the **Field** list, and then click **Add**.
11. Click the **Constants** tab, click **String** in the **Type** list, leave the **Constant** box blank, and then click **Add**.
12. In the **Type** list, click **Integer**, type *2* in the **Constant** box, and then click **Add**. The following information appears in the **Expressions Calculated** box:

    **FUNCTION_SCRIPT(RW_GetInternetInfo"ITM"SOP_LINE_WORK.Item Number""2)**

    > [!NOTE]
    > This calculated field displays the information that appears in the **Home Page** field of the Internet Information window.

13. Follow steps 1 through 12 for each line that you want to print in the report. For example, to print the information that is displayed in the **E-mail** field of the Internet Information window, type *1* in the **Constant** box in step 12. In this situation, the following information appears:

    **FUNCTION_SCRIPT(RW_GetInternetInfo"ITM"SOP_LINE_WORK.Item Number""1)**

14. Click **OK**.

## Step 4: Add the calculated field to the report layout

1. In the Toolbox window, leave the **Calculated Fields** option selected in the list on the **Layout** tab. Then, drag the **Item Home Page** field from the list of calculated fields to the **H2** area of the report.
2. Modify the size and the location of the **Item Home Page** field according to your requirements.

## Step 5: Save the changes to the report, and then exit Report Writer

1. On the **File** menu, click **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.
2. Click **Save** when you are prompted to save the changes to the report layout.
3. Click **Save** when you are prompted to save the changes to the modified report.
4. Exit Report Writer.

## Step 6: Assign security permissions to the modified report by using the Standard Security tool

1. Open the User Security Setup window by pointing to the Microsoft Dynamics GP menu, then point to **Tools**, point to **Setup**, point to **System**, and then click on **User Security**.
2. Enter the User Id you are looking to grant access to the modified form/report to.
3. Enter the company this security needs to be granted in.
4. Take down the "Alternate/Modified Forms and Reports ID" that appears at the bottom of the window.
5. Open the Alternate/Modified Forms and Reports window by pointing to the **Microsoft Dynamics GP** menu, then point to **Tools,** point to **Setup**, point to **System**, then click on **Alternate/Modified Forms and Reports.**
6. Enter in the Id obtained in step 4.
7. Select Microsoft Dynamics GP as the product.
8. Select **Reports** as the **Type**.
9. Expand the **Sales Folder**.
10. Find the report you are looking to grant access to in the list that populates and expand it. Make sure it is set to the one labeled (modified).

---
title: How to set up the VAT Daybook reports
description: The VAT Daybook reports are used by European customers for tax reporting. VAT Daybook generates separate VAT Daybook reports for the sales modules and for the purchasing modules.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set up the VAT Daybook reports in Microsoft Dynamics GP

This article describes how to set up the Value-Added Tax (VAT) Daybook reports in Microsoft Dynamics GP 9.0. The VAT Daybook reports are used by European customers for tax reporting. VAT Daybook in Microsoft Dynamics GP generates separate VAT Daybook reports for the sales modules and for the purchasing modules.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 932379

To set up the VAT Daybook reports in Microsoft Dynamics GP 9.0, follow these steps.

## Step 1 - Install the international Microsoft Dynamics GP client software

To do this, select **United Kingdom & Ireland** in the **Country/Region** list during the installation process.

## Step 2 - Enable VAT Daybook reporting

1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Use VAT Daybook**.
2. Select a report template for each company. For example, if you want to generate the VAT Daybook report for United Kingdom, select **GB** in the **Report Template** list.

## Step 3 - Set up VAT Daybook report IDs and VAT Daybook column codes

1. On the **Cards** menu, point to **Company**, and then select **VAT Daybook Reports**.
2. In the **Report ID** field, type a report ID, and then type a description in the **Report Description** field.
3. In the **Country/Region Code** list, select a code that is based on the country/region for which you are reporting VAT. For example, select **GB** for the country/region code for United Kingdom.
4. In the **Column Code** field, type column codes for each column that you want to display in the VAT Daybook report. Include the **European Union (EU) transactions** column and the **VAT reclaimed** column.
5. Select **Add** when you are prompted to add the column code. The VAT Daybook Column Codes window automatically opens.
6. Type descriptions in the **Description 1** field and in the **Description 2** field.
7. In the **Tax Detail ID** field, type the applicable tax detail IDs.
8. In the **Amount Type** list, select **Net Amount** or select **Tax Amount**.
9. In the **Document Type** list, select one of the following document types:
   - **Invoices**
   - **Credits**
   - **Invoices & Credits**
10. Select **Save**, and then close the VAT Daybook Column Codes window.
11. Select **Save**, and then close the VAT Daybook Reports window.

## Step 4 - Create and post the sales transactions and the purchasing transactions

Create and post the sales transaction and the purchasing transactions. When you create transactions, make sure that you use the tax details that are assigned to the report.

## Step 5 - Print the VAT Daybook reports

1. On the **Tools** menu, point to **Routines**, point to **Company**, and then select **VAT Daybook Reports**.
2. Create a report option. To do this, follow these steps:

   1. Type an option ID in the **Option** field.
   2. In the **Report ID** list, select the report ID that you created in the Step 3 - Set up VAT Daybook report IDs and column codes section.

3. In the **From** field and in the **To** field, type the dates for the date range in the **Dates** area. The date range should include the document date and the tax date of the transactions that were posted in the Step 4 - Create and post the sales and purchasing transactions section.
4. In the **Type of Report** area, select **Draft** or select **Draft+Draft Return**.
5. If you selected **Draft** in step 2d, select **Both** in the **Transactions** area.
6. Select **Print** to print the VAT Daybook reports.

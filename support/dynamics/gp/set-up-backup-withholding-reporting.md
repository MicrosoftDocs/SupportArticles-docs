---
title: Set up backup withholding for reporting
description: Describes the setup steps and the processes for backup withholding for 1099 miscellaneous vendors in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set up backup withholding for 1099 reporting for miscellaneous vendors in Microsoft Dynamics GP

This article describes how to set up backup withholding for 1099 reporting for miscellaneous vendors in a company in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 930487

## Set up the company

1. On the **Tools** menu, point to **Setup**, point to **Company**, and then select **Company**.
2. In the Company Setup window, select **Options**.
3. In the Company Setup Options window, enter information in the following fields:
   - **Withholding Vendor ID**  
   - **Withholding File/Reconciliation Number**  
   - **Withholding Tax Rate**
4. Select **OK**.

## Set up the vendors

Set up the vendors as 1099 vendors, and then specify the withholding options. To do it, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Vendors**.
2. In the Vendor Maintenance window, select a vendor in the **Vendor ID** list, and then select **Withholding** button.
3. In the **Vendor Withholding Options** window, select the **Subject To Withholding Deduction** check box, and then enter the required withholding information for the tax rate, the tax type (such as Non-Resident Withholding), and the tax Start and End Dates. Consult your own local tax advisor to help you select the correct options.
4. Select **OK**.
5. Select **Options** button. In the **Vendor Maintenance Options** window, select **Miscellaneous** in the **Tax Type** field. Box 7 will default in for the 1099 Box, so change accordingly if needed.
6. Select **OK**.
7. In the Vendor Maintenance window, select **Save**.

## Enter transactions and withholding amounts

1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.
2. In the **Set up for vendors** area, select the vendor that you set up.
3. When you receive the following message, select **Yes**:
    > "Is this document subject to withholding?"
4. Enter the invoice amounts and the other required information.
    > [!NOTE]
    > The **Subject to WIthholding** checkbox is marked and the % has defaulted in, but it editable. (The distributions for the withholding taken will be on the payment, not the invoice.)
5. If you choose a 1099 vendor, the **1099 Amount** field is automatically populated with the transaction amount.
6. Select **Post**.

Example:  Let's say you have a $1,000 invoice with 20% withholding, so a net check of $800 was paid out. In the 1099 Details window, **Box 7 will display $1,000 and $200 will show in Box 4** for Federal Tax Withheld. (To get the withholding in Box 16 for State Tax Withheld, you would have to manually edit the 1099 Details before printing.)

> [!NOTE]
> There's no functionality for 'State' requirements built into 1099 processing at this time.

## Display the Withholding YTD column

1. On the **Microsoft Dynamics GP** menu, select **Smartlist**.
2. In the Smartlist window, expand **Vendors**, and then select **1099 Vendors**.
3. If the **Withholding YTD** column isn't displayed, select **Columns**.
4. In the Change Column Display window, select **Add**.
5. In the Columns window, select **Withholding YTD** in the **Available Columns** list, and then select **OK**.
6. Select **OK** to close the Change Column Display window.

    Now you can view the withholding year-to-date amounts of 1099 vendors in the Smartlist window.

## View the withholding amounts

In the Vendor Credit Summary window, you can view the withholding amount for individual vendors by period. To do it, follow these steps:

1. On the **Cards** menu, point to **Purchasing**, and then select **Summary**.
2. In the Vendor Credit Summary window, select a 1099 vendor.
3. Select **Period**.
4. In the Vendor Period Summary window, select the year, and then specify the period.

    The **Withholding** field displays the withholding amount. The **1099 Amount** field displays the amount that was paid for the period. The sum of the withholding amount and of the 1099 amount is the same as the original invoice amount.

## Print the Purchasing Analysis report

To see the 1099 amount by period and by vendor, print the Purchasing Analysis report. To do it, follow these steps:

1. On the **Reports** menu, point to **Purchasing**, and then select **Analysis**.
2. In the Purchasing Analysis Reports window, select **Period** in the **Reports** list, and then select **Print**.

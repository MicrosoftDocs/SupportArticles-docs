---
title: Manual Totaling on the Business Activity Statement
description: Describes Manual Totaling on the Business Activity Statement, how to control it, and how it affects the tax figures reported in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: lmuelle
ms.date: 03/13/2024
---
# Information about Manual Totaling on the Business Activity Statement in Microsoft Dynamics GP

This article describes **Manual Totaling** on the Business Activity Statement, how to control it, and how it affects the tax figures reported in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 953439

The Business Activity Statement (BAS) is the tax return form that is used in Australia to report the Goods and Services Tax (GST) figures to the Australian Taxation Office (ATO). The ATO allows two calculation methods for the tax collected and tax paid as shown in fields **G9** (GST on Sales) and **G20** (GST on Purchases) on the GST Calculation Sheet. The field **M** (Use manual totaling) on the GST Calculation Sheet is used to show which of the two methods has been used.

## Method 1 - Use Manual Totaling

With **Manual Totaling**, the BAS processor code sums up the tax amounts from the individual transactions. Then, the values are manually totaled for fields **G9** (GST on Sales) and **G20** (GST on Purchases) on the GST Calculation Sheet.

**Manual Totaling** is the recommended method because it is the most accurate. This method directly relates to the source transaction data.

> [!NOTE]
> when you use **Manual Totaling**, when you divide the value in the **G8** field (Total sales subject to GST after adjustments) by 11, it may not equal the value in the **G9** field (GST on Sales). In addition, when you divide the value of the **G19** field (Total purchases subject to GST after adjustments) by 11, it may not equal the value in the **G20** field (GST on Purchases).

This is typical, and is frequently caused by a combination of rounding errors and partially taxed transactions, Reduced Input Tax Credit (RITC) transactions, or transactions taxed at a non-standard rate (not 10%).

## Method 2 - Use Divide by 11

The **Divide by 11** method sums the total transaction amount including GST for sales and purchases that are subject to GST, and then divides these amounts by 11 to obtain the estimated tax component of these transactions.

The tax amounts for fields **G9** (GST on Sales) and **G20** (GST on Purchases) calculated in this manner are estimates and will not be as accurate as the **Manual Totaling** method.

> [!NOTE]
> The GST rate is set to 10%. The following example shows how the divide by 11 rule is implemented:
>
> |Tax ratio =|Tax Rate % / (100% + Tax Rate %)|
> |---|---|
> ||10% / (100% + 10%)|
> ||10% / (110%)|
> ||1 / 11|

To display the GST Calculation Sheet, follow these steps:

1. On the **Reports** menu, point to **Company**, and then select **BAS Report** to open the main Business Activity Statement Report window.
2. Select a **BAS Report Option** which has been processed. A list of process run dates and times will be displayed.
3. Select a process run, and then select **Open** to open the Edit Business Activity Statement window.

4. Select the expansion button to the right side of one of the following fields to open the Edit GST Details window:

    - **1A** (GST on sales or GST installment)
    - **1B** (GST on purchases)

5. Select the expansion button to the right side of one of the following fields to open the Edit GST Calculation Sheet window:

    - **G1** (Total sales)
    - **G10** (Capital Purchases)
    - **G22** (Estimated net GST for the year)

    On the lower left corner of the GST Calculation Sheet is the **M** (Use manual totaling) field. This will show whether **Manual Totaling** has been used for the current process run.

## How to start using or stop using Manual Totaling

1. On the **Reports** menu, point to **Company**, and then select **BAS Report** to open the main Business Activity Statement Report window.

2. Select a **BAS Report Option**, and then follow the appropriate step:

    - If a **BAS Report Option** exists, select **Modify**.
    - If no **BAS Report Option** exists, select **Add**.

3. Modify the **Report using Tax Collected & Paid amount** processing option:

    - Leave the **Report using Tax Collected & Paid amount** check box selected to use **Manual Totaling**.
    - Clear the **Report using Tax Collected & Paid amount** check box to stop using **Manual Totaling**.

   Changes to the **Report using Tax Collected & Paid amount** check box will take effect the next time that the BAS Report Option processed.

## References

For more information about how to handle reduced-input tax credits in the Business Activity Statement reporting tool in the Australian version of Microsoft Dynamics GP, see [How to handle reduced-input tax credits in the Business Activity Statement reporting tool in the Australian version of Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-handle-reduced-input-tax-credits-in-the-business-activity-statement-reporting-tool-in-the-australian-version-of-microsoft-dynamics-gp-dc91feec-d266-a76c-11cc-87c05fc074ef).

For more information about why transactions are missing from the Business Activity Statement (BAS) for Australian GST, see [Information about why transactions are missing from the Business Activity Statement (BAS) for Australian GST in Microsoft Dynamics GP](https://support.microsoft.com/topic/information-about-why-transactions-are-missing-from-the-business-activity-statement-bas-for-australian-gst-in-microsoft-dynamics-gp-620a880f-dbe7-c0c9-93df-4794a84fd376).

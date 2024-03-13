---
title: How to handle reduced-input tax credits
description: Discusses Australian GST and reduced-input tax credits (RITC). Contains information about how RITC ratio formulas and the BAS reporting tool are used to calculate tax amounts in Microsoft Dynamics GP.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to handle reduced-input tax credits in the Business Activity Statement reporting tool in the Australian version of Microsoft Dynamics GP

This article describes how to handle reduced-input tax credits (RITC) in the Business Activity Statement reporting tool in the Australian version of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 934694

## Reduced-input tax credits

You can claim an input tax credit for the goods-and-services tax (GST) that you paid for business expenses if the following conditions are true:

- You are registered for GST.
- You purchase a good or a service that you use only for a business or partly for a business.
- The cost includes GST.
- You have the tax invoice from the supplier for the good or for the service.

If a good or a service that you purchase is both for private use and for business use, you can claim only the business part of the input tax credit and the business-related amount of any expenses that you incur in operating a business. When only a part of the GST can be claimed as an input tax credit, this is known as a reduced-input tax credit.

## The Business Activity Statement reporting tool

By default, the Business Activity Statement reporting tool is configured to automatically detect when to use the reduced-input tax-credit ratio formulas. The Business Activity Statement reporting tool uses the reduced-input tax-credit ratio formulas to help obtain the correct transaction amount because Microsoft Dynamics GP does not automatically generate the required tax entries for reduced-input tax credits.

Consider the following scenario. You purchased a good or a service that cost $100. The GST was 10 percent of the cost. You use the good or the service for business use 80 percent of the time. You use the good or the service for private use 20 percent of the time. Therefore, you can claim 80 percent of the GST as a reduced-input tax credit. This scenario appears in the Tax Details window of the Business Activity Statement reporting tool as follows:

$80 @ 10% tax = $8 to a claimable tax detail ID  
$20 @ 10% tax = $2 to a non-claimable tax detail ID  
The total of the transaction = $80 + $20 = $100
The total of the tax = $8 + $2 = $10

However, Microsoft Dynamics GP cannot split the currency values. Therefore, the rate is split as follows:

$100 @ 8% tax = $8 to a claimable tax detail ID  
$100 @ 2% tax = $2 to a non-claimable tax detail ID  
The total of the transaction = $100 + $100 = $200  
The total of the tax = $8 + $2 = $10

When Microsoft Dynamics GP splits the rate in this manner, the total of the transaction is incorrect. If the reduced-input tax-credit ratio formulas remain in automatic mode, the reduced-input tax-credit ratio formulas will calculate that the total of $200 is not equal to the transaction total. Therefore, the following reduced-input tax-credit ratio formulas are applied as follows:

The formula for the total of the transaction = (line transaction amount × (line tax amount / (total tax amount)))

The formula for the total of the tax = sum of (line tax amount)

The formula for the total of the tax = (tax line detail) + (tax line detail) = (line tax amount)

The total of the transaction = $100 × ($8 / ($8 + $2)) + $100 × ($2 / ($8 + $2))

= $100 × 0.8 + $100 × 0.2

= $80 + $20

= $100

The total of the tax = $8 + $2

= $10

When the reduced-input tax-credit ratio formulas are in automatic mode, the formulas may be applied when they are not required. To prevent the reduced-input tax-credit ratio formulas from being used incorrectly, configure Microsoft Dynamics GP to use the formulas only when Microsoft Dynamics GP has been configured to use them. This manual activation feature was added to the Business Activity Statement reporting tool after the original development. Therefore, both the manual mode and the automatic mode are supported.

To use the manual mode, open the Business Activity Statement Setup window. To do this, select **Tools**, point to **Setup**, point to **Company**, select **Company**, and then select **Options**. Then, select the **Enable Manual activation of RITC ratio formula based on Tax Detail** check box. Now, the Business Activity Statement reporting tool only applies the reduced-input tax-credit ratio formula when the specific tax detail ID has the **Use RITC Formula for Tax Detail** option selected in the **BAS Assignments** list. This prevents the reduced-input tax-credit ratio formulas from being used when the formulas should not be used.

Because the manual mode makes sure that the formulas are used only when they should be used, we recommend that you use the manual mode to handle reduced-input tax credits.

## Tax detail settings

To use reduced-input tax credits correctly, you must create a matched pair of tax details to be used in a single tax schedule. When the Australian GST is enabled for a company, the **BAS Assignments** field is displayed in the Tax Detail Maintenance window.

The tax percentage that is used should be based on the claimable part of the GST. Consider the following scenario. GST of 10 percent is applied, and you can claim 80 percent of the GST. In this scenario, specify 8 percent as the claimable rate. Specify 2 percent as the rate that cannot be claimed.

The following values are available in the **BAS Assignments** field for the claimable tax detail ID (8 percent tax rate):

- G11 Other Acquisitions
- G17 Creditable Acquisitions
- Use RITC Ratio Formula for Tax Detail

The following values are available in the **BAS Assignments** field for the non-claimable tax detail ID (2 percent tax rate):

- G11 Other Acquisitions
- G15 Private & Non Deductible Acq.
- Use RITC Ratio Formula for Tax Detail

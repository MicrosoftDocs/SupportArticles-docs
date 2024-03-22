---
title: Description of the date that's used for the invoice date when you transfer a quote to an invoice or when you transfer an order to an invoice in Microsoft Dynamics GP
description: Description of the date that is used for the invoice date when you transfer a quote to an invoice or when you transfer an order to an invoice in Microsoft Dynamics GP.
ms.date: 03/20/2024
ms.reviewer: theley
ms.custom: sap:Distribution - Purchase Order Processing
---
# Description of the date that is used for the invoice date when you transfer a quote to an invoice or when you transfer an order to an invoice in Microsoft Dynamics GP

This article describes what date is used for the invoice date when you transfer a quote to an invoice or when you transfer an order to an invoice in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866489

## Summary

When you click the blue, right-arrow button next to the **Date** field in the **Sales Transaction Entry** window, the **Sales Date Entry** window appears. Then, Microsoft Dynamics GP looks for an invoice date in the **Sales Date Entry** window. If a date exists in the **Invoice Date** field, Microsoft Dynamics GP creates the invoice by using the date in the **Invoice Date** field. If no date exists in the **Invoice Date** field, Microsoft Dynamics GP creates the invoice by using the system date on the local computer.

> [!NOTE]
> To open the **Sales Transaction Entry** window, point to **Sales** on the **Transactions** menu, and then click **Sales** **Transaction Entry**.

If Advanced Distribution in Microsoft Dynamics GP is registered, the "Update Invoice Date on First Print" setting may affect the invoice date.

## Use the "Update Invoice Date on First Print" setting

To use the "Update Invoice Date on First Print" setting, follow these steps:

1. Use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft** **Dynamics GP** menu, point to **Sales**, and then click **Sales Order Processing.**  
    - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Sales**, and then click **Sales Order Processing**.

2. In the **Sales Order Processing Setup** window, click **Fulfillment Order/Invoice.**  

3. In the Sales Fulfillment Order/Invoice Setup window, click the lookup button next to the **Fulfillment Order/Invoice ID** field.

4. In the **Sales Type IDs** window, click a type ID that is used for the invoice, and then click **Select**.

5. To use the "Update Invoice Date on First Print" setting, click to select the **Update Invoice Date on First Print** check box in the Sales Fulfillment Order/Invoice Setup window. If you do not want to use the "Update Invoice Date on First Print" setting, click to clear the **Update Invoice Date on First Print** check box in the Sales Fulfillment Order/Invoice Setup window.

If the **Update Invoice Date on First Print** check box is selected, Microsoft Dynamics GP assigns the system date of the local computer to the invoice date and to the document date when you print the invoice document.

For example, no date exists in the **Invoice Date** field in the **Sales Date Entry** window. Additionally, the **Update Invoice Date on First Print** check box is selected. When you transfer a quote or an order to an invoice on May 1, the invoice date is May 1. However, if you print the invoice document on May 3, the document date and the invoice date in the document are updated to May 3.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

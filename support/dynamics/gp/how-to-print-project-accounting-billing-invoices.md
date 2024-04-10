---
title: Printing Project Accounting Billing Invoices
description: How to print customer invoices in their currency within Project Accounting.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# How to print Project Accounting Billing Invoices in the Customers Currency

This article introduces how to print in your customer's currency in the billing entry window if you have multicurrency registered.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856738

If you would like to use cycle biller and print in the customer's currency, then go to setup-project-billing and place the radio button next to Customer Currency ID. Save the changes and then create the invoice.

If you would like to do a regular billing and use the customer's currency, go to transactions-project-billing-billing entry and create the invoice. When it is time to print the invoice, place a check mark next to Multicurrency in the Billing Entry Print window. If this is left unmarked, it will print in the system's functional currency.

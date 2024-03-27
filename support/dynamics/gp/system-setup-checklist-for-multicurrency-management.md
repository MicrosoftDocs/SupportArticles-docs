---
title: System setup checklist for Multicurrency Management
description: System setup checklist for Multicurrency Management in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# System setup checklist for Multicurrency Management in Microsoft Dynamics GP

This article describes how to set up Multicurrency Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858556

## More information

For more information about how to set up Multicurrency Management at the company level, see [How to set up a company in Multicurrency Management in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-set-up-a-company-in-multicurrency-management-in-microsoft-dynamics-gp-95f2a996-cba7-3e64-7631-0381bbdda94b).

To set up Multicurrency Management, follow these steps.

### Step 1 - Set up a currency

Use the Currency Setup window to create the currencies to use in Microsoft Dynamics GP. Currencies that are set up in Multicurrency Management can be used in any company, as long as companies are provided access to the currencies. To open the Currency Setup window, follow the appropriate step for your version of the program.

- On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Currency**.

### Step 2 - Grant company access to the currency

Use the Multicurrency Access Setup window to grant company access when you do any of the following:

- Set up a currency ID
- Set up an exchange table ID
- Create a company

This window can also be used to temporarily stop usage of a currency or of an exchange table without deleting the currency or exchange table, and without removing company access to the currency or to the exchange table. Grant the individual companies access to currencies and to exchange tables. To open the Multicurrency Access Setup window, follow the appropriate step for your version of the program.

- On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Multicurrency Access**.

### Step 3 - Set up exchange rate tables

Set up exchange rate tables for the currency in which the company was granted access. To open the Multicurrency Exchange Rate Table Setup window, follow the appropriate step for your version of the program.

- On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Exchange Table**.

### Step 4 - Grant company access to the exchange rate tables

Use the Multicurrency Access Setup window to grant company access to the exchange rate tables. To do this, follow the steps under Step 2 - Grant company access to the currency.

### Step 5 - Create exchange rates

Create exchange rates. Use the Multicurrency Exchange Rate Maintenance window to assign individual exchange rates to the exchange rate tables. The exchange rates can be used by any company. To use a single exchange rate table together with two or more companies, those companies must use the same functional currency or the primary currency that is used for maintaining the account records.

To open the Multicurrency Exchange Rate Maintenance window, select **System** on the **Cards** menu, and then select **Exchange Table**.

Or, follow the appropriate step for your version of the program.

- On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Exchange Table**.

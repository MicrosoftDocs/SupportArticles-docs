---
title: Multicurrency billing feature in Project Accounting in Microsoft Dynamics GP 9.0
description: Describes a new feature in Microsoft Dynamics GP 9.0 that lets you enter budget amounts in a currency other than the functional currency.
ms.reviewer: ppeterso, lmuelle
ms.date: 03/13/2024
---
# Description of the multicurrency billing feature in Project Accounting in Microsoft Dynamics GP 9.0

This article describes a new feature in Microsoft Dynamics GP 9.0 that lets you enter budget amounts in a currency other than the functional currency.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917723

## Introduction

In Project Accounting in Microsoft Dynamics GP 9.0, you can enter budget amounts in a currency other than the functional currency. This multicurrency billing feature lets you create a budget and then create a billing invoice by using the customer's originating currency. For example, a customer negotiates a billing rate in the originating currency for a project. In this situation, the billing rate doesn't change even if the exchange rate is different at the time of billing. The functional amount is adjusted to reflect the exchange rate at the time of billing. So the project budget bears the risk of any changes in the exchange rate.

## More information

Consider the following behavior that occurs when you use the multicurrency billing feature:

- You can enter an originating currency in the **Billing Currency ID** field in the Contract Maintenance window and then create a multicurrency billing project. However, this feature is available only for Time and Materials and for Fixed Price projects that have a fee.
- The currency that's entered on the contract in the Contract Maintenance window is automatically rolled down to the projects. All projects under the contract must be assigned the same currency. This currency cannot be changed.
- The Change Orders button may be disabled in the Contract Maintenance window and in the Project Maintenance window. The button is disabled if an originating currency is entered in the **Billing Currency ID** field. This behavior occurs because the change order functionality is unavailable on multicurrency billing projects.
- The only profit types that can be used on multicurrency billing projects are **Billing Rate** and **None**.
- Purchase/Material - Inventory cost categories cannot be used on multicurrency billing projects.
- The only fees that can be added to multicurrency billing projects are fees that use Fee Amount as their calculation method.
- In the Project Maintenance window, the lookup button next to the **Billing Currency ID** field is enabled. If the project has a status of **Estimate**, the PA Baseline Exchange Rate Entry window opens when you click the lookup button. If the project has a status of **Open**, the PA Forecast Exchange Rate Entry window opens when you click the lookup button. The exchange rate that's entered in this window is used only for budgeting. This exchange rate isn't used for actual transactions.
- A **Change Currency Viewed** list is available in the Contract Maintenance window, in the Project Maintenance window, and in the Budget Maintenance window.
- If the originating currency is displayed in the Budget Maintenance window or in the Budget Detail Entry window, you can't change the unit cost. If the functional currency is displayed in either of these windows, you can't change the billing rate in the Budget Detail Entry window.
- If the functional currency isn't entered in the **Billing Currency ID** field, the profit always comes from the budget. In this situation, the type of profit is the one that is entered in the **Profit Type** field.
- When you enter a cost transaction for a multicurrency billing project, the lookup button next to the **Date** field is enabled. When you click the lookup button, the PA Billing Exchange Rate Entry window opens. You can enter an exchange rate in this window. This exchange rate is used to calculate the total accrued revenues.
- You can only bill the project by using the billing currency that is entered in the Project Maintenance window.
- The exchange rate may change between the time that the cost transaction is entered and the time that the billing is performed. If the exchange rate changes, the difference in cost is posted to the Adjusted Unbilled Revenue and the Adjusted Unbilled Receivable account types. These account types use the same account numbers that are used for the Unbilled Project Revenue and the Unbilled Accounts Receivable account types, respectively.
- You can add an Employee or Position Rate table to the project by using the Project Billing Settings window. However, only cost information will come from the assigned rate table. Profit information will still always come from the budget.

---
title: Accounting methods and revenue recognition
description: Describes the different accounting methods and their effects on revenue recognition in Project Accounting.
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
---
# Information about the accounting methods and revenue recognition process in Microsoft Dynamics GP Project Accounting

This article describes the different accounting methods and theirs effect on revenue recognition in Microsoft Dynamics GP Project Accounting.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857542

## Introduction

Several different accounting methods are available in Project Accounting. Each method has different effects on projects, specifically for revenue recognition and of the amounts to be recognized.

## The When Performed accounting method

This accounting method is for Time and Materials projects only. Revenues and costs are recognized when cost transactions are posted. For example, the Cost of Goods Sold account is debited when cost transactions are posted.

## The When Billed accounting method

This accounting method is for Time and Materials projects only. Revenues and costs are recognized when the project is billed. When a cost transaction is posted, the Work in Process (WIP) account is debited. The same account is credited when the cost is billed, and the Cost of Goods Sold account is debited.

## The Cost-to-Cost (percentage completion) accounting method

This accounting method is for Fixed Price projects and for Cost Plus projects. Revenues are recognized on a percentage completion basis calculated on project costs when you enter a Revenue Recognition transaction. The full number of actual costs are recognized.

The following example is the formula:  
(Actual Costs to date/Forecast Total Cost) * Forecast Billing Amount = Earned Revenue Amount

> [!NOTE]
> You have to budget costs on your cost categories if you plan to use this accounting method. Failure to budget costs will result in 0% complete. So no revenue is recognized.

## The Effort-Expended (percentage completion) accounting method

This accounting method is for Fixed Price projects and for Cost Plus projects. Revenues are recognized on a percentage completion basis calculated on project quantities for all cost categories on the project when you enter a Revenue Recognition transaction. The full number of actual costs are recognized.

The following example is the formula:  
(Actual Quantity to date/Forecast Total Quantity) * Forecast Billing Amount = Earned Revenue Amount

> [!NOTE]
> You have to budget quantities on your cost categories if you plan to use this accounting method. Failure to budget quantities will result in 0% complete. So no revenue is recognized.

## The Effort-Expended - Labor Only (percentage completion) accounting method

This accounting method is for Fixed Price projects and for Cost Plus projects. Revenues are recognized on a percentage completion basis that is calculated on direct labor hours for timesheet cost categories on the project. The full number of actual costs are recognized. This calculation occurs when you enter a Revenue Recognition transaction.

The following example is the formula:  
(Actual Quantity of labor hours to date/Forecast Total Quantity of labor hours) * Forecast Billing Amount = Earned Revenue Amount

> [!NOTE]
>
> - You have to budget quantities on your timesheet cost categories if you plan to use this accounting method. If you don't budget quantities, you receive a 0% complete result. So no revenue is recognized.
> - You must have the **Combine for Revenue Recognition** check box selected in the Project Maintenance window if you use this method.

## The Completed accounting method

This accounting method is for Fixed Price projects and for and Cost Plus projects. Revenues and costs are recognized when the project is substantially complete. Which means that the project status must be changed to **Completed** to access the Revenue Recognition Entry window.

> [!NOTE]
> You don't enter revenue recognition transactions for the When Performed accounting method or for the When Billed accounting method unless service fees are being used. Service fees use the Ratable accounting method.

## The Ratable accounting method

Revenues are recognized ratably over the life of the fee. The revenue can be recognized according to the scheduled amount of the fee that would be due. The service fee doesn't have to be billed. However, the service fee has to be scheduled.

> [!NOTE]
> Combining and segmenting also affects revenue recognition. If the **Combined for Revenue Recognition** check box is selected in the Project Maintenance window, the percentage completion calculation is based on the combined totals of all the cost categories on the project. If the check box is cleared, each cost category calculates its own percentage of completion. If the **Combine for Revenue Recognition** check box is also selected in the Contract Maintenance window, each project on the contract is combined together to determine the overall percentage of completion.

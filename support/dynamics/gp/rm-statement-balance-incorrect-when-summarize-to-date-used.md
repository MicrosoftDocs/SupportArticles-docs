---
title: RM Statement balance incorrect when 'Summarize To' Date is used in Receivables Management
description: When printing RM statements, the ending statement balance is incorrect when a Summarize To Date is used. This article provides a solution to this issue.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# RM statement balance incorrect when 'Summarize To' Date is used in Receivables Management for Microsoft Dynamics GP

This article provides a solution to an issue where the RM statement balance is incorrect when a 'Summarize To' Date is used in Receivables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2141603

## Symptoms

When printing a Receivables Statement, the A/R statement balance is incorrect when a 'Summarize To' Date is used.

(To print a Receivables Statement, click on Microsoft Dynamics GP, click on **Tools**, point to **Routines**, point to **Sales** and click on **Statements**.)

## Cause

The 'date' used for the Summarize To date may cause varied results. The Summarize To Date needs to be greater than the last document date that is in OPEN status, and has an applied record in HIST status. If the Summarize To Date is less than this document date, then it will not pick up the applied record in history and the ending statement balance will be incorrect.

## Resolution

Enter a 'Summarize To' Date that is greater than the last document date that has an applied record in history.

As a recommendation, we can say to use a date greater than the last 'Paid Transaction Removal' date that was used, and you would be pretty safe with this date. Never use a Summarize To date less than the last Paid Transaction Removal Date that was used.

## More information

For example, consider these documents applied to each other for this customer:

> HIST 1/16/2010 CRM ($100.00)  
OPEN 3/15/2010 INV $300.00  
\---------------------------------  
Net Balance $200.00

Result #1 - If you use a Summarize To date between 1/16/2010 and 3/14/2010, the ending balance of the statement will incorrectly show $300 because the applied record in history will not be picked up.

Result #2 - If you use a Summarize To date of 3/15/2010 or greater, then the ending balance will correctly show $200.

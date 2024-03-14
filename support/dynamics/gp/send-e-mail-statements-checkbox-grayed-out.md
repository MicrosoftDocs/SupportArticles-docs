---
title: Send E-mail Statements checkbox grayed out
description: Provides a solution to an issue where the Send E-mail Statements checkbox/section is grayed out in Customer Maintenance Options window in Microsoft Dynamics GP 2013.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# Send E-mail Statements checkbox/section grayed out in Customer Maintenance Options window in Microsoft Dynamics GP 2013

This article provides a solution to an issue where the Send E-mail Statements checkbox/section is grayed out in Customer Maintenance Options window in Microsoft Dynamics GP 2013.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2884548

## Symptoms

The Send E-mail Statements checkbox/section is grayed out in Customer Maintenance Options window in Microsoft Dynamics GP 2013.

## Cause

New functionality in Microsoft Dynamics GP 2013 has been added to send receivables statements using Word Templates. So if the checkbox for Customer Statement is marked in the Word Templates setup window, the Send Email Statements section/checkbox will be grayed out in the Customer Maintenance Options window as Word Templates doesn't use this section.

## Resolution

Navigate to **Tools** under Microsoft Dynamics GP, point to **Setup**, point to **Company** and select **Email Settings**. Select the **Sales Series**. (You may be prompted to enter your network password.) Review if the checkbox for Customer Statement is marked or not.

- Marking the Customer Statement checkbox in the Sales E-mail Setup window will generate the customer statement using the Word Templates functionality and will gray out the Send Email Statements section on the Customer Maintenance Options window.
- Unmarking the Customer Statement checkbox in the Sales E-mail Setup window will enable the Send Email Statements  section on the Customer Maintenance Options window so you can continue to generate customer statements through the Receivables module as you did in prior versions of Microsoft Dynamics GP.

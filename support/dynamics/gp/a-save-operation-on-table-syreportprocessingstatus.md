---
title: A save operation cannot find the table
description: Provides a solution to an error that occurs when printing remittances in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "A save operation on table 'syReportProcessingStatusHdr' cannot find the table" error message when printing remittances in Payables Management in Microsoft Dynamics GP

This article provides a solution to an error that occurs when printing remittances in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2901385

## Symptoms

When processing remittances for EFT in Payables Management in Microsoft Dynamics GP, this error happens:

> A save operation on table 'syReportProcessingStatusHdr' cannot find the table

## Cause

This message is caused by having the **template** option turned on to use Word Templates, but the users don't have a template set up. The *syReportProcessingStatusHdr* table is a temp table used to store the header information for the processing status of a Word Template. It's created as needed.

## Resolution

To resolve this issue:

1. Go to **Reports|Template Configuration**.

2. Select to expand **Enable all templates for all companies**.

3. Mark the appropriate selection as described below for your scenario:

    - If you don't use templates in any of the companies, then unmark the checkbox for **Enable Report Templates** option in the bottom-left corner.
    - However, if you do use templates in other companies, but this company, then uncheck the checkbox next to the Company database(s) that don’t use templates in the top portion of the window.
4. Select **Save**.

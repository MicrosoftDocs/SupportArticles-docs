---
title: How Remove Bank History utility works
description: Introduces how Remove Bank History utility works in Microsoft Dynamics GP.
ms.reviewer: theley, Cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Bank Reconciliation
---
# How the Remove Bank History utility works in Microsoft Dynamics GP

This article introduces how the Remove Bank History utility (**Microsoft Dynamics GP** > **Utilities** > **Financial** > **Remove Bank History**) works in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics SL Bank Reconciliation, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4073668

## Introduction

**In Microsoft Dynamics GP 2016 R2 (16.00.0541) and higher versions:** (only deletes from historical tables)

Mark to remove Reconciled Transactions, Voided transactions, or voided Receipts. At least one range restriction must be selected and the range selections will vary for what type of transaction you are trying to remove. If you mark the option to REMOVE HISTORY, and select PROCESS, the selected transactions will be deleted from the CM Transaction History (**CM30200**) table or CM Receipt History (**CM30300**) table. Transactions are now removed from historical tables only.

Transactions are no longer removed from the CM Transaction (CM20200) and CM Receipt (CM20300) tables. You must use the Reconciled Transaction Maintenance utility first (under **Microsoft Dynamics GP** > **Tools** > **Routines** > **Financial**) to move the transactions to history, before trying to remove them.

**In Microsoft Dynamics GP 2016 RTM (16.00.0439) and lower versions, Microsoft Dynamics GP 2015, Microsoft Dynamics GP 2013:** (Deletes from open tables)

Mark to remove Reconciled Transactions, Voided transactions, or voided Receipts. At least one range restriction must be select for Checkbook ID, Reconcile Audit Trail Code, or Statement Ending date. If you mark the option to REMOVE HISTORY, and select PROCESS, the selected transactions will be deleted from the CM Transaction (**CM20200**) table or CM Receipt (**CM20300**) table.

## More information

> [!NOTE]
> Under **Microsoft Dynamics GP** > **Tools** > **Setup** > **Financial** > **Bank Reconciliation**, the option for MAINTAIN HISTORY for Transaction/Reconciliation must be marked, otherwise transactions will disappear from the CM20200/CM20300 tables immediately when reconciled or voided.

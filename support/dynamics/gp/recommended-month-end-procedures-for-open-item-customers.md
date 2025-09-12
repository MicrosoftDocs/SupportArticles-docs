---
title: Recommended month-end procedures for Open Item customers in Receivables Management in Microsoft Dynamics GP
description: Describes the month-end procedures that are recommended for Open Item customers in Receivables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Financial - Receivables Management
---
# Recommended month-end procedures for Open Item customers in Receivables Management in Microsoft Dynamics GP

This article describes the month-end procedures that are recommended for Open Item customers in Receivables Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865910

The following month-end procedures are recommended for Open Item customers in Receivables Management:

- Post all transactions for the month.
- Make a backup of the company database.
- Print the Unapplied Documents report to determine whether you want to apply all the documents. To print the Unapplied Documents report, point to **Reports** on the **Sales** menu, and then click **Analysis**.
- Perform the aging routine. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then click **Aging**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then click **Aging**.
- Reconcile Receivables Management to the general ledger. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, perform the "Reconcile to GL" process for Receivables Management. The "Reconcile to GL" process generates a Microsoft Office Excel spreadsheet that can be used to match transactions in Receivables Management that have been posted to General Ledger. To open the "Reconcile to GL" window, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Financial**, and then click **Reconcile to GL**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, print the Historical Aged Trial Balance report. To do this, click **Reports**, point to **Sales**, and then click **Trial Balance**.
- Assess finance charges. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then click **Finance Charge**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then click **Finance Charge**.
- Post the finance charge batches. To do this, point to **Sales** on the **Transactions** menu, and then click **Series Post**.
- Print statements. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then click **Statements**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then click **Statements**.
- Transfer commissions. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then click **Transfer Commission**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then click **Transfer Commission**.
- Write off any outstanding credit amount balances or any outstanding debit amount balances in the Write Off Documents window. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then click **Write Off Documents**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then click **Write Off Documents.**
- In the Paid Sales Transaction Removal window, remove fully applied transactions. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then click **Paid Transaction Removal**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Sales**, and then click **Paid Transaction Removal**.
- (Optional) Print month-end reports. Month-end reports may include the following reports:
  - Receivables Transactions
  - Period Sales Analysis
  - Tax Period
- (Optional) In the Fiscal Period Setup window, close the fiscal periods for the Sales series. To do this, use one of the following steps:
  - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then click **Fiscal Periods**.
  - In Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, point to **Setup** on the **Tools** menu, point to **Company**, and then click **Fiscal Periods**.

## References

- [856577](https://support.microsoft.com/help/856577) Month-end procedures for Open Item customers in Receivables Management and in Project Accounting  

- [857019](https://support.microsoft.com/help/857019) Month-end procedures for Balance Forward customers

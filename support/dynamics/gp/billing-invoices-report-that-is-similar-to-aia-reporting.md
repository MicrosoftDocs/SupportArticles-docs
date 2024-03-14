---
title: Information about a billing invoices report that is similar to AIA reporting for construction billing for Microsoft Dynamics GP
description: Information about a billing invoices report that is similar to AIA reporting for construction billing for Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# Information about a billing invoices report that is similar to AIA reporting for construction billing for Microsoft Dynamics GP

This article provides information about a billing invoices report that is similar to AIA reporting for construction billing for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952221

## Introduction

The PA Invoice Format Project Summary Page 1 billing invoice and the PA Invoice Format Contract Summary Page 1 billing invoice in Project Accounting can be modified to display the necessary information for a report similar to AIA reporting.

Use the following links to download sample package files:

- PA Invoice Format Project Summary Page 1 billing invoice

    Release Date: June 24, 2009

    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

- PA Invoice Format Contract Summary Page 1 billing invoice

    Release Date: June 24, 2009

    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

> [!NOTE]
> The package file can be used for Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 9.0, and Microsoft Business Solutions - Great Plains 8.0.

## More information

The following computations are made for the AIA fields for downloaded reports from the Reports Library.

### Contractor's Application for Payment

- Original Contract Sum

    PA Project Amount - PA Total Change Order Amount

    > [!NOTE]
    > The PA Total Change Order Amount field contains unapproved change order amounts and approved change order amounts.

- Net change by Change Orders

    PA CO Baseline Project Amount + PA CO Baseline Fee Project Amount

    The fields in the calculation exist in one of the following tables:

  - Project level report: PA Project CO Periodic Totals MSTR table (PA01222)
  - Contract level report: PA Contract CO Periodic Totals MSTR table (PA01122)

    The PA CO Baseline Project Amount field contains one of the following:

  - Approved change order baseline budget amounts for FP projects
  - Approved change order forecast budget amounts for CP and T&M projects

    The PA CO Baseline Fee Project Amount field contains the approved change order fee amount for Project and Service Fees.

    > [!NOTE]
    > The periodic table range is the current billing period based on the billing cutoff date.

- Contract Sum to Date

    Original Contract Sum + Net Change by Change Orders

- Total Completed Stored to Date

    Previous actual billings + current billable amount
  
  - current billable amount

    T&M Billable Amount + CP/FP Billable Amount + Project Fees + Service Fees
  
  - previous actual billings

    PA Actual Billings field (PAPostedBillingsN) from the PA Project Periodic Totals MSTR table or the PA Contract Periodic Totals MSTR table

    > [!NOTE]
    > The periodic table range is from the current billing period based on the billing cutoff date.

- Retainage

    Previous actual retention amount + the current retention amount

  - previous actual retention amount PA Actual Retention Amount field (PAPOSTRETAMT) from the PA Project Periodic Totals MSTR table or the PA Contract Periodic Totals MSTR table

    > [!NOTE]
    > The periodic table range is from the current billing period based on is computed as previous actual retention amount plus the current retention amount.

- Total Earned less Retainage

    Total Completed Stored to Date - Retainage

- Less Previous Certificates for Payment

    Actual billings - actual retention amount.

- Current Payment Due

    Total Earned Less Retainage - Less Previous Certificates for Payment.

    > [!NOTE]
    > This amount will match the total amount due for the project or contract because it does not include taxes, retention fees, and retainer fees.

- Balance to Finish, including Retainage

    Contract Sum to Date - Total Earned Less Retainage.

### Change Orders Summary

- Total approved this month

    PA CO Baseline Project Amount + PA CO Baseline Fee Project Amount

    The **Total Approved this month** field is the approved change order budget and fee amount for the current billing period based on the billing cutoff date.

    The fields in the calculation exist in one of the following tables:

  - Project level report: PA Project CO Periodic Totals MSTR table (PA01222)
  - Contract level report: PA Contract CO Periodic Totals MSTR table (PA01122)

- Total changes approved in previous months by Owner

    Net change by Change Orders - Total approved this month.

- Net changes by Change Order

    Total changes approved in previous months by Owner + Total approved this month.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

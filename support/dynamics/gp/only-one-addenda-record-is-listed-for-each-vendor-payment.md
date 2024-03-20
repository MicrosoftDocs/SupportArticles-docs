---
title: Only one addenda record is listed for each vendor payment in the EFT file
description: Provides a solution to a problem where only one addenda record is added for each vendor to the EFT file when you add an invoice number or addenda record to the existing EFT file format.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# Only one addenda record is listed for each vendor payment in the EFT file when using Electronic Funds Transfer for Payables Management in Microsoft Dynamics GP

This article provides a solution to an issue where only one addenda record is listed for each vendor payment when you add an invoice number or addenda record to the existing EFT file format.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2413184

## Symptoms

If you add an addenda line to the existing EFT file format in Payables Management in Microsoft Dynamics GP, only one addenda record is listed for each vendor payment. You would expect multiple addenda lines (each invoice that totals the payment amount) to be listed under the vendor payment detail line. Only one addenda line prints and the rest of the addenda records are missing.

For example, if five invoices make up the total vendor payment line, only the first addenda record is listed and the other four addenda records are omitted. You would expect five addenda records to be listed under the detail line for the vendor payment.

## Cause

This is a problem in Microsoft Dynamics GP 10.0 and earlier versions, when using addenda records in the EFT file format. The addenda record will return only "one" addenda record under each vendor payment when the check batch was generated using **One Check Per Vendor**.

This issue was fixed in Microsoft Dynamics GP 2010 Service Pack 1.

## Resolution

Upgrade to Service Pack 1 or higher for Microsoft Dynamics GP 2010.

## Workaround

During the **Select Checks** process, select the option for **One Check per Invoice** instead of **One Check per Vendor**. This work-around will generate a payment or detail line for each invoice, so there should only be one addenda record for each detail line.

## More information

This issue was not fixed in Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0.

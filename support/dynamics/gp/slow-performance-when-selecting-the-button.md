---
title: Slow performance when selecting the button
description: Provides a solution to an issue where slow performance is experienced when selecting the Generate EFT button for a sales batch using Electronic Funds transfer for Receivables.
ms.reviewer: lmuelle, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Slow performance when you select the Generate EFT File button for an RM Cash Receipts batch using EFT for Receivables in Dynamics GP 2010

This article provides a solution to an issue where slow performance is experienced when selecting the **Generate EFT** button for a sales batch in Microsoft Dynamics GP 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2531207

## Symptoms

Slow performance is experienced when selecting the **Generate EFT** button for a sales batch in Microsoft Dynamics GP 2010.

## Cause

It's a known quality issue in Microsoft Dynamics GP 2010 and was fixed in the 2011 US Payroll Year-end update patch. The performance issue is caused by a stored procedure that scans the CM Receipt (CM20300) table in Bank Reconciliation looking for the exact receipt record to automatically deposit. As the CM20300 gets larger, this EFT file generation process will take longer to complete.

## Resolution

This issue was fixed in version 11.00.1852 and was included with the Year-End Compliance patch for 2011.

> [!NOTE]
> If you aren't using Bank Reconciliation, you can periodically delete the data in the CM20300 table as a work-around.

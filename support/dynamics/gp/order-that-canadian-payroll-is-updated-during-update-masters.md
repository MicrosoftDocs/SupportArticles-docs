---
title: Order that Canadian Payroll is updated during Update Masters
description: This article lists the order that Canadian Payroll tables are updated during the Update Masters process to assist with batch posting issues. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Order that Canadian Payroll is updated during Update Masters for Microsoft Dynamics GP

This article lists the order that Canadian Payroll tables are updated during the Update Masters process to assist with batch posting issues.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2462948

## Symptoms

If the payroll batch in Canadian Payroll becomes stuck or there is a posting interruption during the Update Masters process, restore to a backup immediately and rerun the payrun. However, if that is not possible, then review the tables in Canadian Payroll that are updated during the posting process.

## Cause

Posting interruption.

## Resolution

If the Update Masters process has started, you will not be able to set the batch back to available status. Instead, you will need to review the following tables to remove any data that posted from this batch. Then recreate the batch and start the payrun process over.

The following is the order that Canadian Payroll is updated:

Batch MSTR - CPY30260  
CSB MSTR - CPY30264  
WS TRX MSTR - CPY30262  
PA TRX MSTR - CPY30265  
Calc MSTR - CPY30250  
Post MSTR - CPY30230  
Post Detail MSTR - CPY30231  
Cheque MSTR - CPY30210  
Distribution MSTR - CPY30235  
Pay code Distribution MSTR - CPY30236  
Batch Setup (flags) - CPY30010  
EE Banked OT - CPY10110  
EE Banked Sick - CPY10130  
EE Banked Stat - CPY10120  
EE Banked Leave - CPY10115  
Delayed Deductions - CPY10135  
EE Pay code YTD -CPY10160  
Pay code Base Amounts - CPY30263  
Employee Master - CPY10100  
EE Miscellaneous - CPY10101  
Control - CPY20100  
CSB Setup - - CPY20110  
Checkbook MSTR/Transaction - - CM00100/CM20200  
Clear WS TRX Entry - CPY30101  
Clear PA TRX Entry - CPY30102  
Clear Manual Cheque: WORK - CPY30105  
Detail - CPY30106  
Clear Batch Entry - P_Batch_Entry - CPY30100

The last four items above get updated during update masters. However, unlike the others, records are removed from them, rather than being added or updated.

The following tables are also updated:

CDN Payroll Employee T4 File - CPY10103  
CDN Payroll Employee T4A File - CPY10104  
CDN Payroll Employee R1 - CPY40105

> [!NOTE]
> The above table list may not be complete.

The supported method is to restore to your backup immediately if there is a posting interruption during the update masters process. If that is not possible, then you are on your own to review the tables above to remove any data from the interrupted batch. Then recreate the batch and start the payrun process over. Cleaning up these tables for you falls under Microsoft's consulting guidelines for *data-fixing* and is not covered by your regular support plan.

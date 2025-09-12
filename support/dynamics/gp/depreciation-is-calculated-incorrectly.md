---
title: Depreciation is calculated incorrectly
description: Provides a solution to an issue where depreciation is calculated incorrectly when you use a Month averaging convention in the Fixed Assets module of Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, ryanklev
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# Depreciation is calculated incorrectly when you use a Month averaging convention in the Fixed Assets module of Microsoft Dynamics GP

This article provides a solution to an issue where depreciation is calculated incorrectly when you use a Month averaging convention in the Fixed Assets module of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2023750

## Symptoms

Depreciation is calculated incorrectly when you use a Month averaging convention in the Fixed Assets module of Microsoft Dynamics GP.

## Cause

A Month averaging convention should only be used in a scenario where your Fixed Assets calendar is set up as a true calendar year (Jan 1 - Dec 31) with periods that begin on the true FIRST DAY day of every month and end on the true last day of every month (Such as Jan 1-31, Feb 1-28, Mar 1-31, and so on). If your Fixed Assets calendar isn't a true calendar year and/or doesn't have periods set up with the true first and last day of each month, then you wouldn't want to use the Month averaging convention. The Month averaging conventions in Dynamics GP that should only be used for periods set up this way involve the following ones:

- Mid-Month(1st)
- Mid-Month(15th)
- Next Month
- Full Month

## Resolution

The Month averaging conventions aren't intended to be used when your Fixed Assets calendar isn't set up as a true calendar year (Jan 1 - Dec 31) and doesn't contain period dates true to the first and last day of each month. If the Fixed Assets calendar isn't set up as a true calendar year and doesn't contain period dates true to the first and last day of each month, you'll need to change the Averaging Convention assigned to the Asset ID to correct the depreciation figures. After you change the Averaging Convention assigned in the Asset Book window, you'll be prompted with a warning message that states:
> "You have changed a depreciation sensitive field. This will result in depreciation values being recalculated. Do you wish to continue?"

After you select **Yes** to this message, you'll then need to decide upon one of the following options:

- **Option 1: Reset Life**

    This option recalculates depreciation from the Place in Service Date up through the date the asset is already depreciated. Depreciation adjustments will be made for each period. The prior year depreciation amount will post to the Prior Year Depreciation account.

    > [!NOTE]
    > This depreciation doesn't have to be posted to General Ledger for each of these periods. The General Ledger Posting window allows you to select a range of periods from the Financial Detail file and then post the entire amount to the period of the transaction date. The net adjustment to depreciation can be included in the current month GL posting.

- **Option 2: Reset Year**  

    This option calculates a new yearly depreciation rate, and uses this rate to begin recalculating depreciation from the beginning of the current fiscal year up through the date the asset is already depreciated.

    > [!NOTE]
    > This depreciation doesn't have to be posted to General Ledger for each of these periods. The General Ledger Posting window allows you to select a range of periods from the Financial Detail file and then post the entire amount to the period of the transaction date. The net adjustment to depreciation can be included in the current month GL posting.

- **Option 3: Recalculate**

    This option calculates a new yearly depreciation rate as of the beginning of the current fiscal year, but doesn't begin using this rate until the next time depreciation is taken on this asset. This process doesn't change the current year-to-date depreciation amount. The difference between the new yearly rate and the current year-to-date depreciation amount will be allocated over the remaining time in the current fiscal year.

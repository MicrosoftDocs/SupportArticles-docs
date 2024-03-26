---
title: Purchase button not showing in Fixed Asset General Information
description: The Purchase button does not show in Fixed Asset General Information window in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# Purchase button does not show in the Fixed Asset General Information window in Microsoft Dynamics GP

This article provides a resolution to make sure the Purchase button can show in the Fixed Asset General Information window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2761966

## Symptoms

The Purchase button is missing from the Fixed Asset General Information window in Microsoft Dynamics GP.

## Cause

The setup is not complete. See Resolution section below.

## Resolution

There are five requirements to have Payables interface with Fixed Assets, and the Purchase button to appear on the Fixed Asset General Information window:

1. On the **Microsoft Dynamics GP** menu, select **Tools**, point to **Setup**, point to **Fixed Assets** and select **Company**. Make sure the **Post PM through to FA** checkbox is marked.
2. Also on the Fixed Assets Company Setup window, make sure the **Require Account** checkbox is marked.

3. On the **Microsoft Dynamics GP** menu, select **Tools**, point to **Setup**, point to **Fixed Assets** and select **Purchase Posting Accounts**. Select the **Lookup** button next to the **Account number** field and make sure a GL account has been specified. The accounts listed here will be the trigger accounts to interface Purchasing with Fixed Assets.

4. Fixed Assets must be installed on that particular workstation.

5. When entering the transaction in Payables Transaction Entry, select the **Distributions** button. The trigger account must be keyed in the PURCH line and a debit to the trigger account (from step 3). Post the transaction in Payables.

Now when you go to the Asset General Information window in Fixed Assets, the Purchase button will show. However, first you must enter the Asset ID and suffix, then select the **Purchase** button and mark the checkbox for the purchases document you wish and select **Select** to have it populate the Asset General Information window.

---
title: Retained earnings account not found error
description: You may receive the Retained earnings account not found error when closing the GL year in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# "Retained earnings account not found" error when closing the GL year in Microsoft Dynamics GP

This article provides a resolution for the issue that you may receive a **Retained earnings account not found** error when closing the GL year in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4462490

## Symptoms

When trying to close the GL year in Microsoft Dynamics GP, you receive the following error message:

> Retained earnings account not found.

## Cause

What is likely occurring here is you're closing to Divisional Retained Earnings Accounts and you're missing a Divisional Account(s) that pertains to the Retained Earnings account.

This issue usually happens when a new Account Segment is created.

For example:

Let's say my retained earnings account is 000-1200-01, and I use Divisional Retained earnings and close to the FIRST segment. The second and third segments stay the same. I have segments 100,200,300, and so I have accounts 100-1200-01, 200-1200-01 and 300-1200-01 set up. If I create a new segment of 111, I would also need to set up account 111-1200-01 for my retained earnings to work if you're closing by Divisional Retained earnings.

## Resolution

1. Go to **Tools** > **Setup** > **Financial** > **General Ledger** and view your Retained Earnings account and if you're closing to divisional account segments and if so, which segment.

1. Review all the segments created for that segment (**Tools** > **Setup** > **Financial** > **Segment**).

1. Go to **Cards** > **Financial** > **Account** and verify that all the GL accounts exist that are needed to close to divisional retained earnings. (that is, make sure all the accounts exist using the Retained earnings account you found in step 1 above with all the combinations of the segments found in step 2 above.)

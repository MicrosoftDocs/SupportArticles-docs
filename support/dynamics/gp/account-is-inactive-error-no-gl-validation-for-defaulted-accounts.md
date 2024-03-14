---
title: Account is inactive error and no GL validation for defaulted accounts
description: Introduces a by design behavior that there's no GL validation for defaulted accounts in RM/PM/SOP/POP in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
---
# "Account is inactive" error and no GL validation for defaulted accounts in RM/PM/SOP/POP in Microsoft Dynamics GP

This article describes a by design behavior that there is no GL validation for defaulted accounts when posting a document in RM/PM/SOP/POP in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4508207

## Symptoms

When you post a document in Payables management (PM), Receivables managements (RM), Sales order processing (SOP), or Purchasing order processing (POP) with a defaulted distribution account, it posts fine in the submodule, but will fall out to Batch recovery in GL. The General Ledger edit list shows this informational message:

> Account is inactive; please activate or change the account.

> [!NOTE]
> The defaulted account can come from posting accounts setup, customer/vendor posting setup, item setup, and so on.

## More information

This issue is by design. When you inactive a GL account, it's only inactivated in GL and prevents the account from showing up in account lookup lists in transaction windows going forward.

There's no validation back to any of the current default posting setups at the time you inactive the GL account, or in the submodule when posting a transaction using the defaulted GL account.

The user would be expected to manually remove the account from all default posting windows for account setups, vendor accounts, customer accounts, and so on. at the time the GL account is inactivated. If this is not done, then the batch will post in the submodule without error, but when it posts to GL the validation is performed and the batch may fall out to Batch recovery.

## To vote

If you would like this considered for a future product enhancement, select the product suggestion link below and vote on it:

["Account is inactive" error in GL when posting from submodule](https://experience.dynamics.com/ideas/idea/?ideaid=3434cf8b-a18b-e911-80e7-0003ff68d305)

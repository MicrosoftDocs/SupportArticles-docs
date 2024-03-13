---
title: Cannot turn off AA Trx Edit Lists
description: Describes a by design behavior that you can't turn off the AA Trx Edit Lists in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Can't turn off the "AA Trx Edit Lists" in Microsoft Dynamics GP

This article describes a by design behavior that you can't turn off the AA Edit Lists when you print an Edit List in a submodule in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3179118

## Symptoms

When you print a Payables Transaction Edit List, you're also prompted to print the AA Transaction Edit List and you would like to turn off the prompt to print the AA Edit List.

## More information

This issue is by design.

There are no options to turn off the AA Edit Lists when you print an Edit List in a submodule (that is, Payables, SOP, and so on) at this time. This behavior is the design of the system. All modules are integrated with AA at the transaction level (whatever if you have any GL accounts linked to AA used on the transaction or not). And this is how the system tracks and alerts you what transactional information is updated to the AA tables. So, there are no options to turn this AA edit list off at this time, without inactivating the Analytical Accounting module.

However, you can only turn off the AA Posting Journals under **Microsoft Dynamics GP** > **Tools** > **Setup** > **Posting** > **Posting**.

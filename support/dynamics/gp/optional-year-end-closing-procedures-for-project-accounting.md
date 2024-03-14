---
title: Optional year-end closing procedures for Project Accounting
description: Describes the optional year-end closing procedures for Project Accounting in Microsoft Dynamics.
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# Optional year-end closing procedures for Project Accounting in Microsoft Dynamics

This article describes the optional year-end closing procedures for Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 875116

Project Accounting does not have any required year-end closing procedures for the fiscal year or for the calendar year. Projects can span multiple fiscal periods. Additionally, projects are independent of the fiscal year and of the calendar year.

You may perform the following procedures as part of the year-end process:

1. Post all cost transactions.
2. Run the final billings and revenue recognition on projects for the year. You do this to make sure that the General Ledger module is updated before you run the year-end routine in the General Ledger module. After you do this, Project Accounting and General Ledger will reconcile more quickly and easily.
3. Update the rate tables in the PA Position Rate Table Maintenance and PA Employee Rate Table Maintenance windows.

---
title: Unable to upgrade the LinkedInSalesNavigatorForUnifiedClient solution
description: Resolves issues related to upgrading the LinkedInSalesNavigatorForUnifiedClient solution in Microsoft Dynamics 365 Sales.
author: udaykirang
ms.author: udag
ms.reviewer: sagarwwal
ms.date: 10/18/2024
ms.custom: sap:LinkedIn Sales Navigator\LinkedIn Sales Navigator integration errors
---
# Can't upgrade the LinkedInSalesNavigatorForUnifiedClient solution

This article helps you resolve issues related to upgrading the **LinkedInSalesNavigatorForUnifiedClient** solution in Microsoft Dynamics 365 Sales.

## Symptoms

You can't upgrade the **LinkedInSalesNavigatorForUnifiedClient** solution from version 1.*x* to 3.*x*.

## Cause

This issue occurs due to existing dependencies associated with the solution. You can't update a solution that has dependencies.

## Resolution  

To resolve this issue, you must remove the existing dependencies for the **LinkedInSalesNavigatorForUnifiedClient** solution. Follow these steps:  

1. For the current **LinkedInSalesNavigatorForUnifiedClient** solution, remove the dependencies and uninstall the solution. For more information, see step 4 in [Uninstall LinkedIn Sales Navigator](/dynamics365/linkedin/uninstall-sales-navigator).  

1. Uninstall the **msdyn_LinkedInSalesNavigatorAnchor** solution.  

1. After the solutions are successfully deleted, reinstall them. For more information, see [Install and enable LinkedIn Sales Navigator](/dynamics365/linkedin/install-sales-navigator).  

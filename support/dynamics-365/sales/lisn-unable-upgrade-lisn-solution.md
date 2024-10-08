---
title: Unable to upgrade the LinkedInSalesNavigatorForUnifiedClient solution
description: Learn how to resolve issues related to upgrading the LinkedInSalesNavigatorForUnifiedClient solution in Dynamics 365 Sales.
author: udaykirang
ms.author: udag
ms.reviewer: udag
ms.topic: troubleshooting
ms.collection: 
ms.date: 10/03/2024
ms.custom: bap-template 
---

# Unable to upgrade the LinkedInSalesNavigatorForUnifiedClient solution

This article helps you resolve issues related to upgrading the **LinkedInSalesNavigatorForUnifiedClient** solution in Dynamics 365 Sales.

## Symptom

You're unable to upgrade the **LinkedInSalesNavigatorForUnifiedClient** solution from 1.*x* to 3.*x*. This issue occurs because of the dependencies that exist for the solution: you can’t update the solution that has dependencies associated with it.  

## Resolution  

To resolve this issue, you must remove the existing dependencies for the **LinkedInSalesNavigatorForUnifiedClient** solution. Follow these steps:  

1. For the current **LinkedInSalesNavigatorForUnifiedClient** solution, remove the dependencies and uninstall the solution. For more information, see step 4 in [Uninstall LinkedIn Sales Navigator](/dynamics365/linkedin/uninstall-sales-navigator).  
1. Uninstall the **msdyn_LinkedInSalesNavigatorAnchor** solution.  
1. After the solutions are successfully deleted, install them again. More information: [Install and enable LinkedIn Sales Navigator](/dynamics365/linkedin/install-sales-navigator).  

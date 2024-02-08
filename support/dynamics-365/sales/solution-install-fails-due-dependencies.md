---
title: Solution install fails due to dependencies
description: Provides a solution to an issue where solution install fails because of dependencies that don't exist in a CDS environment.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Solution install fails because of dependencies that don't exist in a CDS environment

This article provides a solution to an issue where solution install fails because of dependencies that don't exist in a CDS environment.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4499731

## Symptoms

When you attempt to import a solution in Dynamics 365, the import fails because of missing dependencies. If you're installing the solution from the administration center, you may just see a message indicating installation failed. If you're importing a solution from the Dynamics 365 web application, you may see more details such as what dependencies are missing.

## Cause

It can occur if the solution requires components that don't exist in a Common Data Service (CDS) environment. A CDS only environment doesn't have all the entities included and only includes some standard entities. If the solution you're attempting to install depends on an entity that doesn't exist in your environment (ex. an entity that only exists in the sales app), the solution would fail to install successfully.

## Resolution

Only attempt to install the solution in an environment that includes the required components. There are many solutions that can be found in the Administration Center and AppSource that can only be installed if you have certain licenses such as a license that includes the Sales app.

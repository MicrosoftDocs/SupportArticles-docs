---
title: The publisher name cannot be changed
description: Provides a solution to the 8004801c error that occurs when attempting to import a solution in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "The publisher name cannot be changed from '[publisher name]' to '[other publisher name]'" error occurs when importing solution in Microsoft Dynamics 365

This article provides a solution to an error that occurs when attempting to import a solution in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4463386

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The following managed solution cannot be imported: [solution name]. The publisher name cannot be changed from '[publisher name]' to '[other publisher name]'  
Error code 8004801c"

## Cause

This error can occur if you attempt to import a solution that is already installed but the Publisher has changed.

## Resolution

Changing the Publisher for a solution isn't supported.

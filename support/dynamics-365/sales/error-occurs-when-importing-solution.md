---
title: Error occurs when importing a solution
description: Describes an error that occurs when importing a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The import solution must have a higher version than the existing solution it is upgrading error occurs when importing a Microsoft Dynamics 365 solution

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4499878

## Symptoms

When attempting to import a solution in Dynamics 365, you see an error with the following message:

> "The import solution must have a higher version than the existing solution it is upgrading"

You may also see a reference to error code 80048541.

## Cause

This error can occur if you're trying to import a solution upgrade but the version of the solution isn't higher than the currently installed solution.

## Resolution

When upgrading a solution, make sure the version of the solution you're importing is higher than the version that is already installed.

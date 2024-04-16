---
title: The solution package was on 365 Online
description: Provides a solution to the code 8004806B error that occurs when attempting to import a solution in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# The solution package you are importing was generated on Microsoft Dynamics 365 Online, it cannot be imported into on-premises or hosted versions of Microsoft Dynamics 365

This article provides a solution to an error that occurs when attempting to import a solution in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4457896

## Symptoms

When attempting to import a solution in Dynamics 365, you see the following message:

> "The solution package you are importing was generated on Microsoft Dynamics 365 Online, it cannot be imported into on-premises or hosted versions of Microsoft Dynamics 365."
You may also see a reference for error code 8004806B.

## Cause

This solution can't be imported into an on-premises or hosted version of Dynamics 365.

## Resolution

Only try to import this solution in a Dynamics 365 Online organization.

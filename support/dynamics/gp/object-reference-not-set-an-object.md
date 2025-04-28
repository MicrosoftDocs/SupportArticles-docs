---
title: Object reference not set to an object
description: Provides a solution to an error that occurs when you try to open the Query Relationship window in Integration Manager for Microsoft Dynamics GP 10.0.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Object reference not set to an instance of an object" Error message in Integration Manager for Microsoft Dynamics GP 10.0

This article provides a solution to an error that occurs when you try to open the Query Relationship window in Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 967738

## Symptoms

When you try to open the Query Relationship window in Integration Manager for Microsoft Dynamics GP 10.0, you receive the following error message:

> Object reference not set to an instance of an object
>
> Source: Microsoft.Dynamics.GP.IntegrationManager.frmRelationships.SetNextPosition  
> Message: Object reference not set to an instance of an object  
> Number: -2147221462
>
> Call Stack:
>
> frmRelationships.SetNextPosition  
frmRelationships.GetQueryDimensions  
frmRelationships.DisplayQueries  
frmRelationships.Form_Activate

## Cause

This issue occurs when you remove an integration source file before you remove the query relationship.

## Resolution

To resolve this issue, follow these steps:

1. Remove all the integration sources on the integration except the main source.

2. Add one source back to the integration.

3. Open the Relationships window, and then set the relationship.

4. Repeat steps 2 and 3 until all the sources are on the integration and until the relationship is linked.

---
title: AA budgets are doubled in Management Reporter
description: AA budgets are doubled in Management Reporter using Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# AA budgets are doubled in Management Reporter using Microsoft Dynamics GP

This article provides more information to solve the issue that AA budgets in Microsoft Dynamics GP are not being read correctly by Management Reporter. The budget amounts may show as doubled on the MR report. Or it may only show one set of dimensions.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Management Reporter 2012  
_Original KB number:_ &nbsp; 4013058

## Resolution

If one dimension is owned by another dimension, then both dimensions need to be added. If you add only one dimension, then you will only see that one. If you do not add any, then the amounts may be doubled. If one dimension is owned by another, you should add both to the account to have the amounts show correctly on the MR report. See the example in the below blow article:

[Reporting on AA budgets in MR](https://community.dynamics.com/blogs/post/?postid=6a43acd4-e5e9-4383-a9b7-d81fa862518a)

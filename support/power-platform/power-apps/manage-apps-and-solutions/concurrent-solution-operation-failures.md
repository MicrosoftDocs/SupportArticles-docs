---
title: Concurrent solution operation failures 
description: Solution operations like import, delete, publish customization, create solution component and background ribbon calculation, these can result in failure because of Concurrent operations. Only one operation can be done at a time, customer needs retry later if they still see failure.
ms.reviewer: jdaly
ms.date: 08/16/2023
author: swatimadhukargit
ms.author: swatim
---
# Concurrent solution operation failures

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to do any of these solution operations:

- Import solution
- Delete solution
- Publish customizations
- Create solution component
- Background ribbon calculation

You get an error: **Please try again later**.

## Error example

> Microsoft.Crm.ObjectModel.CustomizationLockException: Cannot start the requested operation [PublishAll] because there is another [Import] running at this moment. Use Solution History for more details. -- The solution installation or removal failed due to the installation or removal of another solution at the same time. Please try again later.


## Cause

Dataverse only allows one solution operation at a time. A concurrent request for different solution operations returns this error until the previous operation is completed.

## Workaround

- You can avoid conflicts by not attempting multiple operations at a time in an environment. Waiting is the only resolution.
- You can avoid conflicts by being aware of your [maintenance window](/power-platform/admin/policies-communications#maintenance-timeline) and by scheduling your deployment accordingly. For production environment, you can [change your maintenance window](/power-platform/admin/manage-maintenance-window) by shifting to another time.
- You can also [watch the solution history page](/power-apps/maker/data-platform/solution-history) to check for completion any other operations on the environment.

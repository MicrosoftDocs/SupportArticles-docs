---
title: Concurrent solution operation failures in Power Apps
description: Works around the Cannot start the requested operation because there is another running error that occurs when you perform multiple solution operations at a time in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 04/17/2025
author: swatimadhukargit
ms.author: swatim
ms.custom: sap:Working with Solutions\Solution import - Other errors
---
# Concurrent solution operation failures

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when you perform multiple solution operations simultaneously in Microsoft Power Apps. These concurrent operations can cause failures because only one operation can be performed at a time. If you encounter a failure, retry the operation later.

## Symptoms

When you try to perform multiple solution operations simultaneously, such as:

- Import a solution
- Delete a solution
- Publish customizations
- Create a solution component
- Background ribbon calculation

You receive an error message like the following one:

> Microsoft.Crm.ObjectModel.CustomizationLockException: Cannot start the requested operation [PublishAll] because there is another [Import] running at this moment. Use Solution History for more details. -- The solution installation or removal failed due to the installation or removal of another solution at the same time. Please try again later.

## Cause

Dataverse allows only one solution operation at a time. A concurrent request for different solution operations returns the error until the previous operation is completed.

## Workaround

Performing multiple operations simultaneously in an environment can lead to conflicts, so it's best to avoid doing so. 

To prevent conflicts,

- Be aware of your [maintenance window](/power-platform/admin/policies-communications#maintenance-timeline) and schedule your deployment accordingly. If you're working in a production environment, you can [change your maintenance window](/power-platform/admin/manage-maintenance-window) by shifting to a different time.
- [Use the solution history page](/power-apps/maker/data-platform/solution-history) to check the status of operations in the environment.

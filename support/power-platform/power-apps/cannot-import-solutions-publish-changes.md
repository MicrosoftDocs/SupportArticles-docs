---
title: Can't import solutions or publish changes
description: Describes an issue in which import solutions or publish changes fails in Power Platform. Provides workarounds.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 06/18/2021
---
# Can't import solutions or publish unmanaged changes in Power Platform

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) or publish unmanaged changes by using the [**Publish all customizations**](/powerapps/maker/data-platform/create-solution#publish-changes) function in Power Platform, you receive the following error message:

> [error]Cannot start the requested operation [PublishAll] because there is another [Import] running at this moment.
Use Solution History for more details. -- The solution installation or removal failed due to the installation or
removal of another solution at the same time. Please try again later.

## Cause

This issue occurs because another solution is being imported at the same time.

## Workaround

To work around this issue, use one of the following methods according to the development environment:

- **Single-user**: Import solutions one by one and make sure that the previous solution is imported.
- **Multi-user**: Create a central repository, and use automated deploy solutions such as [Azure Pipelines](https://azure.microsoft.com/services/devops/pipelines) or [GitHub Actions](https://docs.github.com/actions) to import solutions in queues.

---
title: Can't import solutions or publish changes
description: Describes an issue in which import solutions or publish changes fail in Power Platform. Provides workarounds.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 06/18/2021
author: nhelgren
ms.author: risquass
---
# Can't import solutions or publish unmanaged changes in Power Platform

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to [import a solution](/powerapps/maker/data-platform/import-update-export-solutions) or use the [**Publish all customizations**](/powerapps/maker/data-platform/create-solution#publish-changes) function to publish unmanaged changes in Microsoft Power Platform, you receive the following error message:

> Error: Cannot start the requested operation [PublishAll] because there is another [Import] running at this moment. Use Solution History for more details. -- The solution installation or removal failed due to the installation or removal of another solution at the same time. Please try again later.

## Cause

This issue occurs because another solution is being imported at the same time.

## Workaround

To work around this issue, use one of the following methods, according to the development environment:

- **Single-user**: Make sure that the previous solution is imported before you import the next one.
- **Multi-user**: Create a central repository, and use automated deployment such as [Azure Pipelines](https://azure.microsoft.com/services/devops/pipelines) or [GitHub Actions](https://docs.github.com/actions) to import solutions in queues.

---
title: Troubleshooting ribbon issues in Power Apps
description: Provides workarounds to ribbon issues in Power Apps.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 05/15/2021
---
# Troubleshooting ribbon issues in Power Apps

This guide provides help and resolution if you are experiencing an issue in a Power Apps model-driven app or a customer engagement app (Dynamics 365 Sales, Customer Service, Field Service, or Marketing) with a ribbon command bar button.

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

> [!IMPORTANT]
> The ribbon troubleshooting information is only applicable to [Unified Interface apps](/powerapps/user/unified-interface); it isn't applicable to the legacy web client interface.

## Identify the issue

This guide is companion to an in-app tool called **Command Checker** to inspect the ribbon component definitions to help us determine what might be causing problems.

When the tool is run, you will be asked to identify or choose one of the items from the list below of the most common types of ribbon command bar problems. Select the link below to know more about troubleshooting each area:

- [A button in the command bar is hidden when it should not be](ribbon-issues-button-hidden.md)

- [A button in the command bar is visible when it should not be](ribbon-issues-button-visible.md)

- [A button in the command bar is not working correctly](ribbon-issues-button-not-working-correctly.md)

> [!IMPORTANT]
> Missing or incorrect ribbon metadata is often the cause for the above issues and can typically be resolved by regenerating all ribbon metadata. The in-app tool (**Command Checker**) has a feature to allow you to [trigger the regeneration of all ribbon metadata](regenerate-ribbon-metadata.md).

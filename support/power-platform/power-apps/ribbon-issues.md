---
title: Troubleshooting ribbon issues in Power Apps
description: Provides a resolution for ribbon issues in Power Apps.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 05/15/2021
ms.subservice: powerapps-ribbons-commanding
---
# Troubleshooting ribbon issues in Power Apps

This guide helps you resolve issues that affect a ribbon command bar button in a Power Apps model-driven app or a customer engagement app (Dynamics 365 Sales, Customer Service, Field Service, or Marketing).

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

> [!IMPORTANT]
> This ribbon troubleshooting information is applicable to only [Unified Interface apps](/powerapps/user/unified-interface). It isn't applicable to the legacy web client interface.

## Identify the issue

This is a companion guide for an in-app tool, Command Checker, that lets you inspect the ribbon component definitions to help us determine what might be causing issues.

When you run the tool, you're asked to identify or choose one of the items in the following list of the most common kinds of ribbon command bar issues. Select the appropriate link to learn more about how to troubleshoot that issue:

- [A button on the command bar is hidden when it should be visible](ribbon-issues-button-hidden.md)

- [A button on the command bar is visible when it should be hidden](ribbon-issues-button-visible.md)

- [A button on the command bar is not working correctly](ribbon-issues-button-not-working-correctly.md)

> [!IMPORTANT]
> These issues are often caused by missing or incorrect ribbon metadata. Typically, this situation can be resolved by regenerating all ribbon metadata. Command Checker has a feature that enables you to [trigger the regeneration of all ribbon metadata](regenerate-ribbon-metadata.md). Only system administrators, system customizers, and makers have the permissions to regenerate metadata.

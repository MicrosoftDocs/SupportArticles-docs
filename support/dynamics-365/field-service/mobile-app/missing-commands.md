---
title: Commands disappear in offline mode
description: Describes an issue where a button on the command bar is missing in offline mode.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/14/2023
ms.custom: sap:offline-data-sync-other
---
# Commands disappear in offline mode

## Symptoms

When a user is offline, custom commands and default commands without the `Mscrm.IsEntityAvailableForUserInMocaOffline` [enable rule](/power-apps/developer/model-driven-apps/define-ribbon-enable-rules) don't show.

## Resolution

The following articles introduce how to customize commands and how to use the command checker to check if that flag is used and how to fix it.

- [Customize commands and the ribbon](/powerapps/developer/model-driven-apps/customize-commands-ribbon)
- [Fix hidden buttons on the command bar](../../../power-platform/power-apps/create-and-use-apps/ribbon-issues-button-hidden.md?tabs=fix)

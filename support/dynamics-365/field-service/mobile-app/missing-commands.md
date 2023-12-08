---
title: Commands disappear in offline mode
description: Troubleshoot issues when a button on the command bar is missing in offline mode.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/08/2023
ms.custom: sap:offline-data-sync-other
---
# Commands disappear in offline mode

## Symptoms

If the user is offline, custom commands and default commands without the `Mscrm.IsEntityAvailableForUserInMocaOffline` [enable rule](/power-apps/developer/model-driven-apps/define-ribbon-enable-rules) don't show.

## Resolution

The following articles introduce how to customize commands and how the command checker can be used to check if that flag is used and how to fix it.

- [Customize commands and the ribbon](/powerapps/developer/model-driven-apps/customize-commands-ribbon)
- [Fix hidden buttons on the command bar](../../../power-platform/power-apps/create-and-use-apps/ribbon-issues-button-hidden.md?tabs=fix)

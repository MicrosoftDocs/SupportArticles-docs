---
title: Commands disappear when in offline mode
description: Troubleshoot issues when a button on the command bar is missing in offline mode.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 11/20/2023
---

# Commands disappear when in offline mode

## Symptoms

If the user is offline, custom commands and default commands without the `Mscrm.IsEntityAvailableForUserInMocaOffline` enable rule don't show.

## Resolutions

The following articles show how to customize commands and how the command checker can be used to check if that flag is used and how to fix it.

- [Customize commands and the ribbon](/powerapps/developer/model-driven-apps/customize-commands-ribbon)

- [Fix hidden buttons on the command bar](../../../power-platform/power-apps/create-and-use-apps/ribbon-issues-button-hidden.md?tabs=fix)

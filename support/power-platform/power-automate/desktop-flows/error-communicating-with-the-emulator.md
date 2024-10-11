---
title: Error communicating with the emulator
description: Provides a resolution when “Error communicating with the emulator” occurs, while calling the "Open terminal session" action in Power Automate for desktop.
ms.author: iomavrid
author: YiannisMavridis
ms.reviewer: tapanm
ms.date: 10/11/2022
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Error communicating with the emulator

This article provides a resolution when “Error communicating with the emulator” occurs, while calling the "Open terminal session" action in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate

## Symptoms

The message “Error communicating with the emulator” occurs when running the "Open terminal session" action with Reflection Desktop in Power Automate for desktop.

Here are the parameters are configured in the "Open terminal session" action.


## Cause

This issue occurs because the new update of Chromium-based web browsers (Google Chrome, Microsoft Edge) to version 113.x breaks the communication between Power Automate for desktop and the respective browsers.

## Resolution

To solve this issue, you need to update Power Automate for desktop to the latest version.


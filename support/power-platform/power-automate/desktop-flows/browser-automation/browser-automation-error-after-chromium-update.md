---
title: Browser automation actions not working after a browser update
description: Provides a resolution for the issue where the browser automation actions stop working in Power Automate for desktop after a browser update.
ms.author: pefelesk
author: PetrosFeleskouras
ms.reviewer: jefernn, tapanm
ms.date: 05/15/2023
ms.custom: sap:Desktop flows\UI or browser automation
---
# "You need the Power Automate extension" or "Failed to assume control of Chrome/Edge" when using browser automation actions

This article provides a resolution for the issue where the browser automation actions aren't working in Power Automate for desktop after you update a web browser.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Browser automation actions can't communicate with Google Chrome, Microsoft Edge, or both.

At design time, when you try to capture UI elements in one of the web browsers, you receive the "You need the Power Automate extension" message.

At runtime, when you execute the **Launch new Chrome** or **Launch new Microsoft Edge** action, you receive the following error message:

"Failed to assume control of Chrome/Edge (Communication with the browser failed. Try reloading extension)."

The affected web browsers:

- Google Chrome (version: 113.x)
- Microsoft Edge (version: 113.x)

## Cause

This issue occurs because the new update of Chromium-based web browsers (Google Chrome, Microsoft Edge) to version 113.x breaks the communication between Power Automate for desktop and the respective browsers.

## Resolution

To solve this issue, you need to update Power Automate for desktop to the latest version.

## Workaround

To workaround this issue, you can:

- Prevent the web browsers from being updated.
- Roll back the update of the web browsers.

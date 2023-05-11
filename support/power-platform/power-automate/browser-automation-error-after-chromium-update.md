---
title: Browser automation stopped working after browser update
description: Provides resolution for the issue that browser automation stopped working in Power Automate for desktop after a browser update.
ms.reviewer: pefelesk
ms.date: 5/10/2022
ms.subservice: power-automate-desktop-flows
---
# Browser automation stopped working after browser update

This article helps you fix an issue where browser automation stopped working in Power Automate for desktop after a browser update.

_Applies to:_ &nbsp; Power Automate  

## Symptoms

“Browser automation” actions cannot communicate with the Google Chrome and/or Microsoft Edge browsers. 
At design time, trying to capture UI elements in one of the browsers, shows the _“You need the Power Automate extension”_ message.
At runtime, executing the **Launch new Chrome** or **Launch new Microsoft Edge** action, results to the error message _"Failed to assume control of Chrome/Edge (Communication with the browser failed. Try reloading extension)."_ 

Browsers affected:
- Chrome 113.x
- Microsoft Edge 113.x

## Cause

The new update of Chromium-based web browsers (Google Chrome, Microsoft Edge) to version 113.x.y broke the communication between Power Automate for desktop and the respective browsers.

## Resolution

Update to the latest version of Power Automate for desktop. 

## Workarounds

1. Prevent the web browsers from being updated.
1. Rollback the update of the web browsers.

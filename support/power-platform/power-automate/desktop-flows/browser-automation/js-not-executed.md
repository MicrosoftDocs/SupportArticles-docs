---
title: Run JavaScript function on Web Page Action Fails to Execute
description: Solves an issue where the Run JavaScript function on web page action isn't executed and returns no error.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: andreas-mitrou
ms.date: 04/01/2025
---
# The "Run JavaScript function on web page" action doesn't execute but no error is reported

This article provides a resolution for an issue where the [Run JavaScript function on web page](/power-automate/desktop-flows/how-to/populate-text-fields-click-links-javascript) action fails to execute the JavaScript code and doesn't indicate any error.

## Symptoms

The JavaScript code provided in the **Run JavaScript function on web page** action isn't executed, but no error or exception is reported.

## Cause

This issue can occur when a third-party web extension installed and enabled in the browser blocks the JavaScript code execution initiated by Power Automate for desktop.

## Resolution

To solve this issue:

1. Temporarily disable all third-party web extensions in the browser, except the Power Automate extension, to determine if the issue persists.

   - [Turn off an extension in Microsoft Edge](https://support.microsoft.com/en-us/microsoft-edge/add-turn-off-or-remove-extensions-in-microsoft-edge-9c0ec68c-2fbc-2f2c-9ff0-bdc76f46b026)
   - [Turn off an extension in Google Chrome](https://support.google.com/chrome_webstore/answer/2664769)
   - [Disabling extensions in Mozilla Firefox](https://support.mozilla.org/en-US/kb/disable-or-remove-add-ons#w_disabling-extensions)

1. If disabling third-party web extensions isn't feasible, you can replace the JavaScript code with a specific web automation action that involves physical interaction. For example:

   If the JavaScript code is designed to click an element using the `document.getElementById('elementID').click();` code, this code can be replaced by the **Click link on web page** action with the **Send physical click** option enabled.

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
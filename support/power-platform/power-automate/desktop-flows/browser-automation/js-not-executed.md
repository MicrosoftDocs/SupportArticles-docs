---
title: Run Javascript function On Web Page Action Isn't Executed Without Any Error
description: Solves an issue where the Run JavaScript function on web page action isn't executed without indicating any error.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: andreas-mitrou
ms.date: 03/28/2025
---
# The "Run JavaScript function on web page" action isn't executed without any error thrown

This article provides a resolution for an issue where the [Run JavaScript function on web page](/power-automate/desktop-flows/how-to/populate-text-fields-click-links-javascript) action fails to execute the JavaScript code without indicating any error.

## Symptoms

The JavaScript code provided in the **Run JavaScript function on web page** action isn't executed, but no error or exception is reported.

## Cause

This issue can occur when a third-party web extension installed and enabled in the browser blocks the JavaScript code execution initiated by Power Automate for desktop.

## Resolution

To solve this issue,

1. Temporarily disable all third-party web extensions in the browser, except for the Power Automate extension, to determine if the issue persists.

1. If disabling third-party web extensions isn't a viable option, you can replace the JavaScript code with a specific web automation action that involves physical interaction. For example:

   If the JavaScript code is designed to click an element using the `document.getElementById('elementID').click();` code, this code can be replaced by the **Click link on web page** action with the **Send physical click** option enabled.

---
title: Run Javascript function on Web page action isn't executed without any error thrown
description:  Provides suggestions and workarounds on how to solve the problem that action **Run JavaScript function on web page** isn't executed without indicating any error.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/17/2025
---

# Run JavaScript function on Web page action isn't executed without any error thrown

This article refers on suggestion on how to solve the problem that action **Run JavaScript function on web page** isn't executed without indicating any error.

## Symptoms

The code that is inside the JavaScript function in the **Run JavaScript function on web page** action isn't executed, but no error is thrown.

## Cause

A third-party web extension is installed and enabled, in the browser that blocks the javaScript code execution from PAD.

## Resolution

1. Try disabling all other web extensions except the Power Automate extension to see whether the issue persists.
2. If disabling the web extensions isn't an option, then use a specific web automation action, that involves physical interaction, instead of JavaScript code.

**Example**
   If the javaScript code functionality is to click on an element using the code **document.getElementById('elementID').click();**, then this code can be replaced by the **Click element on web page** action and have the **Send Physical click** option enabled.

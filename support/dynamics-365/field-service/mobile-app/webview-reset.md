---
title: Home page unexpectedly shown and WebView reset in Dynamics 365 Field Service mobile app
description: Troubleshoot WebView reset issues in Dynamics 365 Field Service mobile app.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 12/04/2024
ms.custom: sap:Mobile Application\Application is throwing errors
---
# The Field Service mobile app shows the Home page unexpectedly and "WebView reset" message occurs

This article helps you troubleshoot and resolve issues in [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview) where the Home page is unexpectedly displayed and WebView resets occur.

## Symptoms

The Dynamics 365 Field Service mobile ap displays the Home page unexpectedly, and WebView resets occur.

## Cause

There are several reasons for a WebView reset to occur. When an Android or iOS device runs low on memory, it proactively shuts down apps to recover memory. Processes that use large amounts of memory include:

- Using the camera and uploading large files such as images, videos, audio, PDF, or other documents.
- Customizations like PowerApps Component Framework (PCF) controls. For example, using annotations with custom controls.
- Screen sharing in Microsoft Teams.
- Running other apps on the device.

## Resolution

Try the following suggestions to mitigate the issue:

- Determine the cause of the reset. Use developer tools to inspect memory usage in the WebView in the apps and browser. For example: [Debug JavaScript on Android](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code#debug-javascript-in-mobile-apps-on-android) or [Fix memory problems](/microsoft-edge/devtools-guide-chromium/memory-problems/).
- Take steps to reduce memory usage such as avoid screen sharing or close apps other than the Field Service mobile app that use large amounts of memory.
- Review [performance considerations when customizing the mobile app](/dynamics365/field-service/mobile/improve-mobile-performance) and take actions to reduce memory usage.

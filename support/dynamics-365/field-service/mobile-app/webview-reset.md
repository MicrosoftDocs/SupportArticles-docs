---
title: WebView reset in Dynamics 365 Field Service mobile app
description: Troubleshoot WebView reset issues in Dynamics 365 Field Service mobile app.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 10/28/2024
ms.custom: sap:Mobile application
---

# WebView reset error

This article helps you troubleshoot and resolve issues in Dynamics 365 Field Service mobile app where the Home page is unexpectedly displayed and WebView resets occur.

## Symptoms

The Dynamics 365 Field Service mobile app displays the Home page unexpectedly and WebView resets occur.

## Cause

There are several reasons for WebView reset to occur. When an Android or iOS device runs low on memory, it proactively shuts down apps to recover memory. Processes that use large amounts of memory include:

- Camera use and uploading large images, videos, audio, PDF, or other files.
- Customizations like PowerApps Component Framework (PCF) controls. For example, using annotations with custom controls.
- Screen sharing in Microsoft Teams.
- Other apps on the device.

## Resolution

Try the following suggestions to mitigate the issue:

- Determine the cause of the reset. Use developer tools to inspect memory usage in the WebView in the apps and browser. For example: [Debug JavaScript on Android](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code#debug-javascript-in-mobile-apps-on-android) or [Fix memory problems](/microsoft-edge/devtools-guide-chromium/memory-problems/).
- Take steps to reduce memory usage such as avoid screen sharing or close apps other than the Field Service mobile app that use large amounts of memory.
- Review [performance considerations when customizing the mobile app](/dynamics365/field-service/mobile/improve-mobile-performance) and take actions to reduce memory usage.


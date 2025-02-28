---
title: Home Page Unexpectedly Shown and WebView Reset in Dynamics 365 Field Service Mobile App
description: Helps resolve WebView reset issues in the Dynamics 365 Field Service mobile app.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 12/12/2024
ms.custom: sap:Mobile Application\Application is throwing errors
---
# The Field Service mobile app shows the home page unexpectedly and a WebView reset occurs

This article helps you troubleshoot and resolve issues in the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview), where the home page is unexpectedly displayed, and a WebView reset occurs.

## Symptoms

The Dynamics 365 Field Service mobile app unexpectedly displays the home page, and a WebView reset occurs.

## Cause

WebView resets for several reasons. When an Android or iOS device runs low on memory, it proactively closes apps to recover memory. Processes that use large amounts of memory include:

- Using the camera and uploading large files such as images, videos, audio, PDFs, or other documents.
- Customizations like PowerApps Component Framework (PCF) controls. For example, using annotations with custom controls.
- Sharing screen in Microsoft Teams.
- Running other apps on the device.

## Resolution

Try the following suggestions to mitigate the issue:

- Determine the cause of the reset. Use developer tools to inspect memory usage in the WebView in the app and browser. For example, [Debug JavaScript in mobile app on Android](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code#debug-javascript-in-mobile-apps-on-android) or [Fix memory problems](/microsoft-edge/devtools-guide-chromium/memory-problems/).
- Take steps to reduce memory usage, such as avoiding screen sharing or closing apps other than the Field Service mobile app that use large amounts of memory.
- Review [performance considerations when customizing the mobile app](/dynamics365/field-service/mobile/improve-mobile-performance) and take actions to reduce memory usage.

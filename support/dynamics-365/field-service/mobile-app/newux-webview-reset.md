---
title: WebView reset error
description: Resolves the issue where the Microsoft Dynamics 365 Field Service mobile app shows a WebView reset message.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 10/28/2024
ms.custom: sap:Mobile application
---

# WebView reset error

This article helps resolve an issue where the Field Service mobile app displays the Home page unexpectedly and a WebView reset message appears.

## Symptoms

When an Android or iOS device runs low on memory, they proactively shut down apps to recover memory.

## Cause

There can be several reasons for the WebView reset to occur. Processes that use large amounts of memory include:

- Camera use and uploading large images.
- Customizations like PowerApps Component Framework (PCF) controls. For example, using annotations with custom controls.
- Screen sharing in Microsoft Teams.
- Other apps on the device.

## Resolution

Try any of the following resolutions to solve the issue:

- Determine the cause of the reset. Use developer tools to inspect memory usage in the WebView in the apps and browser.
- Take steps to reduce memory usage such as avoid screen sharing or close other apps that are using large amounts of memory.
- Review [performance considerations when customizing the mobile app](/dynamics365/field-service/mobile/improve-mobile-performance).


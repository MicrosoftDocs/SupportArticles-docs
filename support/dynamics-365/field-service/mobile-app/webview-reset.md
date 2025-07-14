---
title: Home Page Unexpectedly Shown and WebView Reset in Dynamics 365 Field Service Mobile App
description: Helps resolve WebView reset issues in the Dynamics 365 Field Service mobile app.
author: JonBaker007
ms.author: jobaker
ms.reviewer: puneet-singh1
ms.date: 07/11/2025
ms.custom: sap:Mobile Application\Application is throwing errors
---
# Troubleshoot WebView reset in Dynamics 365 Field Service mobile app

This article helps you troubleshoot and resolve issues in the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview), where the home page is unexpectedly displayed, and a WebView reset occurs.

## What is a WebView reset?

A WebView reset in the Dynamics 365 Field Service mobile app typically indicates that the app module consumes too much memory. It's often triggered by activities that cause memory pressure on the WebView process. [Model-driven applications in Power Apps](/power-apps/maker/model-driven-apps/model-driven-app-overview), such as Dynamics 365 Field Service, run as web applications inside a WebView on the mobile client. As a result, they're subject to the memory management policies of the mobile operating system.

## Root cause

A WebView reset occurs when the mobile operating system terminates an application process that exceeds its memory limits. The threshold for "too much memory" varies by device and operating system, so the issue might not always be reproducible.

- **iOS:** The WebView reset error occurs only on iOS because WebViews run in separate processes that can be terminated independently from the main app. If the WebView process exceeds the operating system memory threshold, it's terminated. The app detects this issue, restarts the WebView, and displays a reset message to the user.
- **Android:** The WebView runs within the main application process. If memory limits are exceeded, the entire app process is terminated, resulting in a crash.
- **Desktop browsers:** WebView resets don't occur, but memory pressure can still be investigated using browser tools.

> [!IMPORTANT]
> Poor memory management in customizations can negatively impact the app experience.

## Understanding memory pressure

There are two main causes of memory pressure:

1. Memory spike

    A memory spike occurs when a large object is allocated in the WebView process, causing a sudden increase in memory usage. Common causes include:

    - Storing Base64-encoded images or videos in variables within [Power Apps component framework](/power-apps/developer/component-framework/overview) controls or web resources.
    - Using JavaScript libraries that import large resource files (for example, font libraries.)

    If you can reliably reproduce a WebView reset by performing a specific action (like opening a form or control), a memory spike is likely the cause.

2. Memory leaks

    A memory leak occurs when memory allocated within the WebView process isn't released because of lingering references, such as event listeners or objects that aren't properly cleaned up. This issue prevents the garbage collector from reclaiming the memory, causing memory usage to gradually increase over time. For example, adding event listeners to the window object in JavaScript without removing them when navigating away can lead to leaks. If WebView resets occur randomly and aren't tied to a specific action, it's likely due to a memory leak from previous activities.

## Troubleshooting memory pressure

To diagnose and resolve memory pressure issues:

- For iOS, use Safari memory analysis tools to check the memory performance of your iOS app module. For more information, see [the Timelines Tab in Web Inspector](https://webkit.org/web-inspector/timelines-tab/).
- The WebView reset error is specific to iOS applications running WebViews and can only be reproduced within that context. However, code that causes memory pressure on mobile also causes memory pressure buildup on desktop browsers. You can investigate the root cause of a WebView reset by using browser developer tools (such as Microsoft Edge DevTools) to track memory usage and identify issues. For more information, see [Fix memory problems in Microsoft Edge DevTools](/microsoft-edge/devtools-guide-chromium/memory-problems/).
- [Debug JavaScript code for model-driven apps](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code) to identify problematic scripts or customizations.

## More information

[Performance considerations when customizing the Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/improve-mobile-performance)

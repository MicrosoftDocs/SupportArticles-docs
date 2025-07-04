---
title: Home Page Unexpectedly Shown and WebView Reset in Dynamics 365 Field Service Mobile App
description: Helps resolve WebView reset issues in the Dynamics 365 Field Service mobile app.
author: JonBaker007
ms.author: jobaker
ms.reviewer: puneet-singh1
ms.date: 07/04/2025
ms.custom: sap:Mobile Application\Application is throwing errors
---
# WebView Reset Overview

This article helps you troubleshoot and resolve issues in the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview), where the home page is unexpectedly displayed, and a WebView reset occurs.

A WebView reset error while using Field Service Mobile indicates that the code within the app module is using too much memory. The cause of a WebView reset is the activity that precedes it, which causes memory pressure on the WebView process. Model-driven Applications in Power Apps like Field Service are web applications that are run within a WebView on the mobile client. This leaves them susceptible to memory management policies that mobile operating systems impose on these processes.

## The Root Cause

A WebView reset occurs when the mobile operating system terminates an application process that consumes too much memory. The threshold for "too much memory" varies by device and operating system and can affect how reliably the issue can be reproduced on a device. The WebView Reset error dialog is specific to iOS, which runs WebViews on separate, terminable processes outside of the core mobile application process. When this WebView process consumes more memory than the operating system tolerates, the WebView process is terminated. After the mobile system terminates the process to reclaim memory, the mobile application detects the loss of the WebView and restarts it, showing a message to the user indicating a WebView Reset occurred. On Android, the WebView isn't run on a separate process, so the entire application process is terminated, resulting in an application crash. WebView resets don't occur when using the application on a desktop browser, however the memory pressure buildup can still be present and investigated in this context.

> [!IMPORTANT]
> Poor memory management practices can affect the application experience when you create customizations.

## Memory Pressure

There are two common causes of memory pressure buildup to be aware of.

**Memory Spike** – A memory spike is when a large object is allocated into the WebView process and causes an immediate spike in memory usage. Examples include storing Base64 representations of images and videos in variables within Power Apps Component Framework controls and Web Resources or utilizing JavaScript libraries that import large resource files like font libraries. If you can reliably reproduce a WebView reset through an action like opening a specific form or interacting with a specific control, you're likely encountering a memory spike.

**Memory Leaks** – A memory leak is when memory is allocated within the WebView process but isn't cleaned up when no longer needed due to dangling pointers and references preventing garbage collection from reclaiming the allocated memory. This causes memory pressure buildup over time that can lead to a WebView reset. Examples include adding event listeners to the window object in JavaScript but not removing them when navigating away. If you can't reliably reproduce a WebView reset and seem to experience them at random while doing different activities within the application, you're likely encountering a memory leak in the previous activities that you performed before the reset.

## Debugging Memory Pressure

The WebView reset error itself is specific to iOS applications running WebViews and can only be reproduced within that context. However, code that causes memory pressure on mobile also causes memory pressure buildup on desktop browsers. You can investigate the root cause of a WebView reset by using browser debug tools, like those provided by Microsoft Edge for tracking memory usage. Learn more in [Fix memory problems - Microsoft Edge Developer documentation](/microsoft-edge/devtools-guide-chromium/memory-problems/).

You can also use these debugging tools on mobile devices: [Debugging JavaScript Code in Model-Driven Apps](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code).

Use Safari memory analysis tools to check the memory performance of your iOS app module. Learn more in [Timelines Tab](https://webkit.org/web-inspector/timelines-tab/).

## Related content

- [Debugging JavaScript Code in Model-Driven Apps](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code)
- [Fix memory problems - Microsoft Edge Developer documentation](/microsoft-edge/devtools-guide-chromium/memory-problems/)
- [Performance considerations when customizing the mobile app](/dynamics365/field-service/mobile/improve-mobile-performance)

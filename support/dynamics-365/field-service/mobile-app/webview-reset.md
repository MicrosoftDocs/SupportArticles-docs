---
title: Fix WebView reset errors in the Dynamics 365 Field Service mobile app
description: Resolve WebView reset errors in the Dynamics 365 Field Service mobile app. Fix memory spikes from large files, PCF controls, and JavaScript leaks on iOS and Android.
ms.date: 03/20/2026
ms.reviewer: jobaker, puneet-singh1, v-shaywood
ms.custom: sap:Mobile Application\Application is throwing errors
---

# WebView reset error in the Dynamics 365 Field Service mobile app

## Summary

This article helps you resolve WebView reset problems in the [Dynamics 365 Field Service mobile app](/dynamics365/field-service/mobile/overview). A WebView reset occur if the mobile operating system stops an app process that uses too much memory. These problems include:

- The home screen appears unexpectedly
- File or PDF attachments close immediately after they open
- The app steps responding (crashes) on Android devices

The problem is usually caused by memory spikes from large files or custom controls, or memory leaks from incorrectly managed JavaScript in [model-driven apps](/power-apps/maker/model-driven-apps/model-driven-app-overview).

## Symptoms

When you use the Field Service mobile app, you experience one or more of the following symptoms:

- The app unexpectedly returns to the home screen without warning.
- A file or PDF attachment opens briefly and immediately closes.
- The following error message appears:

  > WebView reset.

- On Android, the app stops responding instead of showing an error message.

These symptoms might occur when you open large files, go to forms with complex customizations, or use the app for a long time.

## Cause

A WebView reset occurs when the mobile operating system ends an app process that exceeds its memory limits. The Field Service mobile app runs as a web application inside a WebView on the mobile client and is subject to the operating system's memory management policies. The memory threshold varies by device and operating system, so you might not always be able to reproduce the issue.

The behavior differs by platform:

- **iOS**: WebViews run in separate processes that the operating system can terminate independently from the main app. If the WebView process exceeds the memory threshold, the operating system ends it. The app detects this condition, restarts the WebView, and shows the "WebView reset" error.
- **Android**: The WebView runs within the main app process. If memory limits are exceeded, the entire app crashes.
- **Desktop browsers**: WebView resets don't occur, but you can still investigate memory pressure by using browser tools.

Two types of memory problems typically cause WebView resets:

### Memory spike

A memory spike is a sudden increase in memory usage caused by allocating a large object. Common causes include:

- Storing Base64-encoded images or videos in variables within [Power Apps component framework (PCF)](/power-apps/developer/component-framework/overview) controls or web resources.
- Using JavaScript libraries that import large resource files, like font libraries.

If you can reliably reproduce a WebView reset by performing a specific action like opening a form or control, a memory spike is likely the cause.

### Memory leak

A memory leak occurs when allocated memory isn't released because of lingering references, such as event listeners or objects that aren't properly cleaned up. This problem prevents the garbage collector from reclaiming the memory, so usage gradually increases over time.

For example, adding event listeners to the JavaScript `window` object without removing them when you navigate away from a page can cause a leak. If WebView resets occur randomly and aren't tied to a specific action, a memory leak is the likely cause.

## Solution

### For end users

If the WebView reset occurs when you open a PDF or file attachment on a work order, try the following steps:

1. Reduce the file size. Attachments larger than 10 MB are more likely to trigger a WebView reset. Ask the sender to compress or resave the file at a lower resolution before reattaching it to the work order.
1. If the issue happens consistently with the same file, try opening it on a different device or in a desktop browser to check whether the file is corrupted.
1. Close other apps running on the device to free up memory, then restart the Field Service app and try opening the attachment again.

### For administrators

1. Review any [custom controls or web resources](/dynamics365/guidance/resources/field-service-mobile-improve-performance) added to the mobile app. Custom controls that store Base64-encoded images or import large JavaScript libraries can cause memory pressure and more frequent WebView resets.

1. For iOS, use Safari memory analysis tools to check the memory performance of your iOS app. For more information, see [the Timelines tab in Web Inspector](https://webkit.org/web-inspector/timelines-tab/).

1. Use browser developer tools like Microsoft Edge DevTools to track memory usage and find issues. Code that causes memory pressure on mobile also causes memory pressure on desktop browsers. For more information, see [Fix memory problems in Microsoft Edge DevTools](/microsoft-edge/devtools-guide-chromium/memory-problems/).

1. [Debug JavaScript code for model-driven apps](/power-apps/developer/model-driven-apps/clientapi/debug-javascript-code) to find problematic scripts or customizations.

## Related content

- [Troubleshoot common issues with the Field Service mobile app](mobile-app-common-issues.md)
- ["Validations have been restarted in the background" error](validation-restarted-background.md)

---
title: Troubleshoot Slow or Unnecessary Mobile App Network Calls
description: Troubleshoot slow or unnecessary network calls in the Field Service mobile app. Capture network traces, find blocking requests, and fix offline dependencies.
ms.date: 07/31/2026
ms.subservice: field-service-mobile
ms.reviewer: jobaker, v-wesmith
ms.custom: sap:Mobile Application\Issues with performance
ai-usage: ai-assisted
---

# Troubleshoot slow or unnecessary network calls in the Field Service mobile app

## Summary

This article helps you identify network requests that slow down or block forms, views, or grids in the Dynamics 365 Field Service mobile app. Use this guidance to capture a network trace, spot long-running or blocking requests, tell locally cached responses apart from remote server calls, and fix the offline dependencies that hurt performance on poor or intermittent connections. Administrators, solution architects, support engineers, and developers can all follow this process.

When a form or grid loads slowly, the cause is often a request that still depends on the network during rendering. This investigation helps you check:

- Which requests are slow, pending, failed, or blocking rendering.
- Whether each request is served locally or reaches the remote server.
- Whether a customization or Microsoft platform behavior causes the request.

## When to use this guidance

Use this process when users report any of the following symptoms in the Field Service mobile app:

- A form, view, or grid loads slowly.
- The app appears to hang when connectivity is poor.
- An offline scenario works inconsistently.
- Images, icons, scripts, controls, or web resources fail to load offline.
- Performance gets worse when the device has weak or intermittent connectivity.

## Prerequisites

Before you begin, make sure you have:

- A mobile device or browser session that can reproduce the issue.
- Access to the affected app, form, view, or grid.
- Remote debugging access to the running mobile web view:
  - **iOS**. Safari Web Inspector.
  - **Android**. Chrome remote debugging with `chrome://inspect`.
  - **Browser client**. Browser DevTools.
- Access to the **Network** panel in DevTools.
- A way to simulate poor or offline connectivity:
  - **Android**. DevTools network throttling.
  - **iOS**. Network Link Conditioner on the device or on macOS.

## Capture network traffic while you reproduce the issue

1. Open DevTools for the affected session.
1. Open the **Network** panel.
1. Clear the existing network log.
1. Go to the slow form, view, or grid.
1. Wait for the page to finish loading or for the issue to reproduce.
1. Save or keep the network trace available for analysis.

Take the first capture under normal conditions. This capture gives you a baseline before you test poor connectivity.

## Identify long-running, pending, or failed requests

In the **Network** panel, sort requests by **Duration** or **Time**.

Focus first on requests that:

- Take several seconds to complete.
- Stay pending for most of the session.
- Fail when the app is offline.
- Block other visible work, such as form rendering or grid loading.
- Request images, icons, JavaScript files, web resources, or metadata during render.

For each suspicious request, record:

- Request URL.
- Request status.
- Duration.
- Resource type.
- Initiator or call stack.
- Whether the request was served locally or from the remote origin.

## Check whether the request is local or remote

After a successful offline sync, the app serves static assets that are available offline from the local cache. Requests that still go to the remote server can stall when the device is offline or on a poor connection.

Use the following platform-specific signals.

### Android

On Android, locally served assets typically show **ServiceWorker** in the **Network** panel, such as in the request source or size column.

If the request isn't served by the service worker and still reaches the remote origin, the asset might not be available offline.

### iOS

On iOS, locally served assets typically use **localhost**, which points to the device-local web server.

If the request still goes to the remote organization URL instead of localhost, the asset was fetched over the network.

## Identify the source as customization or platform behavior

For each slow or blocking request, inspect the **Initiator** column and call stack.

Classify the request into one of the following categories.

### Customer-side customization

Examples include:

- Form scripts.
- JavaScript web resources.
- Image web resources loaded during form or grid rendering.
- View column image-provider scripts.
- Power Apps component framework (PCF) controls.
- Custom controls.
- Command bar customizations.
- Custom logic that runs during load.

If a customization triggers a render-time network dependency, remove the dependency, make the resource available offline, or redesign the customization so it doesn't require a network call during load.

### Microsoft platform behavior

Examples include:

- Core metadata requests.
- Authentication or user context requests.
- Data-layer requests.
- Batch requests.
- Platform telemetry.
- Command evaluation or platform module loading.

If the initiator points to Microsoft platform code and the request blocks offline or poor-network usage, collect evidence and raise the issue through Microsoft support or the appropriate product escalation path.

## Reproduce under poor or offline network conditions

After you identify suspicious requests, reproduce the scenario under degraded connectivity.

### Throttle the network on Android

1. Open Chrome DevTools for the mobile web view.
1. Open the **Network** panel.
1. Use the throttling menu to select a slow profile, such as **Slow 3G**, or choose **Offline**.
1. Reload the affected form, view, or grid.
1. Capture the network log again.

### Simulate a poor connection on iOS

Safari Web Inspector doesn't provide the same built-in network throttling experience as Chrome DevTools. To simulate poor connectivity on iOS, use **Network Link Conditioner**.

1. Turn on Network Link Conditioner on the device or on macOS.
1. Choose a poor network profile, such as a high-latency or high-loss profile.
1. Reload the affected form, view, or grid.
1. Capture the network log again in Safari Web Inspector.

## Interpret the result

Use the following table to decide what to do next.

| Observation | What it means | Recommended action |
| --- | --- | --- |
| Request is slow but eventually returns `200`. | The call works online but creates a render-time network dependency. | If it comes from customization, remove or redesign the dependency. If it comes from platform code, collect evidence and escalate. |
| Request fails or never returns offline. | The app depends on a forced-online call with no offline fallback. | Check the initiator. Fix customer-side dependencies or escalate platform dependencies. |
| Image or icon request reaches the remote origin. | The asset might not be available offline. | Set up the asset for offline use or replace the pattern with an offline-friendly design. |
| JavaScript web resource loads during grid render. | A grid customization might be loading scripts during render. | Review view column image providers, custom JavaScript, and PCF controls. |
| Request is served by ServiceWorker on Android. | The asset is served locally. | This request is less likely to be the source of an offline network stall. |
| Request is served from localhost on iOS. | The asset is served locally. | This request is less likely to be the source of an offline network stall. |
| Platform request blocks rendering in poor network. | A Microsoft platform dependency might be affecting load behavior. | Capture request details, timings, initiator stack, and reproduction steps for escalation. |

## Quick checklist

Use this checklist during your investigation:

1. Open DevTools and capture the **Network** log.
1. Reproduce the slow form, view, or grid.
1. Sort by **Duration** or **Time**.
1. Identify long-running, pending, or failed requests.
1. Check whether each request is served locally:
   - **Android**. **ServiceWorker**.
   - **iOS**. **localhost**.
1. Inspect the **Initiator** column and call stack.
1. Classify the source as customization or Microsoft platform.
1. Reproduce with degraded or offline connectivity.
1. Decide whether to fix the customization, set up the asset for offline use, or escalate the platform dependency.

## Recommended outcome

At the end of this process, you should have a short list of requests that explain the delay or offline failure. For each request, you should know:

- Whether it's slow, pending, failed, or blocking.
- Whether it's local or remote.
- Whether it comes from customer customization or Microsoft platform code.
- What action is needed to reduce or remove the render-time network dependency.

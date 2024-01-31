---
title: General Power Apps troubleshooting strategies
description: Learn about general strategies to narrow down the cause of app errors.
author: tahoon
ms.reviewer: tapanm, lanced
ms.date: 01/31/2024
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# Power Apps troubleshooting strategies

There are different approaches to troubleshooting Power Apps depending on the type of issue you're facing. The troubleshooting strategies in this article can help you narrow down the cause of the issue and point you in the right direction to work around or fix the issue.

## Functionality troubleshooting

For issues with **functionality** where Power Apps features aren't behaving as expected, try to isolate the problem using the following steps and links as a guide. A critical step in figuring out the issue is being able to reliably reproduce the issue in as few steps as possible.

As a first step, follow the [General troubleshooting strategies](#general-troubleshooting-strategies).

Then, use the following articles to isolate the issue and create a minimal repro app, where practical.

For Canvas apps:

- [Isolate Canvas App issues](isolate-canvas-app-issues.md)
- [Minimal Canvas App repro](minimal-canvas-app-repro.md)

For model-driven apps:

- [Isolate Model App issues](isolate-model-app-issues.md)
- [Minimal Model App repro](vanilla-model-driven-app-repro.md)

After you have isolated the issue to a specific functionality area, use the following sections to help you work around or address the issue.

- [Connectors and delegation](common-issues-and-resolutions.md#connectors-and-delegation)
- [Controls](common-issues-and-resolutions.md#controls)
- [Integration](common-issues-and-resolutions.md#integration)
- [Power Fx](common-issues-and-resolutions.md#power-fx)
- [Region](common-issues-and-resolutions.md#region)
- [Studio and Forms](common-issues-and-resolutions.md#studio-and-forms)
- [Browser](common-issues-and-resolutions.md#browser)
- [Power Apps for Windows](common-issues-and-resolutions.md#power-apps-for-windows)

If your issue isn't listed, see [Next steps](#next-steps) later in this article.

## Performance troubleshooting

For issues with **performance**, you can use profiling tools like [Monitor](/power-apps/maker/monitor-overview) and [Performance insights](/power-apps/maker/common/performance-insights-overview) to help you debug and diagnose problems.

### Canvas apps

For an overview of how to create a performant canvas app, see the [Overview of creating performant apps](/power-apps/maker/canvas-apps/create-performant-apps-overview).

For more information and guidance on creating performant apps, see:

- [Small data payloads](/power-apps/maker/canvas-apps/small-data-payloads)
- [Optimized data query patterns](/power-apps/maker/canvas-apps/optimized-query-data-patterns)
- [Speed up app or page load](/power-apps/maker/canvas-apps/fast-app-page-load)
- [Fast calculations](/power-apps/maker/canvas-apps/efficient-calculations)

For information on debugging canvas apps and performance issues, see:

- [Understand canvas app execution phases and performance monitoring](/power-apps/maker/canvas-apps/execution-phases-data-flow)
- [Creating performant apps](/power-apps/maker/canvas-apps/create-performant-apps-overview)
- [Common canvas app performance issues and resolutions](/power-apps/maker/canvas-apps/common-performance-issue-resolutions)
- [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps)

### Model-driven apps

For model-driven apps, verify if [forms are designed for performance](/power-apps/maker/model-driven-apps/design-performant-forms).

For more information on debugging model-driven apps and performance issues, see [Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps).

## General troubleshooting strategies

### Isolate changes

When you make multiple changes at the same time, it's not obvious which one causes a problem. Try reverting to the last known working state and make a single change. If it works fine, revert the change and make another one until the issue occurs. For example, you can [restore a canvas app to a previous version](/power-apps/maker/canvas-apps/restore-an-app) and apply changes progressively.

If you can't revert an app to a working state, it's also helpful to make one change differently while keeping everything else the same.

Here are a few examples:

- If searching for a long piece of text doesn't return correct results, try a shorter piece of text.
- View the same app on the same device, but with a different browser.
- If the data isn't displayed correctly in a control, try displaying it in a different type of control.
- If the data isn't displayed correctly on a page, try a different page or app with the same data.
- If one data connection doesn't work, try another.

Knowing what works as expected is as important as knowing what doesn't. For example, if you can connect to one Microsoft Dataverse table but not another, the table might be misconfigured. On the other hand, if you can't connect to any tables at all, it could be a larger problem caused by an outage, a network failure, or a bug. These possibilities suggest other avenues for investigation and help you get closer to the source of the error.

### Simplify

A complex app has many components that might go wrong. Remove unnecessary details so that there are fewer variables.

If there are [client scripts in model-driven apps](/power-apps/developer/model-driven-apps/client-scripting), try disabling them. If the problem persists, at least you have eliminated those scripts as the potential cause.

### Start from scratch

Consider creating a new app or configuration. This process can be broken into multiple simplified steps and checkpoints, especially when the original version is too complex to re-create. Consider the essence of the app and experiment with what works and what doesn't. For example, if a table in a model-driven app doesn't show the right records, try [re-creating the view](/power-apps/developer/model-driven-apps/customize-entity-views).

If the new app works, compare it with the original one to find the difference. If there's no difference, the problem might be fixed in the latest version. Or, the original app might have configuration problems. Even if you can't upgrade your app, knowing if and how the problem was fixed will guide the next steps.

### Find out which layer has data issues

Power Apps is based on web technologies. Different layers are involved when working with cloud data. Some typical layers are:

- **Server** - stores data and controls who can access it.
- **Network** - transports data between the server and the app.
- **App** - requests data from the server, processes it, and displays it in the app.
- **App host** - where the app is running. The host provides the infrastructure to use an app. For Power Apps, the app host can be a browser, [Power Apps mobile](/power-apps/mobile/run-powerapps-on-mobile), or another website that Power Apps is embedded in.

Together, these layers form a general technical stack for Power Apps. Isolating the layer where a problem occurs can uncover more ideas for solutions and workarounds.

Here are some examples of isolating the layer:

- **Server** - if there's a problem with the server, the same issue will happen on any website or app that accesses the data. To investigate further:
  - Check if you can work with data outside of Power Apps. For example, for Microsoft Lists, check if you can view and edit records on the SharePoint site that hosts the list.
  - Check if a different user experiences the same problem. Comparing the experience with an admin user might uncover permission issues.
- **Network** - there won't be internet access when the network isn't available. Though unusual, check the following:
  - [Try a different network](#try-a-different-network)
  - Try to run the app in a different geographical region, which might have different network conditions or restrictions.
- **App** - use [Monitor](/power-apps/maker/monitor-overview) to examine the network requests made by the app. If the correct data is returned by the server, it's a problem with the app. If the data returned is wrong, it might be a server error or the app didn't request the data correctly.
- **App host** - try a different host. For example, if you're using the Power Apps mobile app for Android, try the mobile app for iOS or use a desktop browser.

### Reproduce intermittent issues reliably

Intermittent issues can be difficult to solve. The key is to create the conditions that make them happen all the time. The following steps might help you investigate intermittent issues related to caching, network speed, browser performance, or hardware limitations.

#### Try private browsing mode or a different browser

- Confirm that the browser you're using is up to date. For more information, see [System requirements, limits, and configuration values for Power Apps](/power-apps/limits-and-config).
- Expired cookies or stale files saved in a browser can cause incorrect operation. Try using the browser's InPrivate or Incognito mode.
- Try a different supported browser.
- Disable all browser extensions and add-ons.
- For apps, try reinstalling them to clear stale data.

#### Try a different network

Slow loading of data might result in different behavior. If you're using a mobile data connection, try a wireless or wired connection. If you're using a virtual private network (VPN), try disabling it. You can also simulate slow networks on desktop browsers with browser developer tools.

#### Try a different device

Similar to data speed, processing speed can also result in different behavior. If you're using a phone, check if the problem occurs on a desktop computer.

## Next steps

If your issue isn't listed in this article, you can [search for more support resources](https://powerapps.microsoft.com/support), or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support). For more information, see [Get Help + Support](/power-platform/admin/get-help-support).

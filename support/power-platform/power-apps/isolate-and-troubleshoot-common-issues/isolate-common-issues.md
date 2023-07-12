---
title: General Power Apps debugging strategies
description: Learn about general strategies to narrow down the cause of app errors.
author: tahoon
ms.reviewer: tapanm
ms.date: 07/12/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# General Power Apps debugging strategies

It's common to run into issues when making apps. Debugging strategies help you narrow down the cause, fix them, and find workarounds. Even if you aren't able to solve an issue, you can investigate more easily with the information collected through debugging practices.

## Isolate changes

When multiple changes are made, it's not obvious which ones contribute to a problem. Try reverting to the last known working state and make a single change. If it works fine, revert the change and make another one until the issue happens. For example, you can [restore a canvas app to a previous version](/power-apps/maker/canvas-apps/restore-an-app) and apply changes progressively.

## Try something related

If you're unable to revert an app to a working state, it's also helpful to make one change differently while keeping everything else the same.

Here are a few examples:

- Searching for a long piece of text doesn't return correct results. Try a shorter piece of text.
- View the same app on the same device, but with a different browser.
- If data isn't displaying correctly in a control, try displaying it in a different type of control.
- If data isn't displaying correctly on a page, try a different page or app with the same data.
- If one data connection isn't working, try another.

Knowing what is working as expected is as important as knowing what doesn't. For example, if you can connect to one Microsoft Dataverse table but not another, the table could be misconfigured. On the other hand, if you aren't able to connect to any tables at all, it could be a larger problem with the possible causes as an outage, a network failure, or possibly a bug. These possibilities suggest other avenues for investigation and help you get closer to the source of the error.

## Simplify

A complex app has many components that might go wrong. Remove unnecessary details so that there are fewer variables to worry about. It's also helpful to discuss the problem with others. For example, if there are [client scripts in model-driven apps](/power-apps/developer/model-driven-apps/client-scripting), try disabling them. Even if the problem still persists, at least you'd eliminate those scripts as the cause of the problem.

## Start from scratch

It's possible to be oblivious to common mistakes. For example, consider creating a new app or configuration. This process can be broken into multiple simplified steps and checkpoints, especially when the original version is too complex to re-create. Consider the essence of the app and experiment with what works and what doesn't. For example, if a table in a model-driven app doesn't show the right records, try [re-creating the view](/power-apps/developer/model-driven-apps/customize-entity-views).

If the new app works, compare it with the original to find the difference. If there's no difference, the problem might be fixed with the latest version. Or, the original app has configuration problems. Even if you're unable to upgrade your app, knowing if and how the problem was fixed will guide the next steps.


## Find out which layer has data issues

Power Apps is based on web technologies. Different layers are involved when working with cloud data. Some of the typical layers when working with cloud data are:

- **Server** - stores data and controls who can access it.
- **Network** - transports data between the server and the app.
- **App** - requests data from the server, processes it, and displays it in the app.
- **App host** - where the app is running. The host provides infrastructure to use an app. For Power Apps, the app host could be a browser, [Power Apps Mobile](/power-apps/mobile/run-powerapps-on-mobile), or another website that Power Apps is embedded in.

Together, these layers form a general technical stack for Power Apps. Isolating the layer where a problem occurs can uncover more ideas for solutions and workarounds.

Some of the examples for such isolation are:

- **Server** - if there's a problem with the server, the same issue will happen on any website or app that accesses the data. Check the following to further investigate:
  - Check if you can work with data outside of Power Apps. For example, with Microsoft Lists, you can view and edit records on the SharePoint site that hosts the list.
  - Check if a different user experiences the same problem. Comparing the experience with an admin user might uncover permission issues.
- **Network** - there won't be internet access when network isn't available. Though unusual, check the following possibilities:
  - [Try a different network](#try-a-different-network)
  - Try to run the app in a different geographical region. There may be different network conditions or restrictions.
- **App** - use [Monitor](/power-apps/maker/monitor-overview) to examine the network requests made by the app. If the correct data is returned by the server, then it's a problem with the app. If the data returned is wrong, it could be a server error or the app didn't request for data correctly.
- **App host** - try a different host. For example, if you're using the Power Apps Mobile app for Android, try the one for iOS or use a desktop browser.

## Reproduce intermittent issues reliably

Intermittent issues can be difficult to solve. The key is to create the conditions that make them happen all the time. The following steps might help you investigate intermittent issues related to caching, network speed, browser performance, or hardware limitations:

### Try private browsing mode or a different browser

Expired cookies or stale files saved in a browser can cause incorrect operation. Using private browsing mode or a different browser forces reauthentication. It ensures you're running the latest version. For apps, you can try reinstalling them to clear stale data.

### Try a different network

Slow loading of data might result in different behavior. If you're using a mobile data connection, try wireless or a wired connection. If you're using a VPN, try disabling them. You can also simulate slow networks on desktop browsers with browser developer tools.

### Try a different device

Similar to data speed, processing speed can also result in different behavior. If you're using a phone, check if the problem occurs on a desktop computer.

## Understand how apps run to identify performance problems

Progressively simplifying an app is an effective technique for finding the source of performance issues. You can also use profiling tools like [Monitor](/power-apps/maker/monitor-overview) and [Performance insights](/power-apps/maker/common/performance-insights-overview).

- For canvas apps, understand their [execution phases](/power-apps/maker/canvas-apps/execution-phases-data-flow) and [common sources of slow performance](/power-apps/maker/canvas-apps/slow-performance-sources).
- For model-driven apps, verify if [forms are designed for performance](/power-apps/maker/model-driven-apps/design-performant-forms).

## Next steps

- [Isolate issues in canvas apps](isolate-canvas-app-issues.md)
- [Isolate issues in model-driven apps](isolate-model-app-issues.md)

### See also

- [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps)
- [Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps)

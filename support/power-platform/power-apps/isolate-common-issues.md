---
title: Think like a debugger
description: Learn about general strategies to narrow down the cause of app errors.
author: tahoon

ms.subservice: troubleshoot
ms.topic: conceptual
ms.custom:
ms.reviewer:
ms.date: 06/15/2022
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---

# Think like a debugger

It's common to run into issues when making apps. Having a debugging mindset will help you narrow down the cause, fix them, and find workarounds. Even if you are not able to solve an issue, others can help you more easily with the information you uncover.

These are some techniques to isolate problems in an app.


## General strategies

### Change one thing at a time

When multiple changes are made, it's not obvious which ones contribute to a problem. Try reverting to the last known working state and make a single change. If it works fine, revert the change and make another one until the issue happens. For example, you can [restore a canvas app to a previous version](/power-apps/maker/canvas-apps/restore-an-app) and apply changes progressively.

If you're unable to revert an app to a working state, it's also helpful to do one thing differently while keeping everything else the same. Some examples:

* View the same app on the same device, but with a different browser.
* If data is not displaying correctly in a control, try showing it in a different type of control.
* If a data connection is not working, try a different one.

Knowing what works is as important as knowing what doesn't. For example, if you can connect to one Dataverse table but not another, the table could be misconfigured. On the other hand, if you are not able to connect to any tables at all, it could be a Dataverse outage, Power Apps bug, or a network failure. These suggest other avenues for investigation and brings you closer to the source of the error.

### Simplify

A complex app has many things that could go wrong. An effective investigator removes unnecessary details so that there are less variables to worry about. It's also easier to show the problem to others. For example, if there are [client scripts in model-driven apps](/power-apps/developer/model-driven-apps/client-scripting), try disabling them. Even if the problem still occurs, one can eliminate that as the cause of the problem.

### Start from scratch

We can be blind to our own mistakes. It can be instructive to create a new app or configuration. This can be a simplified version, especially when the original is too complex to re-create. Think about the essence of the app and experiment with what works and what doesn't. For example, if a table in a model-driven app does not show the right records, try [re-creating the view](/developer/model-driven-apps/customize-entity-views).

Should the new app work, compare it with the original to find the difference. If there is no difference, the problem might have been fixed with the latest version. Or, the original app might be corrupted. Even if you are unable to upgrade your app, knowing if and how the problem was fixed will guide next steps.


## Data issues

Power Apps is based on web technologies. Different layers are involved when working with cloud data.

* **Server**. Stores data and controls who can access it.
* **Network**. Transports data between the server and the app.
* **App**. Requests data from the server, processes it, and displays it in the app.
* **App host**. Where the app is run. It provides infrastructure to use an app. This could be a browser, [Power Apps Mobile](/power-apps/mobile/run-powerapps-on-mobile), or another website that Power Apps is embedded in.

Together, these layers form the tech stack of Power Apps. Isolating the layer where a problem occurs can spark ideas for solutions and workarounds. Should data not show correctly in your app, you can determine the problematic layer with these methods.

* **Server**. If there is a problem with the server, the same issue will happen on any website or app that accesses the data.
  * Check if you can work with data outside of the Power Apps app. For example, with Microsoft Lists, you can view and edit records on the SharePoint website that has the list.
  * Check if a different user experiences the same problem. Comparing the experience with an admin user might uncover permission issues.
* **Network**. This is rarely a cause of mystery. When the network is down, there will be no internet access. However, there are a few subtle conditions that might affect the behavior of an app.
  * [Check a different network.](#try-a-different-network)
  * Run the app in a different geographical region, if possible. There may be different network conditions or restrictions.
* **App**.
  * Use [Monitor](/power-apps/maker/monitor-overview) to examine the network requests made by the app. If the correct data is returned by the server, then it's a problem with the app. If the data returned is wrong, it could be a server error or the app didn't request for data correctly. See individual guides below to learn how to read network events with Monitor.
* **App host**.
  * Try a different host. For example, if you are using the Power Apps Mobile app for Android, try the one for iOS or use a desktop browser.

## Intermittent issues

Intermittent issues are particularly difficult to solve. The key is to create the conditions that make them happen all the time. Whether it's caching, network speed, browser performance, or hardware limitations, these steps can help narrow down the cause.

### Try private browsing mode or a different browser
Expired cookies or stale files saved in a browser can cause incorrect operation. Using private browsing mode or a different browser forces re-authentication. It ensures you're running the latest version. For apps, you can try re-installing them to clear stale data.

### Try a different network
Slow loading of data might result in different behavior. If you are using a mobile data connection, try WiFi or a wired connection. If you are using VPNs, try disabling them. You can also simulate slow networks on desktop browsers with browser developer tools.

### Try a different device
Similar to data speed, processing speed can also result in different behavior. If you are using a phone, check if the problem occurs on a desktop computer.


## Performance issues

Progressively simplifying an app is an effective technique for finding the source of performance issues. You can also use profiling tools like [Monitor](/power-apps/maker/monitor-overview) and [Performance insights](/power-apps/maker/common/performance-insights-overview).

For canvas apps, understand their [execution phases](/power-apps/maker/canvas-apps/execution-phases-data-flow) and [common sources of slow performance](/power-apps/maker/canvas-apps/slow-performance-sources).

For model-driven apps, verify if [forms are designed for performance](/power-apps/maker/model-driven-apps/design-performant-forms).


## Next steps

[Isolate issues in canvas apps](isolate-canvas-app-issues.md)
[Isolate issues in model-driven apps](isolate-model-app-issues.md)


### See also

[Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps)
[Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps)


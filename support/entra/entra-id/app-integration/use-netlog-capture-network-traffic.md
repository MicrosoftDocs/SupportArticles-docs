---
title: Use NetLog to capture network traffic
description: Provides guidance about using the Network Logs (NetLog) tool as an alternative to Fiddler and HTTP Archive (HAR) captures.
ms.reviewer: bachoang, v-weizhu
ms.date: 04/08/2025
ms.service: entra-id
ms.topic: how-to
ms.custom: sap:Enterprise Applications
---
# Use NetLog as an alternative to Fiddler and HAR captures

This article provides guidance on using the Network Logs (NetLog) tool as an alternative to Fiddler and HTTP Archive (HAR) captures for diagnosing network issues in Microsoft Entra. NetLog is built into in Chromium-based browsers like Microsoft Edge, Chrome, and Electron. When standard Fiddler captures are unavailable or HAR captures from developer tools truncate necessary information, you can use it to capture network traffic.

## Known limitations

Before using NetLog, be aware of the following limitations:

- POST request bodies aren't captured.
- Sites running in compatibility mode for Internet Explorer aren't captured.

Depending on the information you need, you might still need to use Fiddler or HAR captures.

## Use NetLog in browsers

Follow these steps to capture network traffic using NetLog:

1. (Optional but helpful) Close all browser tabs except one.
1. Navigate to NetLog:
    - For Chrome: Open a new tab and go to `chrome://net-export`.
    - For Microsoft Edge: Open a new tab and go to `edge://net-export`.
1. In the **Options** section, select **Include raw bytes (will include cookies and credentials)**.
1. Leave the **Maximum log size** field blank.
1. Select **Start Logging to Disk**.
1. Select a file and a location (such as **Desktop**) to save the log file.
1. Within the same browser window, open a new tab.
1. Reproduce the issue.

    > [!NOTE]
    > If you close or navigate away from the NetLog tab, the logging will stop automatically.
1. After reproducing the issue, return to the NetLog tab and select the **Stop Logging** button.
1. Locate the NetLog file (*NetLog.json*) saved in step 6.

## Use NetLog on mobile devices

NetLog is supported on mobile versions of Edge and Chrome:

- Android: NetLog works in Edge and Chrome for Android.
- iOS: NetLog works in Chrome for iOS.

On mobile devices, you will have an email option to send the log.

## View and analyze NetLog data

You can view the NetLog.json files using the NetLog Viewer. To do so, open the [online NetLog Viewer](https://netlog-viewer.appspot.com/#import), select **File**, and then upload the exported NetLog .json file.

You can use the following tabs in the NetLog Viewer to inspect different aspects of network activities:

- Events: View detailed network events.
- Proxy: Check proxy settings.
- Timeline: Analyze request timing.
- DNS: Inspect DNS lookups.
- Sockets: Review TCP connections.
- Cache: Examine cached resources.

For more information, see [Providing network details with NetLog](https://dev.chromium.org/for-testers/providing-network-details).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
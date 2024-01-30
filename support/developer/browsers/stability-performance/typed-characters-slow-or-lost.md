---
title: Typed characters are slow or lost in Internet Explorer
description: Due to changes in the use of the navigator.online DOM property in Internet Explorer, web site code may cause the browser to display typed input slowly or cause characters to be omitted intermittently.
ms.date: 06/08/2020
ms.reviewer: joelba
---
# Typed characters are slow or fail to appear in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a solution to solve the problem of losing characters typed in web pages due to frequent calls to JavaScript to detect the connection status of the client.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2665220

## Symptoms

When typing in text areas of some web pages, the typed characters may intermittently be slow to appear or be omitted entirely.

If Task Manager is used to review the running processes at the time of the slow behavior, the SERVICES.EXE and possibly one instance of the SvcHost.EXE process may also indicate a significant or sustained increase in CPU utilization.

## Cause

The web page content likely includes JavaScript functions to test the client browser connection state, using the `window.navigator.onLine` property.

If the content leverages this conditional check too frequently or the state of the client connection is not determined quickly enough, typed characters can be lost while the browser awaits the connection test results.

## Resolution

The optimal recommendation is to modify the site content, which implements this function and lessen the frequency in which a check of `navigator.onLine` is invoked, or modify the code to leverage the on online and on offline events and callback handlers. If it is not possible to modify the content of the web site showing this problem, a client-side change can be implemented to block use of the new features of the `navigator.onLine` property, without impacting the original functionality.

To make a client-side change to block, use of the new features of the `navigator.onLine` property, without impacting the original functionality, follow these steps after taking the necessary precautions to export a copy of the registry key(s) to be modified:

1. Start Regedit.
2. Based on the version of Internet Explorer impacted, navigate to the following feature control key. If it doesn't already exist, create it.

    - For 32-bit Internet Explorer on 32-bit Windows or 64-bit Internet Explorer on 64-bit Windows installations:  
        `HKEY_LOCAL_MACHINE (or HKEY_CURRENT_USER)\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_AJAX_CONNECTIONEVENTS`

    - For 32-bit Internet Explorer on 64-bit Windows installations:  
        `HKEY_LOCAL_MACHINE (or HKEY_CURRENT_USER)\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_AJAX_CONNECTIONEVENTS`

3. Create a new **DWORD** called *iexplore.exe* and set its value data to `0x00000000(0)`.

If after creating the registry key you want to re-enable connectivity events, set the value for iexplore.exe to `0x00000001(1)`.

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More information

From Internet Explorer 4 to Internet Explorer 7, the DOM navigator object `onLine` property was used to reflect the state of the browser **Work Offline** mode, as many of these early Internet Explorer versions allowed clients to persist Favorite web site content for viewing offline. When these sites leveraged content that required the client to be connected, web content authors could implement this property and designate alternate code to be executed when the client was configured to work offline. Considering this state mechanism response was provided by querying the browser configuration directly, the response was nearly immediate.

Starting in Internet Explorer 8, this property was complemented with an additional verification of the underlying network state. When this connection check is performed, Internet Explorer must leverage the operating system to validate the connection points. As a result, the browser must block the handling of incoming user input so that it can handle the connection status response as soon as it is made available. In most cases, this behavior is not impactful to the overall user experience. However, if this activity is performed repeatedly, in short durations or the operating system has not completed the network status check, the delays can become noticeable.

For more information about connectivity enhancements, see the following links:

- [AJAX - Connectivity Enhancements in Internet Explorer 8](/previous-versions//cc304129(v=vs.85))
- [Supporting Offline Browsing in Applications and Components](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa768170(v=vs.85))

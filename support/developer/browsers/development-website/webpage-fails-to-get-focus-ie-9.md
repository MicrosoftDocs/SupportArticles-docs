---
title: Failed to get focus in Internet Explorer 9
description: This article describes some known problems with Internet Explorer 9's Hang Resistance Feature.
ms.date: 06/09/2020
ms.reviewer: bachoang
---
# A web page may fail to get focus in Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information on resolving webpage issues that can't get focus in Internet Explorer 9.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2600156

## Symptoms

A web page or ActiveX control hosted in a web page can stop receiving focus intermittently when being viewed using Internet Explorer 9. The controls may appear disabled, or the focus may end up in the address bar when a user clicks on the page to try to get focus. This issue can affect any UI element on the page that is able to receive focus.

## Cause

The problem happens because the Tab Window is detached from the Frame Window's Input Queue. Microsoft has confirmed that this is a problem in Internet Explorer 9 related to how the Hang Resistance feature works.

## Resolution

The fix for this issue is available in [Internet Explorer Cumulative Update MS11-099 (KB 2618444)](/security-updates/Securitybulletins/2011/ms11-099) or any Internet Explorer Cumulative Update onwards.

There are several ways to work around this problem:

1. Avoid making long running blocking calls or performing any synchronous work on a UI Thread that can potentially interfere with the thread's Message Pump.

2. Create the following Registry Key Value to disable the Hang Resistance feature:

    ```console
    HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\
    Type: REG_DWORD
    Name: HangRecovery
    Value: 0
    ```

    The Hang Resistance feature is enabled by default in Internet Explorer 9. Setting the `HangRecovery` value to `0` disables this feature; setting it to `1` enables it.

3. Avoid calling AttachThreadInput or other APIs that can potentially result in changing the owner for the Tab window, since those APIs affect the Tab Thread's Input Queue. An example of an API that can end up changing the Tab Thread's Input Queue is SetWindowLong.

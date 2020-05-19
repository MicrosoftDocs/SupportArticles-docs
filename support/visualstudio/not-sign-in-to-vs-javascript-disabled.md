---
title: Cannot sign in to VS with JavaScript disabled
description: Discusses an issue in which you cannot sign in to Visual Studio 2013 when JavaScript is disabled in Internet Explorer. Provides a workaround.
ms.date: 04/22/2020
ms.prod-support-area-path:
ms.reviewer: anthc, meyoung
---
# You cannot sign in to Visual Studio 2013 when JavaScript is disabled in Internet Explorer

This article provides the resolution to solve the issue that you can't sign in to Microsoft Visual Studio 2013 with disabled JavaScript in Internet Explorer.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2880131

## Symptoms

When you disable JavaScript in Internet Explorer, you cannot sign in to Microsoft Visual Studio 2013. Additionally, you cannot synchronize Visual Studio settings with other devices.

## Workaround

To work around this issue, enable the JavaScript feature in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer, press Alt to reveal the menu bar, click **Tools**, and then click **Internet Options**.
2. Click the **Security** tab, and then click the **Internet** zone.
3. Depending on whether you have to customize your Internet security settings, select one of the following options:

   - If you do not have to customize your Internet security settings, click **Default Level**.
   - If you have to customize your Internet security settings, click **Custom level**, scroll down to the **Active scripting** section, and then click **Enable**.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the **Applies to** section.

## References

- [How to enable JavaScript in Windows](https://support.microsoft.com/help/3135465)

- [Known issues for Visual Studio 2013](https://support.microsoft.com/help/2890846)

- [Known issues for Visual Studio 2013 RC](https://support.microsoft.com/help/2876195)

## Applies to

- Visual Studio Professional 2013
- Visual Studio Premium 2013
- Visual Studio Ultimate 2013
- Visual Studio Test Professional 2013

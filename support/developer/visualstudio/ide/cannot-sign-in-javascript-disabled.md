---
title: Can't sign in when JavaScript is disabled
description: This article discusses a problem in which you can't sign in to Visual Studio 2013 when JavaScript is disabled in Internet Explorer and provides a workaround.
ms.date: 04/22/2020
ms.reviewer: anthc, meyoung
ms.custom: sap:Integrated Development Environment (IDE)\Visual Studio profile, sign-in, syncing
---
# You can't sign in to Visual Studio 2013 when JavaScript is disabled in Internet Explorer

This article helps you resolve the problem where you can't sign in to Microsoft Visual Studio 2013 with disabled JavaScript in Internet Explorer.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2880131

## Symptoms

When you disable JavaScript in Internet Explorer, you can't sign in to Visual Studio 2013. Additionally, you can't synchronize Visual Studio settings with other devices.

## Workaround

To work around this problem, enable the JavaScript feature in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer, press Alt to reveal the menu bar, click **Tools**, and then click **Internet Options**.
2. Click the **Security** tab, and then click the **Internet** zone.
3. Depending on whether you have to customize your Internet security settings, select one of the following options:

   - If you don't have to customize your Internet security settings, select **Default Level**.
   - If you have to customize your Internet security settings, select **Custom level**, scroll down to the **Active scripting** section, and then select **Enable**.

## Status

Microsoft has confirmed that this is a problem in the products that are listed in the **Applies to** section below.

## References

- [How to enable JavaScript in Windows](https://support.microsoft.com/help/3135465)

- [Known issues for Visual Studio 2013](https://support.microsoft.com/help/2890846)

## Applies to

- Visual Studio Professional 2013
- Visual Studio Premium 2013
- Visual Studio Ultimate 2013
- Visual Studio Test Professional 2013

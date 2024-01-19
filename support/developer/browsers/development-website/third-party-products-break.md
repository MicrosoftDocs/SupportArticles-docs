---
title: BHOs or toolbars break in third-party products in Internet Explorer 11
description: Describes an issue in which Browser Helper Objects (BHOs) and toolbars do not work correctly in third-party products in Internet Explorer 11.
ms.date: 03/23/2020
ms.reviewer: pierrelc
---
# Third-party products that rely on BHOs or toolbars break in Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the workaround to make sure the logic of third-party products cannot break due to Browser Helper Objects (BHOs) or toolbars.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3058703

## Symptoms

When you develop a third-party product that relies on a Browser Helper Object (BHO) or a toolbar, the product cannot detect whether a newly created tab is a virtual tab. This behavior occurs when the virtual tab is not visible in Internet Explorer 11.

## Cause

This issue occurs because non-visible virtual tabs that are created in Internet Explorer 11 may break the logic of the product, and the product cannot detect whether a tab is virtual or not.

> [!NOTE]
> Virtual tabs are heavily used in Internet Explorer 11. You may encounter this issue if you just want to create resources or perform actions only when a tab is visible.

## Workaround

To work around this issue, use certain techniques, such as relying on a secondary thread to check the window state about 1 second after the product obtains the handle.

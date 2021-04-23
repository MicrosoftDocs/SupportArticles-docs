---
title: Edge icon wrongly shown for URL shortcut on Start menu
description: This article describes an issue where the specified icon doesn't display for the shortcut to a website in Microsoft Edge on Start menu in Windows 10.
ms.date: 04/23/2021
ms.prod-support-area-path: 
ms.reviewer: traceytu;DEV_Triage
author: HaiyingYu
ms.author: haiyingyu
---

# Edge icon wrongly shown for URL shortcut on Start menu in Windows 10

This article provides the resolution to solve the issue that the shortcut to a website, in Microsoft Edge 85.0.564.63 and later versions, doesn't apply the icon change to the tile on Start menu in Windows 10.

_Applies to:_ &nbsp; Microsoft Edge, Windows 10  

## Symptoms

Consider the following scenario:

- You are using new Microsoft Edge :::image type="icon" source="./media/edge-icon-show-for-url-shortcut/M365_Edge_icon.png" border="false"::: that is based on Chromium.
- You have created a shortcut to a website in Microsoft Edge on your computer.
- The shortcut target is `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" <URL>`.
- The shortcut is pinned to Start menu.
- The icon of the shortcut is changed to a specified one.
  
  :::image type="content" source="./media/edge-icon-show-for-url-shortcut/edge-shortcut-change-icon.png" alt-text="Change the icon of the Microsoft Edge url shortcut" border="true":::

In this scenario, the tile on Start menu of the shortcut still shows the Microsoft Edge icon :::image type="icon" source="./media/edge-icon-show-for-url-shortcut/M365_Edge_icon.png" border="false":::.

:::image type="content" source="./media/edge-icon-show-for-url-shortcut/edge-tile-icon-not-change.png" alt-text="Tile icon on Start menu does not change" border="true":::

## Cause

This issue occurs because the Start menu incorrectly pulls the Edge logo from the Edge Visual Element Manifest XML file instead of the targeted Icon in the shortcut.

## Use msedge_proxy.exe as the target application

You can use "msedge_proxy.exe" as the target application of the shortcut to resolve the problem. This is a small file that redirects to the main msedge.exe application.

To create a new shortcut to a website in Microsoft Edge, and then change the icon, follow these steps:

1. Right-click the empty spaces on your Desktop, and then select **New** -> **Shortcut**.
1. In **Create shortcut** window, in the **Type the location of the item** field, enter `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe" <URL>`.
  :::image type="content" source="./media/edge-icon-show-for-url-shortcut/shortcut-location.png" alt-text="Enter the location for the new shortcut" border="true":::
1. Provide a name for the shortcut and then click **Finish**.
1. Right-click on the new created shortcut, and then select **Properties**.
1. Click the **Change Icon...** button, select a new icon and then apply the change.
1. Right-click on the shortcut, and then select **Pin to Start**.
1. Check the new tile on Start menu. You will see the tile icon is changed to the specified one.
  :::image type="content" source="./media/edge-icon-show-for-url-shortcut/correct-start-menu-icon.png" alt-text="Check the Windows Start menu icon" border="true":::

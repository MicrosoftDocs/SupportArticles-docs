---
title: Edge icon incorrectly shown for URL shortcut on Start menu
description: This article describes an issue where the specified icon doesn't display for the shortcut to a website in Microsoft Edge on Start menu in Windows 10.
ms.date: 04/23/2021
ms.prod-support-area-path: 
ms.reviewer: traceytu;DEV_Triage
author: HaiyingYu
ms.author: haiyingyu
---

# Edge icon incorrectly shown for URL shortcut on Start menu in Windows 10

This article resolves an issue in which the Microsoft Edge browser icon is incorrectly displayed for a website on the Windows 10 Start menu. This issue affects Microsoft Edge 85.0.564.63 and later versions.

_Applies to:_ &nbsp; Microsoft Edge, Windows 10  

## Symptoms

Consider the following scenario:

- You're using the Microsoft Edge :::image type="icon" source="./media/edge-icon-show-for-url-shortcut/M365_Edge_icon.png" border="false"::: browser that is based on Chromium.
- You create a shortcut to a website on the desktop of your computer.
- The shortcut target is `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" <URL>`.
- You pin the shortcut to the Start menu.
- You change the icon of the shortcut.
  
  :::image type="content" source="./media/edge-icon-show-for-url-shortcut/edge-shortcut-change-icon.png" alt-text="Change the icon of the Microsoft Edge url shortcut" border="true":::

In this scenario, the tile for the shortcut on the Start menu continues to show the Microsoft Edge icon :::image type="icon" source="./media/edge-icon-show-for-url-shortcut/M365_Edge_icon.png" border="false"::: instead of the website-specific icon or another icon that you selected.

:::image type="content" source="./media/edge-icon-show-for-url-shortcut/edge-tile-icon-not-change.png" alt-text="Tile icon on Start menu does not change" border="true":::

## Cause

This issue occurs because the Start menu incorrectly pulls the Edge logo from the Edge Visual Element Manifest XML file instead of using the icon that's targeted in the shortcut.

## Use Msedge_proxy.exe as the target application

To resolve the issue, use "msedge_proxy.exe" as the target application of the shortcut. This is a small file that redirects the shortcut to the main Msedge.exe application.

To create a shortcut to a website that opens in Microsoft Edge, and then change the icon, follow these steps:

1. Right-click anywhere in the empty space on the desktop, and then select **New** > **Shortcut** to open the **Create shortcut** window.
1. In the **Type the location of the item** box, enter `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe" <URL>`, and then select **Next**.
  :::image type="content" source="./media/edge-icon-show-for-url-shortcut/shortcut-location.png" alt-text="Enter the location for the new shortcut" border="true":::
1. Provide a name for the shortcut, and then select **Finish**.
1. Right-click the new shortcut, and then select **Properties**.
1. Select the **Change Icon** button, select a new icon, and then select **OK** to apply the change.
1. On the desktop, right-click the shortcut again, and then select **Pin to Start**.
1. Check the new tile on Start menu. You should now see that the tile icon is changed to the specified icon.
  :::image type="content" source="./media/edge-icon-show-for-url-shortcut/correct-start-menu-icon.png" alt-text="Check the Windows Start menu icon" border="true":::

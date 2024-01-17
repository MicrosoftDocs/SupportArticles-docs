---
title: Edge icon is incorrectly shown for URL shortcut on Start menu
description: This article describes an issue where the specified icon isn't shown for the shortcut to a website in Microsoft Edge on the Windows 10 Start menu.
ms.date: 04/23/2021
ms.reviewer: traceytu;DEV_Triage
author: HaiyingYu
ms.author: haiyingyu
---

# Edge icon is incorrectly shown for URL shortcut on Start menu in Windows 10

[!INCLUDE [](../../../includes/browsers-important.md)]

_Applies to:_ &nbsp; Microsoft Edge, Windows 10  

This article resolves an issue in which the Microsoft Edge browser icon is incorrectly displayed for the shortcut to a website in Microsoft Edge on the Windows 10 **Start** menu. This issue affects Microsoft Edge 85.0.564.63 and later versions.

## Symptoms

Consider the following scenario:

- You're using the Microsoft Chromium-based Edge :::image type="icon" source="media/edge-icon-show-for-url-shortcut/m365-edge-icon.png"::: browser.
- You create a shortcut to a website on the desktop of your computer.
- The shortcut target is *:::no-loc text="\"C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe\" &lt;URL&gt;":::*.
- You pin the shortcut to the **Start** menu.
- You change the icon of the shortcut.
  
    :::image type="content" source="media/edge-icon-show-for-url-shortcut/edge-shortcut-change-icon.png" alt-text="Screenshot shows the windows to change the icon of the Microsoft Edge url shortcut.":::

In this scenario, the tile for the shortcut on the **Start** menu continues to show the Microsoft Edge icon :::image type="icon" source="media/edge-icon-show-for-url-shortcut/m365-edge-icon.png"::: instead of the website-specific icon or another icon that you selected.

  :::image type="content" source="media/edge-icon-show-for-url-shortcut/edge-tile-icon-not-change.png" alt-text="Screenshot shows Tile icon on Start menu does not change.":::

## Cause

This issue occurs because the **Start** menu incorrectly pulls the Edge logo from the Edge Visual Element Manifest XML file instead of using the icon that's targeted in the shortcut.

## Use msedge_proxy.exe as the target application

To resolve the issue, use *msedge_proxy.exe* as the target application of the shortcut. This is a small file that redirects the shortcut to the main *msedge.exe* application.

To create a shortcut to a website that opens in Microsoft Edge, and then change the icon, follow these steps:

1. Right-click anywhere in the empty space on the desktop, and then select **New** > **Shortcut** to open the **Create shortcut** window.
1. In the **Type the location of the item** box, enter *:::no-loc text="\"C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge_proxy.exe\" &lt;URL&gt;":::*, and then select **Next**.

    **Note:** Replace \<URL\> with the address of the website that you want to create the shortcut to.

    :::image type="content" source="media/edge-icon-show-for-url-shortcut/shortcut-location.png" alt-text="Screenshot of the Create Shortcut page, where the location for the new shortcut is entered.":::

1. Provide a name for the shortcut, and then select **Finish**.
1. Right-click the new shortcut, and then select **Properties**.
1. Select the **Change Icon** button, select a new icon, and then select **OK** to apply the change.
1. On the desktop, right-click the shortcut again, and then select **Pin to Start**.
1. Check the new tile on **Start** menu. You should now see that the tile icon is changed to the specified icon.

    :::image type="content" source="media/edge-icon-show-for-url-shortcut/correct-start-menu-icon.png" alt-text="Screenshot shows the correct Tile icon on Start menu.":::

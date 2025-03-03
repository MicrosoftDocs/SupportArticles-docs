---
title: SAP UI Element Click Issue 
description: Solves an issue where clicking an SAP UI element fails in Power Automate for desktop.
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.custom: sap:Desktop flows\SAP automation
ms.date: 03/03/2025
---
# Clicking an SAP UI element fails

This article helps you resolve issues with UI automation actions (such as clicking an SAP UI element) that occur because the application isn't fully dots per inch (DPI) aware.

## Symptoms

When you try to [click an SAP UI element](/power-automate/desktop-flows/actions-reference/sap#clicksapguielement), the mouse cursor moves and appears to locate the element. However, the cursor isn't positioned over the correct element, causing the click action to fail.

## Cause

This issue occurs because the SAP application isn't fully DPI aware and might not always scale properly on high-DPI displays. When a user captures an element on a machine other than the one where the flow is run, and the two machines have different screen resolutions, the flow might fail. This behavior can also occur on machines with multiple screens.

## Resolution

1. In the SAP application, go to **SAP settings** > **Visual Design** > **Theme Settings** and enable the **Multi-monitor scaling awareness** option.

   > [!NOTE]
   > This option isn't available in all themes.

   :::image type="content" source="media/sap-click-element-dpi/mutli-monitor-scaling-awareness.png" alt-text="Screenshot of the Multi-monitor scaling awareness option in SAP Theme Settings.":::

2. On Windows, go to **System** > **Display** and set the **Scale** to 100%.

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]

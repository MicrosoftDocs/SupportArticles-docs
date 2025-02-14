---
title: SAP UI element click issue 
description: Solves an issue where clicking on an SAP UI element fails in Power Automate for desktop.
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.custom: sap:Desktop flows\SAP automation
ms.date: 02/14/2025
---
# Clicking on an SAP UI element fails

This article solves an issue where clicking on an SAP UI element fails due to the application not being DPI aware in Power Automate for desktop.

## Symptoms

When you try to [click on an SAP UI element](/power-automate/desktop-flows/actions-reference/sap#clicksapguielement), the mouse cursor moves and appears to locate the element. However, the cursor isn't positioned over the correct element, causing the click action to fail.

## Cause

This issue occurs because the SAP application isn't dots per inch (DPI) aware. When the user captures an element on a machine that's different from the one where the flow is run, and the two machines have different screen resolutions, the flow fails. This behavior can also occur on machines with multiple screens.

## Resolution

1. In the SAP application, go to **SAP settings** > **Visual Design** > **Theme Settings** and enable the **Multi-monitor scaling awareness** option.

   > [!NOTE]
   > This option isn't available in all the themes.

   :::image type="content" source="media/sap-click-element-dpi/mutli-monitor-scaling-awareness.png" alt-text="The Multi monitor scaling awareness option shown in SAP Theme Settings.":::

2. On Windows, go to **System** > **Display** and set the **Scale** to 100%.

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]

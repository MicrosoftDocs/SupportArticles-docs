---
title: SAP UI element click issue
description: Solves issues with sap element click
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/29/2025
---
# SAP UI element click issue

## Symptoms

The mouse moves and seems like it finds the elements but it's not over the correct element causing the action to fail.

## Cause

This behavior is because the SAP application is not DPI aware. So, when the user captures an element in a different machine that the one the flow is run, and the two machines have different resolution then, the flow will fail (Same behavior has been notices on machines with multiple screens).

## Resolution

Go to SAP settings > Visual design > Theme settings and check the Multi-monitor scaling awareness option. This option is not available in all the themes.

:::image type="content" source="media/sap-click-element-dpi/mutli-monitor.png" alt-text="Multi-monitor scaling awareness.":::

Also, on windows go to System > Display and set the Scale to 100%.

---
title: Non-customizable buttons in ribbon
description: Provides more information about the buttons that aren't customizable in ribbon.
ms.date: 01/10/2023
ms.reviewer: brflood
ms.custom: sap:Configuring model-driven app commands\Command is not shown or hidden as expected
---
# Non-customizable buttons in ribbon

_Applies to:_ &nbsp; Power Apps  

The **Show Chart**, **Create view**, **Show as**, and **Open Dashboards** buttons on grids in the Unified Interface aren't implemented by ribbon customizations. The buttons are hardcoded by grid control code and unfortunately aren't customizable. Therefore, they aren't visible in Ribbon Workbench.

> [!NOTE]
> The button with ID `Mscrm.HomepageGrid.{!EntityLogicalName}.ChangeDataSetControlButton` is a button intended only for Web client interface that is now deprecated and this is intentionally disabled in the Unified Interface. Any attempts to modify this button is not supported.

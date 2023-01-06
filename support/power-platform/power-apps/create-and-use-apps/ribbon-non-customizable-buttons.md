---
title: Non-customizable buttons in ribbon
description: Describes buttons in ribbon that are not customizable.
ms.topic: troubleshooting
ms.date: 01/06/2023
---
# Non-customizable buttons in ribbon

_Applies to:_ &nbsp; Power Apps  

The "**Show Chart**", "**Create view**", "**Show as**" and "**Open Dashboards**" buttons on grids in the Unified Interface are not implemented using ribbon customizations, rather they are hardcoded by grid control code and unfortunately are not customizable and therefore not visible in Ribbon Workbench.

> [!NOTE]
> The button with id `Mscrm.HomepageGrid.{!EntityLogicalName}.ChangeDataSetControlButton` is a button intended only for Web Client interface that is now deprecated and this is intentionally disabled in the Unified Interface. Any attempts to modify this button is not supported.

You can hide the "**Show as**" button for a specific entity by **disabling** the **editable grid** for that entity. See [https://docs.microsoft.com/dynamics365/customer-engagement/customize/make-grids-lists-editable-custom-control](https://docs.microsoft.com/dynamics365/customer-engagement/customize/make-grids-lists-editable-custom-control)

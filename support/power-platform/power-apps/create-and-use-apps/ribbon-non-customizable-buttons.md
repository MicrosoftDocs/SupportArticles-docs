---
title: Noncustomizable buttons in ribbon
description: Provides more information about the buttons that aren't customizable in ribbon in Microsoft Power Apps.
ms.date: 09/10/2025
ms.reviewer: brflood
ms.custom: sap:Configuring model-driven app commands\Command is not shown or hidden as expected
---
# Noncustomizable buttons in ribbon 

_Applies to:_ &nbsp; Power Apps  

The following buttons in the Unified Interface aren't implemented by [ribbon customizations](/power-apps/developer/model-driven-apps/customize-commands-ribbon). They're hardcoded by internal platform code and unfortunately aren't customizable. Therefore, they aren't visible in the [Ribbon Workbench](https://www.develop1.net/public/rwb/ribbonworkbench.aspx).

- **Create view**
- **Help**
- **See all records**
- **Share**
- **Show as**
- **Show Chart**
- **Open Dashboards**

> [!NOTE]
>
> - The button with ID `Mscrm.HomepageGrid.{!EntityLogicalName}.ChangeDataSetControlButton` is a button intended only for Web client interface that's now deprecated and this is intentionally disabled in the Unified Interface. Any attempts to modify this button aren't supported.
> - Microsoft doesn't provide help or support for community tools. To obtain support or help to use these programs, contact the program publisher.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

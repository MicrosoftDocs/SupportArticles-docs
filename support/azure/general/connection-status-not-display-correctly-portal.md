---
title: Connection status isn't displayed correctly on the Azure Management Portal
description: Describes an issue that occurs when a site-to-site connection is configured to use a Standard-size gateway.
ms.date: 11/26/2020
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
ms.reviewer: 
---
# Connection status isn't displayed correctly on the Azure Management Portal

_Original product version:_ &nbsp; Virtual Network, Portal  
_Original KB number:_ &nbsp; 3110165

## Symptoms

When a site-to-site connection is configured to use a Standard-size gateway, the connection status isn't displayed correctly on the Microsoft [Azure Management Portal](https://portal.azure.com/). Additionally, a download link for the VPN device script isn't displayed.

:::image type="content" source="media/connection-status-not-display-correctly-portal/virtual-network.png" alt-text="Screenshot shows that connection status is displayed normally.":::

Figure 1: Usually, the connection status is displayed as in this figure.

:::image type="content" source="media/connection-status-not-display-correctly-portal/connection-status.png" alt-text="Screenshot shows that with Standard size gateway, some items are not properly displayed.":::

Figure 2: When you use a Standard-size gateway, some items aren't displayed correctly.

## Cause

This issue occurs because of an inconsistency between the implementation of the back-end virtual network and the front-end management portal.

## Workaround

Use any other gateway size (for example, the Default or HighPerformance size) for site-to-site connection.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

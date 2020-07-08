---
title: Exchange connector version is not supported
description: Describes an issue in which you receive an Intune Exchange Connector version is not supported error message.
ms.date: 05/13/2020
ms.prod-support-area-path: Exchange on-premises connector
---
# Intune Exchange connector version is not supported when configuring the on-premises Exchange connector

This article provides the information to solve the **Intune Exchange Connector version is not supported** error message that occurs when you try to configure the on-premises Exchange connector.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4464186

## Symptoms

When you try to [configure the Microsoft Intune on-premises Exchange connector](/mem/intune/protect/exchange-connector-install), you receive the following error message:

> Configuration Failed  
> The Microsoft Intune Exchange Connector version is not supported.

:::image type="content" source="media/exchange-connector-version-not-supported/connector-error.png" alt-text="screenshot of Connector error":::

## Cause

This issue occurs if an old version of the Intune on-premises Exchange connector is installed.

## Resolution

To fix the issue, make sure that you [download](/mem/intune/protect/exchange-connector-install#download-the-installation-package) and [install](/mem/intune/protect/exchange-connector-install#install-and-configure-the-intune-exchange-connector) the latest version of the Intune on-premises Exchange connector.

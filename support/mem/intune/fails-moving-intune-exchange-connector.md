---
title: Can't move an on-premises Intune Exchange connector
description: Fixes the Microsoft Intune Exchange Connector version is not supported error when you try to move the connector to a new Exchange server.
ms.date: 05/11/2020
ms.prod-support-area-path: Exchange on-premises connector
---
# The Microsoft Intune Exchange Connector version is not supported error when moving the connector

This article fixes the error **The Microsoft Intune Exchange Connector version is not supported** when you try to move the connector to a new Exchange server.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4342995

## Symptoms

When you try to move a Microsoft Intune Exchange connector from an existing on-premises server that is running Microsoft Exchange Server to another on-premises server that is running Exchange, the configuration process fails and returns the following error message:  

> The Microsoft Intune Exchange Connector version is not supported.

## Cause

This issue may occur if the original on-premises Exchange connector is still installed.

## Resolution

To resolve this issue, remove the original Exchange connector, and then install a new Exchange connector.

## More information

For more information about how to install an Exchange connector, see [Set up the on-premises Intune Exchange connector](/mem/intune/protect/exchange-connector-install).

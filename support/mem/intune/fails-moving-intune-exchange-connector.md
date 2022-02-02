---
title: Can't move an on-premises Intune Exchange connector
description: Fixes the Microsoft Intune Exchange Connector version is not supported error when you try to move the connector to a new Exchange server.
ms.date: 12/20/2021
ms.custom: sap:Exchange on-premises connector
---
# Microsoft Intune Exchange Connector version is not supported error when moving the connector

This article fixes the error **The Microsoft Intune Exchange Connector version is not supported** when you try to move the connector to a new Exchange server.

## Symptoms

When you try to move a Microsoft Intune Exchange connector from an existing on-premises server that is running Microsoft Exchange Server to another on-premises server that is running Exchange, the configuration process fails and returns the following error message:

> The Microsoft Intune Exchange Connector version is not supported.

## Cause

This issue may occur if the original on-premises Exchange connector is still installed.

## Solution

To resolve this issue, remove the original Exchange connector, and then install a new Exchange connector. For detailed instructions, see [Set up the on-premises Intune Exchange connector](/mem/intune/protect/exchange-connector-install).

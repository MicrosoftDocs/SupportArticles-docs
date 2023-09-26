---
title: Failed to fetch error when creating flow
description: Provides a solution to an error that occurs when you try to create a flow and add a trigger/action from the Outlook 365 connector.
ms.reviewer: wifun
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-flows
---
# "Failed to fetch" error when creating flow with Outlook 365 connector

This article provides a solution to an error that occurs when you try to create a flow and add a trigger/action from the Outlook 365 connector.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4527579

## Symptoms

When you try to create a flow and add a trigger/action from the Outlook 365 connector, you may receive the following error message:

> "Failed to fetch"

## Cause

This error can be reached because:

- Your environment hasn't been given permission to use the Outlook 365 connector.
- IT may have blocked the connector on your network

## Resolution

Contact the Global Administrator of your Tenant to grant the necessary permissions.

Contact your IT to unblock the connector. For more information, see [Limits for automated, scheduled, and instant flows](/power-automate/limits-and-config#ip-address-configuration).

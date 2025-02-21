---
title: Remote Control always prompts for user permission
description: Provides a solution to an issue where the user is still prompted for permissions to allow the Remote Control even though you uncheck Require User's permission under the Remote Control tab.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:remote desktop services and terminal services\session connectivity
- pcy:WinComm User Experience
---
# Remote Control always prompts for user permission

This article provides a solution to an issue where the user is still prompted for permissions to allow the Remote Control even though you uncheck **Require User's permission** under the **Remote Control** tab.

_Original KB number:_ &nbsp; 2690875

## Symptoms

You configure a user in Active Directory and uncheck **Require User's permission** under the **Remote Control** tab.

However, when you try to Remote Control this user, and the user is on the physical Console Session, the user is still prompted for permissions to allow the Remote Control.

## Cause

In the case of Remote Control the Console Session, the user property is currently not taken into consideration.

## Workaround

To work around this issue, disable the user prompt for all users with a machine policy found under computer configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections:

Set rules for remote control of Remote Desktop Services user sessions

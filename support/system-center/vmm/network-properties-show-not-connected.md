---
title: Network properties show not connected
description: Fixes an issue where the virtual machine network may show not connected in the App Controller portal website though the virtual machine is connected.
ms.date: 08/18/2020
---
# Virtual machine network shows Not connected in the App Controller portal website

This article helps you fix an issue where the virtual machine network may show **not connected** in the App Controller portal website though the virtual machine is connected.

_Original product version:_ &nbsp; Microsoft System Center 2012 App Controller Service Pack 1  
_Original KB number:_ &nbsp; 2866038

## Symptoms

You log on to the App Controller portal in a Self-Service User role. When you open the **Properties** for a virtual machine, the virtual machine network may show **not connected** despite the fact that the virtual machine is connected. If you close and reopen **Properties**, the correct network connection is shown.

## Cause

This can occur if the required virtual machine networks are missing from the Self-Service User role's **Networking** properties.

## Resolution

To resolve this issue, go to the Self-Service User role's **Networking** properties and add the virtual machine networks to which the virtual machine is connected.

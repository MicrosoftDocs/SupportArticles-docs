---
title: Devices connected through a Thunderbolt Dock stop working after the computer resumes from the S5 power state
description: Describes an issue in which devices that are connected through a Thunderbolt Dock stop working after the computer resumes from the S5 power state. Provides a workaround.
ms.date: 12/03/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Power Management
ms.technology: windows-client-deployment
---
# Devices connected through a Thunderbolt Dock stop working after the computer resumes from the S5 power state

This article provides a workaround for an issue where devices that are connected through a Thunderbolt Dock stop working after the computer resumes from the S5 power state.

_Original product version:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4532436

## Symptoms

Consider the following scenario:

- On a computer that is running Windows 10 that has a version between Windows 10, version 1709 and Windows 10, version 2004, you enable Fast Startup.
- On a Thunderbolt Dock, several devices, such as a keyboard, mouse, and USB encryption key, are attached.
- You repeatedly do the following steps:
  - You connect the Thunderbolt Dock to the computer. Devices on the Thunderbolt Dock are enumerated.
  - You press the power button to put the system into a Soft Off (S5) power state. After the screen turns off, you remove the Thunderbolt Dock.
  - You wait for the S5 process to finish, plug in the Thunderbolt Dock, and then wait five seconds for the Thunderbolt Dock to become idle.
  - You power on the computer. Then, you check whether the mouse, keyboard, and USB key are functional.

In this scenario, there is a five percent failure rate for all the devices that are attached to the Thunderbolt Dock. In this situation, the devices stop working even if they are listed in Device Manager.

When the failure occurs, the functionality of the devices cannot be restored by re-attaching the Thunderbolt Dock. Instead, you have to restart the computer.

## Workaround

To work around this issue, restart the computer.

## References

For more information about Windows power states, see [System Power States](/windows/win32/power/system-power-states).

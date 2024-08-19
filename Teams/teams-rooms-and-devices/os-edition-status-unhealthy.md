---
title: The OS Edition status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the OS Edition signal of a Teams Rooms device to appear as Unhealthy.
ms.reviewer: joolive
ms.topic: troubleshooting
ms.date: 12/08/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro\
  - CI167670
---
# The OS Edition status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **OS Edition** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity is shown as **Critical**.

Users also experience the following issues on the device:

- The device doesn't sign in automatically.
- The device console displays a black or gray screen.

## Cause

These issues occur when the Teams Rooms Pro agent detects that the device isn't running a supported edition of Windows. Microsoft Teams Rooms requires the Windows IoT Enterprise or Windows Enterprise SKUs under the Global Availability Channel servicing option. For more information, see [Windows release support](/microsoftteams/rooms/rooms-lifecycle-support#windows-release-support).

## Resolution

- Make sure that you're using a supported Teams Rooms system listed in [Microsoft Teams Rooms requirements](/microsoftteams/rooms/requirements). Otherwise, replace it with a supported system. All current Teams Rooms devices and bundles are available in the [Teams Rooms product showcase](https://www.microsoft.com/microsoft-teams/across-devices/devices/category/teams-rooms/20).
- Reimage the device as described in the OEM documentation.

## More information

All certified Teams Rooms devices are pre-installed together with an IoT Enterprise or the binary-equivalent Enterprise edition of Windows 10 or Windows 11. You can also choose to upgrade an existing IoT Enterprise edition to the full Enterprise edition using Bring Your Own License (BYOL).

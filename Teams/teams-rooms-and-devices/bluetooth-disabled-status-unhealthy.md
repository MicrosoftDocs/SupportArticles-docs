---
title: The Bluetooth disabled status of a Teams Rooms device is Unhealthy
description: Resolves an issue that causes the Bluetooth disabled signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: rebenite
ms.topic: troubleshooting
ms.date: 10/30/2023
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI174031
---
# The Bluetooth disabled status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Bluetooth disabled** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**. Additionally, users might experience the following issue:

When Bluetooth is disabled on the Teams Rooms device at the operating system (OS) level, the proximity feature that facilitates the discovery and addition of nearby Teams Rooms to a meeting might be affected.

> [!NOTE]  
> Incidents that are classified as **Warning** don't affect the health status that's reported for a device.

## Cause

This issue occurs if Bluetooth is turned off in Windows settings on the Teams Rooms device.

If Bluetooth has to be disabled, we recommend that you disable it within the Teams Rooms app instead to avoid triggering this event.

## Resolution

To fix this issue, [turn on Bluetooth in Windows settings](https://support.microsoft.com/windows/9e92fddd-4e12-e32b-9132-5e36bdb2f75a), as follows:

1. Select **Start** > **Settings** > **Bluetooth & devices**.

2. On the **Bluetooth & devices** page, turn on Bluetooth.

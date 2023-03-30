---
title: The Bluetooth disabled status of a Teams Rooms device is Unhealthy
description: Resolves an issue that causes the Bluetooth disabled signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: rebenite
ms.topic: troubleshooting
ms.date: 3/30/2023
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI174031
---
# The Bluetooth disabled status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Bluetooth disabled** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**. Additionally, users might experience the following issue:

When Bluetooth is disabled on the Teams Rooms device at the operating system (OS) level, the proximity feature that facilitates the discovery and addition of nearby Teams Rooms to a meeting may be impacted.

## Cause

This issue occurs if Bluetooth is disabled in the Teams Rooms device OS in Windows settings.

If Bluetooth needs to be disabled, it's recommended to disable it within the Teams Rooms app instead to avoid this event to be triggered.

## Resolution

To fix this issue, [turn on Bluetooth in Windows settings](https://support.microsoft.com/windows/9e92fddd-4e12-e32b-9132-5e36bdb2f75a) as follows:

1. Select **Start** > **Settings** > **Bluetooth & devices**.

2. On the **Bluetooth & devices** page, turn on Bluetooth.

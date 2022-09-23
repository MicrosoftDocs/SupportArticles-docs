---
title: The Default Credentials status of an MTR device is unhealthy
description: Resolve the issue that the Default Credentials signal of a Microsoft Teams Rooms (MTR) device is Unhealthy.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 9/23/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI167104
---
# The Default Credentials status is unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Default Credentials** signal of a Microsoft Teams Rooms (MTR) device is **Unhealthy**, and the incident severity is **Warning**.

> [!NOTE]
> Incidents classified as **Warning** severity don't affect the health status reported on a device.

## Cause

Every new MTR device includes a local administrator account called **Admin** with a well-known default password. If the default password remains the same after the device is set up, it creates a security breach because anyone who knows the default password can modify the device. In this case, the MTR Pro agent detects and reports the **Default Credentials** status as **Unhealthy**.

> [!NOTE]
> The MTR Pro agent performs a test on the device with these well-known credentials whenever any of the following key elements of the local **Admin** user change:
>
> - Name (username)
> - Enabled
> - PsswordLastSet

## Resolution

To fix this issue, change the password of the built-in **Admin** account. You can also set up an alternate local administrator account or import domain accounts into the local Windows Administrator group.

> [!NOTE]
> As the best practice, organizations should define policies to govern administrative access of MTR devices and password configuration as needed. For more information, see [MTR account security](/microsoftteams/rooms/security#account-security).

---
title: The Default Credentials status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Default Credentials signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: joolive
ms.topic: troubleshooting
ms.date: 10/30/2023
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI167104
---
# The Default Credentials status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Default Credentials** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and the incident severity value is shown as **Warning**.

> [!NOTE]
> Incidents that are classified as **Warning** don't affect the health status that's reported for a device.

## Cause

Every new Teams Rooms device includes a local administrator account that named **Admin** that has a well-known default password. If the default password remains the same after the device is set up, this creates a security breach because anyone who knows the default password can modify the device. In this case, the Teams Rooms Pro agent detects and reports the **Default Credentials** status as **Unhealthy**.

> [!NOTE]
> The Teams Rooms Pro agent performs a test on the device with these well-known credentials whenever any of the following key elements of the local **Admin** user change:
>
> - Name (username)
> - Enabled
> - PsswordLastSet

## Resolution

To fix this issue, change the password of the built-in **Admin** account. You can also set up an alternative local administrator account or import domain accounts into the local Windows Administrator group.

> [!NOTE]
> As a best practice, organizations should define policies to govern administrative access of Teams Rooms devices and password configuration as necessary. For more information, see [Teams Rooms account security](/microsoftteams/rooms/security#account-security).

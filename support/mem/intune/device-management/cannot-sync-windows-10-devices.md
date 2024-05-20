---
title: Troubleshoot Windows 10 devices that can't sync with Intune after enrollment
description: Gives the resolution for when a Windows 10 device can't sync with Microsoft Intune after it's enrolled for two minutes to two days.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Enroll Device - Windows\MDM only
ms.reviewer: kaushika
---
# Windows 10 devices can't sync with Intune after enrollment

This article describes an issue in which a Windows 10 device can't sync with Microsoft Intune after it's enrolled for two minutes to two days.

## Symptoms

After a Windows 10 device is enrolled in Intune for some time (randomly from two minutes to two days), the device can no longer sync with Intune. When you start a manual sync on the device or in the Microsoft Intune admin center, synchronization isn't started and the last sync time isn't updated. When this issue occurs, no errors are logged in the event logs.

> [!NOTE]
> In this scenario, the Intune management extension still works and you can still deploy PowerShell scripts to the device.

## Cause

This issue occurs if the [Device Management Wireless Application Protocol (dmwappushservice)](/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server#dmwappushsvc) service is disabled. For example, you have a PowerShell script that is deployed to the device, and the script contains a command that disables this service.

The `dmwappushservice` service is required on client devices for Intune management. If this service is disabled, the device can't sync with Intune.

## Solution

To fix the issue, change the startup type of the `dmwappushservice` service to **Automatic**.

:::image type="content" source="media/cannot-sync-windows-10-devices/change-startup-type.png" alt-text="Screenshot shows steps to find the change startup type drop-down option.":::

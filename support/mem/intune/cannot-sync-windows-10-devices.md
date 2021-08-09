---
title: Windows 10 devices can't sync with Intune after enrollment
description: Describes an issue in which a Windows 10 device can't sync with Intune after it's enrolled for two minutes to two days.
ms.date: 08/12/2020
ms.prod-support-area-path:  device management
---
# Windows 10 devices can't sync with Intune after enrollment

This article describes an issue in which a Windows 10 device can't sync with Intune after it's enrolled for two minutes to two days.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4511914

## Symptoms

After a Windows 10 device is enrolled in Microsoft Intune for some time (randomly from two minutes to two days), the device can no longer sync with Intune. When you start a manual sync on the device or in the Intune Azure portal, synchronization isn't started and the last sync time isn't updated. When this issue occurs, no errors are logged in the event logs.

> [!NOTE]
> In this scenario, the Intune management extension still works and you can still deploy PowerShell scripts to the device.

## Cause

This issue occurs if the [Dmwappushservice](/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server#dmwappushsvc) service is disabled. For example, you have a PowerShell script that is deployed to the device, and the script contains a command that disables this service.

The `Dmwappushservice` service is required on client devices for Intune management. If this service is disabled, the device can't sync with Intune.

## Resolution

To fix the issue, change the startup type of the `Dmwappushservice` service to **Automatic**.

:::image type="content" source="media/cannot-sync-windows-10-devices/change-startup-type.png" alt-text="change startup type":::

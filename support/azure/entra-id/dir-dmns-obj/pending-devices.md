---
title: Pending devices in Microsoft Entra ID
description: Explains why a device is in the pending state in Microsoft Entra ID.
author: genlin
ms.author: genli
ms.date: 10/10/2023
ms.service: active-directory
ms.subservice: domain-services
---
# Pending devices in Microsoft Entra ID

[!INCLUDE [Feedback](../../../includes/feedback.md)]

Pending devices are devices that are synced to Microsoft Entra ID from your on-premises Active Directory, but haven't completed registration with the Microsoft Entra device registration service. When the registered state of a device is pending, the device can't complete any authorization or authentication requests, such as requesting a [Primary Refresh token](/azure/active-directory/devices/concept-primary-refresh-token) for single sign-on, or applying [device-based Conditional Access policies](/mem/intune/protect/create-conditional-access-intune).

> [!NOTE]
> The pending state exists only for Microsoft Entra hybrid joined devices.

## Why a device might be in a pending state

When you configure a **Microsoft Entra hybrid join** task in the Microsoft Entra Connect Sync for your on-premises devices, the task will sync the device objects to Microsoft Entra ID, and temporarily set the registered state of the devices to "pending" before the device completes the device registration. This is because the device must be added to the Microsoft Entra directory before it can be registered. For more information about the device registration process, see [How it works: Device registration](/azure/active-directory/devices/device-registration-how-it-works#hybrid-azure-ad-joined-in-managed-environments).

For more information about how to troubleshoot pending devices, see the following video:

> [!VIDEO https://www.youtube-nocookie.com/embed/QBR1c81kaxA]

## How a device gets stuck in a pending state

There are two scenarios in which a device can be stuck in a pending state.

<a name='sync-a-new-on-premises-domain-joined-device-to-azure-ad'></a>

### Sync a new on-premises domain joined device to Microsoft Entra ID

A new on-premises device can get stuck in a pending state if it can't complete the device registration process. This problem can be caused by several factors, such as that the device can't connect to the registration service.

To troubleshoot a device registration problem, see:

- [Troubleshooting Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current)
- [Test Device Registration Connectivity](/samples/azure-samples/testdeviceregconnectivity/testdeviceregconnectivity/)

### The state of a registered device is changed to pending

This problem can occur in the following scenario:

1. The device object is moved to another organizational unit (OU) that isn't in the sync scope in Microsoft Entra Connect Sync.
1. Microsoft Entra Connect Sync recognizes this change as the device object being deleted in the on-premises Active Directory. Therefore, it deletes the device in Microsoft Entra ID.
1. The device object was moved back to the OU in the sync scope.
1. Microsoft Entra Connect Sync creates a pending device object for this device in Microsoft Entra ID.
1. The device fails to complete the device registration process because it was registered previously.

To fix the problem, unregister the device by running `dsregcmd /leave` at an elevated command prompt, and restart the device. The device will reinitiate the device registration process through the scheduled task. For Windows 10-based devices, the scheduled task is under **Task Scheduler Library** > **Microsoft** > **Windows** > **Workplace Join** > **Automatic-Device-Join Task**.

## Get a list of pending devices

1. The [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation?view=graph-powershell-1.0&preserve-view=true) must be installed to execute Microsoft Graph PowerShell commands.
2. Use the `Connect-MgGraph` command to sign in to your Microsoft Entra tenant. For more information, see [Get started with the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/get-started?view=graph-powershell-1.0&preserve-view=true).
3. Count all pending devices:

    ```powershell
    (Get-MgDevice -All -Filter "TrustType eq 'ServerAd'" | Where-Object{($_.ProfileType -ne "RegisteredDevice") -and (-not $_.AlternativeSecurityIds)}).count
    ```

    You can also save the returned data in a CSV file:

    ```powershell
    Get-MgDevice -All -Filter "TrustType eq 'ServerAd'" | Where-Object{($_.ProfileType -ne "RegisteredDevice") -and (-not $_.AlternativeSecurityIds)} | select-object -Property AccountEnabled, Id, DeviceId, DisplayName, OperatingSystem, OperatingSystemVersion, TrustType | export-csv pendingdevicelist-summary.csv -NoTypeInformation
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

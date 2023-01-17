---
title: Pending devices in Azure Active Directory
description: Explains why a device is in the pending state in Azure Active Directory.
author: genlin
ms.author: genli
ms.date: 08/17/2021
ms.service: active-directory
ms.subservice: domain-services
---
# Pending devices in Azure Active Directory

Pending devices are devices that are synced to Azure Active Directory (Azure AD) from your on-premises Active Directory, but haven't completed registration with the Azure AD device registration service. When the registered state of a device is pending, the device can't complete any authorization or authentication requests, such as requesting a [Primary Refresh token](/azure/active-directory/devices/concept-primary-refresh-token) for single sign-on, or applying [device-based Conditional Access policies](/mem/intune/protect/create-conditional-access-intune).

> [!NOTE]
> The pending state exists only for hybrid Azure AD-joined devices.

## Why a device might be in a pending state

When you configure a **Hybrid Azure AD join** task in the Azure AD Connect Sync for your on-premises devices, the task will sync the device objects to Azure AD, and temporarily set the registered state of the devices to "pending" before the device completes the device registration. This is because the device must be added to the Azure AD directory before it can be registered. For more information about the device registration process, see [How it works: Device registration](/azure/active-directory/devices/device-registration-how-it-works#hybrid-azure-ad-joined-in-managed-environments).

For more information about how to troubleshoot pending devices, see the following video:

> [!VIDEO https://www.youtube-nocookie.com/embed/QBR1c81kaxA]

## How a device gets stuck in a pending state

There are two scenarios in which a device can be stuck in a pending state.

### Sync a new on-premises domain joined device to Azure AD

A new on-premises device can get stuck in a pending state if it can't complete the device registration process. This problem can be caused by several factors, such as that the device can't connect to the registration service.

To troubleshoot a device registration problem, see:

- [Troubleshooting hybrid Azure Active Directory joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current)
- [Test Device Registration Connectivity](/samples/azure-samples/testdeviceregconnectivity/testdeviceregconnectivity/)

### The state of a registered device is changed to pending

This problem can occur in the following scenario:

1. The device object is moved to another organizational unit (OU) that isn't in the sync scope in Azure AD Connect Sync.
1. Azure AD Connect Sync recognizes this change as the device object being deleted in the on-premises Active Directory. Therefore, it deletes the device in Azure AD.
1. The device object was moved back to the OU in the sync scope.
1. Azure AD Connect Sync creates a pending device object for this device in Azure AD.
1. The device fails to complete the device registration process because it was registered previously.

To fix the problem, unregister the device by running `dsregcmd /leave` at an elevated command prompt, and restart the device. The device will reinitiate the device registration process through the scheduled task. For Windows 10-based devices, the scheduled task is under **Task Scheduler Library** > **Microsoft** > **Windows** > **Workplace Join** > **Automatic-Device-Join Task**.

## Get a list of pending devices

**Count all pending devices**

```powershell
(Get-AzureADDevice -all $true |  Where-Object{($_.DeviceTrustType -eq"ServerAd") -and ($_.ProfileType -ne"RegisteredDevice") -and (-not $_.AlternativeSecurityIds)}).count
```

**Get all pending devices, and save the returned data in a CSV file**

 ```powershell
Get-AzureADDevice -all $true |  Where-Object{($_.DeviceTrustType -eq"ServerAd") -and ($_.ProfileType -ne"RegisteredDevice") -and (-not $_.AlternativeSecurityIds)} | select-object -Property AccountEnabled, ObjectId, DeviceId, DisplayName, DeviceOSType, DeviceOSVersion, DeviceTrustType | export-csv pendingdevicelist-summary.csv -NoTypeInformation
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

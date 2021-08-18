---
title: Pending devices in Azure Active Directory
description: Explains why a device is in the pending state in Azure Active Directory.
author: genlin
ms.author: genli
ms.date: 08/17/2021
ms.services: active-directorygit 
---
# Pending devices in Azure Active Directory

Pending devices are devices that are synced to Azure Active Directory (Azure AD) from your on-premises Active Directory, but have not successfully completed registration with Azure AD device registration service. When a device’s registered state is pending, the device is unable to complete any authorization and authentication requests, like requesting a [Primary Refresh token](/azure/active-directory/devices/concept-primary-refresh-token) for single sign-on or apply [device based Conditional Access policies](/mem/intune/protect/create-conditional-access-intune).

> [!Note]
> The pending state only exists for hybrid Azure AD joined devices.

## Why would a device be in a pending state?

When you configure a **Hybrid Azure AD join** task in the Azure AD Connect Sync for your on-premises devices, the task will sync the device objects to Azure AD, and temporarily set the registered state of the devices to "pending" before the device completes the device registration. This is because the device must be added to the Azure AD directory before it can be registered. For more information about the device registration process, see [How it works: Device registration](/azure/active-directory/devices/device-registration-how-it-works#hybrid-azure-ad-joined-in-managed-environments).

## How does a device get stuck in a pending state?

There are two scenarios in which a device can be stuck in a pending state:

### Sync a new on-premises domain joined device to Azure AD

If a new on-premises device is stuck in the pending state, this can happen if the device fails to complete the device registration. This problem can be caused by several factors like the device cannot connect to the registration service.

To troubleshoot device registration issues, see:

- [Troubleshooting hybrid Azure Active Directory joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current)
- [Test Device Registration Connectivity](/samples/azure-samples/testdeviceregconnectivity/testdeviceregconnectivity/)

### The state of a registered device is changed to pending

This problem can happen in the following scenario:

1. The device object is moved to another organizational unit (OU) that is not in the sync scope in Azure AD Connect Sync.
2. Azure AD Connect Sync recognizes this as a deletion of the device object in the on-premises AD, therefore it deletes the device in Azure AD.
3. The device object was moved back to the OU in the sync scope.
4. Azure AD Connect Sync creates a pending device object for this device in Azure AD.
5. The device fails to complete the device registration because it was registered before.

To fix the issue, you can unregister the device by running `dsregcmd /leave` in an elevated command and restart the device. The device will reinitiate the device registration process via the scheduled task. For Windows 10 based devices, the scheduled task is under **Task Scheduler Library**> **Microsoft** > **Windows** > **Workplace Join** > **Automatic-Device-Join Task**.

### Get list of the pending devices

**Count all pending devices**

```powershell
(Get-AzureADDevice -all $true |  Where-Object{($_.DeviceTrustType -eq"ServerAd") -and ($_.ProfileType -ne"RegisteredDevice") -and (-not $_.AlternativeSecurityIds)}).count
```

**Get all pending devices and save the returned data in a CSV file**
 
 ```powershell
Get all pending devices and save the returned data in a CSV file:
Get-AzureADDevice -all $true |  Where-Object{($_.DeviceTrustType -eq"ServerAd") -and ($_.ProfileType -ne"RegisteredDevice") -and (-not $_.AlternativeSecurityIds)} | select-object -Property AccountEnabled, ObjectId, DeviceId, DisplayName, DeviceOSType, DeviceOSVersion, DeviceTrustType | export-csv pendingdevicelist-summary.csv -NoTypeInformation
```


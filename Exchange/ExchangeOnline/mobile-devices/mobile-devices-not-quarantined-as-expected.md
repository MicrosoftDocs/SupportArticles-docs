---
title: Mobile devices not quarantined as expected
description: Mobile devices are not quarantined and allowed to connect when they're removed either from the Microsoft 365 Exchange Admin Center or PowerShell cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Mobile devices are not quarantined as expected after they're removed in Exchange Online

_Original KB number:_ &nbsp; 4090814

## Symptoms

In Microsoft Exchange Online, some mobile devices are not quarantined as expected.

For example, consider the following scenario:

1. In the Microsoft 365 tenant, Exchange ActiveSync access settings are configured to **Quarantine - Let me decide to block or allow later**. A quarantined device is then **Allowed**. When the device is allowed, the `Get-CASMailbox` cmdlet shows **Allowed** and **Blocked** devices in the `ActiveSyncAllowedDeviceIDs` and `ActiveSyncBlockedDeviceIDs` parameters.

2. Later, you want to remove the device. You can do this by using either of the following methods:

    Method 1

      1. Locate Exchange Admin Center > **recipients** > **mailboxes**.
      2. On the right side under **Mobile Devices**, select **View details**, and then remove the device from the list of all mobile devices.

    Method 2

    Use the `Remove-MobileDevice` PowerShell cmdlet.

3. After the device is removed, the user tries to add or configure the same device.

In this scenario, the device is not quarantined and is allowed to connect. In the Microsoft 365 Exchange admin center, mobile device details for the user show a status of **Access granted**, and the `Get-MobileDevice` cmdlet shows that the `DeviceAccessState` parameter value is **Allowed**. This is not the expected result. Instead, you expect the device to be quarantined.

## Cause

When the device is removed (either from the Microsoft 365 Exchange Admin Center or through PowerShell by using the `Remove-MobileDevice` cmdlet), the `ActiveSyncAllowedDeviceIDs` and `ActiveSyncBlockedDeviceIDs` parameters are not cleared. Therefore, when the user tries to connect by using the device that was previously removed, the device ID is still populated in the `ActiveSyncAllowedDeviceIDs` parameter, so the device is not quarantined and is allowed to connect.

## Workaround

To prevent the device from connecting, set the `ActiveSyncAllowedDeviceIDs` and `ActiveSyncBlockedDeviceIDs` parameters to **$null** after you remove the device. For example, run the following cmdlet:

```powershell
Set-CASMailbox joe@contoso.com -ActiveSyncAllowedDeviceIDs $null
```

When these parameters are set to $null, the device is quarantined when it tries to connect.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

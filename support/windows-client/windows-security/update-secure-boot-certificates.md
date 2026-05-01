---
title: Update Secure Boot Certificates for Windows Devices
description: Update your Windows devices to maintain Secure Boot protection with 2023 certificates before they expire in June 2026.
ms.date: 05/01/2026
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, anupamk
ms.custom:
- sap:system performance\startup configuration (general,secure boot,uefi)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Update Secure Boot Certificates for Windows Devices


## Summary

Some Windows devices still use Secure Boot certificates issued in 2011, which expire in June 2026. Update to 2023 Secure Boot certificates to maintain boot-level protection.
If you don’t update, devices might still start and continue receiving regular Windows updates. However, they might **not receive future Secure Boot protections** for early boot components.

## Impact

If affected devices aren’t updated:

- Windows may continue to boot and install standard updates.
- Secure Boot may no longer be able to validate or protect future updates to early boot components (for example, boot manager or other pre-OS components).
- Administrators may see indicators that certificate remediation hasn’t been applied.

## Identify affected devices

### Common signs of affected devices

You may see one or more of the following:

- **Secure Boot certificate status** indicates the device is **not updated**
- **System event log** includes:**Event ID 1801**
- **Event ID 1795**
Registry value does not show the expected state:
- UEFICA2023Status is **not** set to **Updated**

### Higher risk scenarios for affected devices

In environments with **outdated firmware**, or where certificate updates don’t apply correctly, customers might experience:

- Secure Boot validation errors
- BitLocker recovery prompts (including repeated prompts/loops)
- Startup hangs
- Devices failing to boot

## Resolution

### Review your device estate

- Identify devices still using **2011 Secure Boot certificates**
- Validate Secure Boot and certificate update status using your preferred inventory method (for example, event logs and registry signals)

### Update firmware first

- Check for and deploy **OEM firmware updates**, especially for older device models.
- Firmware updates can improve compatibility and reduce the chance of update failures.

### Pilot updates before deployment

- Test the certificate update on a representative pilot group:Multiple OEMs
- Different firmware versions
- BitLocker-enabled devices
Confirm:
- Successful certificate update status
- No boot issues
- No unexpected BitLocker recovery prompts

### Deploy updates using supported methods

Use one of the supported deployment options:

- **Microsoft Intune**
- **Registry keys**
- **Windows Configuration Service Provider (CSP) / Windows Configuration system**
- **Group Policy**
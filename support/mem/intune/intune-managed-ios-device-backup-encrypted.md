---
title: iTunes automatically turns on backup encryption 
description: Describes a behavior that causes the backup of an Intune-managed iOS device to be automatically encrypted if an Intune certificate profile was deployed to the device.
ms.date: 05/18/2020
ms.prod-support-area-path: Configure certificates
---
# iTunes automatically encrypts backup of Intune-managed iOS devices

This article describes a behavior that causes the backup of an Intune-managed iOS device to be automatically encrypted.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4490473

## Symptoms

When you try to back up an Intune-managed iOS device by using [iTunes](https://support.apple.com/HT203977#computer), the **Encrypt local backup** option is automatically selected and you can't turn it off.

## Cause

This issue occurs if an Intune certificate profile was deployed to the device.

When certain items are on the iOS device, such as the certificates that are embedded in profiles (as payloads), iTunes automatically turns on backup encryption. The behavior is by design.

## More information

The [iOS Security](https://www.apple.com/ph/privacy/docs/iOS_Security_Guide.pdf) document provides the following information:

The backup payload that's created is referred to as a *keybag* that contains the keychain items that are created by iOS. For these keychain items, the following class protection objects are flagged as **non-migratory**:

- Item accessible
- VPN certificates **Always, non-migratory**
- Bluetooth keys **Always, non-migratory**
- Apple Push Notification service token **Always, non-migratory**
- iCloud certificates and private key **Always, non-migratory**
- iMessage keys **Always, non-migratory**
- Certificates and private keys installed by a configuration profile **Always, non-migratory**
- SIM PIN **Always, non-migratory**

The security goal is for the objects that are flagged as **Always, non-migratory** keychain items to remain wrapped by using the UID-derived key. This goal allows them to be restored to only the device that they were originally backed up from, and renders them inaccessible on a different device. This behavior is why the backups are forced to be encrypted.

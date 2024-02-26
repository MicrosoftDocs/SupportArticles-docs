---
title: iTunes automatically turns on backup encryption on Intune-managed iOS device
description: Describes a behavior that causes the automatic encryption of a backup of an Intune-managed iOS device if an Intune certificate profile was deployed to the device.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure certificates
ms.reviewer: kaushika
---
# iTunes automatically encrypts backup of Intune-managed iOS devices

This article describes a behavior that causes the backup of an Intune-managed iOS device to be automatically encrypted.

## Symptoms

When you try to back up an Intune-managed iOS device by using [iTunes](https://support.apple.com/HT203977#computer), the **Encrypt local backup** option is automatically selected and you can't deselect it.

## Cause

This issue occurs if an Intune certificate profile was deployed to the device.

When certain items are on the iOS device, such as the certificates that are embedded in profiles (as payloads), iTunes automatically turns on backup encryption. The behavior is by design.

## More information

To understand Apple security concepts in more detail, see [Keychain data protection](https://support.apple.com/guide/security/keychain-data-protection-secb0694df1a) and [Keybags for Data Protection](https://support.apple.com/guide/security/keybags-for-data-protection-sec6483d5760) on the Apple Platform Security website. The following information is a summary of concepts relevant to this scenario.

The backup payload that's created is referred to as a *backup keybag* that contains the keychain items that are created by iOS. For these keychain items, the following class protection objects are flagged as **nonmigratory**:

- VPN certificates **Always, nonmigratory**
- Bluetooth keys **Always, nonmigratory**
- Apple Push Notification service token **Always, nonmigratory**
- iCloud certificates and private key **Always, nonmigratory**
- iMessage keys **Always, nonmigratory**
- Certificates and private keys installed by a configuration profile **Always, nonmigratory**
- SIM PIN **Always, nonmigratory**

The security goal is for the objects that are flagged as **Always, nonmigratory** keychain items to remain wrapped by using the UID-derived key. This goal allows them to be restored to *only* the device that they were originally backed up from, and renders them inaccessible on a different device. This behavior is why the backups are forced to be encrypted.

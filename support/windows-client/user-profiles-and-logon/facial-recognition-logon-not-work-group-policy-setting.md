---
title: Facial recognition logon doesn't work after you apply a Group Policy setting in Windows 10
description: Fixes an issue that prevents facial recognition logon in Windows 10.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, justintu
ms.custom: sap:user-logon-fails, csstroubleshoot
---
# Facial recognition logon doesn't work after you apply a Group Policy setting in Windows 10

This article describes an issue that prevents you from logging on by using facial recognition. This issue is caused by a conflicting Group Policy setting (using facial recognition to unlock the device continues to work with the conflicting policy setting).

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3169080

## Introduction

Windows Hello is a feature in Windows 10 that lets users log on and unlock their devices by using a preconfigured PIN, a fingerprint (if the device supports it), and facial recognition (if the device supports it).

With Windows Hello, users can perform authentication by providing their unique biometric identifier when they access the device-specific Microsoft Passport credentials. The Windows Hello authenticator works with Microsoft Passport to authenticate and let users log on to the enterprise network. Authentication doesn't roam among devices, isn't shared with a server, and can't easily be extracted from a device. If multiple employees share a device, each employee will use his or her own biometric data on the device.

## Symptoms

Assume that you set up PIN and Facial Recognition credentials on a supported device that's running Windows 10. The following Group Policy setting is configured:  
**Interactive logon: Do not display last user name: Enable**

After startup or a restart, you cannot use facial recognition for domain logon even when the fingerprint, password, and PIN are working. You can use facial recognition only to unlock the device.

When this issue occurs, the computer tries to use the camera and prompts you with "Looking for you Making sure its you," and then with "Windows Hello requires your PIN."

## Cause

The following Group Policy setting does not currently allow logon or sign-on through facial recognition:

**Computer Configuration**/**Local Policies**/**Security Options**

**Interactive logon: Do not display last user name: Enable**

By default, this Group Policy setting is disabled.

## Resolution

To resolve this issue, change this setting to Disabled , or wait for the anniversary update of Windows 10.

## More Information

When Windows 10 was released, the operating system supported three Hello types:

- PIN. Before you can use Windows Hello to enable biometrics on a device, you must create a PIN to use as your initial Hello gesture. After youve set a PIN, you can add biometric gestures if you want to. You can always use the PIN to release your credentials. Therefore, you can still unlock and use your device even if you cant use your preferred biometric gesture because of an injury or if the sensor is unavailable or not working correctly.
- Facial recognition. This type uses special cameras that recognize an image in infrared (IR) light, which allows them to reliably tell the difference between a photograph or scan and a living person. Several vendors provide external cameras that incorporate this technology, and major laptop manufacturers are incorporating it into their devices.
- Fingerprint recognition. This type uses a capacitive fingerprint sensor to scan your fingerprint. Fingerprint readers have been available for Windows-based computers for years, but the current generation of sensors is significantly more reliable and less error-prone. Most existing fingerprint readers (whether external or integrated into laptops or USB keyboards) work with Windows 10.

For more information, see the [Microsoft Passport guide](/windows/security/identity-protection/hello-for-business/hello-identity-verification).

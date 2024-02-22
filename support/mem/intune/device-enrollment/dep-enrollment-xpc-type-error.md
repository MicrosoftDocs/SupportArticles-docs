---
title: Apple Automated Device Enrollment (ADE) Intune enrollment error XPC_TYPE_ERROR
description: Fixes an issue in which you receive error 'XPC_TYPE_ERROR Connection invalid' during enrolling an Apple ADE device in Microsoft.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:iOS/iPadOS enrollment
ms.reviewer: kaushika
---
# ADE enrollment error 'XPC_TYPE_ERROR Connection invalid'

This article helps you fix an issue in which you receive error 'XPC_TYPE_ERROR Connection invalid' during enrolling an Apple [Automated Device Enrollment (ADE)](https://support.apple.com/en-us/HT204142) device.

## Symptom

When you turn on an Apple ADE device that's assigned an Intune enrollment profile, you receive an error message that resembles the following:

> mobileassetd[83] \<Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid <error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = 'XPCErrorDescription' => \<string: 0x1a49aee18> { length = 18, contents = 'Connection invalid' } }  
> iPhone mobileassetd[83] \<Notice>: Client connection invalid (Connection invalid); terminating connection  
> iPhone com.apple.accessibility.AccessibilityUIServer(MobileAsset) [288] \<Notice>: [MobileAssetError:29] Unable to copy asset information from <`https://mesu.apple.com/assets/`> for asset type com.apple.MobileAsset.VoiceServices.CombinedVocalizerVoices  
> iPhone mobileassetd[83] \<Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid \<error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = 'XPCErrorDescription' => \<string: 0x1a49aee18> { length = 18, contents = 'Connection invalid' }

## Cause

This issue occurs if there's a connection problem between the device and the Apple ADE service.

## Resolution

To fix this issue, fix the connection problem, or use a different network connection to enroll the device. If the issue persists, contact [Apple support](https://support.apple.com).

For more information about how to enroll ADE devices, see [Automatically enroll iOS/iPadOS devices](/mem/intune/enrollment/device-enrollment-program-enroll-ios).

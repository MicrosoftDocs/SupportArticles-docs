---
title: DEP enrollment error XPC_TYPE_ERROR
description: Fixes an issue in which you receive error 'XPC_TYPE_ERROR Connection invalid' during enrolling an Apple DEP device.
ms.date: 03/30/2020
ms.prod-support-area-path: iOS/iPadOS enrollment
---
# DEP enrollment error 'XPC_TYPE_ERROR Connection invalid'

This article helps you fix an issue in which you receive error 'XPC_TYPE_ERROR Connection invalid' during enrolling an Apple DEP device.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4490646

## Symptom

When you turn on an Apple [Device Enrollment Program (DEP)](https://deploy.apple.com/) device that's assigned an Intune enrollment profile, you receive an error message that resembles the following:

> mobileassetd[83] \<Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid <error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = 'XPCErrorDescription' => \<string: 0x1a49aee18> { length = 18, contents = 'Connection invalid' } }  
> iPhone mobileassetd[83] \<Notice>: Client connection invalid (Connection invalid); terminating connection  
> iPhone com.apple.accessibility.AccessibilityUIServer(MobileAsset) [288] \<Notice>: [MobileAssetError:29] Unable to copy asset information from <https://mesu.apple.com/assets/> for asset type com.apple.MobileAsset.VoiceServices.CombinedVocalizerVoices  
> iPhone mobileassetd[83] \<Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid \<error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = 'XPCErrorDescription' => \<string: 0x1a49aee18> { length = 18, contents = 'Connection invalid' }

## Cause

This issue occurs if there's a connection problem between the device and the Apple DEP service.

## Resolution

To fix this issue, fix the connection problem, or use a different network connection to enroll the device. If the issue persists, contact [Apple support](https://support.apple.com).

For more information about how to enroll DEP devices, see [Automatically enroll iOS devices with Apple's Device Enrollment Program](/mem/intune/enrollment/device-enrollment-program-enroll-ios).

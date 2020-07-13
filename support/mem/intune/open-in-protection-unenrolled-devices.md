---
title: OneDrive supports Open-in protection on unenrolled devices
description: Describes a change since OneDrive for iOS version 8.14 to support 'Open-in' protection on devices not managed by an MDM solution.
ms.date: 04/16/2020
ms.prod-support-area-path: App management
ms.reviewer: sbucci
---
# Open-in protection on unenrolled devices is supported as of OneDrive for iOS 8.14

This article describes a change since OneDrive for iOS version 8.14 to support Open-in protection on devices that are not managed by an MDM solution.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4041355

## Introduction

Beginning with version 8.14 of the OneDrive app for iOS, you can prevent access to unmanaged apps on devices that aren't managed by or enrolled in any mobile device management (MDM) solution. For example, when the user tries to send a OneDrive file as an attachment in the iOS Mail app, the file is unreadable.

You can use app protection policies together with the iOS **Open in management** feature to protect data in the following way:

Set the **Allow app to transfer data to other apps** setting to **Policy managed apps**.

## References

[iOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios)

[How to manage data transfer between iOS apps in Microsoft Intune](/mem/intune/apps/data-transfer-between-apps-manage-ios)

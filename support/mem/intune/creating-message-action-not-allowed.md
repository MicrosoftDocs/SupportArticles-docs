---
title: Can't create a message in Outlook for Android supported by Intune
description: Fixes an issue in which creating email in Outlook mobile fails and returns a "This action is not allowed by your organization" error message.
ms.date: 05/18/2020
ms.prod-support-area-path: Use app protection policies
ms.reviewer: joelste, intunecic, waluja
---
# This action is not allowed by your organization error when creating a message in Outlook for Android

This article fixes an issue in which you can't create a message in Outlook for Android supported by Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4492339

## Symptoms

A Microsoft Intune user can't create a new email message by using the Outlook for Android app after an application protection policy is applied. Additionally, the user receives the following error message:

> This action is not allowed by your organization.

## Cause

This is expected behavior when you sign in to Outlook by using a Microsoft Exchange Server on-premises account. Only Azure Active Directory (AAD)-based accounts are supported by the Intune app. Exchange direct on-premises accounts are not supported by Intune.

## Resolution

To resolve this issue, sign in by using an AAD-based account after you configure Exchange hybrid Modern Authentication. For more information about this configuration, see [Using hybrid Modern Authentication with Outlook for iOS and Android](/exchange/clients/outlook-for-ios-and-android/use-hybrid-modern-auth).

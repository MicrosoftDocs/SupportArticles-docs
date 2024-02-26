---
title: Can't prevent saving images locally using Intune app protection policy
description: Describes an issue in which images in Outlook for iOS can be saved to local storage even if you use app protection policy to prevent such behavior.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:App management
ms.reviewer: kaushika, joelste, andcerat
---
# App protection policy doesn't restrict saving images locally in Outlook for iOS

This article describes an issue in which images in Outlook for iOS can be saved to local storage, even if you use a Microsoft Intune app protection policy to prevent such behavior.

## Symptoms

You use the following Intune app protection policy setting for Outlook for iOS to prevent corporate data from being saved to the local device storage:

**Select which storage services corporate data can be saved to**

However, users can still save images in email messages to local storage.

## Cause

This behavior is by design. Currently the **Select which storage services corporate data can be saved to** data relocation setting does not apply to images in email messages in Outlook for iOS.

## More information

For more information about Intune app protection policy settings for iOS, see [iOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios).

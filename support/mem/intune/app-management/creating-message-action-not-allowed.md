---
title: Can't create a message in Outlook for Android supported by Intune
description: Fixes an issue in which creating email in Outlook mobile fails and returns a "This action is not allowed by your organization" error message.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Application Protection - Android\Advisory
ms.reviewer: kaushika, joelste, intunecic, waluja
---
# Unable to create a message in Outlook for Android

This article fixes an issue in which you can't create a message in Outlook for Android after a Microsoft Intune app protection policy is applied.

## Symptoms

An Intune user can't create a new email message in the Outlook for Android app after an application protection policy is applied. Additionally, the user receives the following error message:

> This action is not allowed by your organization.

## Cause

This is expected behavior when you sign in to Outlook by using a Microsoft Exchange Server on-premises account. Only Microsoft Entra accounts are supported by the Intune app. Exchange direct on-premises accounts are not supported by Intune.

## Solution

To resolve this issue, sign in with a Microsoft Entra account after you configure Exchange hybrid Modern Authentication. For more information about this configuration, see [Using hybrid Modern Authentication with Outlook for iOS and Android](/exchange/clients/outlook-for-ios-and-android/use-hybrid-modern-auth).

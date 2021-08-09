---
title: SIP address and password can't be saved
description: Fixes an issue in which Skype for Business on Android Enterprise doesn't save the SIP address and password.
ms.date: 09/11/2020
ms.prod-support-area-path: Add apps
ms.reviewer: joelste, intunecic, a-eyalhu
---
# SIP address and password can't be saved by Skype for Business on Android Enterprise supported by Intune

This article helps you fix an issue in which Skype for Business on Android Enterprise that's supported by Microsoft Intune doesn't save the SIP address and password.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4499250

## Symptoms

Microsoft Intune users can sign in successfully to the Skype for Business app on Android Enterprise devices for the initial authentication. However, after the app is closed or the device is restarted, the credentials are lost upon reopening the app. Users are then prompted to re-enter their credentials to reauthenticate. Additionally, they are required to enter the SIP information again.

This issue occurs even if users select the **Save my Password** option.

## Cause

This issue may occur if the **Add and Remove accounts** policy setting is set to **Block**.

## Resolution

To resolve this issue, go to **Device configuration** > **Profiles** > **Create profile** > **Device restrictions** > **Work profile settings**, and then change the **Add and Remove accounts** setting to **Not Configured**.

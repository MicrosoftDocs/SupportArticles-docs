---
title: SIP address and password not saved on Android Enterprise device
description: Fixes an issue in which Skype for Business on a Microsoft Intune supported Android Enterprise device doesn't save the SIP address and password.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Add apps
ms.reviewer: kaushika, joelste, intunecic, a-eyalhu
---
# Skype for Business on Android Enterprise doesn't save SIP address and password

This article helps you fix an issue in which Skype for Business on Android Enterprise that's supported by Microsoft Intune doesn't save the SIP address and password.

## Symptoms

Microsoft Intune users can sign in successfully to the Skype for Business app on Android Enterprise devices for the initial authentication. However, after the app is closed or the device is restarted, the credentials are lost upon reopening the app. Users are then prompted to re-enter their credentials to reauthenticate. Additionally, they are required to enter the SIP information again.

This issue occurs even if users select the **Save my Password** option.

## Cause

This issue may occur if the **Add and Remove accounts** policy setting is set to **Block**.

## Solution

To resolve this issue, go to **Device configuration** > **Profiles** > **Create profile** > **Device restrictions** > **Work profile settings**, and then change the **Add and Remove accounts** setting to **Not Configured**.

---
title: BitLocker-encrypted device displays as Not compliant
description: Describes an issue in which a BitLocker-encrypted Windows 10 device shows as Not compliant in Intune because BitLocker encryption takes a long time.
ms.date: 12/05/2023
ms.reviewer: kaushika, saurkosh
search.appverid: MET150
ms.custom: sap:Device Compliance\Compliance Issue - Windows
---
# BitLocker-encrypted Windows 10 device shows as Not compliant in Intune

This article describes an issue in which a BitLocker-encrypted Windows 10 device shows as **Not compliant** in Intune.

## Symptom

Consider the following scenario:

- You have a Windows 10 device that has **BitLocker Drive Encryption** enabled.
- The device is enrolled in Microsoft Intune.
- You set device compliance policies to require device encryption.

In this scenario, the Windows 10 device displays a status of **Not compliant**.

## Cause

The issue occurs when encryption isn't finished. Based on factors such as the disk size, number of files, and BitLocker settings, encryption can take a long time. After encryption is completed, the device will show as **Compliant**.

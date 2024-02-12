---
title: Windows 10 BitLocker Recovery auto-shutdown in UEFI mode
description: Discusses the BitLocker Recovery auto-shutdown process in UEFI mode in Windows 10.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rblume
ms.custom: sap:bitlocker, csstroubleshoot
---
# Windows 10 BitLocker Recovery auto-shutdown in UEFI mode

This article discusses a by-design behavior where a computer shuts down after the BitLocker Drive Encryption Recovery screen is displayed for one minute. The one-minute shutdown occurs when the system is in Unified Extensible Firmware Interface (UEFI) mode.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3174095

## Symptoms

A computer shuts down after the BitLocker Drive Encryption Recovery screen is displayed for one minute.

Consider the following scenario:

- You configure the system for Unified Extensible Firmware Interface (UEFI) mode.
- You turn on BitLocker Drive Encryption for the boot (system) partition on drive C.
- You disable the Trusted Platform Module (TPM) chip or you change the boot files so that the BitLocker Drive Encryption Recovery screen is displayed on restart.
- You restart the computer to the BitLocker Drive Encryption Recovery screen.
- You do not touch the BitLocker Drive Encryption Recovery screen for one minute. Then, the computer shuts down.

## Cause

This behavior is by design. We added this shutdown event to the system, and set it to occur after 60 seconds.

## More information

The one-minute shutdown occurs when the system is in UEFI mode. The behavior is different when the system is set up in BIOS mode. Systems that are configured for BIOS mode do not shut down in this manner.

> [!NOTE]
> BIOS mode is also known as legacy mode and compatibility mode.

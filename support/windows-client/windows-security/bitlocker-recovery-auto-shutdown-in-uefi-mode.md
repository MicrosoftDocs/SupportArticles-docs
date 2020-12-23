---
title: Windows 10 BitLocker Recovery auto-shutdown in UEFI mode
description: Discusses the BitLocker Recovery auto-shutdown process in UEFI mode in Windows 10.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: rblume
---
# Windows 10 BitLocker Recovery auto-shutdown in UEFI mode

_Original product version:_ &nbsp; Windows 10, version 1809, all editions, Windows 10  
_Original KB number:_ &nbsp; 3174095

## Symptoms

A computer shuts down after the BitLocker Drive Encryption Recovery screen is displayed for one minute.

Consider the following scenario:


- You configure the system for Unified Extensible Firmware Interface (UEFI) mode.
- You turn on BitLocker Drive Encryption for the boot (system) partition on drive C.
- You disable the Trusted Platform Module (TPM) chip or you change the boot files so that the BitLocker Drive Encryption Recovery screen is displayed on restart.
- You restart the computer to the BitLocker Drive Encryption Recovery screen.
- You do not touch the BitLocker Drive Encryption Recovery screen for one minute. Then, the computer shuts down.
In this scenario, after you restart the computer, Event Viewer may display the following logged event:

## Cause

This behavior is by design. We added this shutdown event to the system, and set it to occur after 60 seconds. 

## More Information

The one-minute shutdown occurs when the system is in UEFI mode. The behavior is different when the system is set up in BIOS mode. Systems that are configured for BIOS mode do not shut down in this manner. 

> [!NOTE]
>  BIOS mode is also known as legacy mode and compatibility mode.

---
title: Code 31 Microsoft Usbccid Smartcard Reader problem
description: Provides a resolution for code 31 in Device Manager when Microsoft Usbccid Smartcard Reader is in a problem state.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, neilshen, v-lolang
ms.custom: sap:smart-card-logon, csstroubleshoot
---
# Code 31 in Device Manager when Microsoft Usbccid Smartcard Reader is in a problem state

_Applies to:_ &nbsp; Windows 10

## Symptoms

After a restart, Microsoft Usbccid Smartcard Reader is in a problem state with a yellow bang and this error is displayed in the device status:

> This device is not working properly because Windows cannot load the drivers required for this device. (Code 31)  
{Operation Failed}  
The requested operation was unsuccessful.

## Cause

During initialization, the smartcard driver attempts to create an instance of smart card class extension. The attempt failed and the driver isn't loaded.

## Resolution

To ensure a successful driver initialization, add the **RetryDeviceInitialize** registry key and restart the computer.

> [!Note]
> The registry key is available for Windows 10, version 1903 (19H1) and later versions.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Calais\Readers`  
**Name**: RetryDeviceInitialize  
**Type**: DWORD (32-bit)  
**Data**: 1  

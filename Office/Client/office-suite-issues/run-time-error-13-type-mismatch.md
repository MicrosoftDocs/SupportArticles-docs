---
title: Run-Time Error 13 Type Mismatch when setting FW company as default
description: You cannot set the FW company as default because there are multiple Microsoft FRx versions on a workstation or server.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft FRx
ms.date: 03/31/2022
---

# Run-Time Error 13: Type Mismatch

## Symptoms

This error occurs when setting the FW company as default.

"Run-time Error 13: Type Mismatch"

## Cause

There are multiple FRx versions on a workstation or server. Either a .dll file is not registered correctly, or there may be a .dll file conflict.

## Resolution

Run the FRxReg.exe located in the FRx directory. For more information, see [How to register a .dll file](https://support.microsoft.com/help/844592/how-to-register-a-dll-file).

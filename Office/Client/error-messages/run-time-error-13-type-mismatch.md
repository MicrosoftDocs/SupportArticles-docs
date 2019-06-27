---
title: Run-Time Error 13 Type Mismatch when setting FW company as default
description: You cannot set the FW company as default because there are multiple FRx versions on a workstation or server.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Run-Time Error 13: Type Mismatch

## Symptoms

"Run-time Error 13: Type Mismatch" This error occurs when setting the FW company as default.

## Cause

There are multiple FRx versions on a workstation or server. Either a .dll file is not registered correctly, or there may be a .dll file conflict.

## Resolution

ResolutionRun the FRxReg.exe located in the FRx directory. For additional information, see [How to register a .dll file](https://support.microsoft.com/help/844592/how-to-register-a-dll-file).
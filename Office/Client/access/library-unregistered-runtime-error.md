---
title: Runtime error 2147319779 (8002801d) when setting a company as default
description: Fails to set a company as default because of an unregistered ADO Object dependency.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# "Runtime error 2147319779 (8002801d) library not registered" when setting a company as default

## Symptoms

"Runtime error -2147319779 (8002801d) automation error library not registered." This error occurs when trying to set a company as default.

## Cause

FRx is trying to access the specification set and system databases using an unregistered ADO Object dependency. This is generally installed with the current version of MDAC (Microsoft Data Access Components) (MDAC Version 2.8 and later).

## Resolution

Register the file msadox.dll located in the C:\Program Files\Common Files\System\ado folder. For information on registering dlls, please see [How to register a .dll file](https://support.microsoft.com/help/844592/how-to-register-a-dll-file).
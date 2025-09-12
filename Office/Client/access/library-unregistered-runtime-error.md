---
title: Runtime error 2147319779 (8002801d) when setting a company as default
description: Fails to set a company as default because of an unregistered ADO Object dependency.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Microsoft Access
ms.date: 05/26/2025
---

# "Runtime error 2147319779 (8002801d) library not registered" when setting a company as default

## Symptoms

"Runtime error -2147319779 (8002801d) automation error library not registered." This error occurs when trying to set a company as default.

## Cause

FRx is trying to access the specification set and system databases using an unregistered ADO Object dependency. This is generally installed with the current version of MDAC (Microsoft Data Access Components) (MDAC Version 2.8 and later).

## Resolution

Register the file msadox.dll located in the C:\Program Files\Common Files\System\ado folder. For information on registering dlls, see [How to register a .dll file](https://support.microsoft.com/help/844592/how-to-register-a-dll-file).

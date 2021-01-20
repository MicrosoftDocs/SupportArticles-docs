---
title: Error 0x8007000D when you activate a machine
description: This article helps fix the error 0x8007000D that occurs when you activate a Windows 7 machine by using any type of product key.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Activation
ms.technology: windows-server-deployment
---
# Error code 0x8007000D when you try to activate a Windows 7 machine by using any type of product key

This article helps fix the error 0x8007000D that occurs when you activate a Windows 7 machine by using any type of product key.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2230957

## Symptoms

You try to activate a Windows 7 machine by using any type of product key. Running `slsmgr -dlv` or `slmgr -ato` from a command line generates the following error:

> The data is invalid.  
> Error code 8007000d.

## Cause

The System account by default has Full Control permissions to the registry path `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root` and any subkeys.

If those permissions have been altered for the `Root` key or any subkey(s), we would see the error code 0x8007000D.

## Resolution

Assign the minimum permission of Enumerate Subkeys to the System account for the registry path `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root`and any of its subkeys.

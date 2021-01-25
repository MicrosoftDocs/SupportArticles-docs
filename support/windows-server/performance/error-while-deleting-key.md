---
title: Error while deleting key
description: When you try to remove a registry key, you receive the Error while deleting key error message. Provides a resolution.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-parapa
ms.prod-support-area-path: Slow Performance
ms.technology: windows-server-performance
---
# Cannot delete certain registry keys and Error while deleting key occurs

This article provides a resolution to solve the **Error while deleting key** error that occurs when trying to remove certain registry keys.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2021860

## Symptoms

You may get the following error message when trying to delete a registry key:

> Error while deleting key

## Cause

This can be caused if you attempt to delete a registry key that contains embedded null characters. These characters aren't visible when viewing the registry entry.

## Resolution

To delete a registry key that contains an embedded null character, you must first replace the null character with another character. You can accomplish this by using the [RegDelNull v1.11](/sysinternals/downloads/regdelnull) tool from Sysinternals.

## More information

```console
Usage: regdelnull <path> [-s]
-s Recurse into subkeys.
```

It isn't possible to manually create a registry entry with an embedded null character. This usually occurs because of a corrupt application install or similar. It's also possible for the Windows kernel to embed a NULL character in a string to form a complete key name. If this entry is then accessed from user-mode, it isn't possible to open the key containing the embedded null string.

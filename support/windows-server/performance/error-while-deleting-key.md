---
title: Error while deleting key
description: When you try to remove a registry key, you receive the Error while deleting key error message. Provides a resolution.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-parapa
ms.custom: sap:slow-performance, csstroubleshoot
---
# Can't delete certain registry keys and Error while deleting key occurs

This article provides a resolution to solve the **Error while deleting key** error that occurs when trying to remove certain registry keys.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2021860

## Symptoms

You may get the following error message when trying to delete a registry key:

> Error while deleting key

## Cause

This issue can be caused if you attempt to delete a registry key that contains embedded null characters. These characters aren't visible when viewing the registry entry.

## Resolution

To delete a registry key that contains an embedded null character, you must first replace the null character with another character. You can accomplish this operation by using the [RegDelNull v1.11](/sysinternals/downloads/regdelnull) tool from Sysinternals.

## More information

```console
Usage: regdelnull <path> [-s]
-s Recurse into subkeys.
```

You can't manually create a registry entry with an embedded null character. This issue usually occurs because of a corrupt application installation or similar. Windows kernel may embed a NULL character in a string to form a complete key name. If this entry is accessed from user-mode, it's not possible to open the key containing the embedded null string.

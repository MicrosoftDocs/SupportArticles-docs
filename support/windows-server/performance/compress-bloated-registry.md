---
title: Compress large registry hives
description: Describes how to compress large registry hives.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:system-hang, csstroubleshoot
---
# Compress "Bloated" Registry Hives

This article describes how to compress large registry hives to avoid performance issues.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2498915

## Symptoms

Consider the following scenario:

You may discover that some of your registry hives are abnormally large or "bloated". Registry hives that are in this state can cause various performance issues and errors in the system log.

## Cause

There can be many causes for this issue. Troubleshooting the actual cause can be a long and tedious process. In this scenario, you simply want to compress the registry hives to a normal state.

## Resolution

While there may be third-party tools available for this scenario, the process listed below could be followed to compress the affected hives.

1. Boot from a WinPE disk. ([What is Windows PE](https://technet.microsoft.com/library/cc766093%28ws.10%29.aspx))
2. Open regedit while booted in WinPe, load the bloated hive under HLKM. (for example, `HKLM\Bloated`)
3. Once the bloated hive has been loaded, export the loaded hive as a "Registry Hive" file with a unique name. (for example, `%windir%\system32\config\compressedhive`)
 a) You can use dir from a command line to verify the old and new sizes of the registry hives.
4. Unload the bloated hive from regedit. (If you get an error here, close the registry editor. Then reopen the registry editor and try again.)
5. Rename the hives so that you'll boot with the compressed hive.
For example,  
`c:\windows\system32\config\ren software software.old`  
`c:\windows\system32\config\ren compressedhive software`

---
title: Error "Invalid store path" during the LoadState process when you use the User State Migration Tool
description: Describes how to fix the error "Invalid store path" during the LoadState process when you use the User State Migration Tool
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, shijoy
ms.custom:
- sap:windows setup,upgrade and deployment\user state migration tool (usmt)
- pcy:WinComm Devices Deploy
---
# Error "Invalid store path" during the LoadState process when you use the User State Migration Tool

This article helps to fix the error "Invalid store path" during the LoadState process when you use the User State Migration Tool.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2892374

## Symptoms

Assume that you are using the User State Migration Tool (USMT) to migrate user profiles to Windows 8 or Windows 7. When you run the LoadState command on the destination computer, you receive the following error message:  
>Invalid store path; check the store parameter and/or file system permissions  

However, the path contains a valid migration store MIG file. 

## Cause

This issue occurs because the migration store path that is specified in the LoadState command points directly to the location of the MIG file. However, it must point to the root folder instead.

## Resolution

To resolve this issue, provide a path of the same folder level that was used in the scan state. Do not use the full path in the command. 

For example, if the MIG file is located at "C:\store\usmt\usmt.mig," the LoadState command should be pointed to "C:\store" as follows: Loadstate.exe c:\store /auto 

## More information

For more information, go to [USMT 4.0: Cryptic messages with easy fixes](https://blogs.technet.com/b/askds/archive/2010/03/01/usmt-4-0-cryptic-messages-with-easy-fixes.aspx).

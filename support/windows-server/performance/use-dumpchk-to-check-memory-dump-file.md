---
title: Use Dumpchk.exe to check memory dump file
description: Describes how to check a memory dump file by using Dumpchk.
ms.date: 03/10/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:system performance\system reliability (crash,errors,bug check or blue screen,unexpected reboot)
- pcy:WinComm Performance
---
# Use Dumpchk.exe to check a memory dump file

This article describes how to check a memory dump file by using Dumpchk.

_Original KB number:_ &nbsp; 156280

## Summary

Dumpchk is a command-line utility you can use to verify that a memory dump file was created correctly. If a memory dump file is corrupt, it can't be analyzed in a debugger. Using Dumpchk to verify a dump file is in a good state is helpful. It saves time and effort in uploading corrupt dump files to be analyzed by support professionals. Dumpchk doesn't require access to symbols.

Dumpchk is part of the Windows Debugging Tools. There are two versions of the Windows Debugger. To use Dumpchk, you must install the version of the Windows Debugging Tools included in the [Windows SDK](https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/):

1. Download the SDK installer.
2. Launch the installer, and then select **Windows Debugging Tools** with other components that you would like to install.
3. After the installation completes, dumchk.exe is in the directory that you installed the Windows Debugging in. Use the version that matches your hardware platform.

When Dumpchk runs, it displays some basic information from the memory dump file, then verifies all the virtual and physical addresses in the file. There are many symbol errors if a symbol path isn't specified. Those errors can be ignored as we're checking the dump file for corruption. Dumpchk reports any errors that are found in the memory dump file.

If there's an error during any portion of the output displayed, the dump file is corrupted, and analysis can't be performed.

When Dumpchk finishes, it displays the stop code and some parameters.

```output
BUGCHECK_CODE:  1e  
BUGCHECK_P1: ffffffffc0000420
BUGCHECK_P2: fffff8004dbab02a
BUGCHECK_P3: 0  BUGCHECK_P4: fffff8003a6d5f20
SYMBOL_NAME:  nt_symbols!72291DF0104D000
PROCESS_NAME:  ntoskrnl.exe
IMAGE_NAME:  ntoskrnl.exe
MODULE_NAME: <Module Name>
FAILURE_BUCKET_ID:  <Bucket Id>
FAILURE_ID_HASH:  {029f6661-9c67-6d47-23e5-a0398183d06e}
```

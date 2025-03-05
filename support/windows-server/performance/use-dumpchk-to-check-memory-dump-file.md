---
title: Use Dumpchk.exe to check memory dump file
description: Describes how to check a memory dump file by using Dumpchk.
ms.date: 01/15/2025
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

Dumpchk is a command-line utility you can use to verify that a memory dump file has been created correctly. If a memory dump file is corrupt, it cannot be analyzed in a debugger.  Using dumpchk to verify a dump file is in a good state is helpful as it will save time and effort in uploading corrupt dump files to be analyzed by support professionals.  Dumpchk does not require access to symbols.

Dumpchk is part of the Windows Debugging Tools. There are two versions of the Windows Debugger. 

You must install the version of the Windows Debugging Tools included in the Windows SDK - [Windows SDK - Windows app development | Microsoft Developer](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeveloper.microsoft.com%2Fen-us%2Fwindows%2Fdownloads%2Fwindows-sdk%2F&data=05%7C02%7CWarren.Williams%40microsoft.com%7C50935613ca604985339808dd5bdf9a6a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638767738151340942%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=bFHDAUD4S%2Fr83YtkM47ejDZryVRp2VLfjioX1txssPI%3D&reserved=0). 

1. Download the SDK installer

1. Lauch the installer and select "Windows Debugging Tools" and anything else you would like to install

1. After the installation completes, dumchk.exe will be in the directory that you installed the Windows Debugging in. Use the version that matches your hardware platform. 

When Dumpchk runs, it displays some basic information from the memory dump file, then verifies all the virtual and physical addresses in the file. You will see a lot of symbol errors if a symbol path is not specified but those can be ignored as we are checking the dump file for corruption. If any errors are found in the memory dump file, Dumpchk reports them. 

If there is an error during any portion of the output displayed above, the dump file is corrupted, and analysis cannot be performed.

When dumpchk is finished it will display the stop code and any parameters. 


```
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


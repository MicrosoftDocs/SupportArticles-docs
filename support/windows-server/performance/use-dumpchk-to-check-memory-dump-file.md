---
title: Use Dumpchk.exe to check memory dump file
description: Describes how to check a memory dump file by using Dumpchk.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Use Dumpchk.exe to check a memory dump file

This article describes how to check a memory dump file by using Dumpchk.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 156280

> [!NOTE]
> For a Microsoft Windows XP version of this article, see [315271](https://support.microsoft.com/help/315271).  

## Summary

Dumpchk is a command-line utility you can use to verify that a memory dump file has been created correctly. Dumpchk does not require access to symbols.

Dumpchk is located in the following locations:

- Windows NT 4.0 CD-ROM: Support\Debug\\\<Platform>\Dumpchk.exe

- Windows 2000 CD-ROM: Install the Support Tools by running Setup.exe from the Support\Tools folder on the CD-ROM. By default, Dumpchk.exe is installed to the Program Files\Support Tools folder.

## Dumpchk command-line switches

Dumpchk has the following command-line switches:

DUMPCHK [options] \<CrashDumpFile>

- -? Display the command syntax.

- -p Prints the header only (with no validation).

- -v Specifies verbose mode.

- -q Performs a quick test. Not available in the Windows 2000.

Additional switches that are only available in Windows 2000 Dumpchk.exe version:

- -c Do dump validation.

- -x Extra file validation. Takes several minutes.

- -e Do dump exam.

- -y \<Path> Set the symbol search path for dump exam.
  - If the symbol search path is empty, the CD-ROM
  - is used for symbols.

- -b \<Path> Set the image search path for dump exam.
  - If the symbol search path is empty, \<SystemRoot>\system32
  - is used for symbols.

- -k \<File> Set the name of the kernel to File.

- -h \<File> Set the name of the hal to File.

Dumpchk displays some basic information from the memory dump file, then verifies all the virtual and physical addresses in the file. If any errors are found in the memory dump file, Dumpchk reports them. The following is an example of the output of a Dumpchk command:

```output
Filename . . . . . . .memory.dmp  
Signature. . . . . . .PAGE  
ValidDump. . . . . . .DUMP  
MajorVersion . . . . .free system  
MinorVersion . . . . .1057  
DirectoryTableBase . .0x00030000  
PfnDataBase. . . . . .0xffbae000  
PsLoadedModuleList . .0x801463d0  
PsActiveProcessHead. .0x801462c8  
MachineImageType . . .i386  
NumberProcessors . . .1  
BugCheckCode . . . . .0xc000021a  
BugCheckParameter1 . .0xe131d948  
BugCheckParameter2 . .0x00000000  
BugCheckParameter3 . .0x00000000  
BugCheckParameter4 . .0x00000000  

ExceptionCode. . . . .0x80000003  
ExceptionFlags . . . .0x00000001  
ExceptionAddress . . .0x80146e1c  

NumberOfRuns . . . . .0x3  
NumberOfPages. . . . .0x1f5e  
Run #1  
BasePage . . . . . .0x1  
PageCount. . . . . .0x9e  
Run #2  
BasePage . . . . . .0x100  
PageCount. . . . . .0xec0  
Run #3  
BasePage . . . . . .0x1000  
PageCount. . . . . .0x1000  

**************--> Validating the integrity of the PsLoadedModuleList  
**************--> Performing a complete check (^C to end)  
**************--> Validating all physical addresses  
**************--> Validating all virtual addresses  
**************--> This dump file is good!
```

If there is an error during any portion of the output displayed above, the dump file is corrupted and analysis cannot be performed.

In this example, the most important information (from a debugging standpoint) is the following:

```output
MajorVersion . . . . .free system  
MinorVersion . . . . .1057  
MachineImageType . . .i386  
NumberProcessors . . .1  
BugCheckCode . . . . .0xc000021a  
BugCheckParameter1 . .0xe131d948  
BugCheckParameter2 . .0x00000000  
BugCheckParameter3 . .0x00000000  
BugCheckParameter4 . .0x00000000
```

This information can be used to determine what Kernel STOP Error occurred and, to a certain extent, what version of Windows was in use.

The information in this article is from the Windows NT Resource Kit. For more information on Dumpchk.exe and other debugging utilities, see Appendix A in the Windows NT 3.51 Resource Kit Update and Update 2.

---
title: Configure SSAS to generate memory dump files
description: This article describes how to configure SQL Server Analysis Services to automatically generate memory dump files.
ms.date: 09/25/2020
ms.custom: sap:Analysis Services
ms.reviewer: lisaliu
ms.topic: how-to
ms.prod: sql
---
# Configure SQL Server Analysis Services to generate memory dump files

This article describes how to configure SQL Server Analysis Services to automatically generate memory dump files.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 919711

## Introduction

This article describes how to configure Microsoft SQL Server Analysis Services (SSAS) 2012 or higher builds to automatically generate different types of memory dump files when it encounters exceptions. The article also outlines how to use the Sqldumper.exe utility to manually obtain a memory dump file for the SQL Server Analysis Services process.

## More information

By default, SQL Server Analysis Services automatically generates minidump files when an exception occurs. For the default installation, the minidump files are written to the default location:

|Analysis Services version |Location |
|-|-|
|2019 |`%ProgramFiles%\Microsoft SQL Server\MSAS15.InstanceName\OLAP\log` |
|2017 |`%ProgramFiles%\Microsoft SQL Server\MSAS14.InstanceName\OLAP\log` |
|2016 |`%ProgramFiles%\Microsoft SQL Server MSAS13.InstanceName\OLAP\log` |
|2014 |`%ProgramFiles%\Microsoft SQL Server MSAS12.InstanceName\OLAP\log` |
|2012 |`%ProgramFiles%\Microsoft SQL Server MSAS11.InstanceName\OLAP\log` |
  
> [!NOTE]
> InstanceName is a placeholder for the corresponding value for SQL Server Analysis Services version.

The SQL Server Analysis Services instance log location can be altered after installation, so you can verify the log location by reviewing the msmdsrv.ini file for the installed SQL Server Analysis Services.

To determine the corresponding value for the system, determine the value of ImagePath registery key, it should contain the path to Config path that contains the msmdsrv.ini.  

|Analysis Services version |Registry subkey |
|-|-|
|Default Instance  |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSSQLServerOLAPService\ImagePath` |
|Named instance |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSOLAP$InstanceName\ImagePath`|
  
The minidump files will include the following information:

- All thread stacks

- Second-order memory that is referenced by pointers on the stack

- Information about the Process Environment Block (PEB)

- Information about the Thread Environment Block (TEB)

- Information about recently unloaded modules

- Thread state information

The Exception section in the Msmdsrv.ini file controls the memory dump file generation. The file by-default is located in the `%ProgramFiles%\Microsoft SQL Server\MSASxx.InstanceName\OLAP\Config` folder. The MSASxx is a placeholder for corresponding version for SQL Server Analysis Service. When you open the file in Notepad, you notice a section in the Exception XML tag that resembles the following:

```xml
<Exception>
<CreateAndSendCrashReports>1</CreateAndSendCrashReports>
<CrashReportsFolder/>
<SQLDumperFlagsOn>0x0</SQLDumperFlagsOn>
<SQLDumperFlagsOff>0x0</SQLDumperFlagsOff>
<MiniDumpFlagsOn>0x0</MiniDumpFlagsOn>
<MiniDumpFlagsOff>0x0</MiniDumpFlagsOff>
<MinidumpErrorList>0xC1000000, 0xC1000001, 0xC1000016, 0xC11D0005, 0xC102003F</MinidumpErrorList>
<ExceptionHandlingMode>0</ExceptionHandlingMode>
<CriticalErrorHandling>1</CriticalErrorHandling>
</Exception>
```

You can control the behavior of generating the memory dump file by modifying the settings in this section. You can also modify these settings in SQL Server Management Studio. For more information about these settings, visit the SQL Server Management Studio download website: [Log Properties](/analysis-services/server-properties/log-properties).

## Disable the automatic memory dump file for Analysis Services

The value of the CreateAndSendCrashReports setting determines whether a memory dump file will be generated. This setting can have one of the values that are listed in the following table.

|Value|Description|
|---|---|
|0|This value specifies that Analysis Services does not generate any memory dump file. Additionally, the value of the other settings under the Exception section is ignored.|
|1|This default value enables the memory dump file. However, SQL Server Analysis Services does not send an error report to Microsoft.|
|2|This value specifies that SQL Server Analysis Services generates a memory dump file and sends an error report to Microsoft.|
  
When the CreateAndSendCrashReports setting is set to 1 or 2, the other settings in the Exception section can control the type of the memory dump file and what information to include in the memory dump file.

## Configure SQL Server Analysis Services to generate a full dump file automatically

To configure SQL Server Analysis Services to generate a full dump file automatically when an exception occurs, you can set the SQLDumperFlagsOn setting to 0x34. Additionally, if you want to configure SQL Server Analysis Services to generate a full dump file that includes the handle information, you can set the SQLDumperFlagsOn setting to 0x34 and the MiniDumpFlagsOn setting to 0x4. For example, the Exception section in the Msmdsrv.ini file may resemble the following:

```xml
<Exception>
<CreateAndSendCrashReports>1</CreateAndSendCrashReports>
<CrashReportsFolder/>
<SQLDumperFlagsOn>0x34</SQLDumperFlagsOn>
<SQLDumperFlagsOff>0x0</SQLDumperFlagsOff>
<MiniDumpFlagsOn>0x4</MiniDumpFlagsOn>
<MiniDumpFlagsOff>0x0</MiniDumpFlagsOff>
<MinidumpErrorList>0xC1000000, 0xC1000001, 0xC1000016, 0xC11D0005, 0xC102003F</MinidumpErrorList>
<ExceptionHandlingMode>0</ExceptionHandlingMode>
<CriticalErrorHandling>1</CriticalErrorHandling>
</Exception>
```

## Generate a full dump file that includes handle information manually

To troubleshoot issues such as a server that stops responding (hangs), you may want to generate a full dump file that includes handle information manually. To do this, you can run the Sqldumper.exe utility at the command prompt together with the following arguments:

```console
Sqldumper.exe PID 0 0x34:0x4 0 PathToDumpFile
```

> [!NOTE]
> PID represents the process ID of the SQL Server Analysis Services process. PathToDumpFile represents the folder to which the dump file is written.

You must run this command from the Shared directory where you installed the instance, or you must specify the full path of the Sqldumper.exe file in the command.

|Analysis Services version |Location |
|-|-|
|2019 |`%ProgramFiles%\Microsoft SQL Server\150\Shared` |
|2017 |`%ProgramFiles%\Microsoft SQL Server\140\Shared` |
|2016 |`%ProgramFiles%\Microsoft SQL Server\130\Shared` |
|2014 |`%ProgramFiles%\Microsoft SQL Server\120\Shared` |
|2012 |`%ProgramFiles%\Microsoft SQL Server\110\Shared` |
  
For example, the default directory to run sqldumper.exe for SQL Server Analysis Services 2019  is `C:\Program Files\Microsoft SQL Server\1590\Shared`.

## More Information

You can use the SQLDumperFlagsOn setting to specify the various SQLDumper flags. The following table lists the bitmask values that you can use as a value for the flag parameter.

|Mnemonic name |Hexadecimal value |Description |
|-|-|-|
|SQLDUMPER_DBGBREAK |0x0001 |This flag causes the Sqldumper.exe utility to run the DebugBreak API call at the start of the program when the parameters are parsed. Typically, Microsoft Product Support Services professionals will not use this flag because the flag is only used to debug Sqldumper.exe utility problems.<br/> **Note** This flag breaks into the Sqldumper.exe process. This flag does not break into the process that the Sqldumper.exe utility is debugging.|
|SQLDUMPER_NOMINIDUMP |0x0002|When you use this flag, the Sqldumper.exe utility does not generate a dump file. This flag is used to test the Sqldumper.exe utility. |
|SQLDUMPER_NOWATSON |0x0004|Typically, this flag is used when you manually generate dump files. This flag overrides the default error-reporting behavior. By default, the dump file is submitted to the error-reporting site that is configured in the registry. |
|SQLDUMPER_REFERENCED_MEMORY |0x0008|This flag causes the Sqldumper.exe utility to set the MiniDumpWithIndirectlyReferencedMemory flag for the MiniDumpType parameter when it calls the MiniDumpWritedump function. Memory for pointers (one level only) that are stack-based (parameters or local variables) will be stored in the dump file. Testing reveals that certain local parameters that are based on thread local storage (TLS) data such as Probabilistic Signature Scheme (PSS) and EC structures do not seem to work even when you set this flag.|
|SQLDUMPER_ALL_MEMORY |0x0010|This flag causes the Sqldumper.exe utility to set theMiniDumpWithFullMemory flag for MiniDumpType when the utility calls the MiniDumpWriteDump function. This behavior is the same as using the .dump /mf command under the debugger. However, you must also have the SQLDUMPER_DUMP_ALL_THREADS flag set to on to make sure that all thread stacks are included. |
|SQLDUMPER_DUMP_ALL_THREADS |0x0020|This flag is not required when you manually run the Sqldumper.exe utility and you specify a ThreadId parameter value of 0. A ThreadId parameter value of 0 indicates that all threads should be dumped. If you specify a specific, non-zero ThreadId parameter value but you also use this flag, all the threads are written to the dump file. This flag exists because the typical behavior in the Sqlservr.exe process is to pass in the current ThreadId property value of the thread that spawns the Sqlservr.exe process. When this behavior occurs, the flag is needed as an option to dump out all threads.|
|SQLDUMPER_MATCH_FILE_NAME |0x0040|You can use this flag to try to force the Sqldumper.exe utility to generate a dump file name that resembles a specific naming convention. This specific naming convention may be based on an existing file name. Because you must set up a special memory structure that contains the existing file name in your own program and then pass that pointer to the Sqldumper.exe utility as the SqlInfoPtr parameter, this flag is not useful when you manually run the Sqldumper.exe utility. |
|SQLDUMPER_SKIP_DW_REG_READ |0x0080|This flag causes the Sqldumper.exe utility not to use the registry as the path for execution of the Dw15.exe program. The Dw15.exe program is used to upload the dump files to the error reporting site.|
|SQLDUMPER_VERBOSE |0x0100|This flag can be valuable if you are not sure about the parameters that the Sqldumper.exe utility thinks are being used as input. When you use this flag, the Sqldumper.exe utility displays the parameter values and how many parameter values were specified from the command line. |
|SQLDUMPER_WAIT_AT_EXIT |0x0200|You can use this flag to attach a debugger to the Sqldumper.exe utility. You can use this debugger to troubleshoot any problems with the Sqldumper.exe utility. These problems may especially occur when the Sqldumper.exe utility is spawned by Sqlservr.exe or by another program. When you set this flag, the Sqldumper.exe utility calls the SleepEx function for 15 seconds just before the Sqldumper.exe program exists and after all other operations are finished.|
|SQLDUMPER_FILTERED |0x0800|You can use this flag to generate a filtered dump file. SQL Server Analysis Services does not support this flag yet. |
  
  You can use the MiniDumpFlagsOn setting to provide minidump flags. The following table lists the available minidump flags:

|Option |Value |Description |
|-|-|-|
|MiniDumpNormal |0x00000000|Create a typical mini-dump file that uses overwriting. |
|MiniDumpWithDataSegs |0x00000001|Include a data segment for all the loaded modules. The flag the loaded modules retrieve global variables. |
|MiniDumpWithFullMemory |0x00000002|Create a full user dump file. A filtered dump file is disabled when the flag is set. |
|MiniDumpWithHandleData |0x00000004|Include handle information.  |
|MiniDumpFilterMemory |0x00000010|Stack and backing store memory should be scanned for pointer references to modules in the module list. The user should not use this flag for SQL Server Analysis Services. |
|MiniDumpWithUnloadedModules |0x00000020|This flag provides information about recently unloaded modules. Only Microsoft Windows XP and Microsoft Windows Server 2003 support this flag. The operating system does not maintain information for unloaded modules until Windows Server 2003 Service Pack 1 (SP1) and Windows XP Service Pack 2 (SP2). |
|MiniDumpWithIndirectlyReferencedMemory |0x00000040|Include pages that have data that is referenced by locals or by other stack memory. |
|MiniDumpFilterModulePaths |0x00000080|If the module path is stripped from the module information, do not use this flag. |
|MiniDumpWithProcessThreadData |0x00000100|This flag provides information about the Process Environment Block (PEB) and the Thread Environment Block (TEB).|
|MiniDumpWithPrivateReadWriteMemory |0x00000200|Scan the virtual address space for other types of memory to be included. |
|MiniDumpWithoutOptionalData |0x00000400|Reduce the data that is dumped by eliminating memory regions that are not required. Do this to meet criteria that are specified for the dump file. Using this flag can avoid dumping memory that may contain data that is private to the user. However, this is not a guarantee that no private information will be present. Do not use this flag. |
|MiniDumpWithFullMemoryInfo |0x00000800|Include enumerated memory region descriptive information. |
|MiniDumpWithThreadInfo |0x00001000|Include thread state information. |
|MiniDumpWithCodeSegs |0x00002000|Include code and code-related sections for all the loaded modules. |
  
## References

[How to use the Sqldumper.exe utility to generate a dump file in SQL Server](https://support.microsoft.com/help/917825)

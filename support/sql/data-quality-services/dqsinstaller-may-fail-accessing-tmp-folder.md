---
title: DQSInstaller may fail accessing temp folder
description: This article provides a resolution for the problem where the temp folder path contains an accented or special ANSI character.
ms.date: 01/14/2021
ms.custom: sap:Data Quality Services
ms.reviewer: JasonH
ms.topic: troubleshooting 
---
# SQL Server 2012 DQSInstaller.exe may fail accessing TMP folder

This article helps you resolve the problem where the temp folder path contains an accented or special ANSI character.

_Applies to:_ &nbsp; SQL Server 2012 Business Intelligence, SQL Server 2012 Developer, SQL Server 2012 Enterprise  
_Original KB number:_ &nbsp; 2702283

## Symptoms

The SQL Server 2012 Data Quality Services installer DQSInstaller.exe may fail on computers where the temp folder path contains an accented or special ANSI character.

For example, for Windows users with accented characters in the user name, the temp folder may contain accented characters `é`, such as `C:\Users\Us é rNam é\AppData\Local\Temp\`.

You may note the following errors on the console when running DQSInstaller.exe, or in the DQSInstaller.exe output log (default location is `C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Log\DQS_install.log`) **CREATE ASSEMBLY failed because it could not open the physical file** Register Microsoft.Practices assemblies:

> Msg 6501, Level 16, State 7, Server DOMAIN\SERVERNAME, Line 2  
CREATE ASSEMBLY failed because it could not open the physical file 'C:\Users\<username>\AppData\Local\Temp\<random folder>\Microsoft.Practices.ObjectBuilder2.dll': 3(The system cannot find the path specified.).  
ERROR - An error occured, check message above
Script process returned unexpected exit code: '1'.  
Action 'Register data quality assemblies and stored procedures' finished with errors, aborting installation.  
Starting installation rollback...  
Installation rollback completed successfully.  
DQS Installer finished with errors. Please see installation log file at c:\Program Files\Microsoft SQL Server\MSSQL11.InstanceName\MSSQL\Log\DQS_install.log  
Press any key to continue...

## Cause

The temp folder used by DQSInstaller.exe is specified by the environment variable TMP.

DQSInstaller extracts assembly files and scripts into a temporary folder with a random name under the temp folder. If this temp path contains special characters, the DQSInstaller does not correctly neutralize the accented or special characters when running scripts and assemblies.

## Resolution

The easiest way to resolve the problem is to launch the command prompt as administrator (elevate it if UAC is enabled), override the TMP location temporarily with a local TMP variable, and then run the DQSInstaller.exe.

In this command prompt syntax example we will make a directory (md) c:\temp, then set the TMP variable to that location, and then change directory into the folder where DQSInstaller.exe is present, then run the DQSInstaller.exe (with no extra switches).

```console
md c:\temp
SET tmp=c:\temp
cd "c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLServer\MSSQL\Binn\"
DQSInstaller.exe
```

## More information

To visit the TMP folder in windows explorer, you may open use the placeholder `%tmp%`:

Start > Run > %tmp%

To test what the current TMP environment variable is, you may use the SET syntax from the command prompt, or echo syntax:

```console
SET TMP

echo %tmp%
```

To permanently change the TMP and TEMP environment variables, see [How to Move the TEMP and TMP Directories](/previous-versions/tn-archive/aa998945(v=exchg.65)).

---
title: Errors when you move a site database
description: Describes an issue that you receive a Failed to find folder or Failed to find file error when you move a Configuration Manager site database.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Failed to find folder or Failed to find file error when you move a site database

This article provides a workaround to solve the **Failed to find folder** or **Failed to find file** error when you try to move a site database.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 3189594

## Symptoms

When you do site maintenance to move a Configuration Manager site database to a new standalone instance of Microsoft SQL Server, or to a new SQL Server Always On availability group, the Configuration Manager setup process fails and generates error messages that resemble the following in the ConfigMgrSetup.log.

Error message 1

> INFO: SQL Connection succeeded. Connection: SMS ACCESS, Type: Secure  
> INFO: SQL Server Native Client: SQLNCLI11 version:<11.0.2100.60>  
> ERROR: Failed to find folder of SQL Server assembly setup msi.

Error message 2

> ERROR: SQL Connection failed. Connection: SMS ACCESS, Type: Secure  
> ERROR: Failed to get SQL Server connection.  
> INFO: SQL Server Native Client: SQLNCLI11 version:<11.2.5641.0>  
> ERROR: Failed to find file: c:\temp\redist\msxml6_x64.msi.

## Cause

This problem can occur if Configuration Manager cannot find the required files. Typically this is because of an invalid registry key value for the following subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Setup\External File Directory`

## Workaround

To work around this problem, use Setupdl.exe to download the required files to a locally accessible folder. The version of Setupdl.exe that you use must match the version of the site so that the correct files are downloaded. Setupdl.exe will automatically update the registry value to have the new, correct download path.

A site-matching version of Setupdl.exe can be found in the cd.latest folder in the following location on the site server:

`<InstallationDrive>:\Program Files\Microsoft Configuration Manager\cd.latest\SMSSETUP\BIN\X64\setupdl.exe`

For environments where the site servers cannot access the Internet, you can run Setupdl.exe from an Internet-connected system, copy the required files to the site server, then manually update the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Setup\External File Directory` subkey.

## More information

Microsoft is researching this problem and will post more information in this article as it becomes available.

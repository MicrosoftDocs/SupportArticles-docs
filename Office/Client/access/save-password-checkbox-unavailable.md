---
title: Save Password checkbox is unavailable in Access
description: Lists two possible causes and feasible workarounds to the issue that you cannot save the logon ID and password locally when you link a table from an ODBC data source since the Save password check box is unavailable in the Link Tables dialog box.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 162524
ms.reviewer: 
search.appverid: 
  - MET150
appliesto: 
  - Access 2016
  - Access 2013
  - Access for Microsoft 365
  - Access 2019
ms.date: 05/26/2025
---

# Save Password check box is unavailable when you link ODBC tables
  
> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
> [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

Advanced: Requires expert coding, interoperability, and multiuser skills.  

This article applies only to a Microsoft Access database (.mdb and .accdb).  

_Original KB number:_ &nbsp; 207823

## Symptoms

You may not be able to save your logon ID and password locally when you link a table from an Open Database Connectivity (ODBC) data source because the **Save password** check box is unavailable in the Link Tables dialog box.

## Cause

This behavior can occur for the following reasons:

- There is a MSysConf table on the SQL Database server, which prohibits users from storing passwords locally.

- The registry has been modified so that network password caching has been disabled on your computer.

## Resolution

### Cause 1: There Is a MSysConf Table on the SQL Database Server

The server administrator has disabled local storage of the logon IDs and passwords in linked tables by creating a MSysConf table on the server, which contains the following record:

> Config nValue  
> \------ ------  
> 101 0  

To re-enable users to save logon IDs and passwords locally, change the record to:

> Config nValue  
> \------ ------  
> 101 1

### Cause 2: Network Password Caching Has Been Disabled

Edit the registry to enable network password caching.

> [!WARNING]
> : If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

Use the Registry Editor to set the DisablePwdCaching key to a decimal value of 0. This registry key may be stored in the following hives:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Office\<Office Version>\Common\Security`

> [!NOTE]
> If you have no plans to ever use the DisablePwdCaching key, you can delete it.

## More information

If you are administering an SQL Database that uses Microsoft Access as the front-end program, you can create a table in your SQL Database named MSysConf to help control communication between the two programs. The MSysConf table has two potential functions:

- It can disable the feature that enables users to save the logon ID and password for a linked SQL Database in Access.
- It can optimize how Access performs background population of records during idle time by setting the number of rows of data that are retrieved at one time and the number of seconds of delay between each retrieval.

## References

For more information about the MSysConf table, click Microsoft Access Help on the Help menu, type use the MSysConf table in a Microsoft Access database with linked SQL Databases in the Office Assistant or the Answer Wizard, and then click Search to view the topic.

---
title: Introduction to Account Lockout and Management Tools
description: Introduces Account Lockout and Management Tools for Windows Server.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Introduction to Account Lockout and Management Tools

_Original product version:_ &nbsp; Windows Server 2019, all editions, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Microsoft Windows Server 2003  
_Original KB number:_ &nbsp; 4469275

## Summary

This article introduces [Account Lockout and Management Tools](https://www.microsoft.com/download/details.aspx?id=18465). This set of tools helps you manage accounts and troubleshoot account lockouts.

## More information

The following files are included in the Account Lockout and Management Tools package:
- **AcctInfo.dll** -  Helps you isolate and troubleshoot account lockouts and change a user's password on a domain controller in that user's site. This tool adds new property pages to user objects in the Active Directory Users and Computers Microsoft Management Console (MMC). 
- **ALockout.dll** **** - On the client computer, helps determine a process or application that is sending wrong credentials. 

> **[!IMPORTANT]
>**  Do not use this tool on servers that host network applications or services. Also, you should not use ALockout.dll on servers that are running Microsoft Exchange Server because it may prevent the Exchange store from starting. 

- **ALoInfo.exe** **** - **** Displays the names and age of passwords for all user accounts. 
- **EnableKerbLog.vbs** **** -  U sed as a startup script by enabling Kerberos protocol to log on to all clients that run Windows 2000 and later versions of Windows. 
- **EventCombMT.exe** **** - **** Collects specific events from event logs of several different computers in one central location. 
- **LockoutStatus.exe** **** -  T o help collect the relevant logs, d etermines all the domain controllers that are involved in a lockout of a user account. LockoutStatus.exe uses the NLParse.exe tool to parse Netlogon logs for specific Netlogon return status codes. This tool directs the output to a comma-separated value (.csv) file that you can sort later. 
- **NLParse.exe** **** -  U sed to extract and display desired entries from the Netlogon log files. 

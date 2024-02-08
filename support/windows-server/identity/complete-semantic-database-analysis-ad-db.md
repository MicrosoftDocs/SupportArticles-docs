---
title: How to complete a semantic database analysis for the Active Directory database by using Ntdsutil.exe
description: This step-by-step article describes how to run the semantic checker on the Active Directory database.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
ms.subservice: active-directory
---
# How to complete a semantic database analysis for the Active Directory database by using Ntdsutil.exe

This article describes the steps to complete a semantic database analysis for the Active Directory database by using Ntdsutil.exe

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315136

## Summary

This step-by-step article describes how to run the semantic checker on the Active Directory database. Unlike the file management commands, which test the integrity of the database with respect to the ESENT database semantics, the semantic analysis analyzes the data with respect to Active Directory semantics. You can use this process to generate reports on the number of records present, including deleted and phantom records.

The Windows 2000 Directory service opens its files in Exclusive mode. This means that the files can't be managed while the computer is operating as a domain controller. The first procedure is to boot your server into Directory Services Restore mode.

## Boot into Directory Services Restore Mode

1. Reboot the server.
2. After the BIOS information appears, press F8.
3. Select **Directory Services Restore Mode (Windows 2000 domain controllers only)**, and then press ENTER.
4. Select your server, and then press ENTER.
5. Log on by using your Restore Administrative account that was made when this domain controller was promoted.

## Starting Ntdsutil.exe

1. Click Start, and then click Run.
2. In the Open box, type *ntdsutil*, and then press ENTER. Note that you can view Ntdsutil.exe Help by typing *?* at the command prompt, and then pressing ENTER.

## Complete a database analysis

This procedure starts the semantic analysis of the Ntds.dit file. A report is generated and written to a file that is named Dsdit.dmp. *n*, in the current folder, where *n* is an integer that is incremented each time that you run the command.

1. At the Ntdsutil.exe command prompt, type *Semantic database analysis*, and then press ENTER.
2. At the Semantic Checker command prompt, type *Go*, and then press ENTER.
3. Verification is displayed. To exit, type *q*, press ENTER, type *q*, and then press ENTER.

## Retrieve a specific record

This procedure retrieves a specific record number from the Ntds.dit file by using the DNT record number variable. One of the functions of the database layer is to translate each distinguished name into an integer structure that is called the distinguished name tag, which is used for all internal accesses. The database layer guarantees the uniqueness of the distinguished name tag for each database record. To display indices and their associated DNT, use the integrity command in the Files menu of Ntdsutil.exe.

1. At the Ntdsutil.exe command prompt, type *Semantic database analysis*, and then press ENTER.
2. At the Semantic Checker command prompt, type *Go*, and then press ENTER.
3. At the Semantic Checker command prompt, type *Get DNT record number*, and then press ENTER.
4. Verification is displayed. To exit, type *q*, press ENTER, type *q*, and then press ENTER.

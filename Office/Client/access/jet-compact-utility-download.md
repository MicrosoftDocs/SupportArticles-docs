---
title: Jet compact utility is available in Download Center
description: Lists the link to download the Jet compact utility JETCOMP.exe. It's a stand-alone utility that compacts databases created with Microsoft Jet database engine 3.x and 4.0. The user interface of JETCOMP.exe is in English only.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: chriswy
appliesto: 
  - Access 2002
ms.date: 06/06/2024
---

# Jet compact utility is available in download center

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies only to a Microsoft Access database (.mdb).

## Summary

The Jet compact utility, JETCOMP.exe, is a stand-alone utility that compacts databases created with Microsoft Jet database engine 3.x and 4.x. This utility may be run in conjunction with Microsoft Jet database engine 3.x and 4.x for recovering corrupted databases. Although you can run the Microsoft Access Compact utility or the CompactDatabase method with Microsoft Jet database engine 3.x and 4.x, Jetcomp.exe may be able to recover some databases that these utilities cannot. The reason for this is that the Microsoft Access Compact utility and the CompactDatabase method attempt to open and close a database before attempting to compact it. In certain cases where these utilities may not be able to reopen the database, Compact will be unable to proceed, preventing recovery of the database. JETCOMP.exe does not attempt to open and close the database before compacting, and may therefore be able to recover some databases that the Microsoft Access compact utility and the CompactDatabase method cannot.

> [!NOTE]
> The user interface of JETCOMP.exe is in English only and is not supported by Microsoft Product Support Services. However, JETCOMP.exe can compact databases in any language supported by the Microsoft Jet database engine. JETCOMP.exe is a freely distributable utility, but requires that one of the following products is installed on the computer:

**Note** You must make sure that no users are accessing the database before you run JETCOMP.exe. 

- Microsoft Office XP   
- Microsoft Office 2000   
- Microsoft Office 97   
- Microsoft Access 2002   
- Microsoft Access 2000   
- Microsoft Access 97   
- Microsoft Visual Basic 6.0   
- Microsoft Visual Basic 5.0   
- A Microsoft Office XP Developer run-time application that includes the run-time version of Microsoft Access 2002   
- A Microsoft Office Developer 2000 run-time application that includes the run-time version of Microsoft Access 2000   
- A Microsoft Office Developer Edition 97 run-time application that includes the run-time version of Microsoft Access 97   
- A Microsoft Visual Basic 6.0 run-time application that includes Microsoft Jet database engine 3.5 or 4.0   
- A Microsoft Visual Basic 5.0 run-time application that includes Microsoft Jet database engine 3.5   

The following file is available for download from the Microsoft Download Center:

[Download the JETCOMP.exe package now.](https://download.microsoft.com/download/access2000/utility/1.0/win98me/en-us/jetcu40.exe)

For additional information about how to download Microsoft Support files, click the following article number to view the article in the Microsoft Knowledge Base:

[119591 ](https://support.microsoft.com/help/119591) How to Obtain Microsoft Support Files from Online Services

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.

## More information

The JetCU40.exe download contains the following files:

```adoc
JETCOMP.exe The Jet Compact Utility
JetComp.doc A word document containing information about
localization and support, instructions for use,
errors encountered in earlier versions of Jet, 
MSysCompactError table, issues fixed by updated 
compact utility, and sample code to view rows
containing modified column data
```

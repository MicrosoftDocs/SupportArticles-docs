---
title: Access crashes after you install Office 2010 SP1
description: Resolves a problem that Access 2010 databases randomly crash after you install Office 2010 SP1.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access 2010
ms.date: 03/31/2022
---

# Access 2010 crashes after you install Office 2010 Service Pack 1, and the error signature in Event Viewer points to the Vbe7.dll file

## Symptoms

After you install Microsoft Office 2010 Service Pack 1 (SP1), you may experience random crashes when you work with Microsoft Access 2010 databases. These crashes may occur in those databases when you open objects, or you try to use the Visual Basic Editor. When you look in Event Viewer, the error signature resembles the following: 

## Resolution

To resolve this issue, install update 2553385. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[2553385 ](https://support.microsoft.com/help/2553385) Description of the Office 2010 update: December 13, 2011

This issue was originally fixed in the following October 2011 hotfix package:

[2596585 ](https://support.microsoft.com/help/2596585) Description of the Office 2010 hotfix package (Vbe7-x-none.msp): October 25, 2011 

To work around this problem, decompile and then recompile the database. To do this, follow these steps:

1. Make a copy or backup of your database.   
2. On the computer that is exhibiting the problem, decompile the database. To do this, at a command prompt, run the following command where c:\folder\test.accdb is the path of your database together with the database file name:

   c:\folder\test.accdb /decompile   
3. Close the database.   
4. Open the database in Access 2010 SP1.   

## More Information

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
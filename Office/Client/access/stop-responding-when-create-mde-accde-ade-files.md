---
title: Access may stop responding when you try to create an MDE or ACCDE file, or an ADE file
description: Discusses the problem when you try to save an Access database file (.mdb or .accdb) as an MDE file (.mde) or an ACCDE file (.accde).
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 120588
  - CSSTroubleshoot
ms.reviewer: SUZANNEL
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
  - Access 2003
  - Microsoft Access 2002 Standard Edition
  - Microsoft Access 2000 Standard Edition
search.appverid: MET150
ms.date: 05/26/2025
---

# Access may stop responding when you try to create an MDE, ACCDE, or ADE file

Moderate: Requires basic macro, coding, and interoperability skills.  

This article applies to a Microsoft Access database (.mdb or .accdb) and a Microsoft Access project (.adp).  

_Original KB number:_ &nbsp; 814858

## Symptoms

When you try to save an Access database file (.mdb or .accdb) as an MDE file (.mde) or ACCDE file (.accde), or when you try to save an Access project file (.adp) as an ADE (.ade) file, Access may stop responding. You may receive the following error message:

> Microsoft Access has encountered a problem and needs to close. We are sorry for the inconvenience.  
> Please tell Microsoft about this problem.  
> We have created an error report that you can send to help us improve Microsoft Access. We will treat this report as confidential and anonymous.  
> To see what data this error report contains, click here.

## Cause

This problem may occur when the compiled Visual Basic for Applications (VBA) project of the .mdb file or the .adp file is corrupted.

## Workaround

To work around this problem, you can reload the VBA project of the Access database from text and then create the MDE,  ACCDE, or ADE file. To do this, follow these steps:

> [!NOTE]
> Make a backup copy of the database before you start these steps.

1. On the taskbar, click **start** and then click **Run**.
1. Type **\<Microsoft_Access_Path>\msaccess.exe /decompile** and then click **OK**.

   > [!NOTE]
   > <Microsoft_Access_Path> is the path of the folder where Access is installed.

1. Open the original .mdb file, the original.accdb file, or the original .adp file that you want to save as the new MDE file, ACCDE file, or ADE file. To do this, follow these steps:

   1. Press **ALT+F11** to open the Visual Basic Editor.
   1. On the **Debug** menu, click **Compile \<DatabaseName>**.
   1. On the **File** menu click **Save \<DatabaseName>**, and then close the Visual Basic Editor.

1. In recent versions of Access, click **File** > **Save As** > **Save Database As** and then click **Make ACCDE File** or click **Make ADE**.

   In Access 2010 and Access 2007, click the **Database Tools** tab, and then click **Make ACCDE File** or click **Make ADE** in the **Database Tools** group.

   In Microsoft Office Access 2003 or in earlier versions of Access, click **Database Utilities** on the Tools menu, and then click **Make MDE File** or click **Make ADE File**.

1. In the **Save MDE As** dialog box, in the **Save As** dialog box, or in the Save ADE As dialog box, locate the folder where you want to save the MDE, the ACCDE file, or the ADE file, type the file name in the **File name** box, and then click **Save**.

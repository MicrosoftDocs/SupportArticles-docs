---
title: Error in loading DLL when using Access wizard
description: Fixes an issue in which you can't use an Access wizard, such as the Import Text wizard or the Import Spreadsheet wizard.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# "Error in loading DLL" error when you run a Microsoft Access wizard

_Original KB number:_ &nbsp; 833220

> [!NOTE]
> This article applies only to a Microsoft Access database (.mdb). Requires basic macro, coding, and interoperability skills.

## Symptoms

When you try to use a Microsoft Access wizard, such as the Import Text wizard or the Import Spreadsheet wizard, in Microsoft Access 2002, you may receive the following error message. When you try to open a form that is created by the Switchboard manager, you may receive the following error message:

> Error in loading DLL

## Cause

This problem may occur if you have missing Microsoft Data Access Components (MDAC) files, corrupted MDAC files, or outdated MDAC files on your computer.

## Resolution

To resolve this problem, use either of the following methods:

Method 1: Register the required Dao360.dll file and the Msado15.dll file

You may have to register the Dao360.dll file and the Msado15.dll file by using the Regsvr32.exe program. To do this, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Run** dialog box, type the following commands in the **Open** box, and then click **OK**:

   `Regsvr32.exe "<<Dao360.dll_Path>>"`

   `Regsvr32.exe "<<Msado15.dll_Path>>"`

   The *Dao360.dll_Path* placeholder is the absolute path of the Dao360.dll file.

   The *Msado15.dll_Path* placeholder is the absolute path of the Msado15.dll file.

   The following examples show how you may specify an absolute path:

   `Regsvr32.exe "C:\Program Files\Common Files\Microsoft Shared\DAO\Dao360.dll"`

   `Regsvr32.exe "C:\Program Files\Common Files\system\ado\Msado15.dll"`

   If the Dao360.dll file is successfully registered, you receive a message that is similar to the following message:

   > DllRegisterServer in C:\Program Files\Common Files\Microsoft Shared\DAO\Dao360.dll succeeded.

   If the Msado15.dll file is successfully registered, you receive a message that is similar to the following message:

   > DllRegisterServer in C:\Program Files\Common Files\system\ado\Msado15.dll succeeded.

3. Click **OK**.

Method 2: Install the latest version of MDAC

For additional information about how to download the latest version of MDAC, visit the following Microsoft Developer Network (MSDN) Web site:

[MDAC](https://msdn.microsoft.com/data/aa937729.aspx)

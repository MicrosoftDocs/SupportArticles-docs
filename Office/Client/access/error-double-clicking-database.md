---
title: Errors when double-clicking to open a database
description: Fixes an issue in which you can't open a database by double-clicking it in Windows Explorer with the error message about invalid Win32 application or about file association.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# File association errors opening databases by double-clicking in Access

_Original KB number:_ &nbsp; 2212418

## Symptoms

When opening databases by double-clicking on them in Windows Explorer, one of the following error messages appears. The same database can be opened by opening Access first and then opening the file from the **File** > **Open** menu option.

> "'\<Database name>' is not a valid Win32 application"

-OR-

> "This file does not have a program associated with if for performing this action. Create an association in the Set Association control panel."

The file extensions used by Access have lost their association to the Access application. The most common extensions are (.accdb, .accde, .mdb, .mde).

## Resolution

This issue is corrected by changing the file association back to Access.

### Method 1

1. Right-click on the problem (.accdb, .accde, .mdb, .mde) file.
2. Point to **Open With**, and then click on **Choose Default Program**.
3. Under **Recommended Programs**, look for Access and select it if found.
4. If Access wasn't listed in the **Recommended Programs** section, click the **Browse** button, browse to and select msaccess.exe, and then click **Open**.

   Common install paths:

   (32-bit Windows / 32-bit Access) or (64-bit Windows / 64-bit Access):

   - Access 2007: `C:\Program Files\Microsoft Office\Office12\MSACCESS.EXE`
   - Access 2010: `C:\Program Files\Microsoft Office\Office14\MSACCESS.EXE`
   - Access 2013: `C:\Program Files\Microsoft Office\Office15\MSACCESS.EXE` (MSI)
   - Access 2013: `C:\Program Files\Microsoft Office 15\root\Office15\MSACCESS.EXE` (C2R)
   - Access 2016: `C:\Program Files\Microsoft Office\Office16\MSACCESS.EXE` (MSI)
   - Access 2016: `C:\Program Files\Microsoft Office\root\Office16\MSACCESS.EXE` (C2R)

   (64-bit Windows / 32-bit Access):

   - Access 2007: `C:\Program Files (x86)\Microsoft Office\Office12\MSACCESS.EXE`
   - Access 2010: `C:\Program Files (x86)\Microsoft Office\Office14\MSACCESS.EXE`
   - Access 2013: `C:\Program Files (x86)\Microsoft Office\Office15\MSACCESS.EXE` (MSI)
   - Access 2013: `C:\Program Files\Microsoft Office 15\root\Office15\MSACCESS.EXE` (C2R)
   - Access 2016: `C:\Program Files (x86)\Microsoft Office\Office16\MSACCESS.EXE` (MSI)
   - Access 2016: `C:\Program Files(x86)\Microsoft Office\root\Office16\MSACCESS.EXE` (C2R)

5. Make sure that the "Always use the selected program..." box is checked, and then click **OK**.

### Method 2

If your operating system is Windows Vista or newer, you can delete the following registry keys to remove the current user choice for the default application used with the file extension. The key is rebuilt with the default association the next time Access is opened.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Open the Registry Editor by clicking on **Start**, typing **Regedit** in the search box, and then pressing enter.
2. Locate the following key:

   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts`

3. Locate the file extension that you want to delete. such as .accdb. Before deleting it, create a backup of the key by right-clicking on the file extension (.accdb), choosing Export, and then providing a filename.

   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.accdb`

4. Right-click on the file extension (.accdb) key again and this time choose **Delete**.
5. Close the Registry Editor and double-click on your database file.

> [!NOTE]
> This is a "FAST PUBLISH" article created directly from within the Microsoft support organization. The information contained herein is provided as-is in response to emerging issues. As a result of the speed in making it available, the materials may include typographical errors and may be revised at any time without notice. See
[Terms of Use](https://go.microsoft.com/fwlink/?LinkId=151500) for other considerations.

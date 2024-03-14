---
title: Error messages when you view a PowerPoint  presentation
description: You cannot view a PowerPoint  presentation if the Hlink.dll file is missing, is damaged, or is the wrong version.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft PowerPoint
ms.date: 03/31/2022
---

# "Hlink.dll Can't Be Loaded" or "PowerPoint Failed to Load Hlink.dll" in a PowerPoint presentation

## Symptoms

When you view a PowerPoint presentation, you may receive one or both of the following error messages:

**Microsoft PowerPoint "hlink.dll" can't be loaded.**

**Microsoft PowerPoint failed to load "hlink.dll".**

## Cause

This issue may occur if the Hlink.dll file is missing, is damaged, or is the wrong version.

## Resolution

To resolve this issue, delete the Hlink.dll file on your hard disk drive if it exists, and then replace it. The Hlink.dll file is stored on the Microsoft Windows CD, and you can install it with Microsoft Internet Explorer. To replace the Hlink.dll file, use either of the following methods.

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

### Method 1: Reinstall Internet Explorer

Note Because there are many different versions of Internet Explorer designed for many different operating systems, use the following Microsoft Knowledge Base article to help you determine the best approach for reinstalling your version of Internet Explorer:

[318378](https://support.microsoft.com/help/318378) How to reinstall or repair Internet Explorer in Windows

### Method 2: Extract the Hlink.dll File

1. Save any open files, and then quit all programs that are running.
2. Click **Start**, point to **Find**, and then click **Files or Folders**.
3. In the **Named** box, type hlink.dll.
4. In the **Look in** box, make sure that drive C is selected, and then click **Find Now**.
5. If you find the Hlink.dll file, right-click the file, and then click **Rename**.
6. Rename the file from Hlink.dll to Hlink.old.
7. Insert the Microsoft Windows 2000 or Windows XP CD in the CD Drive Or DVD Drive.
8. Click **Start**, and then click **Run**.
9. To extract the Hlink.dll file file, in the **Run** dialog box, type the following command line where **drive** is the drive letter of the CD drive or DVD drive, and **windows** is the folder that contains the Windows operating system: 

    **expand drive:\i386 hlink.dl_ c:\windows\system32\hlink.dll**

    Click **OK**.

10. Click **Start** again, and then click **Run**.
11. To register the Hlink.dll file manually on the 32-bit operating system, in the **Run** dialog box, type the following command line where **windows** is the folder that contains the Windows operating system:

    **c:\windows\system32\regsvr32 /s c:\windows\system32\hlink.dll**

    Click **OK**.
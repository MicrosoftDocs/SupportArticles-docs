---
title: Office is slow or stops responding when you open file from network location
description: Fixes an issue in which Office is slow when you open files from network location.
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
  - Microsoft 365
  - Excel LTSC 2021
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - PowerPoint LTSC 2021
  - PowerPoint 2019
  - PowerPoint 2016
  - PowerPoint 2013
  - PowerPoint 2010
  - Microsoft Office PowerPoint 2007
  - Microsoft Office PowerPoint 2003
  - Publisher LTSC 2021
  - Publisher 2019
  - Publisher 2016
  - Publisher 2013
  - Publisher 2010
  - Microsoft Office Publisher 2007
  - Microsoft Office Publisher 2003
ms.date: 03/31/2022
---

# An Office program is slow or may stop responding (hang) when you open a file from a network location

## Symptoms

When you try to open a file from a network location in one of the Microsoft Office programs such as PowerPoint 2003 , Excel 2003, Publisher 2003 or a later version of them, the Office program may run very slowly or may appear to stop responding (hang).

## Cause

This behavior may occur if the connection to the network location is lost during the time that your Office program is opening the file.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this behavior, add the **EnableShellDataCaching** value to the Microsoft Windows registry. To do this, follow these steps:

1. Close your Office programs.
1. Click **Start**, and then click **Run**.
1. In the **Open** box, type regedit, and then click **OK**.
1. Locate, and then click to select one of the following registry keys accordingly:

   - **Microsoft 365 Apps, Office LTSC 2021, Office 2019 and Office 2016:**

      **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Open Find**
   - **Office 2013:**

     **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Open Find**
   - **Office 2010:**

     **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Open Find**
   - **Office 2007:**

     **HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Common\Open Find**
   - **Office 2003:**

     **HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Common\Open Find**
1. After you select the key that is specified in step 4, point to **New** on the **Edit** menu, and then click **DWORD Value**.
1. Type **EnableShellDataCaching**, and then press **ENTER**.
1. Right-click **EnableShellDataCaching**, and then click **Modify**.
1. In the **Value data** box, type 1, and then click **OK**.
   > [!NOTE]
   > Any non-zero number in the **Value data** box will turn on caching. A zero number or blank (default) will turn off caching.
1. On the **File** menu, click **Exit** to quit Registry Editor.

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).

## More information

This situation may occur after you click **Open** in the **Open** dialog box (on the **File** menu, click **Open**) to open a file from a network location (for example, a network server). During the process of opening the file, you lose your network connection or the network location that contains the file that you are trying to open goes down. During the process of opening the file, your Office program tries to add the file name and the path information of the file that you are trying to open to the Windows recent file list. Because the network location (path) does not now exist, the Office program may run slowly and may appear to stop responding (hang).

> [!NOTE]
> This situation may also occur if your connection to your network is slow because your Office program has to make multiple queries to the network to obtain the correct file information.
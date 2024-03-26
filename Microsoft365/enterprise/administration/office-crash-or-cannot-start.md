---
title: Office Applications crash or cannot start
description: Workarounds an issue that Office applications crash or cannot start.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2016
  - Outlook 2016
  - Skype for Business 2016
  - Word 2016
  - PowerPoint 2016
  - Microsoft Publisher 2016
  - Access 2016
  - OneNote 2016
  - Project Standard 2016
ms.date: 03/31/2022
---

# Office Applications crash or cannot start

> [!NOTE]
> **This article only addresses the crash scenario where mso30win32client.dll is the module name in a crash signature.**
>
> For other scenarios, see the following articles:
>
> - [Excel not responding, hangs, freezes, or stops working](https://support.microsoft.com/office/37e7d3c9-9e84-40bf-a805-4ca6853a1ff4)
> - [PowerPoint isn't responding, hangs, or freezes](https://support.microsoft.com/office/652ede6e-e3d2-449a-a07f-8c800dfb948d)
> - [I get a "stopped working" error when I start Office applications on my PC](https://support.microsoft.com/office/52bd7985-4e99-4a35-84c8-2d9b8301a2fa)
> - [Help protect your files in case of a crash](https://support.microsoft.com/office/551c29b1-6a4b-4415-a3ff-a80415b92f99)
>
> If you still couldn't find a solution with Office Applications crashing or not starting, you might check the [Microsoft Community Office Commercial Admin Center Forums](https://techcommunity.microsoft.com/t5/admin-center/bd-p/AdminCenter).

## Symptoms

Microsoft Office 2016 applications may crash or cannot start. The applications that have been seen to be affected are Excel, Outlook, Skype for Business, Word, Access, Publisher, Project and OneNote.

Additionally, in the Application Event log, you may find a crash signature similar to the following in event ID 1000:

```output
Application Name: <application>.exe
Application Version:16.0.4266.1001
Module Name: mso30win32client.dll
Module Version: 16.0.4266.1001
Offset: <varies>
```

> [!NOTE]
>
> - The Application Name will be the name of the executable of the application, such as excel.exe, outlook.exe, lync.exe, winword.exe, msaccess.exe, mspub.exe, winproj.exe, or onenote.exe.
> - The Application Version, Module Version and Offset will vary.  

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, follow these steps:

1. Exit all Office 2016 applications.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

     - Windows 10, Windows 8.1 and Windows 8:Press Windows Key + R to open a Run dialog box. Type regedit.exe and then press **OK**.
     - Windows 7: Click Start, type regedit.exe in the search box, and then press Enter.
3. Locate and then select the following registry key:

    HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\General

4. Locate the **ShownFirstRunOptin** registry value in the key that is specified in step 3. If you do not find **ShownFirstRunOptin**, go to step 5. If you do find it, go to step 7.
5. If you do not find the **ShownFirstRunOptin** registry value, point to **New** on the **Edit** menu, and then click **DWORD (32-bit) Value**.
6. Type ShownFirstRunOptin, and then press ENTER.
7. Right-click **ShownFirstRunOptin**, and then click **Modify**.
8. In the **Value data** box, type 1, and then click **OK**.  
9. On the **File** menu, click **Exit** to exit Registry Editor.

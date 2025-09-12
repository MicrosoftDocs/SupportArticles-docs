---
title: Outlook.exe.log in %Temp% consumes too much disk space
description: Describes an issue in which a file that's named Outlook.exe.log and that may be larger than 1 GB appears in your %Temp% folder. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: RobEvans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook.exe.log file in the %Temp% folder consumes too much disk space

_Original KB number:_ &nbsp; 3038305

## Symptoms

In your computer's %Temp% folder, you notice a very large file (for example, more than 1 GB) that's named Outlook.exe.log.

> [!NOTE]
> The %Temp% folder is typically found at C:\Users\\<**user name**>\AppData\Local\Temp.

## Cause

This problem may occur if you turned on TCOTrace logging by enabling the following registry settings:

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Common\Debug`  
DWORD: TCOTrace  
Value: 1

> [!NOTE]
> The **x.0** placeholder represents your version of Office (16.0 = Outlook 2016, Outlook for Microsoft 365 and Outlook 2019, 15.0 = Outlook 2013, 14.0 = Outlook 2010, and 12.0 = Outlook 2007).

TCOTrace logging should remain enabled only as long as you are working with a support engineer on a specific issue.

## Resolution

To resolve this issue, follow these steps:

1. Exit Outlook.
2. Open a Run dialog box. To do this, use one of the following methods, as appropriate for your situation:
   - Windows 10, Windows 8.1, and Windows 8: Press Windows key+R.
   - Windows 7 or Windows Vista: Select **Start**, and then select **Run**.
3. Type *regedit.exe*, and then select **OK**.
4. Locate and then select the following subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Common\Debug`

    > [!NOTE]
    > The **x.0** placeholder represents your version of Office (16.0 = Outlook 2016, Outlook for Microsoft 365 and Outlook 2019, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007).

5. Right-click TCOTrace, and then select **Delete**.
6. When you are prompted to confirm the deletion, select **Yes**.
7. On the **File** menu, select **Exit** to exit Registry Editor.
8. Delete the Outlook.exe.log file from the %Temp% folder if you are not working with a Microsoft support engineer on an issue.

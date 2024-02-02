---
title: Error or high CPU utilization when running a WPF-based application
description: This article provides a resolution for the problem where you receive a FileFormatException or ArgumentOutOfRangeException error message in a WPF-based program when the WPF-based program processes text.
ms.date: 01/07/2021
ms.reviewer: 
ms.topic: troubleshooting
---
# Error message or high CPU utilization when running a WPF-based application

This article helps you resolve the problem where you receive a **FileFormatException** or **ArgumentOutOfRangeException** error message in a Windows Presentation Foundation (WPF)-based program when the WPF-based program processes text.

_Applies to:_ &nbsp; Windows Presentation Foundation  
_Original KB number:_ &nbsp; 937135

## Symptoms

When you run a WPF-based application in the Microsoft .NET Framework 3.0, you may receive a FileFormatException error or an ArgumentOutofRangeException error. The error occurs when the WPF-based application starts to process text. For example, you may receive a **FileFormatException** error message that resembles the following:

> file:///filepath/file_name file does not conform to the expected file format specification.

In this error message, *file_name* is typically the file name for a font. Additionally, the application consumes up to 100 percent CPU time.

When looking in Task Manager or other tools, PresentationFontCache.exe consumes 50% or more of available processor time.

## Cause

This issue occurs if video drivers overwrite the data in the font cache that is stored in memory.

## Resolution

To resolve this issue, follow these steps:

1. Exit all WPF-based applications that are running on the computer.
1. Stop the Windows Presentation Foundation Font Cache 3.0.0.0 service. To stop the Windows Presentation Foundation Font Cache 3.0.0.0 service, use one of the following methods.

    - Method 1: Use Microsoft Management Console
  
      1. Click **Start**, click **Run**, type *Services.msc*, and then click **OK**.
      1. Right-click **Windows Presentation Foundation Font Cache 3.0.0.0**, and then click **Stop**.
  
    - Method 2: Use the command prompt

      1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
      1. At the command prompt, type *net stop "Windows Presentation Foundation Font Cache 3.0.0.0"*, and then press **ENTER**.

1. Delete the old Fontcache3.0.0.0.dat file.

    > [!NOTE]
    > By default, the Fontcache3.0.0.0.dat file is located in the `%windir%\ServiceProfiles\LocalService\AppData\Local` folder in Windows Vista. By default, the Fontcache3.0.0.0.dat file is located in the `%systemdrive%\Documents and Settings\LocalService\Local Settings\Application Data` folder in Windows XP and in earlier versions of Windows.

1. Update the video card drivers. To do this, use one of the following methods.

    - Method 1: Use Windows Update Catalog

      To update the video card drivers, check for updates in the Windows Update Catalog. For more information about how to download drivers from the Windows Update Catalog, see [How to download updates that include drivers and hotfixes from the Windows Update Catalog](../../../../windows-client/deployment/download-updates-drivers-hotfixes-windows-update-catalog.md).

    - Method 2: Download and then install the latest video card drivers

      To download and install the latest video card drivers, contact the computer or the video hardware manufacturer.

## More information

If the video card drivers overwrite the data in the font cache that is stored in memory, the corrupted data may be saved to the hard disk as a data file. Therefore, you may experience the issue that is described in the [Symptoms](#symptoms) section when another WPF-based application tries to read the corrupted data file.

After you update the video card drivers and after you delete the Fontcache3.0.0.0.dat file, a new font cache data file is created based on the new computer configuration. This new font cache data file is created when the Windows Presentation Foundation Font Cache 3.0.0.0 service is stopped. Typically, the new font cache data file is created when the computer is shut down or restarted.

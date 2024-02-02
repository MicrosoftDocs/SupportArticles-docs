---
title: How to Use the Windiff.exe Utility
description: Describes how to use the Windiff.exe utility, a tool that graphically compares the contents of two ASCII files, or the contents of two folders that contain ASCII files, to verify whether they are the same. The file byte count and the creation date are not reliable indications.
ms.date: 12/04/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:file-explorer/windows-explorer, csstroubleshoot
---
# How to use the Windiff.exe Utility

This article describes how to use the Windiff.exe utility, a tool that graphically compares the contents of two ASCII files, or the contents of two folders that contain ASCII files, to verify whether they are the same. The file byte count and the creation date are not reliable indications.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 159214

## Summary

Sometimes you may experience unusual program behavior and may suspect that a file is damaged, or you may suspect that two files have the same byte count but different dates. Therefore, you want to make sure that they are the same. If a file is suspect, the typical solution is to recopy from a known good file. This solution may solve the problem, but it prevents you from knowing whether the original file was damaged. It can be important to determine this, as file damage can indicate an underlying network or system problem.

## More Information

In Microsoft Windows 2000 and later, Windiff.exe is included on the original CD-ROM in the Support\\Tools folder. To install the support tools, run Setup.exe from the Support\\Tools folder. Windiff.exe is also in the Support.cab file. Support.cab is included with every service pack.

In Microsoft Windows NT, Windiff.exe is included in the Windows NT 4.0 Resource Kit. To download the Windows NT 4.0 Resource Kit Support Tools, visit the following Microsoft Web site:  
[MS Windows NT 4.0 Resource Kit Support Tools](/previous-versions//cc767868(v=technet.10))

The Windiff.exe utility graphically illustrates the differences between ASCII text files that you specify, or the difference between folders that contain ASCII text files, and is especially useful for comparing program source code. You can use Windiff.exe to compare whole subfolder trees. The display shows either a summary of the comparison status of a list of files (outline mode) or a detailed line-by-line comparison of the files (expanded mode).

To compare two files by using Windiff.exe, follow these steps:

1. Start Windiff.exe.
2. On the **File** menu, click **Compare Files**.
3. In the **Select First File** dialog box, locate and then click a file name for the first file in the comparison, and then click **Open**.
4. In the **Select Second File** dialog box, locate and then click a file name for the second file in the comparison, and then click **Open**.

    The information in the right pane indicates whether there is a file difference.
5. To view the actual file differences, click the first line in the Windiff.exe output results, and then on the **Expand** menu, click **Left File Only**, **Right File Only**, or **Both Files**.

    The color-coded results indicate what the file differences are.

To compare two folders by using Windiff.exe, follow these steps:

1. Start Windiff.exe.
2. On the **File** menu, click **Compare Directories**.
3. In the **Select Directories** dialog box, type the two folder names that you want to compare in the **Dir1** and **Dir2** boxes. If you want to include subfolders, click to select the **Include subdirectories** check box.

    The information in the right pane indicates the differences between the two folders.
4. To view the actual file differences, click the line that you want in the Windiff.exe output results, and then on the **Expand** menu, click **Left File Only**, **Right File Only**, or **Both Files**.

    The color-coded results indicate what the file differences are.

You can also run Windiff.exe from the command line. For information about how to do so, or for more information about how to use Windiff.exe, see the Windiff.exe Help file (Windiff.hlp).

There are other utilities that are available besides Windiff.exe that you can use to compare local ASCII and binary files, or to compare a local file to a questionable file at a remote site.

To compare two files or groups of files at a local site, you can use the Fc.exe and the Comp.exe file compare commands. Both commands are run from a command prompt.

You can use Fc.exe to compare two ASCII or binary files on a line-by-line basis. It offers several command-line options. For example, use the `fc /b` command to compare two binary files. For a complete list of options, type `fc /?` at a command prompt.

You can use Comp.exe to compare ASCII and binary files and to compare groups of files in two different folders. For example, to compare all the .dll files in one folder to all the .dll files in the same folder on a different computer, type the following at a command prompt:

```console  
comp C:\Winnt\System32\*.dll \\DifferentComputerName\C$\Winnt\System32\*.dll
```
  
To compare a local file to a remote file, you can use a utility such as the third-party compression utility Pkzip.exe. To do so, use Pkzip.exe to zip the file at both the local and the remote sites. Because zipping a large file can take time, it is faster to use the pkzip -e0 (no compression) option. After you have zipped the files, use the `pkzip -v` command to examine the cyclic redundancy check (CRC32) value for the .zip files. If the CRC32 values are the same for the remote and local sites, the files are the same.

> [!NOTE]
> If you use Pkzip.exe to zip a file before you send the file to a remote site, because of the embedded CRC32, you will receive an error message during the unzip process if the file is damaged in transit. If you receive no error message, the file was conveyed without damage.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

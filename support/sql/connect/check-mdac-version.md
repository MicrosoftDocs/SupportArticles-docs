---
title: Check for MDAC version
description: This article describes how to check the MDAC version.
ms.date: 11/03/2020
ms.custom: sap:MDAC and ADO
ms.topic: how-to
---
# Check for MDAC version  

This article introduces how to check the MDAC version.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 301202

## Summary

This article describes two different ways to check which version of Microsoft Data Access Components (MDAC) is installed on a system:

- Use the Component Checker tool.
- Check the version information that is stored in the registry.

## Install and use the Component Checker tool

The most reliable way to determine which version of MDAC is installed is to compare the version number of each MDAC DLL file to a list of the DLL files that are shipped with each MDAC version. The Component Checker can help you to do this. It checks the files on the computer, compares them to a list from each version of MDAC, and reports the closest match.

To install Component Checker, follow these steps:

1. Browse to the Microsoft Web site: [MDAC Utility: Component Checker](https://www.microsoft.com/download/details.aspx?id=1953).

2. Click the link to download Component Checker. When you are prompted by the browser, save **cc_<CPU_arc>.msi** (a self-extracting executable file) to the desktop.
3. On the desktop, double-click **cc_<CPU_arc>.msi**; this installs the Component Checker files to the default location, `C:\CompChecker\`.

To use Component Checker to check the MDAC version, follow these steps:

1. From the **Start** menu, click **Run**.
2. In the Open text box, type `c:\CompChecker\CC.exe` and then click **OK**.
3. In the Component Checker - Choose **Analysis Type** dialog box, select Perform Analysis of your machine and automatically determine the release version, and then click **OK**.
4. The program attempts to identify the MDAC version on your computer by scanning all of the core MDAC files and registry settings. This process normally takes several minutes. When finished, you should receive the following message:

    > The MDAC version that is closest to the version on your computer is 'XXXX'.

5. Click **OK**.
6. A summary of the Component Checker scan appears.

    > [!NOTE]
    > The Dir, FileDescription, and FileSize errors can be safely ignored.

## Check the version information stored in the registry

Although not the most reliable way to check the MDAC version, checking the registry for the version information is an easy way to double-check this information (if you are not experiencing any MDAC-related issues).

The version information is found in the following key:

`HKEY_LOCAL_MACHINE\Software\Microsoft\DataAccess\FullInstallVer`  

To check the registry, follow these steps:

1. On the **Start** menu, click **Run**.
2. In the Open text box, type `regedit` and then click **OK**; this starts Registry Editor.
3. In the **Navigation** pane, drill down to the following path:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\DataAccess`  

4. In the **Details** pane, look in the Name column for `FullInstallVer` and `Version`. Each of these keys will have corresponding version information in the Data column.
5. When finished, click **Exit** on the Registry menu to close Registry Editor.

## Troubleshooting

> [!NOTE]
> The version information stored in the registry may be incorrect for versions of MDAC prior to 2.1 when compared with the versions of the actual files. Windows 2000 installs version 2.5. Only versions of MDAC later than 2.5 may be installed on Windows 2000.

Downloads for Microsoft Data Access Components are available at [SQL Data Developer](/sql/connect/sql-data-developer).

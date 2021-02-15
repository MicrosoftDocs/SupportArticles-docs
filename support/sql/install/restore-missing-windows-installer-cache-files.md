---
title: Restore the missing Windows Installer cache files
description: This article describes various procedures that you can use to resolve various errors that occur when installing SQL Server service pack or a cumulative update due to corruption of windows installer cache.
ms.date: 11/02/2020
ms.prod-support-area-path: Installation, Patching and Upgrade
ms.reviewer: ramakoni
ms.topic: how-to
ms.prod: sql
---
# Restore the missing Windows Installer cache files and resolve problems that occur during a SQL Server update

This article describes various procedures that you can use to resolve various errors that occur when installing SQL Server service pack or a cumulative update due to corruption of windows installer cache. 

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 969052

> [!NOTE]
> The process that's described in this article provides emergency relief only and not a permanent fix. Customers who use this emergency process should validate their Windows Installer Cache using the Windows Installer Cache Verifier Package, as directed in KB article [Missing Windows Installer cache requires a computer rebuild](https://support.microsoft.com/help/2667628).
## Symptoms

When you try to install a Microsoft SQL Server service pack or a cumulative update, you may encounter various error messages, and these may indicate Windows Installer Cache problems. The Windows Installer Cache, located in *c:\windows\installer* folder, stores important files for applications installed using the Windows Installer technology and should not be deleted. If the installer cache has been compromised, you may not immediately see problems until you perform an action such as uninstall, repair, or update SQL Server.

When you install SQL Server, the Windows Installer stores critical files in the Windows Installer Cache (default is *C:\Windows\Installer*). These files are required for uninstalling and updating applications. Missing files cannot be copied between computers, because they are unique.

Microsoft recommends that for SQL Server installations you first use the repair process that's described in the following articles to verify your current installation:

- [How to: Rebuild the Registry for SQL Server 2005](/previous-versions/sql/sql-server-2005/ms143727(v=sql.90))
- [How to: Repair a Failed SQL Server 2008 Installation](/previous-versions/sql/sql-server-2008/cc646006(v=sql.100))
- [How to: Repair a Failed SQL Server 2008 R2 Installation](/previous-versions/sql/sql-server-2008-r2/cc646006(v=sql.105))
- [How to: Repair a Failed SQL Server 2012 Installation](/previous-versions/sql/sql-server-2012/cc646006(v=sql.110))

You should run the repair from the original installation media, using the command line: `setup.exe/ACTION=REPAIR/INDICATEPROGRESS=TRUE`.

Repair the common shared components and features first, and then repeat the command to repair the instances installed. During the repair process, the setup dialog box disappears. As long as the progress window does not show an error, the repair process is proceeding as expected. If the installer cache file for a specific component is missing, then repair process will encounter an error.

## Cause

These problems may occur when the Windows Installer database file (.msi) or the Windows Installer patch file (.msp) is missing from the Windows Installer cache. The Windows Installer cache is located in the folder: *%windir%\installer*.

When a product is installed by using Windows Installer, a stripped version of the original .msi file is stored in the Windows Installer cache. Every update to the product such as a hotfix, a cumulative update, or a service pack setup, also stores the relevant .msp or .msi file in the Windows Installer cache.

Any future update to the product such as a hotfix, a cumulative update, or a service pack setup, relies on the information in the files that are stored in the Windows Installer cache. Without this information, the new update cannot perform the required transformations.

## Resolution

To resolve these problems, use one of the following procedures.

## Procedure 1.a.: Use the FixMissingMSI tool

In this procedure, you will use the FixMissingMSI tool to identify MSI and MSP files that are missing from the Windows Installer cache. As an additional step you can point the tool to the original media locations and recache the missing files.

You can download the FixMissingMSI tool from the [GitHub repository](https://github.com/suyouquan/SQLSetupTools/releases/).

For more information, please see [SQL Setup ToolSuite Introduction (1) -FixMissingMSI](/archive/blogs/psssql/sql-setup-toolsuite-introduction-1-fixmissingmsi).

## Procedure 1.b.: Use the FindSQLInstalls.vbs script

To complete the steps in this procedure, you have to copy the FindSQLInstalls.vbs script in the *FixMissingMSI* folder from the [GitHub repository](https://github.com/suyouquan/SQLSetupTools/tree/master/FixMissingMSI) to a local folder on the computer where you are trying to update your SQL Server installation.

> [!NOTE]
> The FindSQLInstalls.vbs script collects the information to correct invalid package paths. This script is used against the source locations to make sure that all MSP packages are in the Windows Installer cache directory. After executing the commands indicated in the Action needed lines in the script output file, the missing packages will be re-added if the original source media is available.

To resolve these problems by using a script, follow these steps:

1. Click [here](https://raw.githubusercontent.com/suyouquan/SQLSetupTools/master/FixMissingMSI/FindSQLInstalls.vbs) to go to the FindSQLInstalls.vbs raw page on GitHub.

2. Select all of the contents on this page, copy, and paste it to a text file. Save the text file as *FindSQLInstalls.vbs*.

3. Open an elevated command prompt to the directory to which you saved the **FindSQLInstalls.vbs** file, and run the command: `Cscript FindSQLInstalls.vbs %computername%_sql_install_details.txt`.

4. Open the file from step 2 in a text editor such as Notepad, and identify the problems that are causing the failure. To do this, search the text file for string patterns such as the following:

    - do not
    - !!!

5. Based on the results in step 3, take the steps that are required.

    > [!NOTE]
    > Look for more information about these steps in the [Examples](#examples) section.

6. Repeat steps 2 through 4 until the text file that is created in step 2 no longer contains text that references invalid paths or missing files for the component that is being updated.

## Examples

The following examples are entries and explanations of actions that are outlined in the output file that is generated when you run the FindSQLInstalls.vbs script.

## Example 1: Missing installer files

The following is an example of the output that is generated when you are missing an .msi package in the Windows Installer cache folder.

```console
================================================================================
PRODUCT NAME : Microsoft SQL Server 2008 Database Engine Services  
================================================================================
Product Code: {9FFAE13C-6160-4DD0-A67A-DAC5994F81BD}
Version : 10.2.4000.0
Most Current Install Date: 20110211
Target Install Location:
Registry Path: HKEY_CLASSES_ROOT\Installer\Products\C31EAFF906160DD46AA7AD5C99F418DB\SourceList
Package : sql_engine_core_inst.msi
Install Source: \x64\setup\sql_engine_core_inst_msi\
LastUsedSource: m;1;G:\x64\setup\sql_engine_core_inst_msi\
```

The LastUsedSource line points to the location that was used to run the Setup program.

In the LastUsedSource line, the **m;** entry signifies media and indicates that the original source is CD/DVD media.

In the following example, the source is a CD or a DVD in drive G. If the installation occurred from a file folder or from a network share, the LastUsedSource line begins with an **n;** entry, followed by a **Numeric_Data_Name;** entry, and then the actual path:

```console
!!!! sql_engine_core_inst.msi DOES NOT exist on the path in the path G:\x64\setup\sql_engine_core_inst_msi\ !!!!
Action needed, re-establish the path to G:\x64\setup\sql_engine_core_inst_msi\
```

The Action needed line shows you the full path that must exist in order to update missing files for the original installation media:

Installer Cache File: `C:\WINDOWS\Installer\19b4d2.msi`

The Installer Cache File line confirms the name of the installer cache file:

```console
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!!! C:\WINDOWS\Installer\19b4d2.msi DOES NOT exist in the Installer cache. !!!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

The following section of the output advises you of actions that are required to resolve the missing files:

> Action needed, recreate or re-establish path to the directory: G:\x64\setup\sql_engine_core_inst_msi\then rerun this script to update installer cache and results The path on the line above must exist at the root location to resolve this problem with your msi/msp file not being found or corrupted, In some cases you may need to manually copy the missing file or manually replace the problem file overwriting it is exist: Copy "G:\x64\setup\sql_engine_core_inst_msi\sql_engine_core_inst.msi" C:\WINDOWS\Installer\19b4d2.msi Replace the existing file if prompted to do so.

## Example 2: Missing patches

Missing patches may result in entries that resemble those in Example 1. Most of the time, you will notice entries in the Patch LastUsedSource line that reference a patch, and this line resembles: `Patch LastUsedSource: n;1;c:\0ca91e857a4f12dd390f0821a3\HotFixSQL\Files\`.

This output indicates the following about the patch installation:

- The original patch was installed by double-clicking the patch's executable file.
- The installer for the patch used a temp folder, `c:\0ca91e857a4f12dd390f0821a3`, during installation of the patch.
- To re-create the path, you must run the same executable and add the parameter: `/x:c:\0ca91e857a4f12dd390f0821a3`.

> [!NOTE]
> This command forces the executable to extract the files to the previous missing location, and this re-creates the structure that is required to update the Windows installer cache with any missing files. The actual location will vary, and a single patch such as a service pack may have to be extracted to multiple locations. Each installed product includes a section that contains the following information for Patches Installed:
>
> Display name:  
KB Article URL: `http://support.microsoft.com/?kbid=<value>`  
Patch LastUsedSource:

The KB Article URL line can help you download any patch media, if this is necessary.

## Procedure 2: Manually restore the files

To manually restore the files that are missing from the Windows Installer cache, follow these steps:

1. Collect the complete details about the missing file from the error message, from the setup log file, or from the registry entries that are maintained by the Windows Installer. For example, in Error Message 1 in the [Symptoms](#symptoms) section, all the information that is required to resolve the issue is present in the error message:

    - PatchName: "Hotfix 1702 for SQL Server 2008 R2 (KB981355) (64-bit)"
    - Original MSP file that is used by the Patch: sql_engine_core_inst.msp
    - Cached MSP file: `c:\Windows\Installer\1fdb1aec.msp`

1. If you do not have all the details, see the [Procedure 2: Manually restore the files](#procedure-2-manually-restore-the-files) section for the steps to collect these details.

1. Visit [Queries](https://support.microsoft.com), and search for the KB article that is associated with this patch. In this example, you must search for KB981355.

1. Download this patch package to your computer. Make sure that you download the patch package that corresponds to the required platform. In this example, the package is SQLServer2008R2-KB981355-x64.exe.

1. Extract the contents of the patch package by using the syntax: `C:\Temp>SQLServer2008R2-KB981355-x64.exe /x C:\Temp\SQLServer2008R2-KB981355-x64\`.

1. Locate the original msp file *sql_engine_core_inst.msp* file. The file should be in the following folder: `C:\Temp\SQLServer2008R2-KB981355-x64\x64\setup\sql_engine_core_inst_msi\`.

1. Copy this original msp file to the following Windows Installer cache: `%windir%\installer\`.

1. Rename the original msp file, *sql_engine_core_inst.msp*, to the name: cached msp file 1fdb1aec.msp.

You can start the Setup program for the update that resulted in the error and resume the update process. You may encounter this message for a missing Windows Installer cache file for another component or for another update of the same product.

To obtain a list of all the missing Windows Installer cache files that are related to the SQL Server product components, you can download the SQL Server 2008 R2 BPA tool that is mentioned in the [More Information](#more-information) section.

If the error message references a missing Windows Installer database file (.msi), you do not have to perform steps 2 through 4. Instead, you can go directly to step 5. You have to locate the .msi from the original media that you used to install the product. If this error message was generated for sql_engine_core_inst.msi, then you have to locate this file from the setup media under the folder structure: `\x64\setup\sql_engine_core_inst_msi\`. The other steps are the same.

## Find the patch package and the product details for a missing .msp file

Different versions of the product generate different error messages for this problem. The error messages that are mentioned in the [Symptoms](#symptoms) section appear for Setup programs for updates starting with SQL Server 2008 SP1. For other updates, you receive error messages that may not clearly specify which patch file is missing from the Windows Installer cache and the specific update details. For these error messages, the setup log files will contain information about the missing Windows Installer cache file. A sample setup log resembles the following:

> MSI (s) (FC:F8) [13:48:58:649]: Opening existing patch 'C:\WINDOWS\Installer\145258.msp'.  
MSI (s) (FC:F8) [13:48:58:649]: Couldn't find local patch 'C:\WINDOWS\Installer\145258.msp'. Looking for it at its source.  
MSI (s) (FC:F8) [13:48:58:649]: Resolving Patch source.  
MSI (s) (FC:F8) [13:48:58:649]: Note: 1: 2203 2: D:\cda162709d239766830bae5ce12b\HotFixSQL\Files\sqlrun_sql.msp 3: -2147287037  
MSI (s) (FC:F8) [13:48:58:649]: SOURCEMGMT: Source is invalid due to missing/inaccessible package.  
MSI (s) (FC:F8) [13:49:29:961]: Product: Microsoft SQL Server 2005 -- Installation failed.  
MSI (s) (FC:F8) [13:49:29:992]: MainEngineThread is returning 1635  
This patch package could not be opened. Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package. D:\SQL2K5\Servers\Setup\SqlRun_SQL.msi

If you examine this setup log carefully, it already gives you the information about the Original MSP file that was used by the patch: *sqlrun_sql.msp*.

To find more details about the missing .msp file in the Windows Installer cache, follow these steps:

1. Search for the missing .msp file in the following Windows Installer Patches registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Patches\`

2. Find the **Patch GUID**.

3. Search for the Patch GUID in the following Windows Installer Products registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\`

For the sample setup log, the information about the missing .msp file and its corresponding patch details are present in the following registry entries:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Patches\A3B085EA74A9A7640A496636F7EF9A44`

Value: 0

Name: LocalPackage

Data: `C:\WINDOWS\Installer\145258.msp`

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\1EB3A031CC585314E87AA527E46EECC2\Patches\A3B085EA74A9A7640A496636F7EF9A44`  

Value: 6

Name: DisplayName

Data: GDR 2050 for SQL Server Database Services 2005 ENU (KB932555)

Now you have all the information points to start the steps to resolve the missing files in the Windows Installer cache.

> [!NOTE]
> If you use SQL Server 2008 Service Pack 3 (SP3) or a later version, you can also receive a similar error message for the missing .msi files. By using this error message, you can quickly determine which file is missing, what service pack to download, and where you can find the download.

For more information about how to obtain the service pack, see [KB2546951 - List of issues that are fixed by SQL Server 2008 Service Pack 3](https://support.microsoft.com/help/2546951).

## Procedure 3: Restore from system state backups

You can restore from system state backups as described in [Missing Windows Installer cache requires a computer rebuild](/troubleshoot/windows-client/deployment/missing-windows-installer-cache).

## More information

> [!NOTE]
> The following error messages can be found as text messages in the event log or in the Setup logs that are located in one of the following folders, and they indicate that you should repair your affected instance being proceeding further:
>
> - For SQL Server 2008 and for SQL Server 2008 R2: `C:\Program Files\Microsoft SQL Server\100\Setup Bootstrap`
> - For SQL Server 2012: `C:\Program Files\Microsoft SQL Server\110\Setup Bootstrap`

- **For SQL 2005 (all branches)**

    |Product Version| Error Message when the Installer Package (MSI) is missing| Error Message when the Installer Cache Package (MSP) is missing |
    |---|---|---|
    |SQL Server 2005|1636 Unable to install Windows Installer MSI file<br/>|1636 Unable to install Windows Installer MSP file<br/>|
    ||||

    > [!NOTE]
    > You must review the setup log files to identify whether any cache files are missing. For more information about how to do this, go to the [Resolution](#resolution) section.

- **For SQL Server 2008 SP1**

    |Product Version| Error Message when the Installer Package (MSI) is missing| Error Message when the Installer Cache Package (MSP) is missing |
    |---|---|---|
    |SQL Server 2008 SP1|No error message|TITLE: SQL Server Setup failure.<br/>------------------------------<br/>SQL Server Setup has encountered the error: **The patch file cannot be opened. The file is: c:\WINNT\Installer\FileName.msp. Error code 0x84B20001.**<br/>------------------------------<br/>|
    ||||

- **For SQL Server 2008 SP3 build-only (CU/GDR branches are not applicable)**

    |Product Version| Error Message when the Installer Package (MSI) is missing| Error Message when the Installer Cache Package (MSP) is missing |
    |---|---|---|
    |SQL Server 2008 SP3|The cached MSI file `C:\Windows\Installer\FileName.msi` is missing. Its original file is `sql_engine_core_inst.msi` and it was installed for product SQL Server 2008 Database Engine Services from `NetworkPath`, version `VersionNumber`, language `ENU`.<br/>|The cached patch file `C:\Windows\Installer\FileName.msp` is missing. The original file for this cached file is `sql_engine_core_inst.msp`, which can be installed from Service Pack 3 for SQL Server 2008 (KB2546951) (64-bit), version `VersionNumber`<br/>|
    ||||

    > [!NOTE]
    > You receive the following error message when you perform an upgrade:  
    ![SQL Server error2](./media/restore-missing-windows-installer-cache-files/sql-server-error-image.jpg)

- **For SQL Server 2008 R2 SP1 only (CU/GDR branches are not applicable)**

    |Product Version| Error Message when the Installer Package (MSI) is missing| Error Message when the Installer Cache Package (MSP) is missing |
    |---|---|---|
    |SQL Server 2008 R2 SP1|TITLE: SQL Server Setup failure.<br/>------------------------------<br/>SQL Server Setup has encountered the following error: **C:\Windows\Installer\FileName.msi**.<br/>------------------------------<br/>|The cached patch file `C:\Windows\Installer\FileName.msp` is missing. The original file for this cached file is `sql_engine_core_inst_loc.msp`, which can be installed from Service Pack 1 for SQL Server 2008 R2 (KB2528583) (64-bit), version `VersionNumber`.<br/>|
    ||||

    > [!NOTE]
    > You receive the following error message when you perform an upgrade:
    ![SQL Server error](./media/restore-missing-windows-installer-cache-files/upgrade-error.jpg)

- **For SQL Server 2008 R2 SP2**

    |Product Version| Error Message when the Installer Package (MSI) is missing| Error Message when the Installer Cache Package (MSP) is missing |
    |---|---|---|
    |SQL Server 2008 R2 SP1|The cached MSI file `C:\Windows\Installer\FileName.msi` is missing. Its original file is *sql_engine_core_inst.msi* and it was installed for product SQL Server 2008 R2 SP1 Database Engine Services from `NetworkPath`, version `VersionNumber`, language `LanguageName`.<br/>|The cached patch file `C:\Windows\Installer\FileName.msp` is missing. The original file for this cached file is *sql_engine_core_inst_loc.msp*, which can be installed from Service Pack 1 for SQL Server 2008 R2 (KB2528583) (64-bit), version `VersionNumber`.<br/>|
    ||||

    > [!NOTE]
    > You receive the following error message when you perform an upgrade:
    ![SQL Server error3](./media/restore-missing-windows-installer-cache-files/upgrade-error.jpg)

- **For SQL Server 2012 prior to CU2**

    There is no message for missing MSP or MSI files. However, error code 1714 is logged in the Setup log.

    In the *Summary.txt* file: Component name: SQL Server Setup Support Files
    Component error code: 1714

    In the *Detail.txt* file:

    > Date/Time Slp: Sco: FileFilePath does not exist  
    Date/Time Slp: Sco: FileFilePathdoes not exist  
    Date/Time Slp: Checkpoint: PREINSTALL_SQLSUPPORT_CPU64_ACTION  
    Date/Time Slp: Sco: Attempting to create base registry key HKEY_LOCAL_MACHINE, machineServer Name
    Date/Time Slp: Sco: Attempting to open registry subkey    Software\Microsoft\Windows\CurrentVersion\Installer  
    Date/Time Slp: Sco: Attempting to get registry value InstallerLocation  
    Date/Time Slp: Windows installer version : 5.0.7601.17514  
    Date/Time Slp: Sco: Waiting for service 'msiserver' to accept the stop request.  
    Date/Time Slp: Sco: Attempting to open SC Manager  
    Date/Time Slp: Sco: Attempting to open service handle for service msiserver  
    Date/Time Slp: Invoking QueryServiceStatus Win32 API  
    Date/Time Slp: Sco: Attempting to close service handle for service msiserver  
    Date/Time Slp: Sco: Attempting to close SC Manager  
    Date/TimeSlp: Target package: "FilePath"  
    Date/TimeSlp: MSI Error: 1714 The older version of Microsoft SQL Server 2012 Setup (English) cannot be removed. Contact your technical support group.  
    Date/TimeSlp: InstallPackage: MsiInstallProduct returned the result code 1603.  
    Date/TimeSlp: Using MSI error code to detect the retry option: 1714  
    Date/TimeSlp: No retry-able MSI return code detected.

- **For SQL Server 2012 CU2 (and any subsequent CU or SP)**

    |Product Version| Error Message when the Installer Package (MSI) is missing| Error Message when the Installer Cache Package (MSP) is missing |
    |---|---|---|
    |SQL Server 2008 R2 SP1|The cached MSI file `C:\Windows\Installer\FileName.msi` is missing. Its original file is `C:\Windows\Installer\sql_FeatureName.msi` and it was installed for product Microsoft SQL ServerVersion from `C:\originalfolder`, version `VersionNumber`, language `Language`.<br/>|The cached patch file `c:\Windows\Installer\FileName.msp` is missing. Its original file is `sql_engine_core_inst.msp`, which can be installed from `Hotfix 2316 for SQL Server 2012 (KB2679368) (64-bit)`, version `VersionNumber`. The cached patch file `C:\Windows\Installer\FileName.msp` is missing. Its original file is `C:\Windows\Installer\sql_FeatureName.msp`, which can be installed from Hotfix \<HotfixNumber> for SQL Server 2012 KB Number, version `VersionNumber`.<br/>|
    ||||

    > [!NOTE]
    > Under certain conditions in SQL Server 2012, RTM media may not be registered correctly. When you uninstall a cumulative update or a service pack under those circumstances, setup may prompt you for RTM media. To work around this issue, provide the RTM media path during the patch removal process.

## References

- [Installer Database](/windows/win32/msi/installer-database)

- [Patch Packages](/windows/win32/msi/patch-packages)

- [GitHub repository](https://github.com/suyouquan/SQLSetupTools#fixmissingmsi-version-20)

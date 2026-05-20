---
title: Restore the missing Windows Installer cache files
description: Learn how to restore missing MSI and MSP files in the Windows Installer cache to fix SQL Server cumulative update and service pack installation errors.
ms.date: 05/20/2026
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: jopilov, v-sidong, v-shaywood
---
# Restore missing Windows Installer cache files and fix problems that occur during a SQL Server update

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 969052

## Summary

This article presents several solutions to missing-MSI errors that occur when you install Microsoft SQL Server updates. When the Windows Installer cache is missing MSI or MSP files for SQL Server, cumulative updates, service pack installations, repair operations, and uninstalls can fail. This article shows you how to identify the missing files, restore them from the original installation media or update packages, and fix the resulting SQL Server setup errors. The guidance applies to currently supported SQL Server releases (SQL Server 2016 and later) and to older versions where the same Windows Installer behavior applies.

> [!NOTE]
> The process described in this article provides emergency relief only, not a permanent fix. After you recover from the immediate problem, validate the Windows Installer cache by using the Windows Installer Cache Verifier Package as directed in [Restore missing Windows Installer cache files](~/windows-client/application-management/missing-windows-installer-cache.md).

## Symptoms

When you install a SQL Server service pack or cumulative update, you might see error messages or unexpected behaviors that point to Windows Installer cache problems. The *Windows Installer cache*, located in the `C:\Windows\Installer` folder, stores critical files for applications installed through Windows Installer. If the cache is compromised, such as by manual file deletion, you might not see a problem until you uninstall, repair, or update SQL Server.

### Error messages

Here are some possible error messages you might encounter. Typically, you see one of these outputs:

```output
SQL Server Setup has encountered the following error:

The cached MSI file 'C:\Windows\Installer\xxxxxx.msi' is missing. The original file is 'sql_xxxxx.msi' for product SQL Server 2017 Database Engine Services from 'D:\SQLSetup', version XXXX, language XXX. To resolve this problem, recover the missing file from the installation media and start setup again.
```

```output
The following error has occurred:

Unable to open Windows installer file 'C:\Windows\Installer\xxxxxx.msi'

Click 'Retry' to retry the failed action, or click 'Cancel' to cancel this action and continue setup.
```

```output
No valid sequence could be found for the set of updates. Error code 1648
```

```output
 The cached patch file "C:\Windows\Installer\xxxxxxx.msp" is missing. The original file for this cached file is "xxx_xxxx_xxxxxx.msp", which can be installed from "Hotfix xxxxx for SQL Server 20xx (KBxxxxxx) (64-bit)",
```

If you examine the *Detail.txt* setup log, you might find messages like the following ones:

```output
Slp: Package ID sql_xxx_xxx_xxx: NotInstalled
Slp: Sco: File 'X:\x64\setup\x64\xxx_xxx_xxx.msi' does not exist
Slp: Sco: File 'X:\x64\setup\x64\xxx_xxx_xxx.msi' does not exist
```

If you examine the component setup log, you might find errors like the following ones, where OS error `3` (or `-2147287038`) means `%1 could not be found.`

```output
MSI (s)  Note: 1: 2203 2: I:\xxxxxxx.msi 3: -2147287038
MSI (s)  Source is incorrect. Unable to open or validate MSI package I:\xxxxxxx.msi.
MSI (s)  Note: 1: 2203 2: H:\xxxxxxx.msi 3: -2147287038
MSI (s)  Source is incorrect. Unable to open or validate MSI package H:\xxxxxxx.msi.
MSI (s)  Note: 1: 2203 2: I:\xxxxxxx.msi 3: -2147287038
MSI (s)  Source is incorrect. Unable to open or validate MSI package I:\xxxxxxx.msi.
```

### Unexpected behaviors

You might observe one of the following behaviors as a symptom:

- You might notice that a particular feature that you want to upgrade doesn't appear in the upgrade wizard.
- You attempt to perform an upgrade (including the edition upgrade), but no change occurs.

## Cause

These problems occur when a Windows Installer database file (`.msi`) or a Windows Installer patch file (`.msp`) is missing from the Windows Installer cache at `%windir%\Installer`.

When you install a product by using Windows Installer, the process stores a stripped version of the original `.msi` file in the cache. Every product update, like a hotfix, cumulative update, or service pack, also stores the relevant `.msp` or `.msi` file in the cache.

Any future update to the product relies on the information in the cached files. Without it, the new update can't do the required transformations.

Because SQL Server uses Windows Installer, this issue affects SQL Server too. SQL Server installation packages, which can include `.msi` and `.msp` files, are stored in the Windows Installer cache and are required for uninstall and update operations. The cached files are unique to each computer and you can't copy them from another computer.

> [!WARNING]
> Windows automatically manages the Installer cache directory (`%windir%\Installer`) when applications install and update packages. Manual changes in this directory can cause problems, including the ones described in this article.

## Repair the SQL Server installation

Before you try the other solutions in this article, use the repair process to check your current installation:

- [Repair a failed SQL Server installation](/sql/database-engine/install-windows/repair-a-failed-sql-server-installation) (SQL Server 2016 and later)

For previous versions:

- [Repair a failed SQL Server 2008 installation](/previous-versions/sql/sql-server-2008/cc646006(v=sql.100))
- [Repair a failed SQL Server 2008 R2 installation](/previous-versions/sql/sql-server-2008-r2/cc646006(v=sql.105))
- [Repair a failed SQL Server 2012 installation](/previous-versions/sql/sql-server-2012/cc646006(v=sql.110))

Run the repair from the original installation media by using the following command:

```console
setup.exe /ACTION=REPAIR /INDICATEPROGRESS=TRUE
```

Repair the common shared components and features first, and then repeat the command to repair the installed instances. During the process, the setup dialog box disappears. As long as the progress window doesn't show an error, the repair is running as expected. If the cache file for a specific component is missing, the repair fails with an error.

## Use the FixMissingMSI tool

The FixMissingMSI tool scans the Windows Installer cache, reports missing MSI and MSP files, and can recache them from the original media location in one step.

### Download the tool

Download the FixMissingMSI tool from the [SQLSetupTools releases page on GitHub](https://github.com/suyouquan/SQLSetupTools/releases/).

### Use the tool

FixMissingMSI is a graphical user interface (GUI) tool that helps you find and fix missing MSI and MSP files quickly. To use it, follow these steps:

1. Prepare or locate the installation media for each SQL Server version you need to fix.
1. Download and extract the media locally on the computer that's missing MSI or MSP files. Use separate folders for RTM, service packs, and cumulative updates. For example:

   ```output
   c:\sqlsetup\RTM2017
   c:\sqlsetup\CU31
   ```

   1. If you downloaded a cumulative update or service pack, be sure to extract it to a folder by using the `/X` option. For example:

      ```console
      SQLServer2016SP3-KB5003279-x64-ENU.exe /X
      ```

   1. Choose a directory where to extract the file, such as `c:\sqlsetup\SQL2016SP3`.

1. Open `FixMissingMSI.exe`.
1. In the **Scan** dialog, enter the folder where you downloaded the setup files in step 2 (for example, `D:\sqlsetup\RTM2017`) in the top text box.
1. In **Scan Filter**, keep the default **Product name contains: SQL**.
1. Select **Scan Now**.
1. Any rows whose **Status** column shows **Missing** are highlighted in red.
1. To fix a single file, select the **Fix It** button at the start of its row.

   :::image type="content" source="media/restore-missing-windows-installer-cache-files/fix-missing-msi-tool.png" alt-text="Screenshot of the FixMissingMSI tool.":::

1. To fix every missing MSI or MSP, select the **Fix** menu, and then select **Fix All**.

FixMissingMSI also works for non-SQL Server products, so you can use the same tool to fix Windows Installer cache problems for other applications on the computer.

## Use the FindSQLInstalls.vbs script

Before you start, copy the `FindSQLInstalls.vbs` script from the `FixMissingMSI` folder in the [SQLSetupTools GitHub repository](https://github.com/suyouquan/SQLSetupTools/tree/master/FixMissingMSI) to a local folder on the computer where you're updating SQL Server.

> [!NOTE]
> The `FindSQLInstalls.vbs` script collects package information and identifies invalid package paths. It runs against the source locations to confirm that all MSP packages are in the Windows Installer cache directory. After you run the commands shown on the `Action needed` lines in the script output, the missing packages are re-added if the original source media is available.

To fix the problem by using the script, do the following steps:

1. Go to the [FindSQLInstalls.vbs raw file on GitHub](https://raw.githubusercontent.com/suyouquan/SQLSetupTools/master/FixMissingMSI/FindSQLInstalls.vbs).
1. Copy all the contents on the page to a new text file.
1. Save the text file as `FindSQLInstalls.vbs`.
1. Open an elevated Command Prompt in the directory where you saved `FindSQLInstalls.vbs`, and then run the script.

   ```console
   Cscript FindSQLInstalls.vbs %computername%_sql_install_details.txt
   ```

1. Open the output file in a text editor like Notepad, and find the problems that caused the failure. Search the text file for the following string patterns:

    - `do not`
    - `!!!`

1. Based on the results, take the required actions.

    > [!NOTE]
    > For more information about these steps, see the [FindSQLInstalls.vbs examples](#findsqlinstallsvbs-examples) section.

1. Repeat steps 2 through 4 until the output file no longer references invalid paths or missing files for the component you're changing.

### FindSQLInstalls.vbs examples

The following examples show entries and explanations of actions outlined in the output file that's generated when you run the `FindSQLInstalls.vbs` script.

#### Missing installer files

The following example shows the output you get when an `.msi` package is missing from the Windows Installer cache folder.

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

The `LastUsedSource` line points to the location that was used to run the Setup program.

In the `LastUsedSource` line, the `m;` entry signifies media and indicates that the original source is CD/DVD media.

In the following example, the source is a CD or a DVD in drive G. If the installation occurred from a file folder or a network share, the `LastUsedSource` line begins with an `n;` entry, followed by a `Numeric_Data_Name;` entry, and then the actual path:

```console
!!!! sql_engine_core_inst.msi DOES NOT exist on the path in the path G:\x64\setup\sql_engine_core_inst_msi\ !!!!
Action needed, re-establish the path to G:\x64\setup\sql_engine_core_inst_msi\
```

The `Action needed` line shows you the full path that must exist in order to update missing files for the original installation media:

Installer Cache File: *C:\WINDOWS\Installer\19b4d2.msi*

The `Installer Cache File` line confirms the name of the installer cache file:

```console
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!!! C:\WINDOWS\Installer\19b4d2.msi DOES NOT exist in the Installer cache. !!!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

The following section of the output shows the actions required to fix the missing files:

> Action needed, recreate or re-establish path to the directory: G:\x64\setup\sql_engine_core_inst_msi\then rerun this script to update installer cache and results The path on the line above must exist at the root location to resolve this problem with your msi/msp file not being found or corrupted, In some cases you may need to manually copy the missing file or manually replace the problem file overwriting it is exist: Copy "G:\x64\setup\sql_engine_core_inst_msi\sql_engine_core_inst.msi" C:\WINDOWS\Installer\19b4d2.msi Replace the existing file if prompted to do so.

#### Missing patches

Missing patches produce entries similar to those in the previous example. Most of the time, you see entries on the `Patch LastUsedSource` line that reference a patch, like `Patch LastUsedSource: n;1;c:\0ca91e857a4f12dd390f0821a3\HotFixSQL\Files\`.

This output tells you the following about the patch installation:

- The original patch was installed by double-clicking the patch's executable file.
- The patch installer used a temp folder, `c:\0ca91e857a4f12dd390f0821a3`, during installation.
- To re-create the path, run the same executable and add the parameter `/x:c:\0ca91e857a4f12dd390f0821a3`.

This command forces the executable to extract the files to the previous missing location, and this re-creates the structure that is required to update the Windows installer cache with any missing files. The actual location varies, and a single patch, such as a service pack, might need to be extracted to multiple locations. Each installed product includes a section that contains the following information for patches installed:

- Display name:
- KB Article URL: `http://support.microsoft.com/?kbid=<value>`
- Patch LastUsedSource:

The KB Article URL line helps you download the patch media if needed.

## Manually restore the files

To manually restore files that are missing from the Windows Installer cache, complete the following steps:

1. Collect the full details about the missing file from the error message, the setup log file, or the registry entries that Windows Installer maintains. For example, the first error message in the [Symptoms](#symptoms) section already contains everything you need to fix the issue:

    - PatchName: "Hotfix 1702 for SQL Server 2008 R2 (KB981355) (64-bit)"  
    - Original MSP file that the patch uses: _sql_engine_core_inst.msp_  
    - Cached MSP file: *c:\Windows\Installer\1fdb1aec.msp*

1. If you don't have all the details, see the first step to collect them.
1. Go to [Microsoft Support](https://support.microsoft.com) and search for the KB article associated with this patch. In this example, search for *KB981355*.
1. Download the patch package to your computer. Make sure you download the package that matches the required platform. In this example, the package is `SQLServer2008R2-KB981355-x64.exe`.
1. Extract the contents of the patch package by using the syntax:

   ```console
   C:\Temp>SQLServer2008R2-KB981355-x64.exe /x C:\Temp\SQLServer2008R2-KB981355-x64\
   ```

1. Find the original MSP file, `sql_engine_core_inst.msp`. It should be in the following folder:

    `C:\Temp\SQLServer2008R2-KB981355-x64\x64\setup\sql_engine_core_inst_msi\`

1. Copy the original MSP file to the Windows Installer cache:

    `%windir%\Installer\`

1. Rename the original MSP file, `sql_engine_core_inst.msp`, to the cached MSP file name, `1fdb1aec.msp`.

Start the Setup program for the update that triggered the error, and resume the update. You might see this message again for a missing cache file for another component or another update of the same product.

If the error message references a missing Windows Installer database file (`.msi`), you don't need to do steps 2 through 4. Go straight to step 5. You have to find the `.msi` on the original media you used to install the product. For example, if the error was for `sql_engine_core_inst.msi`, find this file on the setup media under `\x64\setup\sql_engine_core_inst_msi\`. The other steps are the same.

### Find the patch package and product details for a missing .msp file

Different versions of the product produce different error messages for this problem. The error messages in the [Symptoms](#symptoms) section appear for updates starting with SQL Server 2008 SP1. Other updates can return error messages that don't clearly identify which patch file is missing or the specific update details. In those cases, the setup log files contain information about the missing Windows Installer cache file. Here's a sample setup log:

```output
MSI (s) (FC:F8) [13:48:58:649]: Opening existing patch 'C:\WINDOWS\Installer\145258.msp'.  
MSI (s) (FC:F8) [13:48:58:649]: Couldn't find local patch 'C:\WINDOWS\Installer\145258.msp'. Looking for it at its source.  
MSI (s) (FC:F8) [13:48:58:649]: Resolving Patch source.  
MSI (s) (FC:F8) [13:48:58:649]: Note: 1: 2203 2: D:\cda162709d239766830bae5ce12b\HotFixSQL\Files\sqlrun_sql.msp 3: -2147287037  
MSI (s) (FC:F8) [13:48:58:649]: SOURCEMGMT: Source is invalid due to missing/inaccessible package.  
MSI (s) (FC:F8) [13:49:29:961]: Product: Microsoft SQL Server 2005 -- Installation failed.  
MSI (s) (FC:F8) [13:49:29:992]: MainEngineThread is returning 1635  
This patch package could not be opened. Verify that the patch package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer patch package. D:\SQL2K5\Servers\Setup\SqlRun_SQL.msi
```

If you read the setup log carefully, it already tells you which original MSP file the patch used: `sqlrun_sql.msp`.

To find more details about the missing `.msp` file in the Windows Installer cache, do the following:

1. Search for the missing *.msp* file in the Windows Installer Patches registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Patches\`.
1. Find the **Patch GUID**.
1. Search for the Patch GUID in the Windows Installer Products registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\`.

   For the sample setup log, the missing *.msp* file and its corresponding patch details are displayed in the following registry entries:

   ```output
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Patches\A3B085EA74A9A7640A496636F7EF9A44
   Value: 0
   Name: LocalPackage
   Data: `C:\WINDOWS\Installer\145258.msp
   ```

   ```output
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\1EB3A031CC585314E87AA527E46EECC2\Patches\A3B085EA74A9A7640A496636F7EF9A44
   Value: 6
   Name: DisplayName
   Data: GDR 2050 for SQL Server Database Services 2005 ENU (KB932555)
   ```

1. You now have the information you need to fix the missing files in the Windows Installer cache.

   > [!NOTE]
   > On SQL Server 2008 SP3 and later versions, you can also get a similar error message for missing `.msi` files. The message tells you which file is missing, which service pack to download, and where to find the download.

For more information about how to get the service pack, see [KB2546951 - List of issues fixed by SQL Server 2008 Service Pack 3](https://support.microsoft.com/help/2546951).

## Restore from system state backups

If the previous solutions don't work, restore the Windows Installer cache from a system state backup. For step-by-step guidance, see [Missing Windows Installer cache requires a computer rebuild](../../../../windows-client/deployment/missing-windows-installer-cache.md).

## Troubleshooting tips

- Always work from a copy of the original installation media. Extract cumulative updates and service packs by using the `/X` option before you point tools at them.
- Run Command Prompt and PowerShell sessions as administrator. Tools that scan the `%windir%\Installer` folder or rewrite cached files need elevated permissions.
- After you restore missing files, run the SQL Server setup repair again before retrying the update, so the cache is validated end to end.
- If repeated cache corruption occurs on the same computer, check for third-party cleanup tools, group policies, or backup agents that prune the `C:\Windows\Installer` folder.
- For complex mult-instance servers, or if cache problems persist after you try every solution in this article, open a support case with Microsoft so engineering can review the setup logs.

## Error messages by SQL Server version

The following error messages appear as text messages in the event log or in the setup logs in one of the following folders. They indicate that you should repair the affected instance before going further:

- For SQL Server 2008 and SQL Server 2008 R2: `C:\Program Files\Microsoft SQL Server\100\Setup Bootstrap`
- For SQL Server 2012: `C:\Program Files\Microsoft SQL Server\110\Setup Bootstrap`
- For SQL Server 2016 and later: `C:\Program Files\Microsoft SQL Server\<nnn>\Setup Bootstrap\Log`, where `<nnn>` is `130` for SQL Server 2016, `140` for SQL Server 2017, `150` for SQL Server 2019, and `160` for SQL Server 2022.

### SQL Server 2005 (all branches)

- **Installer package (MSI) missing**:

  > 1636 Unable to install Windows Installer MSI file

- **Installer cache package (MSP) missing**:

  > 1636 Unable to install Windows Installer MSP file

> [!NOTE]
> Review the setup log files to find out whether any cache files are missing. For more information, see the [Repair the SQL Server installation](#repair-the-sql-server-installation) section.

### SQL Server 2008 SP1

- **Installer package (MSI) missing**: No error message.
- **Installer cache package (MSP) missing**:

  > TITLE: SQL Server Setup failure.
  >
  > SQL Server Setup has encountered the error: **The patch file cannot be opened. The file is: c:\WINNT\Installer\FileName.msp. Error code 0x84B20001.**

### SQL Server 2008 SP3 build-only (CU/GDR branches aren't applicable)

- **Installer package (MSI) missing**:

  > The cached MSI file *C:\Windows\Installer\FileName.msi* is missing. Its original file is *sql_engine_core_inst.msi* and it was installed for product SQL Server 2008 Database Engine Services from \<NetworkPath\>, version \<VersionNumber\>, language \<ENU\>.

- **Installer cache package (MSP) missing**:

  > The cached patch file *C:\Windows\Installer\FileName.msp* is missing. The original file for this cached file is *sql_engine_core_inst.msp*, which can be installed from Service Pack 3 for SQL Server 2008 (KB2546951) (64-bit), version \<VersionNumber\>.

> [!NOTE]
> You receive the following error message when you perform an upgrade:  
:::image type="content" source="media/restore-missing-windows-installer-cache-files/2008-setup-stopped-working.png" alt-text="Screenshot of the error message: SQL Server 2008 Setup has stopped working." border="false":::

### SQL Server 2008 R2 SP1 only (CU/GDR branches aren't applicable)

- **Installer package (MSI) missing**:

  > TITLE: SQL Server Setup failure.
  >
  > SQL Server Setup has encountered the following error: **C:\Windows\Installer\FileName.msi**.

- **Installer cache package (MSP) missing**:

  > The cached patch file *C:\Windows\Installer\FileName.msp* is missing. The original file for this cached file is *sql_engine_core_inst_loc.msp*, which can be installed from Service Pack 1 for SQL Server 2008 R2 (KB2528583) (64-bit), version \<VersionNumber\>.

> [!NOTE]
> You receive the following error message when you perform an upgrade:
:::image type="content" source="media/restore-missing-windows-installer-cache-files/2008-r2-setup-stopped-working.png" alt-text="Screenshot of the error message: SQL Server 2008 R2 Setup has stopped working." border="false":::

### SQL Server 2008 R2 SP2

- **Installer package (MSI) missing**:

  > The cached MSI file *C:\Windows\Installer\FileName.msi* is missing. Its original file is _sql_engine_core_inst.msi_ and it was installed for product SQL Server 2008 R2 SP1 Database Engine Services from \<NetworkPath\>, version \<VersionNumber\>, language \<LanguageName\>.

- **Installer cache package (MSP) missing**:

  > The cached patch file *C:\Windows\Installer\FileName.msp* is missing. The original file for this cached file is _sql_engine_core_inst_loc.msp_, which can be installed from Service Pack 1 for SQL Server 2008 R2 (KB2528583) (64-bit), version \<VersionNumber\>.

> [!NOTE]
> You receive the following error message when you perform an upgrade:
:::image type="content" source="media/restore-missing-windows-installer-cache-files/2008-r2-setup-stopped-working.png" alt-text="Screenshot of the error message for SP2: SQL Server 2008 R2 Setup has stopped working." border="false":::

### SQL Server 2012 prior to CU2

The setup doesn't show a message for missing MSP or MSI files. However, it logs error code 1714 in the Setup log.

In the _Summary.txt_ file:

```output
Component name: SQL Server Setup Support Files
Component error code: 1714
```

In the _Detail.txt_ file:

```output
Date/Time Slp: Sco: FileFilePath does not exist  
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
```

### SQL Server 2012 CU2 (and any subsequent CU or SP)

- **Installer package (MSI) missing**:

  > The cached MSI file *C:\Windows\Installer\FileName.msi* is missing. Its original file is *C:\Windows\Installer\sql_FeatureName.msi* and it was installed for product Microsoft SQL ServerVersion from *C:\originalfolder*, version \<VersionNumber\>, language \<Language\>.

- **Installer cache package (MSP) missing**:

  > The cached patch file *c:\Windows\Installer\FileName.msp* is missing. Its original file is *sql_engine_core_inst.msp*, which can be installed from `Hotfix 2316 for SQL Server 2012 (KB2679368) (64-bit)`, version \<VersionNumber\>. The cached patch file *C:\Windows\Installer\FileName.msp* is missing. Its original file is *C:\Windows\Installer\sql_FeatureName.msp*, which can be installed from Hotfix \<HotfixNumber\> for SQL Server 2012 KB Number, version \<VersionNumber\>.

> [!NOTE]
> Under certain conditions in SQL Server 2012, RTM media isn't registered correctly. When you uninstall a cumulative update or service pack, setup might prompt you for RTM media. To work around this issue, provide the RTM media path during the patch removal process.

## Related content

- [Installer database](/windows/win32/msi/installer-database)
- [Patch packages](/windows/win32/msi/patch-packages)
- [SQLSetupTools GitHub repository](https://github.com/suyouquan/SQLSetupTools#fixmissingmsi-version-20)

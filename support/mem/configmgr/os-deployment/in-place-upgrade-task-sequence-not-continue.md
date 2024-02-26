---
title: A Configuration Manager in-place upgrade task sequence doesn't continue
description: Fixes an issue in which a Configuration Manager in-place upgrade task sequence doesn't continue after a Windows 10 in-place upgrade rollback, and errors are logged. 
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# A Configuration Manager in-place upgrade task sequence doesn't continue after a Windows 10 in-place upgrade rollback

This article helps you fix an issue in which a Configuration Manager in-place upgrade task sequence doesn't continue after a Windows 10 in-place upgrade rollback.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1902), Configuration Manager (current branch - version 1810)  
_Original KB number:_ &nbsp; 4550023

## Symptoms

When a Windows 10 in-place upgrade rollback occurs during a Configuration Manager in-place upgrade task sequence, the task sequence doesn't continue after the rollback finishes. In this scenario, you notice the following issues when you examine log files on an affected device:

- If you use Configuration Manager current branch version 1902 or an earlier version, and the `/postrollbackcontext system` option isn't manually specified:
  
  - The `C:\$Windows.~BT\Sources\Rollback\setupact.log` file shows that the SetupRollback.cmd script was started by Windows Setup after the rollback finished:

    > MOUPG      SetupManager::ExecuteRollbackScripts: Running rollback script: [C:\\$WINDOWS.~BT\Sources\Scripts\setuprollback.cmd]  
    > MOUPG      SetupManager::ExecuteRollbackScripts: Rollback script [C:\\$WINDOWS.~BT\Sources\Scripts\setuprollback.cmd] returned: [0x0]

  - The SetupRollback.cmd script is responsible for resuming the task sequence after the rollback finishes. The `C:\Windows\SetupRollback.log` file shows that the SetupRollback.cmd script did resume the task sequence. However, the task sequence later exited and returned error code -2147024891:

    > \<Day> \<Date>-\<Time> Entering setuprollback.cmd  
    > \<Day> \<Date>-\<Time> Setting env var _SMSTSSetupRollback=TRUE  
    > \<Day> \<Date>-\<Time> Setting registry to resume task sequence after reboot  
    > \<Day> \<Date>-\<Time> Running C:\WINDOWS\CCM\\\TSMBootstrap.exe to resume task sequence  
    > \...  
    > \<Day> \<Date>-\<Time> **ERRORLEVEL = -2147024891**  
    > \<Day> \<Date>-\<Time> TSMBootstrap did not request reboot, resetting registry  
    > \<Day> \<Date>-\<Time> Exiting setuprollback.cmd

    Error code -2147024891 means **Access Denied**.

  - The Smsts.log file logs the following error message at around the same time that the SetupRollback.log file shows that the task sequence exited:

    > TSManager    Error Task Sequence Manager failed to execute task sequence. Code **0x80070005**  
  
    Error code 80070005 also means **Access Denied**.

    The Smsts.log file may also contain the following additional entries that include error code 80070005:

    > TSManager    g_TSManager.Run(), HRESULT=80070005  
    > TSManager    hMap != 0, HRESULT=80070005  
    > TSManager    m_pGlobalScope->open(), HRESULT=80070005
    >
    > TSManager    hMap != 0, HRESULT=80070005  
    > TSManager    m_pGlobalScope->open(), HRESULT=80070005  
    > TSManager    this->open(), HRESULT=80070005  
    > TSManager    sMp.empty()==false, HRESULT=80004005

    The log entries that contain error code 80070005 may be repeated in Smsts.log.

  - Not all previous log entries occurred as soon as the rollback finished. Instead, the entries occurred when someone first logged in to the device after the rollback finished.
  
  - The Smsts.log file shows that the `/postrollbackcontext system` option wasn't used in the Windows Setup command line that's used to start the in-place upgrade by the task sequence:

    > OSDUpgradeWindows    Executing command line: "C:\\_SMSTaskSequence\Packages\\<Package_ID>\SETUP.EXE" /ImageIndex 3 /auto Upgrade /quiet /noreboot /postoobe "C:\WINDOWS\SMSTSPostUpgrade\SetupComplete.cmd" /postrollback "C:\WINDOWS\SMSTSPostUpgrade\SetupRollback.cmd" /DynamicUpdate Disable with options (0, 0)

- If you deploy Windows 10, version 1903 or 1809, and the `/postrollbackcontext system` option is specified manually (in Configuration Manager current branch version 1902 or an earlier version) or automatically (in Configuration Manager current branch version 1906 or a later version):

  - The Smsts.log file shows that the Windows Setup command line contains the `/postrollbackcontext system` option:

    > OSDUpgradeWindows    Executing command line: "C:\\_SMSTaskSequence\Packages\\<Package_ID>\SETUP.EXE" /ImageIndex 3 /auto Upgrade /quiet /noreboot /postoobe "C:\WINDOWS\SMSTSPostUpgrade\SetupComplete.cmd" /postrollback "C:\WINDOWS\SMSTSPostUpgrade\SetupRollback.cmd" /DynamicUpdate Disable **/postrollbackcontext system** with options (0, 0)

    However, the last log entries in Smsts.log are from the timeframe before the rollback occurred. There are no log entries from the timeframe after the rollback finished.

  - The `C:\$WINDOWS.~BT\Sources\Rollback\setupact.log` file contains no entries that indicate that the SetupRollback.cmd script was ever started.
  - The `C:\Windows\SetupRollback.log` file doesn't exist.

## Cause

This issue occurs for the following reasons:

- A task sequence is resumed after a rollback through the SetupRollback.cmd script that's initiated by the `/PostRollback` option of Windows 10 Setup. However, in Windows 10 versions earlier than 1803, the script runs only when the first user logs on post-upgrade and runs by using the rights of the first logged-in user. This behavior causes the following problems:
  
  - The task sequence won't automatically continue as soon as the rollback finishes. It continues only when a user tries to log on.
  - Task sequences must run in system context to work correctly. When a task sequence continues after a user logs on, it runs in user context instead of system context. Even if the user has administrator rights, the task sequence fails and returns an **Access Denied** error message.

- The `/PostRollbackContext` option is available in Windows 10, version 1803 and later versions. This option allows you to specify whether the SetupRollback.cmd script runs in the context of the System account or the account of the signed in user. When the `/postrollbackcontext` option is set to **system**, the SetupRollback.cmd script runs as soon as the rollback finishes without waiting for a user to log on, and it runs in the context of the System account.

    However, the `/postrollbackcontext system` option isn't automatically added to the Windows Setup command line in Configuration Manager current branch version 1902 or an earlier version. If you don't manually add the `/postrollbackcontext system` option, the SetupRollback.cmd script still runs in user context even if your Windows 10 version is 1803 or a later version.

- An issue in Windows 10, version 1903 and 1809 prevents the `/postrollbackcontext system` option from working. In these two versions of Windows 10, the SetupRollback.cmd script never runs if the `/postrollbackcontext system` option is specified.

## Resolution

To fix the issue, update to the following versions of Configuration Manager and Windows 10:

- Configuration Manager current branch, version 1906 or a later version
- Windows 10, version 1909 or a later version

To fix the issue without updating to Configuration Manager current branch version 1906 and Windows 10 version 1909, follow these steps:

1. If your Windows 10 version is earlier than 1803, update to Windows 10 version 1803 or a later version. Because the SetupRollback.cmd script can't run in system context in Windows 10 versions earlier than 1803, it's not possible to start and continue a Configuration Manager task sequence correctly after an in-place upgrade rollback occurs.

2. If you use Configuration Manager current branch version 1902 or an earlier version, add the `/postrollbackcontext system` option to the Windows Setup command line through the task sequence variable `OSDSetupAdditionalUpgradeOptions`. To do this, add a **Set Task Sequence Variable** step before the **Upgrade Operating System** step, set the task sequence variable to `OSDSetupAdditionalUpgradeOptions`, and then set the value to `/postrollbackcontext system`.

    > [!NOTE]
    > Starting in Configuration Manager current branch version 1906, the `/postrollbackcontext system` option is automatically added during the **Upgrade Operating System** step. After you update to Configuration Manager current branch version 1906 or a later version, remove the **Set Task Sequence Variable** step that sets the `OSDSetupAdditionalUpgradeOptions` variable to `/postrollbackcontext system`.

3. If your Windows 10 version is 1903 or 1809, update the Windows Setup source files by using one of the following methods:

   - In the **Upgrade Operating System** step of the task sequence, select
 **Dynamically update Windows Setup with Windows Update** and **Override policy and use default Microsoft Update**. These options enable the setup to do dynamic update operations, such as download and apply updates to the Windows Setup source files during the **Upgrade Operating System** step.

     > [!NOTE]
     > This method requires that clients have Internet access to the public Microsoft Update site during the task sequence.

   - Download the updated ISO files of Windows 10, version 1903 or 1809 that are dated August 2019 or later. After you download the ISO files, update the **Operating System Upgrade Package**. To do this, delete all files in the package source location, mount the updated ISO files, copy the files from the mounted ISO to the package source location, and then update the package files on distribution points by using the **Update Distribution Points** action.

   - Download the dynamic update for Windows 10, version 1903 or 1809 that's dated August 2019 or later from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/). After you download the dynamic update, extract the content from the CAB file and copy the extracted files to the **Sources** folder of the **Operating System Upgrade Package** to overwrite existing files. Then. update the package files on distribution points by using the **Update Distribution Points** action.

## References

- [Windows Setup Command-Line Options - /PostRollback](/windows-hardware/manufacture/desktop/windows-setup-command-line-options#postrollback)
- [Task sequence variable - OSDSetupAdditionalUpgradeOptions](/mem/configmgr/osd/understand/task-sequence-variables#OSDSetupAdditionalUpgradeOptions)

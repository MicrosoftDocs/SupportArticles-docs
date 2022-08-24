---
title: Management Reporter 2012 WCF diagnostic
description: Describes the MR 2012 WCF diagnostic that enables WCF tracing and message logging.
ms.reviewer: kellybj, kevogt
ms.date: 03/31/2021
---
# [SDP 3][9ebe9abd-0960-4165-9074-7873262746bf] MR 2012 WCF diagnostic

The Management Reporter (MR) 2012 WCF diagnostic gives you the choices to enable WCF tracing and message logging on the MR 2012 Services, Report Designer, and MR Configuration Console. When you run the diagnostic, it prompts you to recreate the issue that you want the diagnostic to log. After you recreate the issue, follow the instructions in the diagnostic to upload the log files that the diagnostic generates.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2711140

## More information

The MR 2012 WCF diagnostic creates two log files each MR component you choose to enable logging on. If you exit the diagnostic while WCF logging is running, WCF logging continues to run, and the log files continue to grow. In this situation, the log files may use a large amount of hard disk space.

### How to disable WCF logging

If you exit the diagnostic before it is finished, you must disable WCF logging.

To manually revert to the MR 2012 Services .config backup file, follow these steps:

1. Open the MR Services directory that contains the MRServiceHost.exe.config file.
2. The name of the .config backup file resembles the following:

    MRServiceHost.exe.configBackup **XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX**

    Rename MRServiceHost.exe.config as MRServiceHost.exe.configTRACE, and then rename the backup file to MRServiceHost.exe.config.

3. Restart MR 2012 Services from the MR Configuration Console.

To manually revert to the ReportDesigner .config backup file, follow these steps:

1. Open the Report Designer directory that contains the ReportDesiger.exe.config file.

2. The name of the .config backup file resembles the following:

    ReportDesigner.exe.configBackup **XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX**

    Rename the existing ReportDesigner.exe.config as ReportDesigner.exe.configTRACE, and then rename the backup file as ReportDesigner.exe.config.

3. Restart Report Designer.

To manually revert to the MRConfigurationConsole .config backup file, follow these steps:

1. Open the MR Configuration Console directory that contains the MRConfigurationConsole.exe.config file.
2. The name of the .config backup file resembles the following:

    MRConfigurationConsole.exe.configBackupXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

3. Rename the existing MRConfigurationConsole.exe.config as MRConfigurationConsole.exe.configTRACE, and then rename the backup file as MRConfigurationConsole.exe.config.

4. Restart the MR Configuration Console.

To troubleshoot this diagnostic, you can review the results in the ResultReport.xml file.

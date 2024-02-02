---
title: Setup stops responding when you upgrade
description: This article provides a resolution for the problem that occurs when you upgrade a SQL instance from one major version to another.
ms.date: 09/25/2020
ms.custom: sap:Installation, Patching and Upgrade
---
# Setup stops responding when you try to upgrade SQL Server to a different version

This article helps you resolve the problem that occurs when you upgrade an earlier version of SQL Server to SQL Server 2012.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2712929

## Symptoms

When you try to upgrade a SQL Server from one major version to another major version (for example, upgrading from SQL Server 2012 to SQL Server 2017), the Setup program seems to stop responding during the SQLEngineConfigAction_upgrade step.

When this issue occurs, setup information that resembles the following is logged at the end of the Detail.txt file:

```console
(01) 2012-05-03 06:18:29 SQLEngine: --SqlEngineSetupPrivate: Setting Security Descriptor D:(<GUID value>) on Directory <Data directory>

(01) 2012-05-03 06:18:29 Slp: Sco: Attempting to set security descriptor for directory <Data Directory>, security descriptor D:( (<GUID value>))

(01) 2012-05-03 06:18:29 Slp: Sco: Attempting to normalize security descriptor D:( (<GUID value>))

(01) 2012-05-03 06:18:29 Slp: Sco: Attempting to replace account with sid in security descriptor D:( (<GUID value>))

(01) 2012-05-03 06:18:29 Slp: ReplaceAccountWithSidInSddl -- SDDL to be processed:  D:( (<GUID value>))

(01) 2012-05-03 06:18:29 Slp: ReplaceAccountWithSidInSddl -- SDDL to be returned:  D:( (<GUID value>))

(01) 2012-05-03 06:18:29 Slp: Sco: Directory <Data Directory>is a volume mount point. VolumeName is \\?\Volume{<VolumeID> }\

(01) 2012-05-03 08:27:50 Slp: Sco: Add DACL to underlying volume '\\?\Volume{<VolumeID }\' for directory '<Data directory>’from SDDL 'D:((<GUID value>))'
```

> [!NOTE]
> The *Detail.txt* file is located in the folder: `\Program Files\Microsoft SQL Server\nnn\Setup Bootstrap\Log\timestamp`.

## Cause

This issue can occur if there are many subfolders and files that contain SQL Server data.

> [!NOTE]
> This issue is more likely to occur if the database is integrated into the NTFS file system by using the FILESTREAM feature or the FILETABLE feature.

## Resolution

No action is required to resolve this issue. To complete the upgrade, let the SQL Server 2012 Setup program finish.

## More information

The issue that is described in the [Symptoms](#symptoms) section occurs because the SQL Server Setup program calls the `SetSecurityInfo` Windows API. The `SetSecurityInfo` API applies a discretionary access control list (DACL) to subfolders and files that contain SQL Server data. This process can take a long time to finish.

## References

- [SetSecurityInfo function (aclapi.h)](/windows/win32/api/aclapi/nf-aclapi-setsecurityinfo)

- [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files)

---
title: Error if you change shared component directory
description: This article provides workarounds for the problem that occurs when you change the path in the shared component directory box on the Feature Selection screen of the Install SQL Server 2008 Setup wizard.
ms.date: 11/09/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: amylewis, mcimfl
---
# Error if you change the shared component directory path on the Feature Selection screen when you install SQL Server 2008 on a computer

This article helps you resolve the problem that occurs when you change the path in the shared component directory box on the Feature Selection screen of the Install SQL Server 2008 Setup wizard.

_Original product version:_ &nbsp; SQL Server 2008  
_Original KB number:_ &nbsp; 955458

## Symptoms

You try to install Microsoft SQL Server 2008 on a computer that is running an Itanium-based (IA-64) version of Windows. However, if you change the path in the **Shared component directory** box on the **Feature Selection** screen of the Install SQL Server 2008 Setup wizard, you receive the following error message when you click **Next**:

> The `INSTANCESHAREDWOWDIR` command line value was not specified.

## Cause

This problem occurs because the Install SQL Server 2008 Setup wizard does not let you specify the InstallSharedWowDir folder path. This path is required to install shared components in the SQL Server 2008 installation. You can only specify the InstallSharedDir folder path.

> [!NOTE]
> For more information about the _INSTALLSHAREDDIR_ parameter and the _INSTALLSHAREDWOWDIR_ parameter, see the [More Information](#more-information) section.

## Workaround

To work around this problem, use one of the following methods.

## Method 1: Use the default path

If you can use the default path for the shared components, do not change the path in the **Shared component directory** box on the **Feature Selection** screen of the Install SQL Server 2008 Setup wizard. If you change the path, you will receive the error message that is specified in the [Symptoms](#symptoms) section. If this occurs, click **Cancel**, and then restart the SQL Server 2008 installation.

## Method 2: Use the /INSTALLSHAREDWOWDIR setup parameter

If you have to specify a different folder location for the shared components, follow these steps:

1. Start the SQL Server 2008 installation by using the `/INSTALLSHAREDWOWDIR` parameter at the command prompt. The `/INSTALLSHAREDWOWDIR` parameter specifies the location to install the 32-bit shared component files.

2. On the **Feature Selection** screen, specify the folder to install the 64-bit shared component files in the **Shared component directory** box.

## More information

When you install SQL Server 2008 on a computer that is running a 64-bit version of Windows, shared component files are installed by setup parameters into two separate default folders, as listed in the following table:

|Setup parameter|Default folder|Files installed|
|---|---|---|
| INSTALLSHAREDDIR|`Program Files\Microsoft SQL Server`|64-bit shared component files|
| INSTALLSHAREDWOWDIR|`Program Files(x86)\Microsoft SQL Server`|32-bit shared component files|
  
For more information about these and other setup parameters for the SQL Server installation, see the SQL Server Setup Help (_S10ch_setup.chm_) file. The _S10ch_setup.chm_ Help file is located in the folder of the SQL Server 2008 DVD: `drive:\IA64\Help\1033`.

> [!NOTE]
> The drive placeholder is the drive designation of your DVD drive.

## References

[How to: Install SQL Server 2008 from the Command Prompt](/previous-versions/sql/sql-server-2008/ms144259(v=sql.100))

---
title: Use content library explorer and transfer tool
description: Describes how to use content library in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Content Management\Content Library
---
# Content library in Configuration Manager

The content library is a new concept that was introduced in System Center 2012 Configuration Manager. In a nut-shell, the content library stores all of the Configuration Manager content efficiently on the disk. The content library optimizes disk storage to avoid redistributing a file that already exists on the distribution points.

For more information, see [Understanding the Configuration Manager Content Library](https://techcommunity.microsoft.com/t5/Configuration-Manager-Archive/Understanding-the-Configuration-Manager-Content-Library/ba-p/273349).

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  

## Content Library Explorer

The Content Library Explorer is included in the [Configuration Manager Tools](/mem/configmgr/core/support/tools). It allows for exploration of the content library on a specific distribution point. This tool can be used to troubleshoot issues with the content library, as well as explore its contents. Using the tool, packages, contents, folders, and files can all be copied out of the content library. Packages can be redistributed to the distribution point, and on remote distribution points, packages can be validated.

### Usage

**ContentLibraryExplorer.exe** must be run using an account that has administrative access to the target distribution point, and access to the WMI provider on the site server and the Configuration Manager provider. In particular, only the RBAC roles **Full Administrator** and **Read-Only Analyst** have sufficient rights to view all information from this tool. Other roles, such as **Application Administrator**, can view partial information (see note below on disabled packages). The **Read-Only Analyst** can't redistribute packages from this tool.

The tool can be run from any machine, as long as it can connect to the distribution point, the primary site server, and the Configuration Manager provider. If the distribution point is colocated with the site server, it is still necessary to have administrative access to the site server.

When the application is started, you must enter in the fully qualified domain name (FQDN) of the target distribution point. The application then connects to the distribution point. If the distribution point is part of a secondary site, you will also be prompted for the FQDN of the primary site server, and the primary site code.

In the left pane, the packages distributed to this distribution point are visible. They can be expanded, and their folder structure explored. This will match the folder structure from which the package was created. When a folder is selected, if it contains any files, these will be listed in the right pane. Information is provided about file name, file size, the drive it's present on, other packages that use the same file on the drive, and when the file was last changed on the distribution point.

The application also connects to the Configuration Manager provider machine, in order to determine which packages are distributed to the distribution point, whether or not they are actually in the distribution point's content library. For instance, a package that is pending distribution may not yet exist in the content library. Such a package would appear as **PENDING** in the tool, and no actions will be enabled for this package.

**Disabled packages**: Some packages are present on the distribution point but not visible in the Configuration Manager console. These packages are marked with an asterisk (*). No actions may be done on these packages. Other packages may also be marked with an asterisk and have actions disabled. Three primary reasons for which might occur:

- The package is the Configuration Manager client upgrade package. This would contain **ccmsetup.exe**.
- The package is not accessible by the running user's RBAC rights. For instance, the **Application Author** role cannot see driver packages in the console, so any driver packages on the distribution point will be marked.
- The package is orphaned on the distribution point.

Packages can be validated by using **Package** > **Validate** on the tool strip. A package node must be selected in the left pane, not a content or folder. The tool connects to the WMI provider on the distribution point to do this. When the tool starts, packages that are missing one or more contents will be marked invalid. Validating the package will reveal which contents are missing. If all contents are present but the data is corrupted, validation will detect the corruption.

Additionally, packages can be redistributed using **Package** > **Redistribute** on the tool strip. Again, a package node must be selected in the left pane. This requires permission to redistribute packages.

Using **Edit** > **Copy**, packages, contents, folders, and files can be copied out of the content library to a specified folder. The content library itself can't be copied. Multiple files can be selected (using Ctrl + click or Shift + click), but multiple folders can't.

Packages can be searched using **Edit** > **Find Package**. This will search for your query in the package name and package ID.

### Limitations

- The tool cannot manipulate the content library directly in any way. Changes to the content library may result in malfunctions.
- The tool can redistribute packages, but only to the target distribution point.
- When the distribution point is colocated with the site server, package data cannot be validated. Use the Configuration Manager console. (It will still inspect to make sure that all the package contents are present, though not necessarily intact).
- Content cannot be deleted using this tool.

## Content Library Transfer tool

The Content Library Transfer tool transfers content from one disk drive to another. It is designed to run on distribution point site systems. The tool supports distribution points colocated with a site or they can be remote.

The tool is useful for the scenario when the disk drive hosting the content library becomes full. After a hard disk is installed (or identified) with sufficient space to host the content library, **ContentLibraryTransfer.exe** is used transfer content from the old filled hard disk to the new (empty) drive.

Once the transfer is complete, content is now accessible to client computers from the new location without admin intervention.

### Usage

**ContentLibraryTransfer.exe** must be run as using an account that has administrative permissions on the distribution point site system.

#### Syntax

`ContentLibraryTransfer.exe -SourceDrive <drive letter of source drive> -TargetDrive <drive letter of destination drive>`

#### Example

`ContentLibraryTransfer -SourceDrive E -TargetDrive G`

### Limitations

- The tool must run locally on the distribution point; it cannot be run from a remote machine.
- The tool must run only when the distribution point is not actively being accessed by client computers. If the tool is run while client computers are accessing the content, the content library on the destination drive may have incomplete data or the data transfer might fail altogether leading to an unusable content library.
- The tool must only run when no content is being distributed to the distribution point. If the tool is run while content is being written to the distribution point, the content library on the destination drive may have incomplete data or the data transfer might fail altogether leading to an unusable content library.

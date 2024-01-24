---
title: Configuration files can't be exported
description: This article provides resolutions for the problem where configuration files cannot be exported to a DFS share through the internet services manager.
ms.date: 04/07/2020
ms.custom: sap:WWW authentication and authorization
ms.technology: www-authentication-authorization
---
# Configuration files can't be exported to a DFS share through the Internet Services Manager in IIS 7.0 and 7.5

This article helps you resolve the problem where configuration files can't be exported to a DFS share through the Internet Services Manager.

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2511835

## Symptoms

When configuring shared configuration in Internet Information Services (IIS) 7.0 or 7.5, you must export the configuration from one server and store it in a location that all of the IIS servers can access. If that share is hosted on a domain-based Distributed File System (DFS) namespace, the export will fail with the following error:

> Cannot write to the specified path. Make sure that the path and credentials are valid.

## Cause

When validating the target share and determining its properties, the Internet Services Manager calls the `NetShareGetInfo` function. This function does not support DFS.

## Resolution

To work around this problem, you can export the configuration files to a local path, then manually copy them to the DFS share.

1. Open IIS Manager.
2. In the tree view, select the server connection for which you want to set up configuration redirection.
3. Double-click **Shared Configuration**.
4. In the **Actions** pane, select **Export Configuration...**
5. In the **Export configuration** dialog box, specify a **local** path (such as `c:\temp`) and provide a password to encrypt the exported files with.
6. Select **OK**.
7. Copy the exported files to the DFS share.

The rest of the configuration is the same as the normal shared configuration setup procedure. A detailed description of this procedure can be found at [Shared Configuration](/iis/manage/managing-your-configuration-settings/shared-configuration_264/).

## More information

This problem does not happen when using a stand-alone namespace. For more information, see [NetShareGetInfo function](/windows/win32/api/lmshare/nf-lmshare-netsharegetinfo).

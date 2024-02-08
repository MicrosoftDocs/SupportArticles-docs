---
title: Current hotfixes have folder redirection
description: This article lists the hotfixes that are currently available for Windows 7 clients that are used in an Active Directory environment that makes use of data centralization, including folder redirection, offline files, and file server access.
ms.date: 10/23/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rnitsch
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# Current hotfixes for Windows 7 SP1 enterprise clients that have folder redirection enabled

This article lists the hotfixes that are currently available for Windows 7 clients that are used in an Active Directory environment that makes use of data centralization, including folder redirection, offline files, and file server access.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2820927

## Summary

In specific, the components of relevance here are:

- CSC (Client Side Caching, Offline Files)
- DFSC (Distributed File System client)
- Shell
- Folder Redirection
- Group Policy Preferences

For other components (client and server) like Srv.sys, mrxsmb.sys, rdbss.sys, ntfs.sys, dfssvc.exe, see the following up-to-date articles:

- [List of currently available hotfixes for the File Services technologies in Windows Server 2008 and in Windows Server 2008 R2](../../windows-server/backup-and-storage/file-services-hotfixes-in-windows-server-2008.md)

- [List of currently available hotfixes for the File Services technologies](../../windows-server/networking/hotfixes-for-file-services-technologies.md)

- [List of currently available hotfixes for Distributed File System (DFS) technologies in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/968429)

This article contains a list of Microsoft Knowledge Base articles that describe the currently available fixes. Each section is divided into subsections for different component drivers:  
DFS Namespace, Offline Files, Shell, Folder Redirection, and Group Policy Preferences.

> [!NOTE]
> The title of the latest fix might not represent the actual issue experienced, however LDR hotfixes do contain all previous fixes to that specific binary.

## DFSN (DFS namespace) client component

|Date added|Knowledge Base Article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
| 10. Feb. 2015| [2916627](https://support.microsoft.com/help/2916627) and [3000482](https://support.microsoft.com/help/3000483)|MS15-011: Vulnerability in Group Policy could allow remote code execution: February 10, 2015|This hotfix contains the most current version of dfsc.sys (6.1.7601.22917)|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed and install both hotfixes.|

## Offline files components

|Date added|Knowledge Base Article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
| 23/01/2014| [2831206](https://support.microsoft.com/help/2831206)|DFS network path goes offline in Windows 7 or Windows Server 2008 R2 when Transparent Caching Group Policy setting is enabled|This hotfix contains the most current version of cscdll.dll and cscapi.dll.|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|
|23/05/2014| [2967567](https://support.microsoft.com/help/2967567)|Cannot access DFS root when the DFS path is offline and you log on to a Windows-based computer for the first time|This hotfix contains the most current version of cscui.dll.|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|

## Shell component

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
| 09/05/2015| [3009986](https://support.microsoft.com/help/3009986)|A copy or move operation is unsuccessful if a symbolic link is included|This hotfix contains the most current version of Shell32.dll.|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|

Folder Redirection (fdeploy.dll)

Currently this binary is the latest available in SP1 for Windows 7.

## Group Policy Preferences

|Date added|Knowledge Base article|Title|Why we recommend this hotfix|Hotfix type and availability|
|---|---|---|---|---|
| 07/04/2014| [2953722](https://support.microsoft.com/help/2953722)|Drive Maps preferences are still displayed in Group Policy RSoP after they are removed or disabled|This hotfix contains the most current version of Gpprefcl.dll. (*)|To apply this hotfix, you must have Windows 7 SP1, or Windows Server 2008 R2 SP1 installed. Available for individual download.|

(*) There's a more recent version in the GDR branch available (security hotfix deployed through Windows Update). Make sure that this hotfix AND all urgent/ critical fixes are installed. The version installed should be of a later date with version 6.1.760 1. 22 xxx and NOT 6.1.760 1. 18 xxx.

For Windows 8.1, install [Offline Files network shares might not be available in Windows 8.1](https://support.microsoft.com/help/3078627).

Under some circumstances, it might be necessary to reset the Offline Files database to reestablish the sync partnerships. These KB articles describe how to do it, or you can run the reg.exe command line to set the key followed by a reboot.

|OS|Knowledge Base article|Reg.Exe command|
|---|---|---|
|XP| [230738](https://support.microsoft.com/help/230738)|REG ADD `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache /v FormatDatabase /t REG_DWORD /d 1 /f`|

Folder redirection can move content when the folder redirection target is changed.

It's straight forward, except when moving between different names that are actually the same location - for example from NetBIOS (Network Basic Input/Output System) to FQDN name, or from server name to DFSN name.

To make sure that the move in these situations is successful, following group policy has to be set:

_Verify Old and New folder redirection targets point to the same share before redirecting_ under `Windows Components\File Explorer` (or Windows Explorer)

Next of course Offline Files is involved because the redirected folder target is by default made offline available.

When the path is changed FR copies the data to the new location that can cause significant delays and corresponding network traffic (especially links with higher latency or when many users are migrated at the same time).

The bandwidth usage for this can't be controlled easily so an option is to copy the data on the backend to the new location with, for example, robocopy.

To make sure the minimum traffic is generated with the already copied data Folder Redirection will try to rename the data in the cache to the new location, rather than actually copying it. For this to work, you must set following registry key (via GPO preferences for example) for the user.

`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ DWORD: FolderRedirectionEnableCacheRename: 1`

This key always has to be set.

Other data that is made available offline through admin assigning or manually making offline available is NOT automatically moved/ renamed.

---
title: Can't edit AVIcode 5.7 templates after upgrading OpsMgr
description: Fixes an issue where you can't edit AVIcode 5.7 templates in the Operations console after upgrading to System Center 2012 Operations Manager.
ms.date: 07/07/2020
---
# You can't edit AVIcode 5.7 templates after upgrading to System Center 2012 Operations Manager

This article helps you fix an issue where you can't edit AVIcode 5.7 templates in the Operations console after upgrading to System Center 2012 Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2606375

## Symptoms

After upgrading a System Center Operations Manager 2007 R2 management group that was integrated with AVIcode 5.7 to System Center 2012 Operations Manager, when trying to edit new or existing AVIcode 5.7 templates in the Operations console, one of these errors occurs:

> The page [AVIcode.SystemCenter.UIPages.LobASPNETChooseName] in the assembly [AVIcode.SystemCenter.UIPages, Version=5.7.491.0, Culture=Neutral, PublicKeyToken=\<TokenID>] could not be loaded. Please make sure that the account you are running under has sufficient privileges to load the given assembly, or the Management Pack that defines this page is installed or the assembly containing the page is in the path of the executable or that the page derives from known Operations Manager page type.

> Microsoft.EnterpriseManagement.Internal.UI.Authoring.Extensibility.UISDKException: The page could not be loaded. Please review the errors and try again. ---> Microsoft.EnterpriseManagement.Internal.UI.Authoring.Extensibility.UISDKException: The page could not be loaded. Please review the errors and try again. ---> System.MissingMethodException: Method not found: 'Microsoft.EnterpriseManagement.ManagementGroup Microsoft.EnterpriseManagement.UI.UIPage.get_ManagementGroup()'.

## Cause

After upgrading to the newer version of Operations Manager, the console can't load the correct wizard pages for the AVIcode template and for the .NET Events view because it must reference binaries from the software development kit (SDK) for Operations Manager 2007.

To allow monitoring configuration changes, this solution redirects the binding assemblies of the UI SDK for Operations Manager 2007 to the UI SDK for the newer version of Operations Manager.

The template needs updating too, but it doesn't happen automatically during the setup.

## Resolution

When AVIcode .NET Enterprise Management Pack for Operations Manager 2007 is present in the management group, and the system gets upgraded, some management packs will need to be manually upgraded after the setup has finished, to fix incompatibilities with Operations Manager 2012.

The management pack files are in the `/SupportTools` directory on the Operations Manager media. They aren't imported automatically.

The management pack files that need to be imported are:

- `AVIcode.DotNet.SystemCenter.Enterprise.Monitoring.mpb`
- `AVIcode.DotNet.SystemCenter.Client.Monitoring.mp`

## More information

To restore management pack templates functionality, the used should import the fix for the AVIcode management packs that are in the `/SupportTools` directory on the Operations Manager media.

For more information about the update process from AVIcode 5.7 to System Center 2012 Operations Manager, see [Notes for AVIcode 5.7 Customers](/previous-versions/system-center/system-center-2012-R2/hh543998(v=sc.12)).

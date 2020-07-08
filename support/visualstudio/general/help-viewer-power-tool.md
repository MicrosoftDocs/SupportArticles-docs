---
title: Help Viewer Power Tool
description: This article describes the Help Viewer Power Tool.
ms.date: 04/27/2020
ms.prod-support-area-path: 
ms.reviewer: scotbren
---
# Help Viewer Power Tool

This article describes the Help Viewer Power Tool, which is released after Microsoft Visual Studio 2010 to address the need for keyword index functionality.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2518841

## Summary

Within the Visual Studio 2010 Service Pack 1 (SP1) release was a local Help viewer that contains a keyword index feature. Since SP1 contains a supported local Help viewer with keyword index, the Help Viewer Power Tool will be removed from the Gallery as on March 10, 2011. The Help Viewer Power Tool is an unsupported application. If you've installed the Help Viewer Power Tool, our guidance is to remove the Help Viewer Power Tool and install Visual Studio SP1, which will deliver the supported local Help viewer with keyword index.

Installing SP1 will remove the Help Viewer Power Tool. If you modified your manifest to support localization per the readme in the Power Tool, then you'll need to revert those changes to the manifest.

## Two alternate ways to address this issue

- Edit Query Manifest without removing the Power Tool, then install Visual Studio 2010 SP1.

    1. Revert the query manifest change made at time of Power Tool install by opening QueryManifest.\<version>.xml from `\ProgramData\Microsoft\HelpLibrary\manifest\`.

        Change all `<brandingPackageFileName>dev10pt.mshc</brandingPackageFileName>` entries to `<brandingPackageFileName>dev10.mshc</brandingPackageFileName>`.
    2. Save query manifest.
    3. Install SP1 (the Power Tool will remain in Address Resolution Protocol (ARP) but be ignored by SP1).

- Uninstall Power Tool, then install Visual Studio 2010 SP1:

    1. Open QueryManifest.\<version>.xml from `\ProgramData\Microsoft\HelpLibrary\manifest\`.
    2. Revert the locale tags in Query Manifest to ENU by changing all locale-specific catalog entries, for example:

        To change *ja-jp* to *en-us*, change `<catalog productId="VS" productVersion="100" productLocale="JA-JP" productDisplayName="" sourceType="index">` to  `<catalog productId="VS" productVersion="100" productLocale="EN-US" productDisplayName="" sourceType="index">`.
    3. Save reverted file.
    4. Uninstall (remove in **Add/Remove Programs** or **Programs and Features**) Power Tool.
    5. Update the locale tags in Query Manifest, replacing the locale designator changed in step 1 - back from *en-us* to the original locale designator.
    6. Revert the query manifest change to branding package file name:

        Change all `<brandingPackageFileName>dev10pt.mshc</brandingPackageFileName>` entries to `<brandingPackageFileName>dev10.mshc</brandingPackageFileName>`

    7. Save query manifest.
    8. Install SP1.

## More information

The use or uninstallation of this Power Tool is not supported by Microsoft Computer Software & Technology Service (CS&S). If you have any questions or problems with the Power Tool, go to [Developer Documentation and Help System](https://social.msdn.microsoft.com/Forums/home?forum=devdocs).

## Applies to

- Visual Studio Premium 2010
- Visual Studio Professional 2010
- Visual Studio 2010 Remote Debugger
- Visual Studio 2010 SDK
- Visual Studio Ultimate 2010

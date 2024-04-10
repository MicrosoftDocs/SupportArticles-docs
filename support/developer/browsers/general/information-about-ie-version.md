---
title: Internet Explorer versions information
description: This article contains a list of Internet Explorer versions.
ms.date: 06/09/2020
ms.reviewer: 
---
# Information about Internet Explorer versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article contains version information about Internet Explorer. This article also discusses how to determine which version of Internet Explorer is installed on your computer.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 969393

## Release versions of Internet Explorer for Windows

Internet Explorer version numbers for Windows Server 2008, Windows 7, and Windows 8 use the following format:

**major version.** **minor version.** **build number.** **subbuild number**

This table shows possible Internet Explorer version numbers.

| Version| Product |
|---|---|
|9.0.8112.16421|Internet Explorer 9 RTM|
|11.0.9600.*****|Internet Explorer 11 for Windows 7 and Windows 8.1|
|11.0.9600.*****|Internet Explorer 11 for Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2|
|11.*****.10240.0|Internet Explorer 11 on Windows 10 (initial version released July 2015)|
|11.*****.14393.0|Internet Explorer 11 on Windows 10 version 1607 and Windows Server 2016|
|11.*****.17134.0|Internet Explorer 11 on Windows 10 version 1803|
|11.*****.17763.0|Internet Explorer 11 on Windows 10 version 1809 and Windows Server 2019|
|11.*****.18362.0|Internet Explorer 11 on Windows 10 version 1903 and Windows 10 version 1909|
  
Internet Explorer 11 will have a version number that starts with 11.0.9600.***** on:

- Windows 7
- Windows 8.1
- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2

The version number for the last ***** will change based on the updates that have been installed for Internet Explorer.

To see the version number and the most recent update installed, go to the **Help** menu, and select **About Internet Explorer**.

Internet Explorer 11 on Windows 10 has a slight different versioning. Internet Explorer 11 changes its version with each update in the second part with the according OS-Build information. For example, if you have Windows 10 version 1607 with the KB4580346 from October 13, 2020, the Operating System shows an OS Build-number of 14393.3986 (as per winver.exe). Internet Explorer 11 will show as version 11.3986.14393.0.

> [!Note]
> The minor version number, build number, and sub-build number may be displayed without trailing zeros. For example, version 7.00.5730.1100 may be displayed as 7.0.5730.11.
>
> All versions of Internet Explorer 9.0 and later versions that are customized with Microsoft Internet Explorer Administration Kit (IEAK) include one of the following strings after the version number. To view this information, click **About** on the **Help** menu:
>
> - **IC** = Internet content provider
> - **IS** = Internet service provider
> - **CO** = Corporate administrator
>
> Internet Explorer version 9.0 and Internet Explorer version 11.0 on products through Windows 10 version 1803 include an Update Versions line that lists all installed updates or hotfixes to the current version of Internet Explorer.
>
> The version numbers of Internet Explorer in the list are based on the versions of Windows. The list numbers might be changed by the latest update.
The build number of Internet Explorer in the release version of Windows Vista is the same as in other versions.

## About Internet Explorer dialog in Internet Explorer 9 and 11 on products through Windows 10 version 1803

You can open the **About Internet Explorer** dialog box by clicking **Help** > **About Internet Explorer**. Or, press Alt+X and then press A.

:::image type="content" source="media/information-about-ie-version/about-internet-explorer-9.png" alt-text="Screenshot of the About Internet Explorer page for Internet Explorer 9." border="false":::

:::image type="content" source="media/information-about-ie-version/about-internet-explorer-11.png" alt-text="Screenshot of the About Internet Explorer page for Internet Explorer 11." border="false":::

The Update Versions field is updated every time Internet Explorer 9 or Internet Explorer 11 is updated. The version number has the following components:

- The App Major version field will remain **9** or **11**.
- The App Minor version field will remain **0**.
- The **Update revision** field will increment by **1** for each Internet Explorer update that is released.

:::image type="content" source="media/information-about-ie-version/update-revision.png" alt-text="Screenshot of the Update version fields.":::

Every update has an associated Knowledge base article (for example, [KB4586768](https://support.microsoft.com/help/4586768) – Cumulative security update for Internet Explorer: November 10, 2020) associated with it. The article provides detailed information about what's included in the update and the binaries that are updated. To get more information easily, check the **About Internet Explorer** dialog box. It provides a link to the Microsoft Knowledge Base Article that's associated with the most recently installed update to Internet Explorer.

For example, if the first update for Internet Explorer 9 has been installed, the **About Internet Explorer** dialog box will have a link to **Update versions: 9.0.1 ([KB2530548](https://support.microsoft.com/help/2530548))**.

:::image type="content" source="media/information-about-ie-version/about-internet-explorer-update-version-901.png" alt-text="Screenshot of the About Internet Explorer page for Internet Explorer 9, showing the installed update versions: 9.0.1 (KB2530548)." border="false":::

## Changes to the About Internet Explorer dialog in Internet Explorer 11 on Windows 10 version 1809 and later

You can open the **About Internet Explorer** dialog box by clicking **Help** > **About Internet Explorer**. Or, press Alt + X and then press A.

:::image type="content" source="media/information-about-ie-version/about-internet-explorer-windows-10.png" alt-text="Screenshot of the About Internet Explorer page in Windows 10 version 1903." border="false":::

On Windows 10 version 1809 and later, the About Dialog has been updated to use a more modern dialog that reflects the latest installed Operating System updates to provide better accuracy. The updated dialog will reflect the same version information as seen in winver.exe. Update Version is no longer used.

## How to determine the version of Internet Explorer for Windows

To determine the version of Internet Explorer, use any of the following methods:

- In all versions of Internet Explorer, select **About Internet Explorer** on the **Help** menu. The product and version information are displayed in the dialog box that appears.
- Use the registry. You can determine the version of Internet Explorer by viewing the following registry key:  
  `HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer`

  Refer to svcVersion value in this key. The version string value contains the version number of Internet Explorer that is installed on your computer. (For example, the version string value for Internet Explorer 11 on Windows 10 version 2004 is 11.630.19041.0). Only one zero is stored in the registry for the minor version number if the minor version number is 00. If the minor version number isn't 00, the full version value is stored.

> [!NOTE]
>
> - The minor version number, build number, and subbuild number may be displayed without trailing zeros. For example, version 7.00.5730.1100 may be displayed as 7.0.5730.11.
> - The version numbers of Internet Explorer in the list are based on the versions of Windows. The list numbers might be changed by the latest hotfix.
> - Determine the version of Internet Explorer by using a script.

All versions of Internet Explorer send version information in the Hypertext Transfer Protocol (HTTP) user agent information header. This information can be read from script on a webpage.

Webpage developers can use this information to take advantage of new features in later versions of Internet Explorer, such as HTTP Strict Transport Security in Internet Explorer 11.0. They can also downgrade for earlier versions of Internet Explorer that don't support these features.

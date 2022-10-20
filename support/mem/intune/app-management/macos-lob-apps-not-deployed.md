---
title: macOS LOB apps aren't deployed in Intune
description: Describes an issue in which macOS line-of-business (LOB) apps aren't installed on targeted devices and no error messages are shown in Intune.
ms.date: 10/19/2021
search.appverid: MET150
ms.custom: sap:Manage Apps
---
# macOS LOB apps aren't deployed in Microsoft Intune

This article give troubleshooting steps to help resolve when Microsoft Intune cannot deploy a macOS line-of-business (LOB) app to targeted devices.

## Symptoms

You [add a macOS line-of-business (LOB) app to Microsoft Intune](/mem/intune/apps/lob-apps-macos), and then you try to deploy the app to macOS devices. However, the app isn't installed on the targeted devices, and no error messages are shown in Intune.

## Cause

The issue occurs if your .pkg package doesn't contain the following information:

- The package `version` and `CFBundleVersion` string in the packageinfo file.
- The correct `install-location` in the pkg-info file.

This information is required so that Intune can deploy the app on targeted devices.

Use the following steps to check whether your .pkg package contains the required information.

1. On a macOS device, use the following `IntuneAppUtil` command within the [Intune App Wrapping Tool for Mac](https://github.com/msintuneappsdk/intune-app-wrapping-tool-mac) to extract the detected parameters and version for the created *.intunemac* file:

    `IntuneAppUtil -r <filename.intunemac> [-v]`

2. Check whether the Detection.xml file contains the package version. Here is an example of the Detection.xml file:

    ```xml
    Archive:  SkypeForBusinessMacOS.intunemac
    extracting: IntuneMacPackage/Metadata/Detection.xml
    <?xml version="1.0" encoding="UTF-8"?>
    <PackageMetadata Version="1.0.0.0" TimeStamp="2018-05-18 20:38:20 +0000" MacOSX="10.13.4"
        xmlns="[https://schemas.microsoft.com/Intune/2018/01/01/MACLOBAPP](https://schemas.microsoft.com/Intune/2018/01/01/MACLOBAPP)">
        <MacOSLobApp PackageType="pkg" PackageName="SkypeForBusinessInstaller-16.17.0.65.pkg" BundleId="com.microsoft.package.Microsoft_AutoUpdate.app" BuildNumber="3.8.16112200">
            <MD5HashChunkSize Size="10485760"/>
            <MD5Hash>
                33a159eef753c90f522f54643b7055a6,f7becc593a7b4dcfbd41586789183211,aaa086b4eb85628356d2df1e7a81802b,445de9a759211d80eb548edaf081eb8e
            </MD5Hash>
            <MacOSLobChildApp BundleId="com.microsoft.SkypeForBusiness" BuildNumber="16.17.65"/>
            <MacOSLobChildApp BundleId="com.microsoft.autoupdate2" BuildNumber="3.8.1" VersionNumber="3.8.1"/>
        </MacOSLobApp>
        <InstallerParams VolumeInfo="/" RestartAction="None"/>
    </PackageMetadata>
    ```

3. Run the following command to extract the pkg-info file in your .pkg file:

    `xar -x -f <.pkg file path> -C <Output folder>`

4. Check whether the output contains `CFBundleVersion` and `install-location`. The installation location should be **/Applications** or its subfolder, as in the following example:

    > \<pkg-info identifier="com.microsoft.OneDrive" version="17.3.6760" install-location="/Applications">  
    > \<bundle path="./OneDrive.app" id="com.microsoft.OneDrive" CFBundleShortVersionString="17.3.6760" CFBundleVersion="6760.105"/>

## Solution

To fix the issue, contact your app developer to rebuild the .pkg package to include the required information. For Apple-specific developer documentation, see [https://developer.apple.com/](https://developer.apple.com/).

## More information

Currently, support for macOS app deployment is limited to simple .pkg apps that are installed in the **/Applications** folder and [Office 365 apps for macOS](/mem/intune/apps/apps-add-office365-macOS).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

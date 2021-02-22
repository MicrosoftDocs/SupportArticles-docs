---
title: Error 0x87D13BA2 deploying a macOS LOB app
description: Fixes the 0x87D13BA2 error when you deploy a macOS LOB app that contains multiple components.
author: helenclu
ms.author: luche
ms.reviewer: markstan
ms.date: 02/18/2021
ms.prod-support-area-path: App management
---
# Error 0x87D13BA2 when you deploy a macOS LOB app

This article fixes a problem that occurs when you try to deploy a macOS LOB app in Microsoft Intune, and you receive the following error message:

> One or more apps contain invalid bundleIds. (0x87D13BA2)

## Symptoms

You publish a macOS line-of-business (LOB) app by using Intune. When you select the app in the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), the **Device install status** shows the following information about the app:

- **Status**: Failed
- **Status details**: One or more apps contain invalid bundleIds. (0x87D13BA2)

Here's an example of Cisco AnyConnect VPN:

:::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/error.png" alt-text="Error 0x87D13BA2 ":::

This problem can occur even if the app is successfully installed on the device.

## Cause

This problem occurs under the following conditions:

- Multiple applications are included in a macOS app package.
- The macOS MDM client doesn't report the installation status of all individual applications that are included in the package.

Any app that has multiple components, such as Cisco AnyConnect VPN, can generate this error message.

## Resolution

To fix this problem and enable the macOS LOB app to correctly report its status, follow these steps:

1. Copy the [wrapped application](/mem/intune/apps/lob-apps-macos) in `.intunemac` format to a macOS device. Put the `.intunemac` file into a temporary folder.
2. Run the following command to extract the `.intunemac` file:

   ```console
   unzip <Package_Name>.intunemac
   ```

   In our example, run `unzip AnyConnect.pkg.intunemac`.
  
   :::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/unzip.png" alt-text="Extract the file":::

   The content of the package will be extracted to a child folder that's named IntuneMacPackage under the temporary folder.
3. Open the IntuneMacPackage/Metadata/Detection.xml file in a text editor.

   Here's a sample Detection.xml file of Cisco AnyConnect VPN:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <PackageMetadata Version="1.0.0.0" TimeStamp="2021-01-27 09:56:37 +0000" MacOSX="10.16" xmlns="http://schemas.microsoft.com/Intune/2018/01/01/MACLOBAPP">
    <MacOSLobApp PackageType="pkg" PackageName="AnyConnect.pkg" BundleId="com.cisco.pkg.anyconnect.iseposture" BuildNumber="4.9.05042">
    <MD5HashChunkSize Size="10485760"/>
    <MD5Hash>
    94afdea75543f488e8347702909ea064,11a70f69441273e6c5bb7bc5c13254a9,b514d8ce061d5632ade7d002bd8ae68c,85488ad9a62e12ba79e9f2d17b4f0eba,f2d2ada34aec51444c96e8ae32c574f1
    </MD5Hash>
    <MacOSLobChildApp BundleId="com.cisco.pkg.anyconnect.nvm_v2" BuildNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.gui" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.pkg.anyconnect.fireamp" BuildNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.pkg.anyconnect.websecurity_v2" BuildNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.macos.acsock" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.dartuninstaller" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.uninstaller" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.vpndownloader" BuildNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.pkg.anyconnect.posture" BuildNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.dart" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.pkg.anyconnect.iseposture" BuildNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.cisco.anyconnect.notification" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
    <MacOSLobChildApp BundleId="com.opendns.OpenDNS-Diagnostic" BuildNumber="1.5.5"/>
    </MacOSLobApp>
    <InstallerParams VolumeInfo="/" RestartAction="None"/>
    </PackageMetadata>
    ```

4. Remove all **MacOSLobChildApp** elements except the one for the main application in the package. Update the **MacOSLobApp** element by using the BundleId and BuildNumber of the main application, and then save the Detection.xml file.

In the example, the BundleId of the main application is **com.cisco.anyconnect.gui**. Remove all **MacOSLobChildApp** elements except the following one:

   ```xml
   <MacOSLobChildApp BundleId="com.cisco.anyconnect.gui" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
   ```

Then, change the **MacOSLobApp** element to:

    ```xml
    <MacOSLobApp PackageType="pkg" PackageName="AnyConnect.pkg" BundleId="com.cisco.pkg.anyconnect.gui" BuildNumber="4.9.05042">
    ```

The following is the updated Detection.xml file:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <PackageMetadata Version="1.0.0.0" TimeStamp="2021-01-27 09:56:37 +0000" MacOSX="10.16" xmlns="http://schemas.microsoft.com/Intune/2018/01/01/MACLOBAPP">
   <MacOSLobApp PackageType="pkg" PackageName="AnyConnect.pkg" BundleId="com.cisco.pkg.anyconnect.gui" BuildNumber="4.9.05042">
   <MD5HashChunkSize Size="10485760"/>
   <MD5Hash>
   94afdea75543f488e8347702909ea064,11a70f69441273e6c5bb7bc5c13254a9,b514d8ce061d5632ade7d002bd8ae68c,85488ad9a62e12ba79e9f2d17b4f0eba,f2d2ada34aec51444c96e8ae32c574f1
   </MD5Hash>
   <MacOSLobChildApp BundleId="com.cisco.anyconnect.gui" BuildNumber="4.9.05042" VersionNumber="4.9.05042"/>
   </MacOSLobApp>
   <InstallerParams VolumeInfo="/" RestartAction="None"/>
   </PackageMetadata>
   ```

5. Run the following command to repackage the IntuneMacPackage folder:

   ```console
   zip -q --symlinks -0 -r <Package_Name>.intunemac <IntuneMacPackage_Folder_Location>
   ```

   **Note:** \<*Package_Name*> is the desired name of the `.intunemac` file, and \<*IntuneMacPackage_Folder_Location*> is the location of the IntuneMacPackage folder that you created in step 2.

   For our example, run the following command:

   ```console
   zip -q --symlinks -0 -r AnyConnect.intunemac IntuneMacPackage
   ```

6. Add the new `.intunemac` file to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then sync the device.

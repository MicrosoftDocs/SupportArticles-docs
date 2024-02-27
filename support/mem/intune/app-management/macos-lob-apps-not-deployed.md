---
title: macOS LOB apps aren't deployed in Intune
description: Describes an issue in which macOS line-of-business (LOB) apps aren't installed on targeted devices and no error messages are shown in Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Manage Apps
ms.reviewer: kaushika
---
# macOS LOB apps aren't deployed in Microsoft Intune

This article give troubleshooting steps to help resolve when Microsoft Intune cannot deploy a macOS line-of-business (LOB) app to targeted devices.

## Symptoms

You [add a macOS line-of-business (LOB) app to Microsoft Intune](/mem/intune/apps/lob-apps-macos), and then you try to deploy the app to macOS devices. However, the app isn't installed on the targeted devices, and no error messages are shown in Intune.

## Cause

The issue occurs if your `.pkg` package doesn't contain the following information in the package info file:

- The package `version` and `CFBundleVersion` strings
- The correct `install-location`

This information is required so that Intune can deploy the app on targeted devices.

Use the following steps to check whether your `.pkg` package contains the required information.

1. Run the following command to extract the pkg-info file from your `.pkg` package:

    `xar -x -f <.pkg file path> -C <Output folder>`

2. Check whether the output contains `CFBundleVersion` and `install-location`. The installation location should be **/Applications** or its subfolder, as in the following example:

    > \<pkg-ref id="com.microsoft.teams" version="1.00.522362">  
    > \<choice id="TeamsApp" title="Microsoft Teams" customLocation="/Applications"/>

## Solution

To fix the issue, contact your app developer to rebuild the `.pkg` package to include the required information. For Apple-specific developer documentation, see [https://developer.apple.com/](https://developer.apple.com/).

## More information

Currently, support for macOS app deployment is limited to simple `.pkg` apps that are installed in the **/Applications** folder and [Office 365 apps for macOS](/mem/intune/apps/apps-add-office365-macOS).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

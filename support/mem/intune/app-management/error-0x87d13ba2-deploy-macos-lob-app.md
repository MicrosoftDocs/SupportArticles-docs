---
title: Error 0x87D13BA2 deploying a macOS LOB app in Intune
description: Fixes the 0x87D13BA2 error when you deploy a macOS LOB app that contains multiple components in Microsoft Intune.
author: helenclu
ms.author: luche
ms.reviewer: kaushika, markstan
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:App management
---
# Error 0x87D13BA2 when you deploy a macOS LOB app

This article gives a solution to the following error message when you deploy a macOS line-of-business (LOB) app in Microsoft Intune:

> One or more apps contain invalid bundleIDs. (0x87D13BA2)

## Symptoms

You publish a macOS LOB app using Intune. When you select the app in the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), the **Device install status** shows the following information about the app:

- **Status**: Failed
- **Status details**: One or more apps contain invalid bundleIDs. (0x87D13BA2)

Here's an example of Microsoft Teams:

:::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/error-0x87d13ba2.png" alt-text="Screenshot of error 0x87D13BA2 in Microsoft Teams." lightbox="media/error-0x87d13ba2-deploy-macos-lob-app/error-0x87d13ba2.png":::

This problem can occur even if the app is successfully installed on the device.

## Cause

This problem occurs under the following conditions:

- Multiple applications are included in a macOS app package.
- The installation status of all individual applications that are included in the package aren't reported back to Intune.

Any app that has multiple components, such as Microsoft Teams, can generate this error message.

## Solution

Use the following steps to fix this problem and enable the macOS LOB app to correctly report its status.

1. On a macOS device that has the app installed through Intune, open Terminal and run the following command to output a list of installed apps to the current directory:

   ```console
   sudo /usr/libexec/mdmclient QueryInstalledApps > InstalledApps.txt
   ```

2. Open the *InstalledApps.txt* file in a text editor:

   :::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/installedapps.png" alt-text="Screenshot of the InstalledApps.txt file.":::

3. Go to the affected app in Intune by selecting **Properties** > **App information** > **Edit**:

   :::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/edit-application.png" alt-text="Screenshot of the Edit application page.":::

4. Compare the list of included apps in Intune with the apps listed in the *InstalledApps.txt* file, and remove any apps that are not showing in the text file:

   :::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/included-apps-intune.png" alt-text="List of included apps in Intune.":::

   :::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/included-apps-text-file.png" alt-text="List of included apps in the text file.":::

5. Review and save the application, and then sync the device to retrieve the latest app installation status:

   :::image type="content" source="media/error-0x87d13ba2-deploy-macos-lob-app/latest-app-installation-status.png" alt-text="Screenshot of the latest app installation status.":::

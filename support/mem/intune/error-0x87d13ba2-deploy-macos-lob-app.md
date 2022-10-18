---
title: Error 0x87D13BA2 deploying a macOS LOB app in Intune
description: Fixes the 0x87D13BA2 error when you deploy a macOS LOB app that contains multiple components in Microsoft Intune.
author: helenclu
ms.author: luche
ms.reviewer: markstan
ms.date: 10/18/2021
search.appverid: MET150
ms.custom: sap:App management
---
# Error 0x87D13BA2 when you deploy a macOS LOB app

This article gives a solution to the following error message when you deploy a macOS line-of-business (LOB) app in Microsoft Intune:

> One or more apps contain invalid bundleIDs. (0x87D13BA2)

## Symptoms

You publish a macOS LOB app using Intune. When you select the app in the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), the **Device install status** shows the following information about the app:

- **Status**: Failed
- **Status details**: One or more apps contain invalid bundleIDs. (0x87D13BA2)

Here's an example of Microsoft Teams:

 ![image](https://user-images.githubusercontent.com/57767769/196536372-d2244378-31e2-41e1-9c31-f897bb3672eb.png)

This problem can occur even if the app is successfully installed on the device.

## Cause

This problem occurs under the following conditions:

- Multiple applications are included in a macOS app package.
- The installation status of all individual applications that are included in the package aren’t reported back to Intune.

Any app that has multiple components, such as Microsoft Teams, can generate this error message.

## Solution

Use the following steps to fix this problem and enable the macOS LOB app to correctly report its status.

1. On a macOS device that has the app installed through Intune, open Terminal and run the following command to output a list of installed apps to the current directory:

   ```console
   sudo /usr/libexec/mdmclient QueryInstalledApps > InstalledApps.txt
   ```

2. Open the InstalledApps.txt file in a text editor:

      <img width="500" alt="image" src="https://user-images.githubusercontent.com/57767769/196536786-0bc12413-46ae-4f35-90f5-04eb5de09823.png">

3. Go to the affected app in Intune > Properties > App information > Edit:

      <img width="500" alt="image" src="https://user-images.githubusercontent.com/57767769/196536881-90947e35-5f73-466b-9cee-b5446a7b3672.png">

4.	Compare the list of included apps in Intune to the apps listed in the InstalledApps.txt, and remove any apps that are not showing in the text file:

      <img width="500" alt="image" src="https://user-images.githubusercontent.com/57767769/196536939-b7356dab-3b3d-4c88-babb-eaa44b096084.png">

      <img width="500" alt="image" src="https://user-images.githubusercontent.com/57767769/196537126-790db738-53fc-432d-932a-0081a7a0d8ed.png">

5.	Review and save the application, and then sync the device to retrieve the latest app installation status:

     ![Screen Shot 2022-10-18 at 4 19 45 PM](https://user-images.githubusercontent.com/57767769/196538620-dc9c15e0-62eb-4a01-a4c7-3bd30ee4ecef.png)






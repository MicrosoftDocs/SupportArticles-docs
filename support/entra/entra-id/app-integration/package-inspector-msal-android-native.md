---
title: Package Inspector for MSAL Android Native
description: Introduces how to install and use the Package Inspector tool.
ms.reviewer: markbukovich, v-weizhu
ms.topic: how-to
ms.service: entra-id
ms.date: 02/20/2025
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Package Inspector for MSAL Android Native

The Microsoft Authentication Library (MSAL) for Android Native includes a tool called Package Inspector. This tool lists the packages installed on an Android device and allows users to view, copy, and paste the signature hash used to sign an application's package. Package Inspector can be invaluable for troubleshooting and verifying the signature hash for applications installed on an Android device. This article covers installation, usage, and common issues of the Package Inspector.

## Scenarios where you can use Package Inspector

- You have successfully developed an application to use MSAL, but after deploying the app to the Google Play Store, the app fails to perform authentication.

    In this scenario, Package Inspector will be useful to discover the new signature hash used by Google to sign in to the app package.

- You are implementing MSAL in your Android application, but encounter the following error:

    > The redirect URI in the configuration file doesn't match with the one generated with the package name and signature hash. Please verify the uri in the config file and your app registration in Azure portal.

    In this scenario, you can use the Package Inspector to verify what the package signature hash is and configure both the Azure portal and application to use the correct signature hash.

- You are implementing MSAL in your Android application, but encounter the following error:

    > Intent filter for: BrowserTabActivity is missing
    
    This error can occur because the signature hash specified in the *AndroidManifest.xml* file doesn't match the signature hash actually used to sign in to the APK file. In this scenario, the Package Inspector will be useful to verify what the signature hash actually is.

> [!NOTE]
> For more information about MSAL for Android Native, see [Microsoft Authentication Library (MSAL) for Android](https://github.com/AzureAD/microsoft-authentication-library-for-android).

## Prerequisites

Before you start, ensure you have the following:

- A recent version of Android Studio installed.
- A virtual Android device with applications installed, which can be managed using Android Studio's AVD manager. For more information, see [AVD manager](https://developer.android.com/studio/run/managing-avds).
- A physical device with developer options, USB debugging enabled, and a USB cable. For more information, see [Developer options](https://developer.android.com/studio/debug/dev-options).
- An application installed to inspect.

## Install Package Inspector

There are two methods to install Package Inspector:

### Option 1: Clone the repository directly into Android Studio

1. Open Android Studio and close any open projects.
2. Select **Get From Version Control**.

    :::image type="content" source="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/7a705a68-d6b2-4df8-b632-fc828b142f6f.png" alt-text="Screenshot that shows the 'Get From Version Control' option in Android Studio" lightbox="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/7a705a68-d6b2-4df8-b632-fc828b142f6f.png":::
3. Ensure **Git** is selected at the top of the window, paste the repository URL `https://github.com/AzureAD/microsoft-authentication-library-for-android.git`, and select **Clone**.

    :::image type="content" source="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/63ea16d9-74d6-43fb-9965-76382e2442f6.png" alt-text="Screenshot that shows how to clone a Git repository in Android Studio" lightbox="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/63ea16d9-74d6-43fb-9965-76382e2442f6.png":::

### Option 2: Download as a zip file and open in Android Studio

1. [Download the repository](https://github.com/AzureAD/microsoft-authentication-library-for-android/archive/refs/heads/dev.zip).
2. Extract the zip file to your selected directory.
3. Open Android Studio and close any open projects.
4. Select **Open an Existing Project**.

    :::image type="content" source="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/c40bb5ff-38b6-45f4-ae7d-1eee54a441d0.png" alt-text="Screenshot that shows the 'Open an Existing Project' option in Android Studio" lightbox="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/c40bb5ff-38b6-45f4-ae7d-1eee54a441d0.png":::
5. Select the root package **msal-android** for the Android MSAL repository. Then, select **OK**. 

    :::image type="content" source="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/8f4e6637-a29a-4605-9c96-e8674c9801d1.png" alt-text="Screenshot showing selecting the Root Package in Android Studio" lightbox="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/8f4e6637-a29a-4605-9c96-e8674c9801d1.png":::

    > [!NOTE]
    > - The default name of the root package is `microsoft-authentication-library-for-android-dev`, but you might have renamed it.
    > - Don't select the **package-inspector** directory. 

## Use Package Inspector

1. With the Android MSAL project open in Android Studio, connect the desired Android device. This can be a physical device connected to the computer's USB port an emulator booted from Android Studio's AVD manager. Ensure your device appears in the drop-down list at the top of Android Studio and select it.
2. To the left of the device drop-down, there is another drop-down list. Select this and select **package-inspector**.

    :::image type="content" source="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/b38c129a-9cfb-4901-85f6-da13cc592f36.png" alt-text="Screenshot that shows the selection of package-inspector in Android Studio" lightbox="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/b38c129a-9cfb-4901-85f6-da13cc592f36.png":::
3. Select the green **play** button (indicated with a green circle on the right) to build, install, and run the package inspector on the selected device.
4. Browse the list of packages in the package-inspector app and select a package to view its signature hash. All accessible packages will appear in this list.

    :::image type="content" source="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/6adfe09a-5e98-4b7b-b2f3-2c83b60fff8f.png" alt-text="Screenshot that shows package selection in the Package Inspector app" lightbox="https://rubikcopilotchat.azurewebsites.net/blobimages/991342cf-513f-4844-8923-37065c451d32/6adfe09a-5e98-4b7b-b2f3-2c83b60fff8f.png":::

## Common issues

### Issues when loading Package Inspector into Android Studio

To resolve these issues, ensure you load the root package from the MSAL repository, not just the package inspector. The project you're loading should be named `microsoft-authentication-library-for-android-dev` or whatever you have renamed the root repository on your system instead of package-inspector. See step 5 under [Option 2](#option-2-download-as-a-zip-file-and-open-in-android-studio) in the [Install Package Inspector](#install-package-inspector) section.

### Not all packages appear in Package Inspector

You can install and open Package Inspector, and a list of packages appear in the app. However, you don't see packages for any of the apps you have installed on the device. It might be due to changes in Android 11 (API 30). For more information, see [here](https://developer.android.com/training/package-visibility).

To resolve this issue, follow these steps:

1. Open the AndroidManifest.xml file within the package-inspector directory on the left side of Android Studio.
2. Add the following permission and query between the `<manifest></manifest>` tags:

    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.microsoft.inspector"></manifest>
    ...
    
    <permission android:name="android.permission.QUERY_ALL_PACKAGES" />
    
    <queries>
        <intent>
            <action android:name="android.intent.action.MAIN" />
        </intent>
    </queries>
    ```

3. Rerun the application from Android Studio to apply the changes. Then, you should can see the packages you have installed.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
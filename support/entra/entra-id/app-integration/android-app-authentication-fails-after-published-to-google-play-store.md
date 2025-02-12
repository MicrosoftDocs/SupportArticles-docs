---
title: Android app authentication fails after published to Google Play Store
description: Provides a solution to an authentication failure with an Android app that's published to Google Play Store.
ms.reviewer: markbukovich, v-weizhu
ms.service: entra-id
ms.date: 02/12/2025
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Authentication failed after Android app is published to Google Play Store

This article provides a solution to an authentication failure that occurs after users install an Android app that's published to Google Play Store.

## Symptoms

Consider the following scenario:

- You have successfully implemented Microsoft Entra Authentication in your Android app with the Microsoft Authentication Library.
- The app has been built and executed, and passed all QA testing.
- You publish the app on Google Play Store. 

After users install the app, authentication doesn't work when signing in to the app.

If you expose authentication error messages to users or if you let them send error messages to your team, you may encounter an error message like the following text:

> The redirect URI in the configuration file doesn't match with the one generated with the package name and signature hash. Please verify the uri in the config file and your app registration in Azure portal.

Another possible scenario of this issue is:

During development and QA testing, you set up your app to use a supported broker to handle authentication and SSO. 

However, after the app deployment through Google Play and installation, the app no longer uses the broker for authentication.

## Cause

When an Android application is built for installation on a device, it is built as an APK compressed package and then signed by a certificate. This certificate signing ensures that the person who built the application is the one who owns the private signing key. This prevents hackers from modifying the application harmfully, as they can't sign their version with the original private key.

Previously, Android developers owned and maintained their private signing keys. Currently, Google Play Services generate and maintain the private signing key for Android developers, ensuring secure storage by Google. The developer still maintains an upload key so that Google Play Services can verify the authenticity of an uploaded app bundle, but the actual signing is performed by the Google-owned signing certificate when users install the app on their device.

The Microsoft Authentication Library (MSAL) for Android Native and Microsoft Supported Authentication Brokers use the public signature hash of an installed application to identify it when interacting through the Android Operating system during authentication.

The public signature hash of an application installed via Google Play differs from one installed before publishing to Google Play. Thus, MSAL will be configured with the incorrect signature hash.

## Solution

To resolve this issue, do the following things:

- Get the new signature hash with the MSAL Package Inspector tool or from the Google Play Console .
- Add a new redirect URI to the App Registration in the Azure portal with the new signature hash.
- Update the MSAL configuration within the application code to use the new redirect URI and signature hash.

### Find the new signature hash

You can get the new signature hash by using the MSAL Package Inspector tool or from the Google Play Console.

To install and use the MSAL Package Inspector, see
https://blogs.aaddevsup.xyz/2022/03/package-inspector-for-msal-android-native-guide/.

To get the signature hash from the Google Play Console, follow these steps:

1. Go to the Google Play Console and sign in with your Google Developer account.
2. Once you are in the Google Play Console, select the app you works on.
3. On the left navigation, under the **Release** category, expand **Setup** and select **App Integrity**.
4. Select the **App signing**tab. You will see the **fingerprint** of the app signing key in three different variations. 
5. Copy the **SHA-1 certificate fingerprint** and paste it into the following PowerShell script as the value of the `$Thumbprint` variable. 
6. Run the following script to obtain the base64 encoded fingerprint that MSAL needs:

    ```powershell
    $Thumbprint = "paste your fingerprint here"
    $Thumbprint = $Thumbprint.Replace(":", "")

    $Bytes = [byte[]]::new($Thumbprint.Length / 2)

    For($i=0; $i -lt $Thumbprint.Length; $i+=2){
        $Bytes[$i/2] = [convert]::ToByte($Thumbprint.Substring($i, 2), 16)
    }

    $hashedString =[Convert]::ToBase64String($Bytes)

    Write-Host $hashedString
    ```

 :::image type="content" source="media/android-app-authentication-fails-after-published-to-google-play-store/google-play-console-app-signing.png" alt-text="Screenshot that shows how to get the signature hash from Google Play Console.":::
 
### Add a new redirect URI to the App Registration in the Azure portal with the new signature hash

> [NOTE]
> We recommend adding a new redirect URI rather than modifying the existing one. Your app registration can contain many redirect URIs. Additionally, modifying the existing redirect URI might result in problems with the development version of your app. This could cause issues during troubleshooting, developing updates, amd so on.

1. Sign in to the Azure portal and navigate to the App registrations page.
2. Select the app registration for your Android app.
3. Under **Manage**, select **Authentication**.
4. Under Platform configurations, select **Add a platform**.
5. Under **Configure platforms**, select **Android**.

    :::image type="content" source="media/android-app-authentication-fails-after-published-to-google-play-store/app-reg-platform-config.png" alt-text="Screenshot that shows how to configure Android platform.":::
6. Enter the package name of your Android app and the new signature hash in the indicated fields and then select **Configure**. 

    :::image type="content" source="media/android-app-authentication-fails-after-published-to-google-play-store/app-registrations-configure-android-app.png" alt-text="Screenshot that shows how to configure an Android app.":::

    > [!NOTE]
    > It's fine to use the same package name in multiple Android Redirect URIs as long as the signature hash is different.

### Update the MSAL Configuration within the application code to use the new redirect URI and signature hash

Update the MSAL configuration and Android Manifest files in the application code.

- MSAL configuration file:

    Only change the redirect URI. Copy and paste it directly from the Azure portal. In the Azure portal, the signature hash portion of the redirect URI is HTTP encoded. It should remain HTTP encoded.

    ```json
    {
        "client_id": "<Client ID>",
        "authorization_user_agent": "DEFAULT",
        "redirect_uri": "<Redirect URI>"
        "broker_redirect_uri_registered": true,
        "authorities": [
            {
                "types": "AAD",
                "audience": {
                    "type": "AzureADMyOrg",
                    "tenant_id": "<Tenant ID>"
                }
            }
        ],
        "logging":{
            "log_level": "VERBOSE",
            "logcat_enabled": true
        }
    }
    ```

- Android Manifest file:

    Only change the `android:path` property in the `com.microsoft.identity.client.BrowserTabActivity` activity. Paste the signature hash as the value for this property.

    ```xml
    <activity
        android:name="com.microsoft.identity.client.BrowserTabActivity">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data
                android:schema="msauth"
                android:host="com.example.azureauthsso1"
                android:path="android_path" />
        </intent-filter>
    </activity>
    ```


    > [!NOTE]
    > - Make sure to include the forward slash at the front of the signature hash.
    > - Unlike the redirect URI, the signature hash here isn't HTTP encoded.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
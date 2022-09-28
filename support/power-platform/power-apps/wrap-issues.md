---
title: Troubleshooting wrap issues in Power Apps
description: Provides possible resolutions for wrap issues in Power Apps
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 09/28/2022
ms.subservice: 
---
# Troubleshooting wrap issues in Power Apps

This guide helps you resolve the most common warp issues in Power Apps.

## Wrap Build is failing

### Verify that your images are in a PNG format 

Ensure that the images your are using in wrap are in a PNG format. Using images in any format other than PNG will cause the wrap build to fail. Please use an image converter to save your images as .PNG files or ensure that your original image files are in a PNG format instead. 

> [!IMPORTANT]
> Note that manually changing your image file extension from .JPEG or any other formats to a .PNG will not automaticallt re-format the image to a PNG format.


### Verify that your App Center is correctly configured 
Your App Center link must be created as an App within an Org, and not a standalone App. 

   :::image type="content" source="media/wrap-issues/BuildFail_1.png" alt-text="Screenshot of how to add a new Organization in App Center.":::


Check that the access token you have created is correct. 

- Correct: Click on your created App -> Settings -> App API Tokens 

- Incorrect: Account Settings -> User API Tokens 

Verify that your iOS or Android App created has the right settings configurations. 

- iOS: OS=Custom 

- Android: OS=Android, Platform=React Native 

 
For more information, refer to Steps 8 and 9 in [Create an App Center container for your mobile app](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#create-an-app-center-container-for-your-mobile-app).

### Verify that your Keyvault configuration is correct 
Make sure that Azure Service Principal was created and the role added correctly. Refer to Steps 1-2 in [Set up KeyVault for automated signing](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing) for the details.

Ensure your Keyvault contains all necessary certificates, secrets and tags for iOS and/or Android: 

- iOS: 2 Tags, 1 Certificate, 1 Secret  

- Android: 1 Tag, 1 Certificate 

For more information, please refer to [Set up KeyVault for automated signing](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing). 

### If you have all the proper configurations, try again. 
If wrap build keeps failing after have you have verified that your wrap project has all the proper configurations, please reach out to our support alias. See details at the end of this document. 

## Wrap button is disabled for my App
You can only wrap Apps that you have **Edit** permissions for. Please make sure you have **Edit** permisions for the App you want to wrap and try again.

## Cannot save my project or trigger a wrap Build 
- Please update to latest wrap solution version and try again. 

- Please ensure there are no UI validation errors blocking Save or Build submission. 

## Cannot install a wrapped Mobile App on a device 
Make sure that you have signed the outputted application. You can do so by configuring a Keyvault and providing it at build trigger time, or manually signing. For more details on code signing, please please refer to: 

- [Setup Keyvault for Automated Signing](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing)

- [Code sign for iOS](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/code-sign-ios)

- [Code sign for Android](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/code-sign-android) 

verify that your mobile device meets these [minimum requirements](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/overview#software-and-device-requirements). 


## Cannot sign in to a wrapped Mobile App or cannot see data  

If you cannot sign in to your wrapped Mobile App, please verify that: 

- Your AAD app is properly configured 

- All API permissions for the App have been added correctly. Please refer to the image below and see [Configure API Permissions](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#configure-api-permissions) for more details on how to see and configure API permissions for the App. 


:::image type="content" source="media/wrap-issues/SignInFail_1.png" alt-text="Screenshot of API permissions for the App.":::



- Verify that admin **Add-AdminAllowedThirdPartyApps** script was run successfully. See [Allow registered apps in your environment](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#allow-registered-apps-in-your-environment) for more information. 

 

- Make sure your AAD app type is Multi-tenant. Under your AAD app’s Authentication tab, Supported account types should be “Accounts in any organizational directory (Any Azure AD directory – Multitenant”. 

- Ensure that the proper Redirect URIs have been created for iOS and Android. For Android, please check that the hash is provided correctly. For more information on Redirect URIs, please see [these steps](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#redirect-uri-format). 

 

 
## Other issues in wrap

For all other issues, or if your issue persists after following these steps, please reach out to support alias pamobsup@microsoft.com, include a repro video and/or screenshots, as well as a session id, which can be acquired in the following ways: 



- Login Screen: Bottom Right Gear Icon -> Session Details 

- App Opened:  Shake Device -> Session Details 

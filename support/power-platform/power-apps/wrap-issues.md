---
title: Troubleshooting wrap issues in Power Apps
description: Provides a resolution for wrap issues in Power Apps.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 09/28/2022
ms.subservice: 
---
# Troubleshooting wrap issues in Power Apps

This guide helps you resolve warp issues in Power Apps.

## Wrap Build is failing

### Verify your images are in a PNG format 

Ensure your images are in a PNG format. Using images in any format other than .PNG will cause the wrap build to fail. Please use an image converter tool or ensure your original image is in a PNG format instead. 

> [!IMPORTANT]
> Note that manually changing your image file extension from .JPEG or any other formats to a .PNG will not automaticallt re-format the image to a PNG format.


### Verify your App Center is correctly configured 
Ensure your App Center link is created as an App within an Org, and not a standalone App. 

[BuildFail_1.png] 


Ensure the access token you created is correct. 

- Correct: Click on your created App -> Settings -> App API Tokens 

- Incorrect: Account Settings -> User API Tokens 

Ensure your iOS or Android App created has the right settings configurations. 

- iOS: OS=Custom 

- Android: OS=Android, Platform=React Native 

 
For more information, refer to Steps 8 and 9 in [Create an App Center container for your mobile app](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#create-an-app-center-container-for-your-mobile-app).

### Verify your Keyvault configuration is correct 
Ensure Azure Service Principal was created and role added (Steps 1-2 in [Set up KeyVault for automated signing](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing)) 

Ensure your Keyvault contains all necessary certificates, secrets and tags for iOS and/or Android: 

- iOS: 2 Tags, 1 Certificate, 1 Secret  

- Android: 1 Tag, 1 Certificate 

For more information, please refer to [Set up KeyVault for automated signing](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing). 

### If you have all the proper configurations, try again. 
If after retries and proper configuration, the build fails, please reach out to our support alias. See details at the end of this document. 

## Cannot save my project or trigger a Build 
- Please update to latest Wrap solution version and try again. 

- Please ensure there are no UI validation errors blocking Save or Build submission. 

## Cannot install a Wrapped Mobile App on a device 
Ensure you have signed the outputted application. You can do so by configuring a Keyvault and providing it at build trigger time, or manually signing. For more details, please refer to: 

- [Setup Keyvault for Automated Signing](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#set-up-keyvault-for-automated-signing)

- [Code sign for iOS](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/code-sign-ios)

- [Code sign for Android](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/code-sign-android) 

Ensure your mobile device meets these [minimum requirements](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/overview#software-and-device-requirements). 


## Cannot sign in to a Wrapped Mobile App or cannot see data  

If you cannot sign in to your Wrapped Mobile App please verify that 

- Your AAD app is properly configured 

- All API permissions have been added correctly. Refer to the below and/or see [Configure API Permissions](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#configure-api-permissions). 


SignInFail_1.png 


- Ensure that admin **Add-AdminAllowedThirdPartyApps** script was run successfully. See [Allow registered apps in your environment](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#allow-registered-apps-in-your-environment) for more information. 

 

- Verify your AAD app type is Multi-tenant. Under your AAD app’s Authentication tab, Supported account types should be “Accounts in any organizational directory (Any Azure AD directory – Multitenant”. 

- Ensure the proper Redirect URI’s have been created for iOS and/or Android. For Android, ensure the hash is provided correctly. For more info, see [these steps](https://docs.microsoft.com/en-us/power-apps/maker/common/wrap/how-to#redirect-uri-format). 

 

 
## Other issues in wrap

For other issues, or if your issue persists after following these steps, please reach out to support alias pamobsup@microsoft.com, include a repro video and/or screenshots, as well as a session id, which can be acquired like so: 



- Login Screen: Bottom Right Gear Icon -> Session Details 

- App Opened:  Shake Device -> Session Details 

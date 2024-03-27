---
title: Error (Server Error in '/' Application) when you sign in to an app that is set up for Azure AD B2C
description: Describes an error that occurs when you try to sign up for or sign in to an app that's set up for Microsoft Azure B2C. This occurs if the policy name is missing or incorrect in the app's web.config file. A resolution is provided.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: B2C
---
# An exception occurs when you sign in to an app that's set up for Azure B2C

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3092592

## Symptoms

When you try to sign up for, or sign in to, an app that's set up for Microsoft Azure B2C, you receive the following error message:

> Server Error in '/' Application"
>
> Response status code does not indicate success: 404 (Not Found)
>
> Description : An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.
>
> Exception Details : System.Net.WebException: The remote server returned an error. 404 (Not Found)
>
> Source Error :  
Line 106: {  
Line 107: ...  
Line 108: OpenIdConnectConfiguration config = await mgr.GetConfigurationAsync();  
Line 109: ...  
Line 110: }

## Cause

This problem occurs if the **Policy Name** setting for sign-in, password reset, or the user profile is missing or incorrect in the web.config file for your app.

## Resolution

To resolve this issue, follow these steps:

1. Open the web.config file for your app.
2. In this file, verify the following:
   - The ida:SignInPolicyId  app key exists, and you've replaced the value with the name of the Sign-in policy that you provided in the Azure B2C Admin Portal.
   - The ida:PasswordResetPolicyId  app key exists, and you've replaced the value with the name of the Sign-in policy that you provided in the Azure B2C Admin Portal.
   - The ida:UserProfilePolicyId  app key exists, and you've replaced the value with the name of the Sign-in policy that you provided in the Azure B2C Admin Portal.

    The web.config file should resemble the following:

    ```console
    <appSettings>
    ...
    <add key="ida:SignInPolicyId" value="B2C_Signin_Policy">
    <add key="ida:PasswordResetPolicyId" value="B2C_PasswordReset_Policy">
    <add key="ida:UserProfilePolicyId" value="B2C_UserProfile_Policy">
    ...
    </appSettings>
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

---
title: Error (Server Error in '/' Application) when you try to sign in to an app that is set up for Azure AD B2C
description: Describes an error that occurs when you try to sign in to an app that is set up for Azure AD B2C.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: B2C
---
# Error when you try to sign in to an app that is set up for Azure AD B2C: Server Error in '/' Application

This article describes an error that occurs when trying to sign in to an app that is set up for Azure AD B2C.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3092588

## Symptoms

When you try to sign in to an app that is set up for Microsoft Azure Active Directory (AD) business to consumer (B2C), you receive the following error message:

> Server Error in '/' Application  
 Response status code does not indicate success: 404 (Not Found)  
 Description : An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.  
 Exception Details : System.Net.Http.HttpRequestException: Response status code does not indicate success: 404 (Not Found)  
 Source Error : An unhandled exception occurred during the execution of the current web request. Information regarding the origin and locations of the exception can be identified using the exception stack trace below.  
 Stack Trace :  
 ...  
 [IOException: Unable to get document from: `https://login.microsoftonline.com/contoso.onmicrosoft.com/.well-known/openid-configuration?p=Policyname`]  

## Cause

The sign-up policy name may be missing or incorrect in the Web.config file for the app.

## Resolution

To fix this issue, follow these steps:

1. Open the Web.config file for the app.
2. In the Web.config file, verify that the app key `ida:SignUpPolicyId` exists.
3. Replace the value of the app key with the name of the sign-up policy that you provided in the Azure AD B2C admin portal.

    The changed part of the file resembles the following:

    ```console
    <appSettings>
    <add key="ida:SignUpPolicyId" value="B2C_Signup_Policy_Name">
    </appSettings>
    ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

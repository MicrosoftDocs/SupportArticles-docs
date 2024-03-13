---
title: Error occurs when you try to sign in to an app that's set up for Azure AD B2C
description: Describes an error that occurs when you try to sign in to an app that's set up for Azure AD B2C.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: B2C
---
# Error occurs when you try to sign in to an app that's set up for Azure AD B2C

This article describes an error that occurs when you try to sign in to an app that's set up for Azure AD B2C.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3092587

## Symptoms

When you try to sign in to an app that is set up for Microsoft Azure Active Directory (AD) business to consumer (B2C), you receive the following error message:

> Sorry, but we're having trouble signing you in  
 We track these errors automatically, but if the problem persists feel free to contact us. In the meantime, please try again.  
 Your administrator hasn't provided any contact details
 Correlation ID:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  
 Timestamp:yyyy-mm-dd hh:mm:ssZ  
 AADB2C: An exception has occurred

## Cause

The client ID may be missing or incorrect in the Web.config file for the app.

## Resolution

To fix this issue, follow these steps:

1. Open the Web.config file for the app.
2. In the Web.config file, find the app key **ida:ClientId**.
3. Replace the value of the app key with the client ID that is provided for your app in the Azure AD B2C admin portal.

    The changed part of the file resembles the following:

    ```console
    <appSettings>
    <add key="ida:ClientId" value="**xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx**">
    </appSettings>
    ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

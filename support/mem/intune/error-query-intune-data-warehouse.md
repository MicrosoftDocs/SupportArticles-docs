---
title: Can't query the Intune Data Warehouse
description: Fixes an issue in which you receive error 'The reply url specified in the request does not match the reply urls configured for the application' when you query the Intune Data Warehouse.
ms.date: 03/30/2020
ms.prod-support-area-path: Intune Data Warehouse
---
# Error AADSTS50011 when you query the Intune Data Warehouse

This article helps you fix an issue in which you receive error 'The reply url specified in the request does not match the reply urls configured for the application' when you query the Intune Data Warehouse.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4505733

## Symptom

When you query the Intune Data Warehouse by using [PowerShell](https://github.com/microsoft/Intune-Data-Warehouse/tree/master/Samples/PowerShell) or a [custom application](/mem/intune/apps/apps-add), you receive an error message that contains the following:

> AADSTS50011: The reply url specified in the request does not match the reply urls configured for the application: '\<application ID assigned by Azure AD>'.

## Cause

This issue occurs if the default redirect URI for the application registration or PowerShell is removed.

## Resolution

To fix the issue, do the following:

- If you use PowerShell, make sure that the default redirect URI is set.

  Here is an example:

  ```powershell
  $redirectUri = "urn:ietf:wg:oauth:2.0:oob"
  ```

- If you use a custom application, follow these steps:

  1. Sign in to the [Azure portal](https://portal.azure.com/).
  2. Select **Azure Active Directory** > **App registrations**.
  3. In the search box, enter the application ID in the error message to find the app.
  4. Select the app, and then select **Authentication** under **Manage**.
  5. Under **Redirect URIs**, add the following URI:

     Type: **Public client (mobile & desktop)**  
     Redirect URI: **urn:ietf:wg:oauth:2.0:oob**

     ![Redirect URI](./media/error-query-intune-data-warehouse/4506350_en_1.png)

## More information

For more information about redirect URIs and app registration, see [Add redirect URI(s) to your application](https://aka.ms/aadv2/redirectUri).

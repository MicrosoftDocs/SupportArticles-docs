---
title: Can't query the Intune Data Warehouse
description: Fixes an issue in which you receive error 'The reply url specified in the request does not match the reply urls configured for the application' when you query the Intune Data Warehouse.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Reporting\Intune Data Warehouse
ms.reviewer: kaushika
---
# Error AADSTS50011 when you query the Intune Data Warehouse

This article helps you fix an issue in which you receive error 'The reply url specified in the request does not match the reply urls configured for the application' when you query the Intune Data Warehouse.

## Symptom

When you query the Intune Data Warehouse by using [PowerShell](https://github.com/microsoft/Intune-Data-Warehouse/tree/master/Samples/PowerShell) or a [custom application](/mem/intune/apps/apps-add), you receive an error message that contains the following:

> AADSTS50011: The reply url specified in the request does not match the reply urls configured for the application: '\<application ID assigned by Azure AD>'.

## Cause

This issue occurs if the default redirect URI for the application registration or PowerShell is removed.

## Solution

To fix the issue, do the following:

- If you use PowerShell, make sure that the default redirect URI is set.

  Here is an example:

  ```powershell
  $redirectUri = "urn:ietf:wg:oauth:2.0:oob"
  ```

- If you use a custom application, follow these steps:

  1. Sign in to the [Azure portal](https://portal.azure.com/).
  2. Select **Microsoft Entra ID** > **App registrations**.
  3. In the search box, enter the application ID in the error message to find the app.
  4. Select the app, and then select **Authentication** under **Manage**.
  5. Under **Redirect URIs**, add the following URI:

     Type: **Public client (mobile & desktop)**  
     Redirect URI: **urn:ietf:wg:oauth:2.0:oob**

     :::image type="content" source="media/error-query-intune-data-warehouse/redirect-uris.png" alt-text="Screenshot of the Redirect URI type and value." lightbox="media/error-query-intune-data-warehouse/redirect-uris.png":::

## More information

For more information about redirect URIs and app registration, see [Add redirect URI(s) to your application](https://aka.ms/aadv2/redirectUri).

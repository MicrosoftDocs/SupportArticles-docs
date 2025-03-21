---
title: Error AADSTS50000 - There Was an Error Issuing a Token or an Issue with Our Sign-In Service
description: Provides a solution to the AADSTS50000 error that occurs when you try to sign in to an Azure app by using Microsoft Entra ID.
ms.service: entra-id
ms.date: 03/12/2025
ms.author: bachoang
ms.custom: sap:Issues Signing In to Applications
---

# Error AADSTS50000 getting a token or signing in to an Azure app

The AADSTS50000 error can occur during the authentication process or token acquisition flow that uses the token endpoint. These errors can have multiple causes. This article provides common scenarios and resolutions for this error.

## Symptoms

When a user tries to sign in to an application that's integrated into Microsoft Entra ID, the user receives the following error message:

> AADSTS50000: There was an error issuing a token or an issue with our sign-in service.

## Cause 1: The user password is expired, invalid, or out of sync

This issue is common in hybrid environments. The user's federated account password might be out of sync between the on-premises Active Directory and Microsoft Entra ID. Additionally, this issue can also occur when a user session is being revoked.

### Solution for cause 1

Reset the user password, and then verify that the new password can successfully authenticate to Microsoft Entra ID.

## Cause 2: Parameters are incorrectly configured in the token acquisition request

This problem commonly occurs in the on-behalf-of (OBO) flow. Certain parameters that are required for token acquisition might be missing or invalid.

### Solution for cause 2

Make sure that the client ID is valid and that other required parameters are configured correctly. For more information, see [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow).

## Cause 3: Consent-related issues

This issue can occur in an OAuth2 Device code grant flow to the token endpoint. After the user signs in to a browser window and accepts the consent dialog, this error occurs.

### Solution for cause 3: Verify application consent settings

1. In the [Azure portal](https://portal.azure.com), make sure that the client application (Service Principal) exists on the tenant's **Enterprise Applications** page. You can search for the application by App ID.
2. Verify that the user can consent to the application. Check the user settings on the **Enterprise Applications** page or review relevant policies that affect user consent.

## Cause 4: Symmetric signing key is used in the application or service principal object

Microsoft Identity Platform (v2 endpoint) tokens must be signed by a certificate (asymmetric key). Errors might occur if a symmetric signing key is used.

### Solution for cause 4

#### Step 1: Check whether symmetric key is used in application object

1. In the Azure portal, go to the **App Registrations**.
2. In the **Manage** section,  select **Manifest**.
3. Check whether an entry exists in the `keyCredentials` section that includes `type=Symmetric` and `usage=Sign`.

    :::image type="content" source="./media/error-code-aadsts50000-issuing-token-sign-in-service/manifest-sample.png" alt-text="Screenshot that shows the Application Manifest Key Credentials code." lightbox="./media/error-code-aadsts50000-issuing-token-sign-in-service/manifest-sample.png":::

Alternatively, use the Microsoft Graph PowerShell cmdlet [Get-MgApplication](/powershell/module/azuread/get-azureadapplicationkeycredential) to retrieve key credentials.

#### Step 2: Check whether symmetric key is used in service principal object

1. If the application is not found in the **App Registrations** page in the Azure portal, browse to the **Enterprise Applications** page.
2. Locate the application, and then get the **Object ID** of the Service Principal.
3. Use [Get-MgServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal) to retrieve the key credentials.

#### Step 3: Remove symmetric signing key

If the symmetric key exists:

- Use [Remove-MgApplicationKey](/powershell/module/microsoft.graph.applications/remove-mgapplicationkey) to remove the symmetric key for the app registration.
- Use [Remove-MgServicePrincipalKey](/powershell/module/microsoft.graph.applications/remove-mgserviceprincipalkey) to remove the symmetric key for the service principal object.

If a signing key is required, use a signing certificate instead. For more information, see [SAML-based single sign-on: Configure a signing certificate](/graph/application-saml-sso-configure-api?tabs=http%2Cpowershell-script#step-6-configure-a-signing-certificate).

## Cause 5: No delegated permission exposed in the resource application (web API)

This error might occur in the following scenario:

- You have a multitenant resource application that's registered in Tenant A. This application exposes only the **Application Permission** type.
- In Tenant B, you have a client application registered. In the **API permission** page for this application, you configure the permission for the resource application that's registered in Tenant A.
- You use an OAuth 2 delegated grant flow (for instance auth code grant flow) to request an access token for the resource app that uses `/.default` as the value of the web API scope.

### Solution for cause 5

Configure the resource application to expose the delegated permission, and then consent to that delegated permission in the client application.

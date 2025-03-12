---
title: Error AADSTS50000 - There was an error issuing a token or an issue with our sign-in service
description: Provides a solution to the AADSTS50000 error that occurs when you try to sign in to an Azure app using Microsoft Entra ID.
ms.service: entra-id
ms.date: 03/12/2025
ms.author: bachoang
ms.custom: sap:Issues Signing In to Applications
---

# Error AADSTS50000 with issuing a token or an issue with sign-in service

The AADSTS50000 error can occur during the authentication process or token acquisition flow using the token endpoint. Multiple causes can lead to these errors, and this article provides common scenarios and their resolutions.

## Symptoms

When a user tries to sign in to an application that's integrated into Microsoft Entra ID, the user receives the following error message:

> AADSTS50000: There was an error issuing a token or an issue with our sign-in service.

## Cause 1: The user password is expired, invalid, or out of sync

This issue is common in hybrid environments. The user's federated account password may be out of sync between the on-premises Active Directory and Microsoft Entra ID. Additionally, this issue can also occur when a user session is being revoked.

### Solution for cause 1

Reset the user password, and then verify the new password can authenticate successfully to Microsoft Entra ID.

## Cause 2: Parameters are incorrectly configured in the token acquisition request

The issue commonly occurs in the on-behalf-of (OBO) flow. Certain parameters required for token acquisition may be missing or invalid.

### Solution for cause 2

Make sure the client ID is valid and other required parameters are configured correctly. For more information, see [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow).

## Cause 3: Consent-related issues

This issue can occur in an OAuth2 Device code grant flow to the token endpoint. After the user signs in to a browser window and accepts the consent dialog, this error occurs.

### Solution 3 for cause 3: verify application consent settings

1. Go to the [Azure portal](https://portal.azure.com), make sure that the client application (Service Principal) exists in the tenant's **Enterprise Applications** page. You can search for the application by App ID.
2. Verify that the user has the ability to consent to the application. Check user settings in the **Enterprise Applications** page or review relevant policies affecting user consent.

## Cause 4: Symmetric signing key is used in the application or service principal object

Microsoft Identity Platform (v2 endpoint) tokens must be signed by a certificate (asymmetric key). Errors may occur if a symmetric signing key is used.

### Solution for cause 4

#### Step 1: Check if symmetric key is used in application object

1. In the Azure portal, go to the **App Registrations**.
2. In the **Manage** section,  select **Manifest**.
3. Check if there is an entry in the `keyCredentials` section with `type=Symmetric` and `usage=Sign`.

    :::image type="content" source="./media/error-code-aadsts50000-issuing-token-sign-in-service/manifest-sample.png" alt-text="Application Manifest Key Credentials" lightbox="/media/error-code-aadsts50000-issuing-token-sign-in-service/manifest-sample.png":::

Alternatively, use the AzureAD PowerShell cmdlet [Get-AzureADApplicationKeyCredential](/powershell/module/azuread/get-azureadapplicationkeycredential) to retrieve key credentials.

#### Step 2: Check if symmetric key is used in service principal object

1. If the application is not found in the **App Registrations** page in the Azure portal, browse to the **Enterprise Applications** page.
2. Locate the application, and then get the **Object ID** of the Service Principal.
3. Use the AzureAD PowerShell cmdlet [Get-AzureADServicePrincipalKeyCredential](/powershell/module/azuread/get-azureadserviceprincipalkeycredential) to retrieve key credentials.

#### Step 3: Remove symmetric signing key

If the symmetric key exits, use:

- [Remove-AzureADApplicationKeyCredential](/powershell/module/azuread/remove-azureadapplicationkeycredential) to remove the symmetric key for the app registration.
- [Remove-AzureADServicePrincipalKeyCredential](/powershell/module/azuread/remove-azureadserviceprincipalkeycredential) to remove the symmetric key for the service principal object.

If a signing key is required, use a signing certificate instead. For more information, see [SAML-based single sign-on: Configure a signing certificate](/graph/application-saml-sso-configure-api?tabs=http%2Cpowershell-script#step-6-configure-a-signing-certificate).

## Cause 5: No delegated permission exposed in the resource application (web API)

This error can occur in the following scenario:

- You have a multitenant resource application registered in tenant A. This application exposes only **Application Permission** type.
- In a different tenant B, you have a client application registered. In the **API permission** page for this application, you configure the permission for the resource application registered in the other tenant.
- Then, you use an OAuth2.0 On-Behalf-Of (delegation) flow to request an access token for the resource app with the `/.default` for the web API scope.

### Solution for cause 5

Configure the resource application to expose delegated permission and consent to that delegated permission in the client application.
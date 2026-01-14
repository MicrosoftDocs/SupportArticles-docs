---
title: Error AADSTS650056 - Misconfigured application
description: Provides solutions for the AADSTS650056 misconfiguration error.
ms.date: 05/19/2025
ms.reviewer: willfid
ms.service: entra-id
ms.custom: sap:Issues Signing In to Applications
---

#  Error AADSTS650056: Misconfigured application

This article provides troubleshooting steps and solutions for the "AADSTS650056: Misconfigured application" error.

## Symptoms

When you try to sign in to a web application that uses Microsoft Entra ID, you receive the following error message:

> AADSTS650056: Misconfigured application. This could be due to one of the following: The client has not listed any permissions for 'AAD Graph' in the requested permissions in the client’s application registration. Or, The admin has not consented in the tenant. Or, Check the application identifier in the request to ensure it matches the configured client application identifier. Please contact your admin to fix the configuration or consent on behalf of the tenant.

## Cause

This error typically occurs for one of the following reasons:

- The Issuer that's provided in the SAMLRequest is not valid.
- The application doesn't have the required permissions to call Microsoft Graph APIs.
- The admin hasn't consented to the permissions for the application on behalf of the tenant.

## Solution 1: The Issuer provided in the SAMLRequest is not valid （for SAML Authentication flows）

In the following SAML request example, the Issuer value must match the Identifier (Entity ID) that's configured in the enterprise application. This value is also known as the *Identifier URI* or *App ID URI*. For example, a SAML request might resemble the following request:

```
<samlp:AuthnRequest xmlns="urn:oasis:names:tc:SAML:2.0:metadata" ID="id6c1c178c166d486687be4aaf5e482730" Version="2.0" IssueInstant="2013-03-18T03:28:54.1839884Z" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"> <Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">https://www.contoso.com</Issuer> </samlp:AuthnRequest> 
```

In this example, the Identifier URI is `https://www.contoso.com`.

To fix a mismatch, do one of the following actions:

- Update the Identifier in the enterprise application so that it matches the Issuer in the SAML request.
- Update the SaaS application configuration on the vendor side so that it passes the correct Issuer.

## Solution 2: Verify application permissions and consent

If your organization owns the application, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com), go to the **App registrations** screen, select your app registration, and then select **API permissions**.
2. Make sure that the application has at least the **User.Read** delegated permission from **Microsoft Graph**.
3. Check the **Status** field to determine whether the permissions are consented to. For example:
    - If the permission isn't consented to, the value appears as **Pending** or blank.
    - If the permission is successfully consented to, the value appears as "Granted for [Tenant Name]."

    Example of a consented permission:

    :::image type="content" source="./media/error-code-AADSTS650056-misconfigured-app/graph-api-permissions.png" alt-text="Screenshot of adding Graph API permissions." :::

If your organization isn't the application owner, follow these steps:

1. Sign in to the application by using a Global Administrator account. You should see a consent screen that prompts you to grant permissions. Make sure that you select the **Consent on behalf of your organization** option before you proceed.

    Example of the consent screen:

    :::image type="content" source="./media/error-code-AADSTS650056-misconfigured-app/consent-permissions.png" alt-text="Screenshot of consent screen" :::

2. If you don't see the consent screen, delete the application from the **Enterprise applications** section in Microsoft Entra ID, and then try again to sign in.

If the error persists, go to the next solution.

## Solution 3: Manually build the consent URL

If the application is designed to access a specific resource, you might not be able to use the **Consent** button in the Azure portal. Instead, you might have to manually generate a consent URL, and then open the URL to grant permissions to the application.

### For the authorization V1 endpoint

The consent URL resembles the following text:

```HTTP
https://login.microsoftonline.com/{Tenant-Id}/oauth2/authorize?response\_type=code
&client\_id={App-Id}
&resource={App-Uri-Id}
&scope=openid
&prompt=consent
```

For example:

```HTTP
https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/authorize
?response\_type=code
&client\_id=044abcc4-914c-4444-9c3f-48cc3140b6b4
&resource=https://vault.azure.net/
&scope=openid
&prompt=consent
```
### For the authorization V2 endpoint

The consent URL resembles the following text:

```HTTP
https://login.microsoftonline.com/{Tenant-Id}/oauth2/v2.0/authorize
?response_type=code
&client_id={App-Id}
&scope=openid+{App-Uri-Id}/{Scope-Name}
&prompt=consent
```

For example:

```HTTP
https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize
?response_type=code
&client_id=044abcc4-914c-4444-9c3f-48cc3140b6b4
&scope=openid+https://vault.azure.net/user_impersonation
&prompt=consent
```

- If the application accesses itself as the resource, **{App-Id}** and **{App-Uri-Id}** are the same.
- You can get the **{App-Id}** and **{App-Uri-Id}** values from the application owner.
- **{Tenant-Id}** corresponds to your tenant identifier. This value can be either your domain or your directory ID.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

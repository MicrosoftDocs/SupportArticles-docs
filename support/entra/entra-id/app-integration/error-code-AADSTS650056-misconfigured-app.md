---
title: Error AADSTS650056 - Misconfigured application
description: Provides solutions for the AADSTS650056 misconfiguration error.
ms.date: 05/19/2025
ms.reviewer: willfid
ms.service: entra-id
ms.custom: sap:Issues Signing In to Applications
---

#  Error AADSTS650056 - Misconfigured application

This article provides troubleshooting steps and solutions for the error message AADSTS650056: Misconfigured application.

## Symptoms

When you try to sign in to a web application that uses Microsoft Entra ID, you might encounter the following error message:

> AADSTS650056: Misconfigured application. This could be due to one of the following: The client has not listed any permissions for 'AAD Graph' in the requested permissions in the client’s application registration. Or, The admin has not consented in the tenant. Or, Check the application identifier in the request to ensure it matches the configured client application identifier. Please contact your admin to fix the configuration or consent on behalf of the tenant.

## Cause

This error usually occurs due to one of the following reasons:

- The Issuer provided in the SAMLRequest is not valid.
- The application does not have the required permissions to call Microsoft Graph APIs.
- The admin has not consented to the permissions for the application on behalf of the tenant.

## Solution 1 for SAML Authentication flows - The Issuer provided in the SAMLRequest is not valid

In the SAML request below, the Issuer value must match the Identifier (Entity ID) configured in the enterprise application. This value is also known as the Identifier URI or App ID URI. For example, a SAML request might look like this:

```
<samlp:AuthnRequest xmlns="urn:oasis:names:tc:SAML:2.0:metadata" ID="id6c1c178c166d486687be4aaf5e482730" Version="2.0" IssueInstant="2013-03-18T03:28:54.1839884Z" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"> <Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">https://www.contoso.com</Issuer> </samlp:AuthnRequest> 
```

In this example, the Identifier URI is `https://www.contoso.com`.

To fix a mismatch, do one of the following:

- Update the Identifier in the enterprise application to match the Issuer in the SAML request.
- Update the SaaS application configuration on the vendor side so that it passes the correct Issuer.


## Solution 2: Verify application permissions and consent

If your organization owns the application, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com), go to the **App registrations**, select your app registration, and then select **API permissions**.
2. Make sure that the application has at least the **User.Read** delegated permission from **Microsoft Graph**.
3. Check the **Status** to verify whether the permissions are consented to. For example:
    - If the permission isn't consented to, it will appear as **Pending** or blank.
    - If successfully consented, it will appear as "Granted for [Tenant Name]".

    Example of a consented permission:

    :::image type="content" source="./media/error-code-aadsts650056-misconfigured-app-graph/graph-api-permissions.png" alt-text="Screenshot of adding Graph API permissions." :::

If your organization isn't the application owner, follow these steps:

1. Sign in to the application by using Global Administrator account. You should see a consent screen prompting you to grant permissions. Make sure that you select the **Consent on behalf of your organization** option before proceeding.

    Example of the consent screen:
:::image type="content" source="./media/error-code-aadsts650056-misconfigured-app-graph/consent-permissions.png" alt-text="Screenshot of consent screen" :::
2. If you don't see the consent screen, delete the application from the **Enterprise applications** section in Microsoft Entra ID and try signing in again.

If the error persists, proceed to the next solution.

## Solution 3: Manually build the consent URL

If the application is designed to access a specific resource, you may not be able to use the **Consent** button from the Azure portal, you may need to manually generate a consent URL, and open the URL to grant permissions to the application.

### For the authorization V1 endpoint:

The consent URL will look like this:

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
### For the authorization V2 endpoint:

The consent URL will look like this:

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

- If the application is accessing itself as the resource, the **{App-Id}** and **{App-Uri-Id}** will be the same.
- You can get the **{App-Id}** and **{App-Uri-Id}** from the application owner.
- The **{Tenant-Id}** corresponds to your tenant identifier, which can be either your domain or your directory ID.

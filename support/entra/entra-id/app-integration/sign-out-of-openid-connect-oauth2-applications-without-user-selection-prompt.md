---
title: Bypass User Selection Prompt When Signing Out of OpenID Connect/OAuth2 Applications
description: Describes how to sign out of an OpenID Connect/OAuth2 application without a user selection prompt.
ms.service: entra-id
ms.date: 06/09/2025
ms.reviewer: willfid, v-weizhu
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
ms.topic: how-to
---
# How to sign out of OpenID Connect/OAuth2 applications without a user selection prompt

By default, when you sign out of an OpenID Connect/OAuth2 application registered in Microsoft Entra ID, you're prompted to select a user account to sign out of, even if only one account is available. This article provides a step-by-step guide to bypass this behavior.

## Step 1: Add an optional claim for login\_hint

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).
2. Browse to **Entra ID** > **App registrations**.
3. Select the application for which you want to configure optional claims.
    1. Under **Manage**, select **Token configuration**.
    2. Select **Add optional claim**.
    3. Select the token type you want to configure, such as **ID**.
    4. Select the optional claim **login_hint** to add.
    5. Select **Add**.

:::image type="content" source="media/sign-out-of-openid-connect-oauth2-applications-without-user-selection-prompt/login-hint-optional-claim.png" alt-text="Screenshot that shows the login_hint claim." lightbox="media/sign-out-of-openid-connect-oauth2-applications-without-user-selection-prompt/login-hint-optional-claim.png":::

For more information about adding optional claims, see [Configure and manage optional claims in ID tokens, access tokens, and SAML tokens](/entra/identity-platform/optional-claims).

## Step 2: Ensure the "profile" and "openid" scopes are included in the original sign-in request

Here are two examples of including both the `openid` and `profile` OpenID connect scopes in the request URL:

- If you use the authorization code flow:

    ```http
    https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?
    response_type=code&client_id=<client_id>&scope=openid+user.read+profile&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient
    ```

    During the token endpoint call, when you acquire an access token, an `id_token` is also returned.

- If you use the implicit flow (not recommended):

    ```HTTP
    https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?
    response_type=id_token&client_id=<client_id>&scope=openid+user.read+profile&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient
    ```

    After sign-in, when Microsoft Entra ID redirects back to your application, an `id_token` is returned.

In the returned `id_token`, the value of the `login_hint` claim is included.

## Step 3: Pass the logout\_hint parameter in the sign-out request

When you send a sign-out request, pass the `logout_hint` parameter along with the value of the `login_hint` claim in the sign-out request:

```http
https://login.microsoftonline.com/<username>.onmicrosoft.com/oauth2/v2.0/logout?
post_logout_redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient
&logout_hint=<login_hint_claim_value>
```

## More information

For applications using Microsoft Authentication Library for JavaScript (MSAL.js), when you send an `EndSessionRequest` with a user account, MSAL.js automatically sends the `logout_hint` parameter along with the `login_hint` claim if detected.

Here's an example code snippet:

```typescript
logout() {
    var account = this.authService.instance.getAllAccounts()[0];
    let logoutRequest:EndSessionRequest = {
      account: account
    };
 
    this.authService.logout(logoutRequest);
  }
```

For applications using Microsoft Identity Web or ASP.NET (Core) OpenID Connect authentication, you can add custom code to set the `logout_hint` parameter in the sign-out request.

Here's an example code snippet:

```csharp
services.Configure<OpenIdConnectOptions>(OpenIdConnectDefaults.AuthenticationScheme, options =>

{

  // Custom code here.
  options.Events.OnRedirectToIdentityProviderForSignOut = (context) =>

  {

    var login_hint = context.HttpContext.User.Claims.Where(c => c.Type == "login_hint").FirstOrDefault();

    if (login_hint != null)

    {

      context.ProtocolMessage.SetParameter("logout_hint", login_hint.Value);

    };

    return Task.FromResult(true);

  };

});
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

---
title: Troubleshoot IDX10501 Error in ASP.NET Core app with Azure B2C Custom Policy
description: Provides guidance for troubleshooting the IDX10501 error in ASP.NET Core with Azure B2C.
ms.date: 01/06/2025
ms.author: markbukovich
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# IDX10501 error in ASP.NET Core app with Azure B2C custom policy

This guide discusses the cause of the "IDX10501" error, and provides a step-by-step solution to resolve it.

## Symptoms
When you [implement a custom policy](/azure/active-directory-b2c/enable-authentication-web-application-options#pass-the-azure-ad-b2c-policy-id) in an ASP.NET Core application that integrates with Azure Active Directory B2C (Azure AD B2C), you might encounter the following IDX10501 error:

> IDX10501: Signature validation failed. Unable to match key: kid: '[PII of type 'System.String' is hidden. For more details, see https://aka.ms/IdentityModel/PII.]'. Number of keys in TokenValidationParameters: '0'. Number of keys in Configuration: '1'. Exceptions caught: '[PII of type 'System.Text.StringBuilder' is hidden. For more details, see https://aka.ms/IdentityModel/PII.]'. token: '[PII of type 'System.IdentityModel.Tokens.Jwt.JwtSecurityToken' is hidden. For more details, see https://aka.ms/IdentityModel/PII.]'.

## Understanding the error

Why is this error generated when the custom policy redirects to your app? In ASP.NET Core, whenever a user is authenticated and authorized, and a redirect page exists to the web app that contains an ID token, ASP.NET Core middleware tries to validate this ID token to make sure that the redirect is genuine. To validate the ID token, the middleware requires the public key of the signing certificate that was used to sign the ID token. The middleware gets this public key by querying Azure Active Directory B2C. Specifically, the middleware uses a "metadata" endpoint in Azure Active Directory B2C that provides authentication information, including any public keys for signing certificates.

When you create a custom policy, you're required to create or upload a signing certificate. This signing certificate is different from that used for built-in user flows in Azure Active Directory B2C. This means that the public keys that are accessible from the "metadata" endpoint for your Azure Active Directory B2C won't contain the public key for your custom policy. The custom policy actually has its own metadata endpoint.

The endpoint that the middleware uses is configured by Microsoft.Identity.Web and is set at app startup. Because the metadata URL is already set, invoking a custom policy during runtime creates a scenario in which the middleware is looking at the wrong metadata URL while it validates the returning token.

## Solution

To resolve this issue, you must configure the correct metadata endpoint for the additional custom policy. To do this, create a second authentication scheme to handle the custom policy. By having this additional authentication scheme, you can set the correct metadata endpoint at startup. This process uses the following steps:

1. Add an additional redirect URI to your app registration.
2. Configure an additional B2C authentication scheme in your app.
3. Add an action to the desired controller.
4. Implement the created action in the layout.

Code sample: [ASP.NET Core Web App with Custom B2C Policy](https://github.com/mbukovich/ExtraB2CPolicyMVC).

### Prerequisites

Before you continue this process, make sure that you have:

- An Azure B2C directory
- An app registration for B2C authentication
- [Standard user flows that are set up](/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-user-flow)
- [A custom B2C policy that's added to your directory](/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-custom-policy)
- An existing ASP.NET Core web app that's configured by having Microsoft.Identity.Web for B2C authentication 

   For more information, see [Enable authentication in your own web app by using Azure AD B2C](/azure/active-directory-b2c/enable-authentication-web-application?tabs=visual-studio)

### Step 1: Add an additional redirect URI

In the app registration, you have to add another redirect URI for the custom policy. In this case, you can't use the existing redirect URI because it could cause confusion for the web app. You'll be setting up two different authentication schemes. However, when the B2C policy redirects to the web app, the middleware won't know which authentication scheme to use. Therefore, you need a separate redirect URI to clearly distinguish between redirects from the existing and new authentication schemes. 

Follow these steps:

1. Navigate to your app registration in the [Azure portal](https://portal.azure.com).
2. In the **Manage** section, select **Authentication**.
3. In the **Redirect URIs** section, select **Add URI**.
4. Add a redirect URI. In this case, the new redirect URI is `https://localhost:44321/signin-oidc-editemail`.

  :::image type="content" source="media/troubleshoot-error-idx10501-aspnet-b2c/add-redirect-uri.png" alt-text="Screenshot of adding Redirect URIs." lightbox="media/troubleshoot-error-idx10501-aspnet-b2c/add-redirect-uri.png":::

> [!NOTE]
> Each custom policy requires its own redirect URI. For example, if you're adding two custom policies, you have to create two authentication schemes and two redirect URIs.

### Step 2: Configure an Additional Authentication Scheme

This process involves adding an action to your controller that issues a challenge to the user. Before you create this action, configure the app with an additional authentication scheme. This requires updating both the Appsettings.json file and the Startup.cs file.

#### Update `Appsettings.json`

Add the following configuration for your custom policy:

```json
"<name-of-your-configuration>": {
    "Instance": "https://<B2C-tenant-name>.b2clogin.com",
    "ClientId": "<client-id-of-your-app-registration>",
    "CallbackPath": "/<endpoint-of-your-new-redirect-uri>",
    "SignedOutCallbackPath": "/signout/<built-in-sign-in-sign-up-policy>",
    "Domain": "<B2C-tenant-name>.onmicrosoft.com",
    "SignUpSignInPolicyId": "<built-in-sign-in-sign-up-policy>"
},
```

Example of `Appsettings.json`

```json
{
  "AzureADB2C": {
    "Instance": "https://markstestorganization1.b2clogin.com",
    "ClientId": "09717d12-ca7f-4388-8393-dafe42c0c3a5",
    "CallbackPath": "/signin-oidc",
    "SignedOutCallbackPath": "/signout/B2C_1_signupsignin1",
    "Domain": "markstestorganization1.onmicrosoft.com",
    "SignUpSignInPolicyId": "B2C_1_signupsignin1",
    "ResetPasswordPolicyId": "B2C_1_PasswordReset1",
    "EditProfilePolicyId": "B2C_1_editProfileTest1"
  },
  "AzureADB2CEditEmail": {
    "Instance": "https://markstestorganization1.b2clogin.com",
    "ClientId": "09717d12-ca7f-4388-8393-dafe42c0c3a5",
    "CallbackPath": "/signin-oidc-editemail",
    "SignedOutCallbackPath": "/signout/B2C_1_signupsignin1",
    "Domain": "markstestorganization1.onmicrosoft.com",
    "SignUpSignInPolicyId": "B2C_1_signupsignin1"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*"
}
```
**Important considerations**

- You can choose any name for the second B2C configuration. This configuration will be used for a single custom policy. If you have to add more custom policies, you must include additional B2C configurations in the AppSettings.json file. For this reason, we recommend that you give the JSON object a name that reflects the associated custom policy.
- The CallbackPath value is the portion of the redirect URI that follows the domain. For example, if your redirect URI is `https://localhost:44321/signin-oidc-editemail`, then CallbackPath will be `/signin-oidc-editemail`.
- You must include the standard built-in sign-up/sign-in user flow in the authentication scheme to make sure that users are prompted to sign in if they try to access your custom policy without being signed-in.

#### Update `Startup.cs`

Configure an additional authentication scheme in the Startup.cs file. In the `ConfigureServices` function, add the following code:

```csharp
// Create another authentication scheme to handle extra custom policy
services.AddAuthentication()
       .AddMicrosoftIdentityWebApp(Configuration.GetSection("<name-of-json-configuration>"), "<Arbitrary-name-for-Auth-Scheme>", "<Arbitrary-name-of-Cookie-Scheme>");

services.Configure<OpenIdConnectOptions>("<Arbitrary-name-for-Auth-Scheme>", options =>
    {
        options.MetadataAddress = "<Metadata-Address-for-Custom-Policy>";
    });
```

- You have to set custom names for both your authentication scheme and the associated cookie scheme. Microsoft.Identity.Web will create these schemes by using the names that you specify.

- Replace `<name-of-json-configuration>` with the name of the JSON configuration from the previous step. Per the example in this article, this should be `AzureADB2CEditEmail`.

- Replace `<Your-Custom-Metadata-URL>` with the OpenID Connect discovery endpoint URL that's found under your custom policy in Azure AD B2C.

#### How to get the metadata address for custom policy

It's important to get the metadata address because this will be used by the middleware to get the required information to validate ID tokens that are returned by the custom policy. 

To find the metadata address, follow these steps:

1. Log in to the Azure B2C portal. 
1. In **Policies** section, select **Identity Experience Framework**.

    :::image type="content" source="media/troubleshoot-error-idx10501-aspnet-b2c/find-identity-exp-fr.png" alt-text="Screenshot of the Identity Experience Framework button.":::
1. Select **Custom policies**, and then select the custom policy that you're using. In this case, it's **B2C_1A_DEMO_CHANGESIGNINNAME**.

    :::image type="content" source="media/troubleshoot-error-idx10501-aspnet-b2c/custom-policy.png" alt-text="Screenshot of checking custom-policy.":::
1. The metadata address is the URL that's listed under **OpenId Connect Discovery Endpoint**. Copy this URL, and paste it as the value for the `options.MetadataAddress` variable.

### Step 3: Add an action to the controller

In your controller, implement an action to trigger the Custom B2C Policy challenge for the user. In code sample, the action is added to the Home Controller for simplicity. Add the following code to your controller, and adjust the values and action name to meet your scenario. This code snippet can be found on line 40 of the `HomeController.cs` file in the `Controllers` folder in the code sample:

```csharp
[Authorize]
public IActionResult EditEmail()
{
    var redirectUrl = Url.Content("~/");
    var properties = new AuthenticationProperties { RedirectUri = redirectUrl };
    properties.Items["policy"] = "B2C_1A_DEMO_CHANGESIGNINNAME";
    return Challenge(properties, "B2CEditEmail");
}
```

Make sure that `<Your-Custom-Policy>` matches your specific policy name and `<CustomAuthScheme>` is consistent with what you configured earlier.

### Step 4: Implement action in layout

Implement the action in the layout so that the user can actually invoke the custom policy. In the code sample, the following snippet adds a button alongside the existing B2C buttons, based on the [tutorial](/azure/active-directory-b2c/enable-authentication-web-application). The snippet is added to line 13 of the `_LayoutPartial.cshtml` file in the `Views/Shared` folder. Note that the `asp-controller` property is set to `Home` to reference the Home Controller, and the `asp-action property` is set to `EditEmail` to reference the action that's created in the Home Controller. For more information, see [Add the UI elements](/azure/active-directory-b2c/enable-authentication-web-application?tabs=visual-studio#step-4-add-the-ui-elements).

```html
<li class="navbar-btn">
    <form method="get" asp-area="" asp-controller="Home" asp-action="EditEmail">
        <button type="submit" class="btn btn-primary">Edit Email</button>
    </form>
</li>
```

If you have an existing app that doesn’t use the partial layout, and you want only a quick link to test the custom policy, you can use the following tag to create a basic link. Make sure that you replace the indicated values and reference the correct controller if you didn’t add your action to the Home Controller.

```html
<a asp-area="" asp-controller="Home" asp-action="replace-with-your-controller-action">Replace with text that describes the action</a>
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

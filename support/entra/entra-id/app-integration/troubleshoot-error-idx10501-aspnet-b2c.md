---
title: Troubleshoot IDX10501 Error in ASP.NET Core with Azure B2C Custom Policy
description: Provides guidance for troubleshooting IDX10501 Error in ASP.NET Core with Azure B2C.
ms.date: 01/06/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Microsoft Entra App Integration and Development
---

# IDX10501 Error in ASP.NET Core with Azure B2C Custom Policy

This guide helps you understand the cause of the IDX10501 error and provide a step-by-step solution to resolve it.

## Symptoms
When you [implement a custom policy](/azure/active-directory-b2c/enable-authentication-web-application-options#pass-the-azure-ad-b2c-policy-id) in an ASP.NET Core application that integrates with Azure Active Directory B2C (Azure AD B2C), you may encounter the following IDX10501 error:

> IDX10501: Signature validation failed. Unable to match key: kid: '[PII of type 'System.String' is hidden. For more details, see https://aka.ms/IdentityModel/PII.]'. Number of keys in TokenValidationParameters: '0'. Number of keys in Configuration: '1'. Exceptions caught: '[PII of type 'System.Text.StringBuilder' is hidden. For more details, see https://aka.ms/IdentityModel/PII.]'. token: '[PII of type 'System.IdentityModel.Tokens.Jwt.JwtSecurityToken' is hidden. For more details, see https://aka.ms/IdentityModel/PII.]'.

## Understanding the Error

First, let’s understand why this error is being thrown when the custom policy redirects back to your app. In ASP.NET Core, whenever a user is authenticated and authorized, and there's a redirect back to the Web app that contains an ID Token. ASP.NET Core middleware will try to validate this ID Token to make sure that the redirect is genuine. To validate the ID Token, the Middleware needs the public key of the signing certificate which was used to sign the ID Token. The Middleware gets this public key by querying Azure Active Directory B2C. Specifically, there's a "metadata" endpoint in Azure Active Directory B2C used by the Middleware which provides authentication information including any public keys for signing certificates.

When you created your custom policy, you were required to create or upload a signing certificate. This signing certificate is different from that used for built-in user flows in Azure Active Directory B2C. This means that the public keys accessible from the "metadata" endpoint for your Azure Active Directory B2C won't contain the public key for your custom policy. The custom policy actually has its own metadata endpoint.

The endpoint which the Middleware uses is configured by Microsoft.Identity.Web and set at app startup. Since the metadata URL is already set, invoking a custom policy during runtime will result in a scenario where the Middleware is looking at the wrong metadata URL while validating the returning token.

## Solution

To resolve this issue, you must configure the correct metadata endpoint for the additional Custom Policy. To do this, create a second authentication scheme to handle the custom policy. With this additional authentication scheme, we can set the correct metadata endpoint at startup. Below is a brief overview of the steps involved:

1. Add an additional redirect URI to your App Registration.
2. Configure an additional B2C authentication scheme in your app.
3. Add an action to the desired controller.
4. Implement the created action in the Layout.

Code sample: [ASP.NET Core Web App with Custom B2C Policy](https://github.com/mbukovich/ExtraB2CPolicyMVC).

### Prerequisites

Before continuing, Ensure you have:

- An Azure B2C directory
- An app registration for B2C authentication
- [Standard user flows set up](/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-user-flow)
- [A custom B2C policy added to your directory](/azure/active-directory-b2c/tutorial-create-user-flows?pivots=b2c-custom-policy)
- An existing ASP.NET Core web app configured with Microsoft.Identity.Web for B2C authentication. For more information, see [Enable authentication in your own web app by using Azure AD B2C](/azure/active-directory-b2c/enable-authentication-web-application?tabs=visual-studio)

### Step 1: Add an Additional Redirect URI

In the App Registration, you need to add another redirect URI for the custom policy. The reason you can't use the existing redirect URI in this case is that it could cause confusion for the Web App. We'll set up two different authentication schemes, but when the B2C policy redirects back to the Web App, the Middleware won't know which authentication scheme to use. Thus, we need a separate redirect URI to clearly distinguish redirects from the existing and new authentication schemes.

1. Navigate to your app registration in the [Azure Portal](https://portal.azure.com).
2. In the **Manage** section, select **Authentication**.
3. In the **Redirect URIs** section, select **Add URI**.
4. Add a new redirect URI. In this article, the new redirect URI is `https://localhost:44321/signin-oidc-editemail`.

  :::image type="content" source="media/troubleshoot-error-idx10501-aspnet-b2c/add-redirect-uri.png" alt-text="Screenshot of adding Redirect URIs." lightbox="media/troubleshoot-error-idx10501-aspnet-b2c/add-redirect-uri.png":::

> [!NOTE]
> Each custom policy requires its own redirect URI. For example, if you're adding two custom policies, you will need to create two authentication scheme and two redirect URIs.

### Step 2: Configure an Additional Authentication Scheme

This process involves adding an action to your controller that will issue a challenge to the user. Before creating this action, we need to configure the app with an additional authentication scheme. This requires updating both the appsettings.json file and the Startup.cs file.

#### Update `appsettings.json`

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

Example of the `appsettings.json`

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
**Important Considerations**

- You can choose any name for the second B2C configuration. This configuration will be used for a single custom policy. If you need to add more custom policies, you'll have to include additional B2C configurations in the AppSettings.json file. For this reason, it's recommended to give the JSON object a name that reflects the associated custom policy.
- The CallbackPath is the portion of the Redirect URI that follows the domain. For example, if your redirect URI is `https://localhost:44321/signin-oidc-editemail`, then the CallbackPath will be `/signin-oidc-editemail`.
- You need to include the standard built-in sign-up/sign-in user flow in the authentication scheme to ensure that users are prompted to sign in if they try to access your custom policy without signed-in.

#### Update `Startup.cs`

Configure an additional authentication scheme in the startup.cs file. In the `ConfigureServices` function, add the following code:

```csharp
// Create another authentication scheme to handle extra custom policy
services.AddAuthentication()
       .AddMicrosoftIdentityWebApp(Configuration.GetSection("<name-of-json-configuration>"), "<Arbitrary-name-for-Auth-Scheme>", "<Arbitrary-name-of-Cookie-Scheme>");

services.Configure<OpenIdConnectOptions>("<Arbitrary-name-for-Auth-Scheme>", options =>
    {
        options.MetadataAddress = "<Metadata-Address-for-Custom-Policy>";
    });
```

- You will need to set custom names for both your authentication scheme and the associated cookie scheme. Microsoft.Identity.Web will create these schemes using the names you specify.

- Additionally, replace `<name-of-json-configuration>` with the name of the JSON configuration from the previous step. In the example of this article, it should be `AzureADB2CEditEmail`.

- Replace `<Your-Custom-Metadata-URL>` with the OpenID Connect discovery endpoint URL found under your custom policy in Azure AD B2C.

#### How to get the Metadata address for Custom Policy

It's important to get the Metadata address. This will be used by the middleware to get the information necessary to validate ID Tokens returned by the Custom Policy. 

To find the metadata address, follow these steps:

1. Log in to the Azure B2C portal. 
2. In **Policies** section, select **Identity Experience Framework**.

    :::image type="content" source="media/troubleshoot-error-idx10501-aspnet-b2c/find-identity-exp-fr.png" alt-text="Screenshot of the Identity Experience Framework button.":::
1. Select Custom policies, and then select the custom policy that you are using. In this article, It's **B2C_1A_DEMO_CHANGESIGNINNAME**.

    :::image type="content" source="media/troubleshoot-error-idx10501-aspnet-b2c/custom-policy.png" alt-text="Screenshot of checking custom-policy.":::
1. The metadata address is the URL listed under **OpenId Connect Discovery Endpoint**. Copy this URL and paste it as the value for the `options.MetadataAddress` variable.

### Step 3: Add Action to Controller

In your controller, implement an action to trigger the Custom B2C Policy challenge for the user. In code sample, the action is added to the Home Controller for the sake of simplicity. Add the following code to your controller and adjust the values and action name to meet your scenario. This code snippet can be found on line 40 of the `HomeController.cs` file in the `Controllers` folder in the Code sample:

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

Ensure `<Your-Custom-Policy>` matches your specific policy name and `<CustomAuthScheme>` is consistent with what you configured earlier.

### Step 4: Implement Action in Layout

Implement the action in the layout, so that the user can actually invoke the custom policy. In code sample, the following snippet adds a button alongside existing B2C buttons based on the [tutorial](/azure/active-directory-b2c/enable-authentication-web-application). The snippet is added to line 13 of the `_LayoutPartial.cshtml` file in the `Views/Shared` folder. Note that the `asp-controller` property is set to `Home` to reference the Home Controller, and the `asp-action property` is set to `EditEmail` to reference the action created in the Home Controller. For more information, see [Add the UI elements](/azure/active-directory-b2c/enable-authentication-web-application?tabs=visual-studio#step-4-add-the-ui-elements).

```html
<li class="navbar-btn">
    <form method="get" asp-area="" asp-controller="Home" asp-action="EditEmail">
        <button type="submit" class="btn btn-primary">Edit Email</button>
    </form>
</li>
```

If you have an existing app that doesn’t use the partial layout and just want a quick link to test the custom policy, you can use the following tag to create a basic link. Be sure to replace the indicated values and reference the correct controller if you didn’t add your action to the Home Controller:

```html
<a asp-area="" asp-controller="Home" asp-action="replace-with-your-controller-action">Replace with text that describes the action</a>
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

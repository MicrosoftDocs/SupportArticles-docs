---
title: Script errors when running MSAL.Net in XBAP application with Internet Explorer
description: Provides solution to  the script errors that occurs when running MSAL.Net in XBAP application with Microsoft Entra ID
ms.date: 03/12/2025
ms.reviewer: bachoang
ms.service: entra-id
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Cookies are disabled error in MSAL.Net XBAP application in Internet Explorer

This article describes a problem in which a script error is returned when performing Microsoft Entra ID login by using an XAML Browser Application (XBAP) from Internet Explorer.

## Symptoms

When you run Microsoft Authentication Library for .NET (MSAL.NET) codes similar to the following in a XAML Browser Application (XBAP) from Internet Explorer to perform Microsoft Entra ID login, you may receive a script error warning with the message **cookies are disabled**.

```C#
string tenantId = "<Tenant ID>";
string clientId = "<Application ID>";
string[] Scopes = new string[] { "User.Read" };
string errorMessage = string.Empty;
try
  {
  using (HttpClient httpClient = new HttpClient())
  {
     IPublicClientApplication publicClientApp = PublicClientApplicationBuilder.Create(clientId)
       .WithDefaultRedirectUri()
       .WithAuthority(AzureCloudInstance.AzurePublic, AadAuthorityAudience.AzureAdMyOrg)
       .WithTenantId(tenantId)
       .Build();
        AuthenticationResult authenticationResult = null;
        var t = Task.Run(async () =>
          {
              try
              {
                 authenticationResult = await publicClientApp.AcquireTokenInteractive(Scopes)
                            .WithAccount(null)
                            .WithPrompt(Prompt.ForceLogin)
                            .ExecuteAsync();
                    }
                    catch (Exception ex)
                    {
                        errorMessage = "Error while getting token: " + ex.ToString();
                    }
                });
                t.Wait();

                if (authenticationResult != null)
                {
                    return authenticationResult.AccessToken;
                }
                else
                {
                    return errorMessage;
                }
            }
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
``` 
## Cause

Although XBAP applications run within Internet Explorer, they operate in their own process space: **PresentationHost.exe**. This process is a highly secure container. XBAP applications use the WebBrowser control to host the Microsoft Entra ID login page. To minimize security risks from the browser surface, this container is configured with security restrictions which include blocking cookies. However, the Microsoft Entra ID login process depends on cookies, which causes a script error.

## Solution

Configure MSAL.Net to use the [System Browser](/azure/active-directory/develop/msal-net-web-browsers#system-browser-experience-on-net) – Microsoft Edge to launch the Entra ID login page. Then, follow these steps to make the required updates:

1. In the Azure portal, locate your app in the **App registrations** page. Register `http://localhost` as a redirect URL under **Mobile and desktop applications** platform.

   :::image type="content" source="./media/script-errors-running-msal-net-xbap-app/add-uri.png" alt-text="Application Manifest Key Credentials" lightbox="./media/script-errors-running-msal-net-xbap-app/add-uri.png":::

2. Make the following change to your code:

    ```C#
    try
    {
        using (HttpClient httpClient = new HttpClient())
        {
            IPublicClientApplication publicClientApp = PublicClientApplicationBuilder.Create(clientId)
                        .WithRedirectUri("http://localhost")
                        .WithAuthority(AzureCloudInstance.AzurePublic, AadAuthorityAudience.AzureAdMyOrg)
                        .WithTenantId(tenantId)
                        .Build();
            AuthenticationResult authenticationResult = null;
    
            var t = Task.Run(async () =>
            {
                try
                {
                    authenticationResult = await publicClientApp.AcquireTokenInteractive(Scopes)
                        .WithAccount(null)
                        .WithPrompt(Prompt.ForceLogin)
                        .WithUseEmbeddedWebView(false)
                        .ExecuteAsync();
                }
                catch (Exception ex)
                {
                    errorMessage = "Error while getting token: " + ex.ToString();
                }
            });
    ```
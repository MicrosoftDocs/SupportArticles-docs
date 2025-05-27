---
title: Enable Bundled Consent for Microsoft Entra ID Applications.
description: Describes how to bundle consent for Microsoft Entra ID applications.
ms.reviewer: willfid
ms.service: entra-id
ms.date: 05/27/2025
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Bundle consent for Microsoft Entra ID applications

This article explains how to configure bundled consent for Microsoft Entra ID applications.

## Symptoms

You have a custom client app and a custom API app， and you create app registrations for the both apps in Microsoft Entra ID. You configure bundle the consent for these two apps. In this scenario, you might receive one of the following errors when you try to sign into the app:

- AADSTS70000: The request was denied because one or more scopes requested are unauthorized or expired. The user must first sign in and grant the client application access to the requested scope

- AADSTS650052: The app is trying to access a service\”{app_id}\”(\”app_name\”) that your organization %\”{organization}\” lacks a service principal for. Contact your IT Admin to review the configuration of your service subscriptions or consent to the application in order to create the required service principal

## Solution

## Step 1: Configure knownClientApplications for the API app registration

Add the custom client app ID to the custom API app registration's `knownClientApplications` property. For more information, see [knownClientApplications attribute](/entra/identity-platform/reference-app-manifest#knownclientapplications-attribute).

## Step 2: Configure API permissions

Make sure that:

- All required API permissions are correctly configured on both the custom client and custom API app registrations.
- The custom client app registration includes the API permissions that are defined in the custom API app registration.

## Step 3: The sign-in request

Your authentication request must use the `.default` scope for Microsoft Graph. For Microsoft accounts, the scope must be for the custom API. 

### Example Request for Microsoft accounts and Work or school accounts

```HTTP
https://login.microsoftonline.com/common/oauth2/v2.0/authorize
?response_type=code
&Client_id=72333f42-5078-4212-abb2-e4f9521ec76a
&redirect_uri=https://localhost
&scope=openid profile offline_access app_uri_id1/.default
&prompt=consent
```
> [NOTE!]
> The client will not appear as having permission for the API. This is expected because the client is listed as a knownClientApplication.

### Example request for Work or school accounts only

If you are not supporting Microsoft Accounts:

```http

GET https://login.microsoftonline.com/common/oauth2/v2.0/authorize
?response_type=code
&client_id=72333f42-5078-4212-abb2-e4f9521ec76a
&redirect_uri=https://localhost
&scope=openid profile offline_access User.Read https://graph.microsoft.com/.default
&prompt=consent

```

### Implementation with MSAL.NET

```http
String[] consentScope = { "api://ae5a0bbe-d6b3-4a20-867b-c8d9fd442160/.default" };
var loginResult = await clientApp.AcquireTokenInteractive(consentScope)
    .WithAccount(account)
	 .WithPrompt(Prompt.Consent)
      .ExecuteAsync();
```

Consent propagation for new service principals and permissions may take time. Your application should handle this delay.

### Acquire Tokens for multiple resources

If your client app needs to acquire tokens for another resource such as Microsoft Graph, you must implement logic to handle potential delays after users consent to application. Here are some recommendations:

- Use the `.default` scope when requesting tokens.
- Track acquired scopes until the required one is returned.
- Add a delay if the result still does not have the required scope.

Currently, if `AcquireTokenSilent` fails, MSAL requires a successful interactive authentication before allowing another silent token acquisition. This restriction applies even if a valid refresh token is available.

Here is a sample code about retry logic:

```csharp
    public static async Task<AuthenticationResult> GetTokenAfterConsentAsync(string[] resourceScopes)
        {
            AuthenticationResult result = null;
            int retryCount = 0;

            int index = resourceScopes[0].LastIndexOf("/");

            string resource = String.Empty;

            // Determine resource of scope
            if (index < 0)
            {
                resource = "https://graph.microsoft.com";
            }
            else
            {
                resource = resourceScopes[0].Substring(0, index);
            }

            string[] defaultScope = { $"{resource}/.default" };

            string[] acquiredScopes = { "" };
            string[] scopes = defaultScope;
            
            while (!acquiredScopes.Contains(resourceScopes[0]) && retryCount <= 15)
            {
                try
                {
                    result = await clientApp.AcquireTokenSilent(scopes, CurrentAccount).WithForceRefresh(true).ExecuteAsync();
                    acquiredScopes = result.Scopes.ToArray();
                    if (acquiredScopes.Contains(resourceScopes[0])) continue;
                }
                catch (Exception e)
                { }

                // Switch scopes to pass to MSAL on next loop. This tricks MSAL to force AcquireTokenSilent after failure. This also resolves intermittent cachine issue in ESTS
                scopes = scopes == resourceScopes ? defaultScope : resourceScopes;
                retryCount++;

                // Obvisouly something went wrong
                if(retryCount==15)
                {
                    throw new Exception();
                }

                // MSA tokens do not return scope in expected format when .default is used
                int i = 0;
                foreach(var acquiredScope in acquiredScopes)
                {
                    if(acquiredScope.IndexOf('/')==0) acquiredScopes[i].Replace("/", $"{resource}/");
                    i++;
                }

                Thread.Sleep(2000);
            }

            return result;
        }
```

### On the custom API using the On-behalf-of flow

Similar to the client app, when your custom API tries to acquire tokens for another resource using the On-Behalf-Of (OBO) flow, it may fail immediately after consent. To resolve this issue, you can implement retry logic and scope tracking as the following sample:

```csharp
while (result == null && retryCount >= 6)
            {
                UserAssertion assertion = new UserAssertion(accessToken);
                try
                {
                    result = await apiMsalClient.AcquireTokenOnBehalfOf(scopes, assertion).ExecuteAsync();
                    
                }
                catch { }

                retryCount++;

                if (result == null)
                {
                    Thread.Sleep(1000 * retryCount * 2);
                }
            }

If (result==null) return new HttpStatusCodeResult(HttpStatusCode.Forbidden, "Need Consent");
```

If all retries fail, return an error and throw an error and instruct the client to initial a full consent process.

**Example of client code that assumes your API throws a 403**

```
HttpResponseMessage apiResult = null;
apiResult = await MockApiCall(result.AccessToken);

if(apiResult.StatusCode==HttpStatusCode.Forbidden)
{
  var authResult = await clientApp.AcquireTokenInteractive(apiDefaultScope)
    .WithAccount(account)
    .WithPrompt(Prompt.Consent)
    .ExecuteAsync();
  CurrentAccount = authResult.Account;

  // Retry API call
  apiResult = await MockApiCall(result.AccessToken); 
}         
```

## Recommendations and expected behavior

Ideally, you should create a separate flow that guides users through the consent process, provisions your app and API in their tenant or Microsoft account, and completes consent in a single step that separate from signing in.

If you don’t separate this flow and instead combine it with your app’s sign-in experience, the process can become confusing. Users may encounter multiple consent prompts. To improve the experience, consider adding a message in your app that informs users they might be asked to consent more than once：

- For Microsoft accounts, expect at least two consent prompts: one for the client app and one for the API.
- For work or school accounts, typically only one consent prompt is required.

The following is an end-to-end code sample that demonstrates a smooth user experience. It supports all account types and prompts for consent only when necessary.

```csharp
string[] msGraphScopes = { "User.Read", "Mail.Send", "Calendar.Read" }
String[] apiScopes = { "api://ae5a0bbe-d6b3-4a20-867b-c8d9fd442160/access_as_user" };
String[] msGraphDefaultScope = { "https://graph.microsoft.com/.default" };
String[] apiDefaultScope = { "api://ae5a0bbe-d6b3-4a20-867b-c8d9fd442160/.default" };

var accounts = await clientApp.GetAccountsAsync();
IAccount account = accounts.FirstOrDefault();

AuthenticationResult msGraphTokenResult = null;
AuthenticationResult apiTokenResult = null;

try
{
	msGraphTokenResult = await clientApp.AcquireTokenSilent(msGraphScopes, account).ExecuteAsync();
	apiTokenResult = await clientApp.AcquireTokenSilent(apiScopes, account).ExecuteAsync();
}
catch (Exception e1)
{
	
	string catch1Message = e1.Message;
	string catch2Message = String.Empty;

	try
	{
        // First possible consent experience
		var result = await clientApp.AcquireTokenInteractive(apiScopes)
		  .WithExtraScopesToConsent(msGraphScopes)
		  .WithAccount(account)
		  .ExecuteAsync();
		CurrentAccount = result.Account;
		msGraphTokenResult = await clientApp.AcquireTokenSilent(msGraphScopes, CurrentAccount).ExecuteAsync();
		apiTokenResult = await clientApp.AcquireTokenSilent(apiScopes, CurrentAccount).ExecuteAsync();
	}
	catch(Exception e2)
	{
		catch2Message = e2.Message;
	};

	if(catch1Message.Contains("AADSTS650052") || catch2Message.Contains("AADSTS650052") || catch1Message.Contains("AADSTS70000") || catch2Message.Contains("AADSTS70000"))
	{
        // Second possible consent experience
		var result = await clientApp.AcquireTokenInteractive(apiDefaultScope)
			.WithAccount(account)
			.WithPrompt(Prompt.Consent)
			.ExecuteAsync();
		CurrentAccount = result.Account;
		msGraphTokenResult = await GetTokenAfterConsentAsync(msGraphScopes);
		apiTokenResult = await GetTokenAfterConsentAsync(apiScopes);
	}
}

// Call API

apiResult = await MockApiCall(apiTokenResult.AccessToken);
var contentMessage = await apiResult.Content.ReadAsStringAsync();

if(apiResult.StatusCode==HttpStatusCode.Forbidden)
{
	var result = await clientApp.AcquireTokenInteractive(apiDefaultScope)
		.WithAccount(account)
		.WithPrompt(Prompt.Consent)
		.ExecuteAsync();
	CurrentAccount = result.Account;

	// Retry API call
	apiResult = await MockApiCall(result.AccessToken);
}
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
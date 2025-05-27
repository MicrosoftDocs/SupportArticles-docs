---
title: Enable Bundled Consent for Multiple Application Registrations in Azure AD
description: Describes how  to bundle consent for application registrations 
ms.reviewer: willfid
ms.service: entra-id
ms.date: 05/09/2025
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# How bundle consent for multiple application registrations

In scenarios that you have a custom client application and a custom API. Each registered as separate applications in Microsoft Entra ID. You may want to streamline the user experience by allowing users to consent to both applications at once. This article explains how to configure bundled consent so that users can grant permissions to multiple apps in a single step.

## Step 1: Configure knownClientApplications for the API app registration

Add the custom client app ID to the custom APIs app registration `knownClientApplications` property. For more information, see [knownClientApplications attribute](/entra/identity-platform/reference-app-manifest#knownclientapplications-attribute).

## Step 2: Configure API permissions

Make sure that:

- All required API permissions are correctly configured on both the custom client and custom API app registrations.
- The custom client app registration includes the API permissions defined in the custom API app registration.

## Step 3: The sign-in request

Your authentication request must use the `.default` scope for Microsoft Graph. For Microsoft accounts, the scope must be for the custom API. This also works for school and work accounts.

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

### Acquire Tokens for Multiple Resources

If your client app needs to acquire tokens for another resource such as Microsoft Graph, you must implement logic to handle potential delays after user consent. Here are some recommendations:

- Use the `.default` scope when requesting tokens.
- Track acquired scopes until the required one is returned
- Add a delay if the result still does not have the required scope.

Currently, if `acquireTokenSilent` fails, MSAL will force you to perform a successful interaction before it will allow you to use `AcquireTokenSilent` again, even if you have a valid refresh token to use.

Here is some sample code of retry logic

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

In the same way the client app does, when your custom API tries to acquire tokens for another resource using the On-Behalf-Of (OBO) flow, it may fail immediately after consent. To resolve this issue, you can implement retry logic and scope tracking as the following sample:

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

Building an app for handling bundled consent is not as straight forward. Preferably you have a separate process you can walk your users through to perform this bundled consent, provision your app and API within their tenant or on their Microsoft Account and only get the consent experience once. (Separate from actually signing into the app.) If you don’t have this process and trying to build it into your app and your sign in experience, it gets messy and your users will have multiple consent prompts. I would recommend that you build a experience within your app that warns users they may get prompted to consent (multiple times).

For Microsoft Accounts, I would expect minimum of two consent prompts. One for the application, and one for the API.

For work and school accounts, I would expect only one consent prompt. Azure AD handles bundled consent much better than Microsoft Accounts.

Here is a end to end example sample of code. This has a pretty good user experience considering trying to support all account types and only prompting consent if required. Its not perfect as perfect is virtually non-existent.



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
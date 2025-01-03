---
title: Troubleshooting consent issues in Microsoft Entra ID
description: Helps you troubleshoot and resolve consent issues in Microsoft Entra ID.
ms.date: 01/03/2025
ms.reviewer: willfid, v-weizhu
ms.service: entra-id
ms.custom: sap:App registrations
---
# Troubleshooting consent issues in Microsoft Entra ID

This article provides guidance on troubleshooting consent issues in Microsoft Entra ID. It applies to OpenID Connect and OAuth2-based authentications.

> [!NOTE]
> SAML-based applications might present similar errors but require different solutions, typically due to configuration mismatches within the SAML request on either the third-party SAML Service Provider or Microsoft Entra ID.

## Symptoms

When an application tries to sign-in or get an access token for a resource which has not been consented by a user or admin, you get a message that's is similar to one of the following error messages:

- > Need admin approval
- > AADSTS65001: The user or administrator has not consented to use the application with ID '{App-Id}' named '{Name-of-App}'. Send an interactive authorization request for this user and resource.
- > AADSTS650056: Misconfigured application. This could be due to one of the following: The client has not listed any permissions for 'AAD Graph' in the requested permissions in the client's application registration. Or, The admin has not consented in the tenant. Or, Check the application identifier in the request to ensure it matches the configured client application identifier. Please contact your admin to fix the configuration or consent on behalf of the tenant.
- > AADSTS90094: An administrator of \<tenantDisplayName> has set a policy that prevents you from granting \<name of app> the permissions it is requesting. Contact an administrator of \<tenantDisplayName>, who can grant permissions to this app on your behalf. 
- > AADSTS90008: The user or administrator has not consented to use the application with ID '162841d6-3c61-4676-a2c1-5a9c1e68ccf3'. This happened because application is misconfigured: it must require access to Windows Azure Active Directory by specifying at least 'Sign in and read user profile' permission

There are many reasons why you might receive a message indicating that admin approval or admin consent is required. Consider the following high-level scenarios:

- The `User.Read` permission is missing.
- User consent is disabled.
- User assignment required is enabled.
- A service principal doesn't exist in the tenant for the client app.
- A service principal doesn't exist in the tenant for the resource.
- A consent URL that specifies `prompt=admin_consent` or `prompt=consent` is requested.
- Scopes that have not been consented to yet are requested in a sign-in request.
- The scope/permission requires admin consent.
- User consent is blocked for risky apps.

The following sections provide troubleshooting guide for finding the root causes of consent issues. If you want to directly resolve issues, go to the [Perform admin consent](#perform-admin-consent) section.

## Before troubleshooting

Make sure the application has the necessary permission for user sign-in, such as the User.Read permission. Furthermore, ensure that this permission has been consented to.

For example, if you own the application registration or any application requiring user sign-in, you should at least have the Microsoft Graph "User.Read" or "Openid" delegated permission added to the application registration **API Permissions**.

 :::image type="content" source="media/troubleshoot-consent-issues/configured-permissions.png" alt-text="Screenshot that shows the permissions added to the application registration API Permissions.":::

## Troubleshoot steps

### Step 1: Get the sign-in request sent to Microsoft Entra ID

To determine why the consent prompt appears, get the sign-in request and examine the parameters sent to Microsoft Entra ID. When the consent prompt appears, you can get the sign-in request by using one of the following methods:

- If you're using a browser, look at the address bar.
- If you're not using a browser or still can't see the address bar in the browser, use a HTTP capture tool like Fiddler to get the request.

A sign-in request should look like the following one:

- Microsoft Entra V1 OAuth2 endpoint:

    `https://{Aad-Instance}/{Tenant-Id}/oauth2/authorize?client_id={App-Id}&response_type=code&redirect_uri={redirect-uri}&resource={App-URI-Id}&scope={Scope}&prompt={Prompt}`

- Microsoft Entra V2 OAuth2 endpoint:

    `https://{Aad-Instance}/{Tenant-Id}/oauth2/v2.0/authorize?client_id={App-Id}&response_type=code&redirect_uri={redirect-uri}& scope={Scope}&prompt={Prompt}`

The following table provides an example of the parameters used in the sign-in request, which are referenced throughout the following troubleshooting steps:

|Property|	Sign-in request portion|	Value|
|---|---|---|
|Aad-Instance|	`{Aad-Instance}`|	login.microsoftonline.com|
|Tenant-Id|	`{Tenant-Id}` portion of the sign-in request|	common|
|App-Id|	`{App-Id}` portion of the sign-in request|	1f92960d-1442-4cd2-8c76-d13c5dcb30bf|
|Scope|	`{Scope}` portion of the sign-in request|	Openid+User.Read+Directory.Read.All|
|App-URI-Id|	V1 endpoint: `{App-URI-Id}` portion of the sign-in request</br>   </br>V2 endpoint: For resources other than Microsoft Graph, this would be the portion before the scope name. For example, for `https://analysis.windows.net/powerbi/api/App.Read.All`, `App.Read.All` is the scope name, so the `App-Uri-Id` is `https://analysis.windows.net/powerbi/api`.|	https://graph.microsoft.com|
|Prompt|	`{Prompt}` portion of the sign-in request	 ||

### Step 2: Verify if you allow users to consent

To check if user consent is allowed in your organization, follow these steps:

1. Sign in to the Azure portal.
2. Navigate to Microsoft Entra ID, select **Enterprise applications** > **Consent and permissions**.
3. Review the **User consent for applications** setting:

    - If **Allow user consent for apps** is selected, all users can consent to permissions which don't require admin consent. In this case, go to next step.

    - If **Do not allow user consent** is selected, users will always get the "Need admin approval" message. In this case, an admin must [perform admin consent](#perform-admin-consent).

        > [!NOTE]
        > If an admin believes he/she has already consented to those permissions, most likely not all of the required permissions listed in the sign-in request are consented to or the wrong application is used based on the `{App-Id}`.

### Step 3: Verify if the application exists

To verify if the application exists in the tenant, follow these steps:

1. Sign in to the Azure portal.
2. Switch to the correct tenant based on the `{Tenant-Id}`.
3. Go to **Enterprise applications**.
4. Set **Application Type** to **All Applications** and search for the `{App-Id}`.
5. If the application isn't found, this would be the cause why you get consent issues. In this case, [perform admin consent](#perform-admin-consent). If the application is found, go to the next step.

### Step 4:Verify if user assignment is required

On the **Enterprise applications** pane, search for and select the application. Under the **Manage** section, select **Properties** to open the **Properties** pane and then review the **Assignment required** setting.

If user assignment is required, an admin must consent to this application. To do this, go to the [perform admin consent](#perform-admin-consent) section.

> [!NOTE]
> Consenting to an application for all users in an organization doesn't allow all users to access the application. You must follow the user assignment rules. Only those users assigned to the application can access it. If you don't want to perform admin consent, the only workaround would be to turn off **Assignment required**, have the user consent when they access the application, and turn **Assignment required** back on.

If user assignment isn't required, go to next step.

### Step 5: Compare permissions requested and granted for the application

To verify if the scopes (also called permissions) in the sign-in request are listed in the **Permissions** section of the application, follow these steps:

1. If the application is found in [Step 3: Verify if the application exists](#step-3-verify-if-the-application-exists), select it.
2. Go to **Permissions**.
3. Compare what is listed on the **Permissions** pane and what is listed as `{Scope}` in the sign-in request. The permissions listed on the **Permissions** pane are the permissions that have been consented.

    > [!NOTE]
    > - Pay attention to the permission type. Delegated permissions are for when users sign in and application permissions are for when the service principal is used to authenticate via the client credential flow. 
    > - OpenID Connect scopes are generally not listed in the enterprise applications. Don't worry if the following scopes aren't listed:
    >
    >   - `openid`: Sign users in
    >   - `email`: View users' email address
    >   - `profile`: View users' basic profile
    >   - `offline_access`: Maintain access to data you have given it access to

4. If `{Scope}` in the sign-in request is blank or contains less than what is listed on the **Permissions** pane, go to the next step. If there are other scopes in `{Scope}` that aren't on the **Permissions** pane, go to the [Perform admin consent](#perform-admin-consent) section. The missing permissions must be consented.

### Step 6: Verify the resource exists in your tenant

To check if a resource exists, try a request that looks like `https://{Aad-Instance}/{Tenant-Id}/oauth2/authorize?response_type=code&client_id={App-Id}&resource={App-Uri-id}`.

You might get one of the following behaviors/errors:

- You're allowed to sign-in (This is the behavior you expect). In this case, go to next step. In most cases, if you see the "code" parameter in the address bar, this means authentication process has been successfully completed.
- Error AADSTS650052: The app needs access to a service that your organization has not subscribed to or enabled. Contact your IT Admin to review the configuration of your service subscriptions. 

    This error means the resource doesn't exist in your organization. To resolve this issue, use this consent URL: `https://login.microsoftonline.com/{Tenant-Id}/oauth2/authorize?response_type=code&client_id={App-Uri-id}&prompt=admin_consent`

- Error AADSTS650057: Invalid resource. The client has requested access to a resource which is not listed in the requested permissions in the client's application registration. Client app ID: {App-Id}({App-Display-Name}). Resource value from request: '{App-Uri-Id}'. Resource app ID:{Resource-App-Id}. List of valid resources from app registration: 00000002-0000-0000-c000-000000000000

    In order for a client application to sign-in and get an access token for a resource, the resource must be assigned to the client application required API permissions. For example, for a client application to access Azure Key Vault.

     :::image type="content" source="media/troubleshoot-consent-issues/azure-key-vault.png" alt-text="Screenshot that shows how to add Azure Key Vault to API permissions.":::

    > [!NOTE]
    > Only the application owner can do this.

- Error AADSTS500011: The resource principal named '{App-Uri-Id}' was not found in the tenant named '{Tenant-Id}'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant. You might have sent your authentication request to the wrong tenant.

    This error means that the specified `{App-Uri-Id}` is not valid at all or is only available as a single tenant application. Otherwise, it means this resource can't be accessed by external organizations or doesn't exist.

    To resolve this issue, you must work with the application owner to verify that `{App-Uri-Id}` and `{Tenant-Id}` are correct. If the `{App-Uri-Id}` is owned by a different `{Tenant-Id}`, then the app registration for `{App-Uri-Id}` must be set up as a multi-tenant application. Otherwise, the `{Tenant-Id}` must be the same tenant as where the app registration for `{App-Uri-Id}` is located.

### Step 7: Verify if the prompt parameter is passed

Sometimes, signing into the application always involves passing the `prompt` parameter of consent or admin_consent. Once the application has been consented to, make sure the `prompt` parameter isn't specified. Otherwise, users might always get the consent error.

Your sign-in request might look like this:

`https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/authorize?client_id=1f92960d-1442-4cd2-8c76-d13c5dcb30bf&response_type=code&redirect_uri=https://www.contoso.com&scope=openid+profile+User.Read+Directory.Read.All&prompt=consent`

So, to resolve consent issues, remove the `prompt` parameter, as follows:

`https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/authorize?client_id=1f92960d-1442-4cd2-8c76-d13c5dcb30bf&response_type=code&redirect_uri=https://www.contoso.com&scope=openid+profile+User.Read+Directory.Read.All`

## Perform admin consent

To resolve consent issues, perform admin consent by following these steps:

1. Have an administrator (a user with the global or company administrator role or Application Administrator role) access the application.
2. If the consent screen appears, review the requested permissions. To approve the requested permissions, select the checkbox **Consent on behalf of your organization** .

    :::image type="content" source="media/troubleshoot-consent-issues/consent-on-behalf-of-your-organization.png" alt-text="Screenshot that shows the 'Consent on behalf of your organization' checkbox.":::

    > [!NOTE]
    > If an administrator isn't sure what the permissions allow, the administrator must work with the application vendor to understand the permissions and what they are used for. Microsoft support might not know what these permissions do or why the permissions are needed.

3. If the admin doesn't get the consent screen, grab the sign-in address and add `&prompt=consent` at the end, and then use this request to perform admin consent.

    Here's an example: `https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/authorize?client_id=1f92960d-1442-4cd2-8c76-d13c5dcb30bf&response_type=code&redirect_uri=https://www.contoso.com&scope=openid+profile&tresource=https://graph.microsoft.com&prompt=consent`

    If the requested permissions aren't listed in the application registration, use the Microsoft identity platform (V2) endpoint to force admin consent. V2 endpoint requires each permission scope to be passed in the `scope` parameter, as follows:

    `https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?client_id=1f92960d-1442-4cd2-8c76-d13c5dcb30bf&response_type=code&redirect_uri=https://www.contoso.com&scope=openid+profile+User.Read+Directory.Read.All&prompt=consent`

> [!NOTE]
> - Permission scopes used by the application must be provided by the application owner.
> - Consent for application permissions will always require admin consent from a global or company administrator. Application permissions must be added within the application registration in the applications owning tenant.
> - Application admins can also consent to delegate permissions which require admin consent.
> - When using the admin consent URL, the permissions must already be configured with the application registration. Otherwise, the application owner must have their application correctly configured with Microsoft Entra ID. An admin consent URL looks like `https://login.microsoftonline.com/{Tenant-Id}/adminconsent?client_id={App-Id}`.

## More information

### Consent

In most cases, certain permissions that requires consent haven't been consented yet. Therefore, we request consent. To understand the consent, see the following pages：

- [Overview of permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview)
- [Microsoft identity platform admin consent protocols](/entra/identity-platform/v2-admin-consent)
- [Microsoft Entra app consent experiences](/entra/identity-platform/application-consent-experience)

### Application registrations and enterprise applications

In Microsoft Entra, there is an application model that consists of application objects also called "application registrations" and "service principal" objects also called "enterprise applications". How their relationship works together based on the required permissions is set on the application object. For more information, see Application and service principal objects in Microsoft Entra ID.

Simply adding permissions to an application registration does NOT consent to the permissions. To consent to permissions, you must assign permissions to the service principal.

### Delegated permissions and application permissions

There are two types of permissions in Microsoft Entra ID: delegated permissions and application permissions. Make sure you apply the correct permission configuration in the application registration and consent to that permission.

For more information about permissions in Microsoft Entra ID, see the following pages：

- [Overview of permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview)
- [Understanding the difference between application and delegated permissions from OAuth2 Authentication Flows](https://blogs.aaddevsup.xyz/2019/07/understanding-the-difference-between-application-and-delegated-permissions-from-oauth2-authentication-flows-perspective/)

### Collect Microsoft Entra activity logs

You can use the Microsoft Entra activity logs to get more details. To do this, follow these steps:

1. Sign in to the Azure portal by using an account that has permissions to read audit logs, such as a Global Admin or Security Reader.
2. Go to Microsoft Entra ID.
3. Select **Audit logs** under the **Monitoring** section.
4. Set your filter as follows:
    - **Category**: **ApplicationManagement**
    - **Status**: **Failure**
    - **Activity**: **Consent to application**
5. Find and select the app that' fails to consent.
6. Review the **STATUS REASON** to get more details.

In certain scenarios, you're required to perform an admin consent even though you might allow users to consent and the permission normally doesn't require an admin to consent. For example, when the status reason shows "Microsoft.Online.Security.UserConsentBlockedForRiskyAppsException". For more information, see [Unexpected error when performing consent to an application](/entra/identity/enterprise-apps/application-sign-in-unexpected-user-consent-error#requesting-not-authorized-permissions-error) and [Unexpected consent prompt when signing in to an application](/entra/identity/enterprise-apps/application-sign-in-unexpected-user-consent-prompt).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
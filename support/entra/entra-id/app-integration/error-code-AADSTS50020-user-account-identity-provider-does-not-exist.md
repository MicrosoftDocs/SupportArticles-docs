---
title: Error AADSTS50020 - User account from identity provider does not exist in tenant
description: Troubleshoot scenarios in which a guest user unsuccessfully tries to sign in to the resource tenant and error code AADSTS50020 is returned.
ms.date: 11/23/2023
ms.editor: v-jsitser
ms.reviewer: rrajan, haelshab, sungow, v-leedennis
ms.service: entra-id
ms.custom: sap:Issues Signing In to Applications, has-azure-ad-ps-ref
keywords: AADSTS50020
#Customer intent: As a Microsoft Entra administrator, I want to figure out why error code AADSTS50020 occurs so that I can make sure that my guest users from an identity provider can sign in to a resource tenant.
---
# Error AADSTS50020 - User account from identity provider does not exist in tenant

This article helps you troubleshoot error code `AADSTS50020` that's returned if a guest user from an identity provider (IdP) can't sign in to a resource tenant in Microsoft Entra ID.

## Symptoms

When a guest user tries to access an application or resource in the resource tenant, the sign-in fails, and the following error message is displayed:

> AADSTS50020: User account 'user@domain.com' from identity provider {IdentityProviderURL} does not exist in tenant {ResourceTenantName}.

When an administrator reviews the sign-in logs on the home tenant, a "90072" error code entry indicates a sign-in failure. The error message states:

> User account {email} from identity provider {idp} does not exist in tenant {tenant} and cannot access the application {appId}({appName}) in that tenant. The account needs to be added as an external user in the tenant first. Sign out and sign in again with a different Microsoft Entra user account.

### Cause 1： Users log in to Microsoft Entra admin center by using personal Microsoft Accounts

When you try to log in to Microsoft Entra admin center by using your personal Microsoft Accounts (Outlook, Hotmail or OneDrive), you are connected to the Microsoft Services tenant by default. Within the default tenant, there is no linked directory for performing any actions. This behavior is expected. 

In the prior experience, a directory (for example: UserNamehotmail735.onmicrosoft.com) is created and linked to the personal account, and you can perform actions such as creating user accounts in the directory. The behavior has now been changed. 

### Solution: Create an Azure account with a new tenant

If you aim to have a directory, you must create an Azure account and a new tenant: 

1.    Browse to [https://azure.microsoft.com/en-us/free/](https://azure.microsoft.com/free/), and then select **Start free** .
2.    Follow the instructions to create an Azure account.
3.    A tenant will be generated alongside the Azure account, and you will be automatically designated as the Global Administrator. This grants you full access to all options within this tenant.

## Cause 2: Used unsupported account type (multitenant and personal accounts)

If your app registration is set to a single-tenant account type, users from other directories or identity providers can't sign in to that application.

### Solution: Change the sign-in audience setting in the app registration manifest

To make sure that your app registration isn't a single-tenant account type, perform the following steps:

1. In [the Azure portal](https://portal.azure.com), search for and select **App registrations**.
1. Select the name of your app registration.
1. In the sidebar, select **Manifest**.
1. In the JSON code, find the **signInAudience** setting.
1. Check whether the setting contains one of the following values:
    - **AzureADandPersonalMicrosoftAccount**
    - **AzureADMultipleOrgs**
    - **PersonalMicrosoftAccount**

    If the **signInAudience** setting doesn't contain one of these values, re-create the app registration by having the correct account type selected. You currently can't change **signInAudience** in the manifest.

For more information about how to register applications, see [Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app).

## Cause 3: Used the wrong endpoint (personal and organization accounts)

Your authentication call must target a URL that matches your selection if your app registration's supported account type was set to one of the following values:

- **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant)**

- **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)**

- **Personal Microsoft accounts only**

If you use `https://login.microsoftonline.com/<YourTenantNameOrID>`, users from other organizations can't access the application. You have to add these users as guests in the tenant that's specified in the request. In that case, the authentication is expected to be run on your tenant only. This scenario causes the sign-in error if you expect users to sign in by using federation with another tenant or identity provider.

### Solution: Use the correct sign-in URL

Use the corresponding sign-in URL for the specific application type, as listed in the following table:

| Application type | Sign-in URL |
| ---------------- | ----------- |
| Multitenant applications | `https://login.microsoftonline.com/organizations` |
| Multitenant and personal accounts | `https://login.microsoftonline.com/common` |
| Personal accounts only | `https://login.microsoftonline.com/consumers` |

In your application code, apply this URL value in the `Authority` setting. For more information about `Authority`, see [Microsoft identity platform application configuration options](/azure/active-directory/develop/msal-client-application-configuration#authority).

## Cause 4: Signed in to the wrong tenant

When users try to access your application, either they're sent a direct link to the application, or they try to gain access through <https://myapps.microsoft.com>. In either situation, users are redirected to sign in to the application. In some cases, the user might already have an active session that uses a different personal account than the one that's intended to be used. Or they have a session that uses their organization account although they intended to use a personal guest account (or vice versa).

To make sure that this scenario is the issue, look for the `User account` and `Identity provider` values in the error message. Do those values match the expected combination or not? For example, did a user sign in by using their organization account to your tenant instead of their home tenant? Or did a user sign in to the `live.com` identity provider by using a different personal account than the one that was already invited?

### Solution: Sign out, then sign in again from a different browser or a private browser session

Instruct the user to open a new in-private browser session or have the user try to access from a different browser. In this case, users must sign out from their active session, and then try to sign in again.

## Cause 5: Guest user wasn't invited

The guest user who tried to sign in was not invited to the tenant.

### Solution: Invite the guest user

Make sure that you follow the steps in [Quickstart: Add guest users to your directory in the Azure portal](/azure/active-directory/external-identities/b2b-quickstart-add-guest-users-portal) to invite the guest user.

## Cause 6: App requires user assignment

If your application is an enterprise application that requires user assignment, error `AADSTS50020` occurs if the user isn't on the list of allowed users who are assigned access to the application. To check whether your enterprise application requires user assignment:

1. In the [Azure portal](https://portal.azure.com), search for and select **Enterprise applications**.

1. Select your enterprise application.

1. In the sidebar, select **Properties**.

1. Check whether the **Assignment required** option is set to **Yes**.

### Solution: Assign access to users individually or as part of a group

Use one of the following options to assign access to users:

- To individually assign the user access to the application, see [Assign a user account to an enterprise application](/azure/active-directory/manage-apps/add-application-portal-assign-users#assign-a-user-account-to-an-enterprise-application).

- To assign users if they're a member of an assigned group or a dynamic group, see [Manage access to an application](/azure/active-directory/manage-apps/what-is-access-management).

## Cause 7: Tried to use a resource owner password credentials flow for personal accounts

If a user tries to use the resource owner password credentials (ROPC) flow for personal accounts, error `AADSTS50020` occurs. The Microsoft identity platform supports ROPC only within Microsoft Entra tenants, not personal accounts.

### Solution: Use an endpoint that's specific to the tenant or organization

Use a tenant-specific endpoint (`https://login.microsoftonline.com/<TenantIDOrName>`) or the organization's endpoint. Personal accounts that are invited to a Microsoft Entra tenant can't use ROPC. For more information, see [Microsoft identity platform and OAuth 2.0 Resource Owner Password Credentials](/azure/active-directory/develop/v2-oauth-ropc).

## Cause 8: A previously deleted user name was re-created by the home tenant administrator

Error `AADSTS50020` might occur if the name of a guest user who was deleted in a resource tenant is re-created by the administrator of the home tenant. To verify that the guest user account in the resource tenant isn't associated with a user account in the home tenant, use one of the following options:

### Verification: Check whether the resource tenant's guest user is older than the home tenant's user account

The first verification option involves comparing the age of the resource tenant's guest user against the home tenant's user account. You can make this verification by using Microsoft Graph, Microsoft Entra PowerShell or Microsoft  Graph PowerShell SDK

#### Microsoft Graph

Issue a request to the [MS Graph API](/graph/api/user-get) to review the user creation date, as follows:

<!-- 
#### Request

{
  "blockType": "request",
  "name": "get_user_createdDateTime"
}
-->

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/users/{id | userPrincipalName}/createdDateTime
```

Then, check the creation date of the guest user in the resource tenant against the creation date of the user account in the home tenant. The scenario is confirmed if the guest user was created before the home tenant's user account was created.

#### Microsoft Entra PowerShell

Run the [Get-EntraUser](/powershell/module/microsoft.entra/get-entrauser) PowerShell cmdlet to review the user creation date, as follows:

```powershell
Get-EntraUser -UserId {id | userPrincipalName} | Select-Object id, userPrincipalName, createdDateTime
```

Then, check the creation date of the guest user in the resource tenant against the creation date of the user account in the home tenant. The scenario is confirmed if the guest user was created before the home tenant's user account was created.

#### Microsoft Graph PowerShell SDK

Run the [Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser) PowerShell cmdlet to review the user creation date, as follows:

```powershell
$p = @('Id', 'UserPrincipalName', 'CreatedDateTime')
Get-MgUser -UserId {id | userPrincipalName} -Property $p| Select-Object $p
```

Then, check the creation date of the guest user in the resource tenant against the creation date of the user account in the home tenant. The scenario is confirmed if the guest user was created before the home tenant's user account was created.

### Solution: Reset the redemption status of the guest user account

Reset the redemption status of the guest user account in the resource tenant. Then, you can keep the guest user object without having to delete and then re-create the guest account. You can reset the redemption status by using the Azure portal, Azure PowerShell, or the Microsoft Graph API. For instructions, see [Reset redemption status for a guest user](/azure/active-directory/external-identities/reset-redemption-status).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

# AADSTS650056: Misconfigured application error

# AADSTS650056: Misconfigured application error

This article provides troubleshooting steps and solutions for the error message AADSTS650056: Misconfigured application. This error typically occurs when there are issues with permissions or consent configurations in an Azure Active Directory (Azure AD) application.

## Symptoms

When attempting to sign in to an application, you might encounter the following error message (or a similar message):

AADSTS650056: Misconfigured application. This could be due to one of the following:
- The client has not listed any permissions for 'AAD Graph' in the requested permissions in the client’s application registration.
- The admin has not consented in the tenant.
- Check the application identifier in the request to ensure it matches the configured client application identifier.Please contact your admin to fix the configuration or consent on behalf of the tenant.

## Cause

This error usually occurs due to one of the following reasons:
- The application does not have the required permissions configured in its Azure AD registration.
- The admin has not consented to the permissions for the application on behalf of the tenant.
- The application identifier specified in the request does not match the registered application identifier in Azure AD.

## Solution 1: Verify application permissions and consent (for application owners)

If your organization owns the application (i.e., the application registration is in your organization's Azure tenant), follow these steps:
1. Ensure that the application has at least the **User.Read** or **openid** delegated permission from **Microsoft Graph** added in its **API Permissions**.
2. Check the **Status** column under **API Permissions** in the application's registration to verify whether the permissions are consented to. For example:
    - If the permission is not consented to, it will appear as pending.
    - If successfully consented, it will appear as "Granted for [Tenant Name]".

    Example of a consented permission:

    :::image type="content" source="https://blogs.aaddevsup.xyz/wp-content/uploads/2019/11/112719_1815_AADSTS650052.png" alt-text="" lightbox="https://blogs.aaddevsup.xyz/wp-content/uploads/2019/11/112719_1815_AADSTS650052.png":::
3. If the application is designed as a multi-tenant application, include the **User.Read** delegated permission in addition to other required permissions to simplify the consent process for customers.
4. If the application appears in **App registrations** in Azure AD, ensure it is properly configured and consented to. Note: Do not confuse this with **Enterprise applications**.

If the issue persists, you may need to generate a manual consent URL (refer to the "Manually build the consent URL" section below).

## Solution 2: Admin consent for third-party applications

If your organization is using the application as a third-party application (i.e., your organization is not the application owner), follow these steps:
1. As the Global Administrator or Company Administrator, attempt to sign in to the application. You should see a consent screen prompting you to grant permissions. Ensure you check the box for **"Consent on behalf of your organization"** before proceeding.

    Example of the consent screen:
:::image type="content" source="https://blogs.aaddevsup.xyz/wp-content/uploads/2019/11/112719_1815_AADSTS650053.png" alt-text="" lightbox="https://blogs.aaddevsup.xyz/wp-content/uploads/2019/11/112719_1815_AADSTS650053.png":::
2. If you do not see the consent screen, delete the application from the **Enterprise applications** section in Azure AD and try signing in again.

If the error persists, proceed to the next solution.

## Solution 3: Manually build the consent URL

In some scenarios, you may need to manually generate a consent URL to grant permissions to the application. This is especially useful when the application is accessing specific resources that require custom configurations.

### For the authorization V1 endpoint:

The consent URL will look like this:

https://login.microsoftonline.com/{Tenant-Id}/oauth2/authorize
?response\_type=code
&client\_id={App-Id}
&resource={App-Uri-Id}
&scope=openid
&prompt=consent

For example:

https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/authorize
?response\_type=code
&client\_id=044abcc4-914c-4444-9c3f-48cc3140b6b4
&resource=https://vault.azure.net/
&scope=openid
&prompt=consent

### For the authorization V2 endpoint:

The consent URL will look like this:

https://login.microsoftonline.com/{Tenant-Id}/oauth2/v2.0/authorize
?response\_type=code
&client\_id={App-Id}
&scope=openid+{App-Uri-Id}/{Scope-Name}
&prompt=consent

For example:

https://login.microsoftonline.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize
?response\_type=code
&client\_id=044abcc4-914c-4444-9c3f-48cc3140b6b4
&scope=openid+https://vault.azure.net/user\_impersonation
&prompt=consent

### Notes:
- If the application is accessing itself as the resource, the **{App-Id}** and **{App-Uri-Id}** will be the same.
- Obtain the **{App-Id}** and **{App-Uri-Id}** from the application owner.
- The **{Tenant-Id}** corresponds to your tenant identifier, which can be either your domain (e.g., yourdomain.onmicrosoft.com) or your directory ID.

Example of a tenant identifier:
:::image type="content" source="https://blogs.aaddevsup.xyz/wp-content/uploads/2019/11/112719_1815_AADSTS650054.png" alt-text="" lightbox="https://blogs.aaddevsup.xyz/wp-content/uploads/2019/11/112719_1815_AADSTS650054.png":::

By following these steps, you can resolve the AADSTS650056: Misconfigured application error. If the issue persists, contact your application owner or Azure AD administrator for further assistance.
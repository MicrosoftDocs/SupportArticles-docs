---
title: Resolve Power Automate Broken Connections
description: Troubleshoot broken connections in Microsoft Power Platform. Learn how to resolve timeouts, DLP blocks, expired tokens, and more. Fix your flows today.
ms.custom: sap:Connections
ms.workload: connectors
ms.reviewer: nravindra, angieandrews, rehodger, matow, v-shaywood
ms.date: 03/30/2026
---
# Troubleshoot broken connections in Microsoft Power Platform

## Summary

[Connections](/power-automate/add-manage-connections) in Microsoft Power Platform can break for many reasons, including expired tokens, Data Loss Prevention (DLP) blocks, password changes, Conditional Access policy mismatches, and disabled accounts. This article helps you identify the cause and fix broken connections in Power Automate.

- [Connection times out](#connection-times-out)
- [A DLP block occurs](#a-dlp-block-occurs)
- [Invalid authenticated devices](#invalid-authenticated-devices)
- [Inactivity for a long time](#inactivity-for-a-long-time)
- [Connection issue related to attended mode](#connection-issue-related-to-attended-mode)
- [Password modification by a user](#password-modification-by-a-user)
- [Microsoft Entra ID configuration is changed](#microsoft-entra-id-configuration-is-changed)
- [Connection owner account is deleted or disabled](#connection-owner-account-is-deleted-or-disabled)
- [Tenant administrator disables the application](#tenant-administrator-disables-the-application)
- [Conditional Access policy mismatch for embedded flows](#conditional-access-policy-mismatch-for-embedded-flows)
- [Terms of Use policy breaks flow connections](#terms-of-use-policy-breaks-flow-connections)

## Connection times out

This problem occurs when a client (such as a web browser or an application) tries to establish a connection with a server, but the server doesn't respond within a specified time limit. Several reasons can cause this problem, such as the server being offline, network problems, or the server taking too long to process the request. When the connection times out, the client stops waiting for a response and terminates the connection attempt.

You might also receive the following error message:

> The user could not be authenticated as the grant is expired. The user must sign in again.

### Solution

1. Check your internet connection: Ensure that the internet connection is stable and working properly.
1. Check the server status: Verify if the server you're trying to connect to is online and not experiencing any downtime.
1. Try increasing the timeout limit: Sometimes, increasing the timeout limit can help establish a connection with the server.

## A DLP block occurs

[Data Loss Prevention (DLP)](/purview/dlp-learn-about-dlp) is a security measure that prevents sensitive information from being shared or transferred inappropriately. A DLP block occurs when a DLP policy detects that an action, such as sending an email or sharing a file, violates the organization's data protection rules. The DLP system then blocks the action to prevent potential data breaches or unauthorized access to sensitive information.

When a DLP block occurs, you might also receive one of the following error messages:

> - Access has been blocked by Conditional Access policies. The access policy does not allow token issuance.
> - Device is not in required device state: domain_joined. Conditional Access policy requires a domain joined device, and the device is not domain joined.

### Solution

1. Review DLP policies: Check the DLP policies configured in the organization to understand what actions are blocked and why.
1. Consult with your administrator: If they blocked the connector or connection, consult with them about unblocking it.

## Invalid authenticated devices

This situation occurs when a user tries to authenticate by using a device for multifactor authentication (MFA), but the device is disabled. This issue isn't related to Power Automate but to the tenant's configuration at the administrative level.

In this situation, you might also receive one of the following error messages:

> - Device object was not found in the tenant '\<TenantID>' directory.
> - Device is not in required device state: compliant. Conditional Access policy requires a compliant device, and the device is not compliant. The user must enroll their device with an approved MDM provider like Intune.
> - Device used during the authentication is disabled.
> - Application needs to enforce Intune protection policies.
> - Error from token exchange. Permission denied due to missing connection ACL.

### Solution

1. Contact the tenant administrator to understand why the device was disabled.
1. Try re-authorizing the connection.

## Inactivity for a long time

This situation occurs when a connection becomes invalid because it isn't used for a specified period. For example, the SharePoint connector requires usage at least once every 90 days to remain active. If you don't use the connection within this period, it expires.

For more information, see [Refresh tokens in the Microsoft identity platform](/entra/identity-platform/refresh-tokens).

In this situation, you might also receive one of the following error messages:

> - The refresh token has expired due to inactivity. The token was issued on \<DateTime> and was inactive for 90.00:00:00.
> - The provided authorization code or refresh token has expired due to inactivity. Send a new interactive authorization request for this user and resource.

### Solution

Create a new connection or re-authorize the existing one.

## Connection issue related to attended mode

This situation refers to problems that occur when a user tries to use features that require a license for unattended mode but doesn't have the necessary license. In attended mode, the user must be present and interact with the system, whereas unattended mode allows for fully automated processes without user interaction. If a user without the appropriate license attempts to use unattended mode, the connection fails.

[Learn more about attended and unattended scenarios for process automation](/power-automate/guidance/planning/attended-unattended).

### Solution

Ensure the user has the correct license to interact with the system as required in unattended mode. For more information, see [Which Power Automate licenses do I need?](/power-platform/admin/power-automate-licensing/faqs#which-power-automate-licenses-do-i-need)

## Password modification by a user

This problem happens when you delete, change, or let the account password expire for the account you use to create the connection. Since account verification is a crucial part of authentication whenever you trigger a connection, the connection breaks if you don't update the new password.

You might also receive the following error message:

> The provided grant has expired due to it being revoked, a fresh auth token is needed. The user might have changed or reset their password. The grant was issued on '\<DateTime>' and the TokensValidFrom date (before which tokens are not valid) for this user is '\<DateTime>'.

### Solution

Every time you update your password, you invalidate the existing connection that uses the old password. You must create a new connection for each of those connectors or edit the existing connection. To avoid this problem, use services like [Microsoft Entra ID](/entra/fundamentals/whatis).

## Microsoft Entra ID configuration is changed

This problem refers to modifications made at the Microsoft Entra ID (formerly Azure Active Directory) level that affect user identities or access policies. These changes include moving to a new location, altering user roles, or updating security settings. Such changes might invalidate existing tokens and require users to reauthenticate.

You might also receive the following error message:

> Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '00000003-0000-0000-c000-000000000000'.

### Solution

Contact the tenant administrator to understand the specific changes and reauthorize the connection if necessary.

## Connection owner account is deleted or disabled

This situation occurs when the account that created a connection is removed or disabled in the directory. As a result, the connection becomes invalid, affecting all users who share it.

In this situation, you might also receive one of the following error messages:

- > The user account {EUII Hidden} has been deleted from the \<DirectoryID> directory. To sign into this application, the account must be added to the directory.
- > The user account is disabled.
- > The user account {EUII Hidden} does not exist in the \<DirectoryID> directory. To sign into this application, the account must be added to the directory.

### Solution

To resolve this issue, another user with access can reauthorize the connection, which updates the ownership and restores functionalities for all users.

## Tenant administrator disables the application

This situation occurs when the tenant administrator deactivates an application registered in Microsoft Entra ID (formerly Azure Active Directory). This action invalidates any service principal connections associated with the application, as it can no longer issue tokens.

You might also receive the following error message:

> The service principal for resource '\<ResourceID>' is disabled. This indicate that a subscription within the tenant has lapsed, or that the administrator for this tenant has disabled the application, preventing tokens from being issued for it.

### Solution

To resolve this issue, the tenant administrator needs to reenable the application or create a new service principal connection.

## Conditional Access policy mismatch for embedded flows

Connections can appear broken when you access a flow from an embedded surface (such as a SharePoint list, Microsoft Teams channel, or Excel workbook) if the Conditional Access (CA) policies for the host application and Power Automate have different requirements.

You might see an authentication error similar to the following error message:

> AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '\<Resource\>'.

### Cause

When a user accesses a flow from SharePoint, Teams, or Excel, the host application exchanges its token for a **Microsoft Flow Service** token. If the CA policies have different requirements (MFA, Terms of Use, or device compliance) for one application but not the other, this exchange fails.

This problem typically happens when CA policies target individual applications with different requirements, rather than using the **Office 365** app or **All cloud apps** target that covers both the host application and Power Automate consistently.

### Solution

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **Protection** > **Conditional Access** > **Policies**.
1. Switch your policy to target the **Office 365** app or **All cloud apps** for consistent enforcement across Power Automate and the apps that embed it.
1. If you must target individual applications, check that all Conditional Access requirements (MFA, Terms of Use, device compliance) are consistent between the host applications (SharePoint, Teams, Excel) and **Microsoft Flow Service** (Application ID: `7df0a125-d3be-4c96-aa54-591f83ff541c`).
1. Ask affected users to sign out and sign back in.

For detailed guidance, see [Conditional access and multifactor authentication in Power Automate](/troubleshoot/power-platform/power-automate/administration/conditional-access-and-multi-factor-authentication-in-flow).

## Terms of Use policy breaks flow connections

Connections can break when an administrator adds a [Terms of Use](/entra/identity/conditional-access/terms-of-use) requirement to a Conditional Access policy after flows are already running, or when a Terms of Use consent expires on a recurring schedule.

You might see the following connection status:

> Failed to refresh access token for service

The accompanying error message doesn't specifically mention Terms of Use as the cause.

### Cause

Power Automate connections refresh tokens silently in the background. When a Terms of Use grant control is in scope, the silent token refresh fails because the Terms of Use acceptance page can't be presented without an interactive session. This failure breaks connections retroactively, even for flows that were working before the Terms of Use policy existed.

### Solution

1. Check Microsoft Entra sign-in logs for `AADSTS50158` or `AADSTS53003` errors targeting the **Microsoft Flow Service** resource. In the **Conditional Access** tab, look for a Terms of Use grant control with a status of **Not Satisfied**.
1. Ask the flow owner to sign in interactively to the [Power Automate portal](https://make.powerautomate.com) to accept the Terms of Use prompt.
1. Repair or re-create the affected connection.
1. To prevent recurrence, exclude service accounts and dedicated flow connection owners from Conditional Access policies that include [Terms of Use](/entra/identity/conditional-access/terms-of-use) grant controls.

For detailed guidance, see [Conditional access and multifactor authentication in Power Automate](/troubleshoot/power-platform/power-automate/administration/conditional-access-and-multi-factor-authentication-in-flow).

## Related content

- [Manage connections in Power Automate](/power-automate/add-manage-connections)
- [Create a connection with a service principal](/power-automate/desktop-flows/alm/alm-connection)

---
title: Troubleshoot Broken Connections
description: Learn how to troubleshoot and resolve connection problems and ensure a smoother experience with your applications and services in Microsoft Power Platform.
ms.custom: sap:Connections
ms.workload: connectors
author: nravindra-msft
ms.author: nravindra
ms.reviewer: angieandrews, rehodger
ms.date: 06/04/2025
---
# Troubleshoot broken connections in Microsoft Power Platform

There are various reasons why [connection](/power-automate/add-manage-connections) problems might occur in Microsoft Power Platform. This article describes some of the common reasons and helps you troubleshoot and solve these issues.

- [Connection times out](#connection-times-out)
- [A DLP block occurs](#a-dlp-block-occurs)
- [Invalid authenticated devices](#invalid-authenticated-devices)
- [Inactivity for a long time](#inactivity-for-a-long-time)
- [Connection issue related to attended mode](#connection-issue-related-to-attended-mode)
- [Password modification by a user](#password-modification-by-a-user)
- [Microsoft Entra ID configuration is changed](#microsoft-entra-id-configuration-is-changed)
- [Connection owner account is deleted or disabled](#connection-owner-account-is-deleted-or-disabled)
- [Tenant administrator disables the application](#tenant-administrator-disables-the-application)

## Connection times out

This issue occurs when a client (such as a web browser or an application) tries to establish a connection with a server, but the server doesn't respond within a specified time limit. This can occur for several reasons, such as the server being offline, network issues, or the server taking too long to process the request. When the connection times out, the client stops waiting for a response and terminates the connection attempt.

You might also receive the following error message:

> The user could not be authenticated as the grant is expired. The user must sign in again.

### Troubleshooting steps

1. Check your internet connection: Ensure that the internet connection is stable and working properly.
2. Check the server status: Verify if the server you're trying to connect to is online and not experiencing any downtime.
3. Try increasing the time-out limit: Sometimes, increasing the time-out limit can help in establishing a connection with the server.

## A DLP block occurs

[Data Loss Prevention (DLP)](/purview/dlp-learn-about-dlp) is a security measure that prevents sensitive information from being shared or transferred inappropriately. A DLP block occurs when a DLP policy detects that an action, such as sending an email or sharing a file, violates the organization's data protection rules. The DLP system then blocks the action to prevent potential data breaches or unauthorized access to sensitive information.

When a DLP block occurs, you might also receive one of the following error messages:

> - Access has been blocked by Conditional Access policies. The access policy does not allow token issuance.
> - Device is not in required device state: domain_joined. Conditional Access policy requires a domain joined device, and the device is not domain joined.

### Troubleshooting steps

1. Review DLP policies: Check the DLP policies configured in the organization to understand what actions are being blocked and why.
2. Consult with your administrator: If they've blocked the connector or connection, consult with them about unblocking it.

## Invalid authenticated devices

This refers to a situation where a user tries to authenticate using a device for multi-factor authentication (MFA), but the device is disabled. This issue isn't related to Power Automate but to the tenant's configuration at the administrative level.

In this situation, you might also receive one of the following error messages:

> - Device object was not found in the tenant '\<TenantID>' directory.
> - Device is not in required device state: compliant. Conditional Access policy requires a compliant device, and the device is not compliant. The user must enroll their device with an approved MDM provider like Intune.
> - Device used during the authentication is disabled.
> - Application needs to enforce Intune protection policies.
> - Error from token exchange. Permission denied due to missing connection ACL.

### Troubleshooting steps

1. Contact the tenant administrator to understand why the device was disabled.
2. Try re-authorizing the connection.

## Inactivity for a long time

This refers to a situation where a connection becomes invalid because it hasn't been used for a specified period. For example, the SharePoint connector requires usage at least once every 90 days to remain active. If the connection isn't used within this period, it expires.

For more information, see [Refresh tokens in the Microsoft identity platform](/entra/identity-platform/refresh-tokens).

In this situation, you might also receive one of the following error messages:

> - The refresh token has expired due to inactivity. The token was issued on \<DateTime> and was inactive for 90.00:00:00.
> - The provided authorization code or refresh token has expired due to inactivity. Send a new interactive authorization request for this user and resource.

### Troubleshooting steps

Create a new connection or re-authorize the existing one.

## Connection issue related to attended mode

This refers to problems that occur when a user tries to use features that require a license for unattended mode but doesn't have the necessary license. In attended mode, the user must be present and interact with the system, whereas unattended mode allows for fully automated processes without user interaction. If a user without the appropriate license attempts to use unattended mode, the connection fails.

[Learn more about attended and unattended scenarios for process automation](/power-automate/guidance/planning/attended-unattended).

### Troubleshooting steps

Ensure the user has the correct license to interact with the system as required in unattended mode. For more information, see [Which Power Automate licenses do I need?](/power-platform/admin/power-automate-licensing/faqs#which-power-automate-licenses-do-i-need)

## Password modification by a user

This issue occurs when the account password used to create the connection is deleted, changed, or expired. Since account verification is a crucial part of authentication whenever a connection is triggered, the connection breaks if the new password isn't updated.

You might also receive the following error message:

> The provided grant has expired due to it being revoked, a fresh auth token is needed. The user might have changed or reset their password. The grant was issued on '\<DateTime>' and the TokensValidFrom date (before which tokens are not valid) for this user is '\<DateTime>'.

### Troubleshooting steps

Every time a user updates the password, the existing connection with the password becomes invalid, so the user must create a new connection for each of those connectors or edit the existing connection. To avoid this issue, use services like [Microsoft Entra ID](/entra/fundamentals/whatis).

## Microsoft Entra ID configuration is changed

This refers to modifications made at the Microsoft Entra ID (formerly Azure Active Directory) level that affect user identities or access policies. These changes include moving to a new location, altering user roles, or updating security settings. Such changes might invalidate existing tokens and require users to reauthenticate.

You might also receive the following error message:

> Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '00000003-0000-0000-c000-000000000000'.

### Troubleshooting steps

Contact the tenant administrator to understand the specific changes and reauthorize the connection if necessary.

## Connection owner account is deleted or disabled

This refers to a situation where the account that created a connection is either removed or disabled in the directory. As a result, the connection becomes invalid, affecting all users who share it.

In this situation, you might also receive one of the following error messages:

- > The user account {EUII Hidden} has been deleted from the \<DirectoryID> directory. To sign into this application, the account must be added to the directory.
- > The user account is disabled.
- > The user account {EUII Hidden} does not exist in the \<DirectoryID> directory. To sign into this application, the account must be added to the directory.

### Troubleshooting steps

To resolve this issue, another user with access can reauthorize the connection, thereby updating the ownership and restoring functionalities for all users.

## Tenant administrator disables the application

This refers to a situation where the tenant administrator has deactivated an application registered in Microsoft Entra ID (formerly Azure Active Directory). This action invalidates any service principal connections associated with the application, as it can no longer issue tokens.

You might also receive the following error message:

> The service principal for resource '\<ResourceID>' is disabled. This indicate that a subscription within the tenant has lapsed, or that the administrator for this tenant has disabled the application, preventing tokens from being issued for it.

### Troubleshooting steps

To resolve this issue, the tenant administrator needs to reenable the application or create a new service principal connection.

## Conditional Access policy mismatch for embedded flows

Connections can appear broken when a flow is accessed from an embedded surface (such as a SharePoint list, Microsoft Teams channel, or Excel workbook) if the Conditional Access (CA) policies for the host application and Power Automate have different MFA requirements.

You might see an authentication error similar to:

> AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '\<resource\>'.

### Cause

When a user accesses a flow from SharePoint, Teams, or Excel, the host application exchanges its token for a **Microsoft Flow Service** token. If the CA policies require MFA for one application but not the other, this exchange fails.

Common scenarios:

- Your CA policy targets the **Office 365** app suite (which includes SharePoint and Teams) but doesn't explicitly include **Microsoft Flow Service** (Application ID: `7df0a125-d3be-4c96-aa54-591f83ff541c`). Microsoft Flow Service is not part of the Office 365 application target.
- Your CA policy requires MFA for Power Automate but not for the host application, or the reverse.

### Troubleshooting steps

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **Protection** > **Conditional Access** > **Policies**.
2. Identify all policies that require MFA for SharePoint, Teams, or the Office 365 app suite.
3. Verify that the same policies also include **Microsoft Flow Service**, or that a separate policy applies equivalent MFA requirements to it.
4. If you want consistent MFA enforcement for all cloud applications, consider targeting **All cloud apps** instead of individual applications.
5. After updating policies, ask affected users to sign out and sign back in.

For detailed guidance, see [Conditional access and multifactor authentication in Power Automate](/troubleshoot/power-platform/power-automate/administration/conditional-access-and-multi-factor-authentication-in-flow).


## More information

- [Manage connections in Power Automate](/power-automate/add-manage-connections)
- [Create a connection with a service principal](/power-automate/desktop-flows/alm/alm-connection)

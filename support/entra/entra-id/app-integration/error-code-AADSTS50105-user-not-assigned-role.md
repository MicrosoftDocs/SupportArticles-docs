---
title: Error AADSTS50105 - The signed-in user isn't assigned to a role for the application
description: Learn how to resolve error AADSTS50105 when a user isn't assigned to an enterprise application that requires assignment and restore access.
ms.date: 08/20/2026
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: bernaw, phsignor
ms.service: entra-id
ms.custom:
 - sap:Issues Signing In to Applications
 - sfi-ga-nochange
ai-usage: ai-assisted
---
# Error AADSTS50105 - The signed-in user isn't assigned to a role for the application

## Summary

Error AADSTS50105 occurs when an enterprise application requires assignment, but the user requesting access doesn't have a qualifying assignment. This article explains how to resolve the error and restore user access.

The assignment check can apply to applications that use SAML, OpenID Connect, OAuth 2.0, WS-Federation, or Application Proxy preauthentication.

[!INCLUDE [Feedback](../../../includes/feedback.md)]

## Symptoms

When a user tries to sign in to an application, they receive the following error:

> Error AADSTS50105 - The signed in user is not assigned to a role for the application.

## Cause

The enterprise application's service principal has **Assignment required?** set to **Yes**, and the requesting user doesn't have an app role assignment to the application.

For a user, access can come from either of these assignments:

- The user is assigned directly to the application.
- A group is assigned to the application, and the user is a direct member of that group.

An assignment to **Default Access** satisfies the assignment requirement when the application doesn't expose a named application role. However, **Default Access** doesn't add a `roles` claim to the token.

> [!IMPORTANT]
> For predictable access, don't rely on nested group membership. Assign the user directly, or use a group of which the user is a direct member.

> [!NOTE]
> The assignment requirement doesn't apply to Global Administrators. A Global Administrator can sign in without an assignment, so test with the affected user.

## Resolution

Use an account that can update the enterprise application's properties and app role assignments, such as a Cloud Application Administrator or Application Administrator, or a current owner of the application's service principal. Group-based assignment requires a Microsoft Entra ID P1 or P2 license.

First, confirm whether the application should restrict access to assigned users:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Browse to **Microsoft Entra ID** > **Enterprise apps** > **All applications**.
1. Select the application, and then select **Properties**.
1. Review **Assignment required?**.

Then use the resolution that matches the intended access policy.

### Keep assignment required

If only selected users and groups should have access:

1. In the enterprise application, select **Users and groups**.
1. Select **Add user/group**.
1. Select the user or group to assign.
1. Select an application role. If the application doesn't expose a named role, select **Default Access**.
1. Select **Assign**.

For more information, see [Assign users and groups to an application](/entra/identity/enterprise-apps/assign-user-or-group-access-portal).

### Don't require assignment

If all otherwise-authorized users in the tenant should be able to access the application:

> [!IMPORTANT]
> Setting **Assignment required?** to **No** broadens token eligibility to include unassigned users and applications. Make this change only if it matches your organization's intended access policy.

1. On the enterprise application's **Properties** page, set **Assignment required?** to **No**.
1. Select **Save**.

This change removes the assignment check. Other access controls, such as Conditional Access policies and application-specific authorization, still apply.

### Verify with the affected identity

Test the change with the user who received the error. Don't use a Global Administrator to verify the assignment because the assignment requirement doesn't apply to that role.

## More information

For an app-only assignment failure that returns AADSTS501051, see [Restrict a Microsoft Entra app to a set of users](/entra/identity-platform/howto-restrict-your-app-to-a-set-of-users).

For a full list of Microsoft Entra authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes).

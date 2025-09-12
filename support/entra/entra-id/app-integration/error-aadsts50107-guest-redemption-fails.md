---
title: Guest Invitation Redemption Fails with Error AADSTS50107
description: Provides a solution to the error AADSTS50107 that occurs when a guest user tries to redeem an invitation via a SAML external trust.
ms.reviewer: laks, joaos, lyzh, v-weizhu
ms.service: entra-id
ms.date: 05/21/2025
ms.custom: sap:Issues Signing In to Applications
---
# Error AADSTS50107 when a guest user redeems an invitation via SAML external trust

This article provides a solution to the Microsoft Entra authentication error AADSTS50107. This error occurs when a guest user attempts to redeem an invitation from a tenant that uses a Security Assertion Markup Language (SAML) external trust.

## Symptoms

Consider the following scenario:

- Your tenant has a direct federation trust with an external organization that uses a SAML or WS-Fed identity provider (IdP).
- The external organization invites a user to your tenant as a guest.
- The guest user attempts to redeem the invitation.

In this scenario, the invitation redemption fails with the following error message:

> Error: AADSTS50107: The requested federation realm object 'https://abc.contoso.com' does not exist.

## Cause

This issue occurs when the issuer URL value in the SAML response doesn't match the one configured in Microsoft Entra ID. The issuer URL in the SAML response corresponds to the URL mentioned in the error message.

## Resolution

To resolve this issue, follow these steps:

1. Ensure that the issuer URL in the external IdP matches the one configured in Microsoft Entra ID.
1. Verify or update the issuer URL in Microsoft Entra ID to align with the one in the SAML response.

    To verify the issuer URL in Microsoft Entra ID, follow these steps:

    1. Sign in to the Microsoft Entra admin center as an administrator.
    1. Select **Manage** > **External Identities**.
    1. Select **View all identity providers**.
    1. Under the **Custom** tab, select the desired SAML trust (such as `Contoso.com`).
    1. Select **Edit Configuration** for the desired SAML trust.
    1. Check if the issuer URL configured in Microsoft Entra ID matches the `saml:Issuer` value in the SAML response sent by the external IdP.

For more information, see [Add federation with SAML/WS-Fed identity providers](/entra/external-id/direct-federation).

## More information

For a full list of Microsoft Entra authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

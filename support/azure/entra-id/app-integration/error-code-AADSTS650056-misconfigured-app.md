---
title: Error AADSTS650056 - Misconfigured application
description: Describes a problem in which you receive an error message AADSTS650056 when signing in to SAML-based single sign-on configured app that has been configured to use Microsoft Entra ID as an Identity Provider (IdP).
ms.date: 08/26/2022
ms.reviewer: bernawy
ms.service: entra-id
ms.subservice: enterprise-apps
---
# Error AADSTS650056 - Misconfigured application

This article describes a problem in which you receive the following error message when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Microsoft Entra ID:

> Error AADSTS650056 - Misconfigured application. This could be due to one of the following: the client has not listed any permissions for '{name}' in the requested permissions in the client's application registration. Or, the admin has not consented in the tenant. Or, check the application identifier in the request to ensure it matches the configured client application identifier. Or, check the certificate in the request to ensure it's valid. Please contact your admin to fix the configuration or consent on behalf of the tenant. Client app ID: {id}. Please contact your admin to fix the configuration or consent on behalf of the tenant.

## Symptoms

You receive error `AADSTS650056` when trying to sign into an application that has been setup to use Microsoft Entra ID for identity management using SAML-based SSO.

## Cause

The `Issuer` attribute sent from the application to Microsoft Entra ID in the SAML request doesn’t match the Identifier value configured for the application in Microsoft Entra ID.

## Resolution

Ensure that the `Issuer` attribute in the SAML request matches the Identifier value configured in Microsoft Entra ID.

Verify that the value in the Identifier textbox matches the value for the identifier value displayed in the error.

For more information about the Issuer attribute, see [Single Sign-On SAML protocol](/azure/active-directory/develop/single-sign-on-saml-protocol).

## More Information

For a full list of Active Directory authentication and authorization error codes see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

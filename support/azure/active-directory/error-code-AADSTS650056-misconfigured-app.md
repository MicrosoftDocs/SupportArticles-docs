---
title: Error AADSTS650056 - Misconfigured application
description: Describes a problem in which you receive an error message AADSTS650056 when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP).
ms.date: 03/15/2021
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS650056 - Misconfigured application

This article describes a problem in which you receive the following error message when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD):

> Error AADSTS650056 - Misconfigured application. This could be due to one of the following: the client has not listed any permissions for '{name}' in the requested permissions in the client's application registration. Or, the admin has not consented in the tenant. Or, check the application identifier in the request to ensure it matches the configured client application identifier. Or, check the certificate in the request to ensure it's valid. Please contact your admin to fix the configuration or consent on behalf of the tenant. Client app ID: {id}. Please contact your admin to fix the configuration or consent on behalf of the tenant.

## Symptoms

You receive error `AADSTS650056` when trying to sign into an application that has been setup to use Azure AD for identity management using SAML-based SSO.

## Cause

The `Issuer` attribute sent from the application to Azure AD in the SAML request doesn’t match the Identifier value configured for the application in Azure AD.

## Resolution

Ensure that the `Issuer` attribute in the SAML request matches the Identifier value configured in Azure AD.

Verify that the value in the Identifier textbox matches the value for the identifier value displayed in the error.

For more information about the Issuer attribute, see [Single Sign-On SAML protocol](/azure/active-directory/develop/single-sign-on-saml-protocol).

## More Information

For a full list of Active Directory authentication and authorization error codes see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

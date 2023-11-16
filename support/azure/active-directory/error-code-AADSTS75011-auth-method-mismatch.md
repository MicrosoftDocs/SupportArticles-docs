---
title: Error - AADSTS75011 Authentication method by which the user authenticated with the service doesn't match requested authentication method AuthnContextClassRef.
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Microsoft Entra ID as an Identity Provider (IdP). The error you receive is Error - AADSTS75011 Authentication method by which the user authenticated with the service doesn't match requested authentication method AuthnContextClassRef
ms.date: 08/26/2022
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error - AADSTS75011 Authentication method by which the user authenticated with the service doesn't match requested authentication method AuthnContextClassRef

This article describes a problem in which you receive the error message "Error - AADSTS75011 Authentication method by which the user authenticated with the service doesn't match requested authentication method AuthnContextClassRef." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Microsoft Entra ID.

## Symptoms

You receive error `AADSTS75011` when trying to sign into an application that has been setup to use Microsoft Entra ID for identity management using SAML-based SSO.

## Cause

The `RequestedAuthnContext` is in the SAML request. This means the app is expecting the `AuthnContext` specified by the `AuthnContextClassRef`. However, the user has already authenticated prior to access the application and the `AuthnContext` (authentication method) used for that previous authentication is different from the one being requested. For example, a federated user access to MyApps and WIA occurred. The `AuthnContextClassRef` will be `urn:federation:authentication:windows`. Microsoft Entra ID won’t perform a fresh authentication request, it will use the authentication context that was passed-through it by the IdP (ADFS or any other federation service in this case). Therefore, there will be a mismatch if the app requests other than `urn:federation:authentication:windows`. Another scenario is when MultiFactor was used: `'X509, MultiFactor`.

## Resolution

`RequestedAuthnContext` is an optional value. Then, if possible, ask the application if it could be removed.

Another option is to make sure the `RequestedAuthnContext` will be honored. This will be done by requesting a fresh authentication. By doing this, when the SAML request is processed, a fresh authentication will be done and the `AuthnContext` will be honored. To request a Fresh Authentication the SAML request must contain the value `forceAuthn="true"`.

## More Information

For a full list of Active Directory Authentication and authorization error codes see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

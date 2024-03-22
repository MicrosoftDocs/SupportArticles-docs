---
title: Error AADSTS75005 - The request is not a valid Saml2 protocol message
description: Describes a problem in which you receive AADSTS75005 error when signing in to SAML-based single sign-on configured app.
ms.date: 08/26/2022
ms.reviewer: bernawy
ms.service: entra-id
ms.subservice: enterprise-apps
---
# Error AADSTS75005 - The request is not a valid Saml2 protocol message

This article describes a problem in which you receive the error message "Error AADSTS75005 - The request is not a valid Saml2 protocol message." when you try to sign into an apapplication that has been integrated with Microsoft Entra ID.

## Symptoms

You receive error `AADSTS75005` when trying to sign into an application that has been set up to use Microsoft Entra ID for identity management using SAML-based SSO.

## Cause

Microsoft Entra ID doesn't support the SAML request sent by the application for single sign-on. Some common issues are:

- Missing required fields in the SAML request.
- SAML request encoded method.

## Resolution

1. Capture the SAML request. Follow the tutorial [How to debug SAML-based single sign-on to applications in Microsoft Entra ID](/azure/active-directory/manage-apps/debug-saml-sso-issues) to learn how to capture the SAML request.
1. Contact the application vendor and share the following info:
    - SAML request
    - [Microsoft Entra Single Sign-on SAML protocol requirements](/azure/active-directory/develop/single-sign-on-saml-protocol)

The application vendor should validate that they support the Microsoft Entra SAML implementation for single sign-on.

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

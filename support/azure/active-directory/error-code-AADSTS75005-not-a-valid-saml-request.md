---
title: Error AADSTS75005 - The request is not a valid Saml2 protocol message.
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The error you receive is Error AADSTS75005 - The request is not a valid Saml2 protocol message.
ms.date: 03/15/2021
ms.prod-support-area-path: 
ms.reviewer: bernawy
---
# The error you receive is Error AADSTS75005 - The request is not a valid Saml2 protocol message

This article describes a problem in which you receive the error message "Error AADSTS75005 - The request is not a valid Saml2 protocol message." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS75005` when trying to sign into an application that has been setup to use Azure AD for identity management using SAML-based SSO.

## Cause

Azure AD doesn’t support the SAML request sent by the application for single sign-on. Some common issues are:

- Missing required fields in the SAML request.
- SAML request encoded method.

## Resolution

1. Capture the SAML request. Follow the tutorial [How to debug SAML-based single sign-on to applications in Azure AD](https://docs.microsoft.com/azure/active-directory/manage-apps/debug-saml-sso-issues) to learn how to capture the SAML request.
1. Contact the application vendor and share the following info:
    - SAML request
    - [Azure AD Single Sign-on SAML protocol requirements](https://docs.microsoft.com/azure/active-directory/develop/single-sign-on-saml-protocol)

The application vendor should validate that they support the Azure AD SAML implementation for single sign-on.

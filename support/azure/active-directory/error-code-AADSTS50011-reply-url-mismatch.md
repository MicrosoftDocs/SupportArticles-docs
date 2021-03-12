---
title: Error AADSTS50011 - The reply URL specified in the request does not match the reply URLs configured for the application.
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP).
ms.date: 03/12/2021
ms.prod-support-area-path: 
ms.reviewer: bernawy
---
# Error AADSTS50011 - The reply URL specified in the request does not match the reply URLs configured for the application.

This article describes a problem in which you receive the error message "Error AADSTS50011 - The reply URL specified in the request does not match the reply URLs configured for the application." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory.

## Symptoms

You receive error `AADSTS50011` when trying to sign into an application that has been setup to use Azure Active Directory (Azure AD) for identity management using SAML-based SSO.

## Cause

The `AssertionConsumerServiceURL` value in the SAML request doesn't match the Reply URL value or pattern configured in Azure AD. The `AssertionConsumerServiceURL` value in the SAML request is the URL you see in the error.

## Resolution

Ensure that the `AssertionConsumerServiceURL` value in the SAML request matches the Reply URL value configured in Azure AD.

Verify or update the value in the Reply URL textbox to match the `AssertionConsumerServiceURL` value in the SAML request.

After you've updated the Reply URL value in Azure AD, and it matches the value sent by the application in the SAML request, you should be able to sign in to the application.

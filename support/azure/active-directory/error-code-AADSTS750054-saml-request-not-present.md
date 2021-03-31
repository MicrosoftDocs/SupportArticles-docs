---
title: Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding.
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The error you receive is Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding.
ms.date: 03/15/2021
ms.prod-support-area-path: 
ms.reviewer: bernawy
---
# Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding

This article describes a problem in which you receive the error message "Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS750054` when trying to sign into an application that has been setup to use Azure AD for identity management using SAML-based SSO.

## Cause

Azure AD wasn’t able to identify the SAML request within the URL parameters in the HTTP request. This can happen if the application is not using HTTP redirect binding when sending the SAML request to Azure AD.

## Resolution

The application needs to send the SAML request encoded into the location header using HTTP redirect binding. For more information about how to implement it, read the section HTTP Redirect Binding in the [SAML protocol specification document](https://docs.oasis-open.org/security/saml/v2.0/saml-bindings-2.0-os.pdf).

## More Information

For a full list of Active Directory Authentication and authorization error codes see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

---
title: Error AADSTS50011 - The reply URL <reply URL sent> specified in the request does not match the reply URLs configured for the application <GUID>....
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The error you receive is Error AADSTS50011 - The reply URL <reply URL sent> specified in the request does not match the reply URLs configured for the application <GUID>. Make sure the reply URL sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/urlMismatchError to learn more about how to fix this.
ms.date: 03/15/2021
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50011 - The reply URL 'reply URL sent' specified in the request does not match the reply URLs configured for the application 'appId'

This article describes a problem in which you receive the error message "Error AADSTS50011 - The reply URL \<reply URL sent\> specified in the request does not match the reply URLs configured for the application \<GUID\>. Make sure the reply URL sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/urlMismatchError to learn more about how to fix this." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS50011` when trying to sign into an application that has been setup to use Azure AD for identity management using SAML-based SSO.

## Cause

The `AssertionConsumerServiceURL` value in the SAML request doesn't match the Reply URL value or pattern configured in Azure AD. The `AssertionConsumerServiceURL` value in the SAML request is the URL you see in the error.

## Resolution

To fix the issue, follow these steps:

1. Ensure that the `AssertionConsumerServiceURL` value in the SAML request matches the Reply URL value configured in Azure AD.
2. Verify or update the value in the Reply URL textbox to match the `AssertionConsumerServiceURL` value in the SAML request.

As an example, refer to the following article for detailed steps about how to configure the values in Azure AD:

- [Tutorial: Azure AD SSO integration with Salesforce](/azure/active-directory/saas-apps/salesforce-tutorial)

>[!Note]
>The reply URL is also known as Redirect URI. These values depend on what application is being used. You should get the values from the application vendor.

After you've updated the Reply URL value in Azure AD, and it matches the value sent by the application in the SAML request, you should be able to sign in to the application.

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

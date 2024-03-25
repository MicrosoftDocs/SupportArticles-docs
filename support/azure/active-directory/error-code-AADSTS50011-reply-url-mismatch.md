---
title: Error AADSTS50011 - The reply URL specified in the request does not match the reply URLs configured for the application <GUID>.
description: Describes a problem in which you receive reply URL does not match error when signing in to SAML-based Single Sign-On configured app.
ms.date: 06/08/2023
ms.reviewer: bernawy
ms.service: entra-id
ms.subservice: enterprise-apps
---
# Error AADSTS50011 with SAML authentication - The reply URL specified in the request does not match

This article provides a resolution to the AADSTS50011 error that occurs during federated authentication with Microsoft Entra ID.

## Symptoms

You receive error `AADSTS50011` when trying to sign into an application that has been set up to use Microsoft Entra ID for identity management using SAML-based SSO.

>Error AADSTS50011 - The reply URL does not match the reply URLs configured for the application \<GUID\>. Make sure the reply URL sent in the request matches one added to your application in the Azure portal. Navigate to https://aka.ms/urlMismatchError to learn more about how to fix this." when trying to sign into a SAML-based Single Sign-On (SSO) configured app that has been integrated with Microsoft Entra ID.

## Cause

The `AssertionConsumerServiceURL` value in the SAML request doesn't match the Reply URL value or pattern configured in Microsoft Entra ID. The `AssertionConsumerServiceURL` value in the SAML request is the URL you see in the error.

## Resolution

To fix the issue, follow these steps:

1. Ensure that the `AssertionConsumerServiceURL` value in the SAML request matches the Reply URL value configured in Microsoft Entra ID.
2. Verify or update the value in the Reply URL textbox to match the `AssertionConsumerServiceURL` value in the SAML request.

As an example, refer to the following article for detailed steps about how to configure the values in Microsoft Entra ID:

- [Tutorial: Microsoft Entra SSO integration with Salesforce](/azure/active-directory/saas-apps/salesforce-tutorial)

>[!Note]
>The reply URL is also known as Redirect URI. These values depend on what application is being used. You should get the values from the application vendor.

After you update the Reply URL value in Microsoft Entra ID and it matches the value that sent by the application in the SAML request, you should be able to sign in to the application.

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

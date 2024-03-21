---
title: Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding.
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Microsoft Entra ID as an Identity Provider (IdP). The error you receive is Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding.
ms.date: 10/12/2022
ms.reviewer: bernawy
ms.service: entra-id
ms.subservice: enterprise-apps
---
# Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding

This article describes a problem in which you receive the error message "Error AADSTS750054 - SAMLRequest or SAMLResponse must be present as query string parameters in HTTP request for SAML Redirect binding." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Microsoft Entra ID.

## Symptoms

You receive error `AADSTS750054` when trying to sign into an application that has been setup to use Microsoft Entra ID for identity management using SAML-based SSO.

## Cause

Microsoft Entra ID wasn't able to identify the SAML request within the URL parameters in the HTTP request. This can happen if the application is not using HTTP redirect binding when sending the SAML request to Microsoft Entra ID.

## Resolution

The application needs to send the SAML request encoded into the location header using HTTP redirect binding. For more information about how to implement it, read the section HTTP Redirect Binding in the [SAML protocol specification document](https://docs.oasis-open.org/security/saml/v2.0/saml-bindings-2.0-os.pdf).

Most often, the error is due to one of the following issues:

1. Ensure that single-sign on is enabled on the application side.
2. The application must support service provider-initiated single sign-on (sometimes known as SP-initiated SSO). When entering a sign-in URL for an application that only supports identity provider-initiated single sign-on can lead to a bounce back from the application without a SAML response.
3. Verify that the sign-on URL is correctly configured.

<a name='using-the-test-sso-function-in-the-azure-ad-portal'></a>

### Using the Test SSO Function in the Microsoft Entra admin center

The Microsoft Entra admin center can help you troubleshoot SAML configuration errors.

:::image type="content" source="media/testing-sso-screen.PNG" alt-text="Screenshot of Testing SSO Feature in Microsoft Entra admin center.":::

1. In the Microsoft Entra admin center, go to **Enterprise Applications** and click on the application needing troubleshooting.
2. Navigate to the **Single sign-on** page using the left-hand navigation menu
3. Click on **Test this application** to use the Test SSO functionality.
4. Copy and paste the error received into the **Resolving Errors** section and click **Get resolution guidance**
5. Follow the steps to troubleshoot error `AADSTS750054`

## More Information

For a full list of Active Directory Authentication and authorization error codes see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

---
title: Error AADSTS70001 - Application with Identifier was not found in the directory.
description: Describes a problem in which you receive the error AADSTS70001 when you sign in to SAML sign-on configured app with Azure Active Directory.
ms.date: 10/12/2022
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS70001 - Application with Identifier was not found in the directory

This article describes a problem in which you receive the error message "Error AADSTS70001 - Application with Identifier was not found in the directory." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS70001` when trying to sign into an application that has been set up to use Azure AD for identity management using SAML-based SSO.

## Cause

The `Issuer` attribute sent from the application to Azure AD in the SAML request doesn’t match the Identifier value that's configured for the application in Azure AD.

## Resolution

Ensure that the `Issuer` attribute in the SAML request matches the Identifier value configured in Azure AD.

On the SAML-based SSO configuration page, in the **Basic SAML configuration** section, verify that the value in the Identifier textbox matches the value for the identifier value displayed in the error. If there's a trailing slash at the end of the url, it should be also included.

### Using the Test SSO Function in the Azure AD Portal

The Azure AD Portal can help you troubleshoot SAML configuration errors.

:::image type="content" source="media/testing-sso-screen.PNG" alt-text="Screenshot of Testing SSO Feature in Azure AD Portal.":::

1. In the Azure AD portal, go to **Enterprise Applications** and click on the application needing troubleshooting.
2. Navigate to the **Single sign-on** page using the left-hand navigation menu
3. Click on **Test this application** to use the Test SSO functionality.
4. Copy and paste the error received into the **Resolving Errors** section and click **Get resolution guidance**
5. View the difference between the Issuer and Identifier found.
6. Correct either the Issuer or Identifier.

## More Information

For a full list of Active Directory Authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

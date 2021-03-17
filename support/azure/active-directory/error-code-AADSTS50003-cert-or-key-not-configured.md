---
title: Error AADSTS50003 - No signing key configured
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The error you receive is Error AADSTS50003 - No signing key configured.
ms.date: 03/15/2021
ms.prod-support-area-path: 
ms.reviewer: bernawy
---
# Error AADSTS50003 - No signing key configured

This article describes a problem in which you receive the error message "Error AADSTS50003 - No signing key configured." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS50003` when trying to sign into an application that has been setup to use Azure AD for identity management using SAML-based SSO.

## Cause

The application object is corrupted and Azure AD doesn’t recognize the certificate configured for the application.

## Resolution

To delete and create a new certificate, follow the steps below:

1. On the SAML-based SSO configuration screen, select **Create new certificate** under the **SAML signing Certificate** section.
1. Select Expiration date and then click **Save**.
1. Check **Make new certificate active** to override the active certificate. Then, click **Save** at the top of the pane and accept to activate the rollover certificate.
1. Under the **SAML Signing Certificate** section, click **remove** to remove the **Unused** certificate.

## More Information

For a full list of Active Directory Authentication and authorization error codes see [Azure AD Authentication and authorization error codes](azure/active-directory/develop/reference-aadsts-error-codes)

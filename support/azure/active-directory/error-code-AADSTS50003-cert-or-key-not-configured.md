---
title: Error AADSTS50003 - No signing key configured
description: Describes a problem in which you receive the error AADSTS50003 when signing in to SAML SSO configured app with Microsoft Entra ID. 
ms.date: 10/12/2022
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50003 - No signing key configured

This article describes a problem in which you receive the error message "Error AADSTS50003 - No signing key configured." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Microsoft Entra ID.

## Symptoms

You receive error `AADSTS50003` when trying to sign into an application that has been setup to use Microsoft Entra ID for identity management using SAML-based SSO.

## Cause

The application object is corrupted and Microsoft Entra ID doesn't recognize the certificate configured for the application.

## Resolution

To delete and create a new certificate, follow the steps below:

1. On the SAML-based SSO configuration screen, select **Create new certificate** under the **SAML signing Certificate** section.
1. Select Expiration date and then click **Save**.
1. Check **Make new certificate active** to override the active certificate. Then, click **Save** at the top of the pane and accept to activate the rollover certificate.
1. Under the **SAML Signing Certificate** section, click **remove** to remove the **Unused** certificate.

## More Information

For a full list of Active Directory Authentication and authorization error codes see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

---
title: Microsoft Entra authentication error AADSTS220501
description: Provides a solution to the Microsoft Entra authentication error AADSTS220501.
ms.reviewer: laks, custorod, v-weizhu
ms.service: entra-id
ms.date: 10/16/2024
ms.custom: sap:Issues Signing In to Applications
---
# Error AADSTS220501 - Unable to download Certificate Revocation List

This article provides a solution to the Microsoft Entra authentication error AADSTS220501 that occurs when you use certificate-based authentication.

## Symptoms

When you try to sign in to an application with certificate-based authentication, you receive the error AADSTS220501 with the following message:

> Unable to download Certificate Revocation List (CRL). Invalid response or no response from CRL Distribution Point {source}

## Cause

The Certificate Revocation List (CRL) is inaccessible or has expired.

## Resolution

To resolve this issue, follow these steps:

1. Verify if the CRL file path is accessible publicly by opening the CRL distribution point URL via a web browser.

    Here's an example of a CRL distribution point URL:
    
    `http://Contoso.com/CRLfilepath/CRLfilename.crl`

    To find the CRL distribution point URL for the tenant, see [Configure certification authorities using the Microsoft Entra admin center](/entra/identity/authentication/how-to-certificate-based-authentication#configure-certification-authorities-using-the-microsoft-entra-admin-center).

2. If the CRL file path is inaccessible, move the CRL to a publicly available location.

   If the CRL file path is accessible, open the CRL file, go to the **General** tab, and then check the date and time in the **Next Update** field that denotes the expiry date of the CRL. If this date and time is earlier than the current system date, Windows computers will invalidate certificates that are checked against this CRL. You have to renew the CRL manually and replace the expired CRL.

## More information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to https://login.microsoftonline.com/error.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

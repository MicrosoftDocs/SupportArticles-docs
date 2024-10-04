---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title: Error AADSTS220501-Unable to download Certificate Revocation List (CRL
description: Describe the problem in which user receives the error code AADSTS220501
author: Laks
ms.author:   laks # Microsoft alias
ms.service: identity
ms.topic: troubleshooting-problem-resolution
ms.date:     09/25/2024
titleSuffix: Azure Directory
---
# Error AADSTS220501-Unable to download Certificate Revocation List (CRL)

This article describes a problem in which you receive the error message `Error AAD AADSTS220501 - Unable to download Certificate Revocation List (CRL).` that occurs when a user is trying to authenticate with a certificate-based authentication.

## Symptoms

You receive AADSTS220501 Error when trying to sign into an application with certificate-based authentication (CBA)

## Cause

Certificate revocation list (CRL) either inaccessible or expired.

## Solution

1) Check if the CRL file path is accessible at the client side. Example, access the CRL distribution point http://Contoso.com/CRL's/crlfinename.CRL (replace example path with your CRL URL). </br> Copy the complete CRL path in a web browser and try to access it.

You can find the CRL configuration for the tenant using the steps from article [Quickstart: "How to configure Microsoft Entra certificate-based authentication - Microsoft Entra ID ](/azure/active-directory/authentication/how-to-certificate-based-authentication#configure-certification-authorities-using-the-microsoft-entra-admin-center)
   
2) If the CRL file  is accessible, open the CRL file -> go to General Tab -> Check the Date and time value for "Next Update".

   Next update: **The date and time that a Windows client considers as the expiration date of the CRL.  If this date and time passes to current date , Windows computers will invalidate certificates that are checked against this CRL.**

   You need to renew the CRL manually and replace the expired CRL.

## More Information

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-error-codes).

To investigate individual errors, go to <https://login.microsoftonline.com/error>.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

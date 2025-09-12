---
title: Error AADSTS50017 - Validation of Given Certificate for Certificate-Based Authentication Failed
description: Provides solutions to the Microsoft Entra authentication AADSTS50017 error that occurs when you access an application or resource with certificate-based authentication (CBA).
ms.reviewer: laks, joaos, willfid, v-weizhu
ms.service: entra-id
ms.date: 02/25/2025
ms.custom: sap:Issues Signing In to Applications
---
# Error AADSTS50017 - Validation of given certificate for certificate-based authentication failed

This article provides solutions to the Microsoft Entra authentication AADSTS50017 error that occurs when you access an application or resource with certificate-based authentication (CBA).

## Symptoms

When you try to access an application or resource with CBA, the sign-in process fails and the following error message is displayed:

> AADSTS50017: Validation of given certificate for certificate based authentication failed.

## Cause 1: Certificate chain failures or validation failures

The AADSTS50017 error might occur because of the following problems:

- Certificate chain failures due to missing certificate authority (CA) certificates in store.
- Validation failures with Subject Key Identifier (SKI) and Authority Key Identifier (AKI) values.

     In Public Key Infrastructure (PKI), the certificate chain validation process ensures the integrity and authenticity of the certificate chain. The SKI and AKI play crucial roles in this process. The SKI provides a unique identifier for the public key held by the certificate. The AKI is used to identify the CA that issues the certificate. 

To resolve this issue, follow these steps:

1. Check if issuing certificate is correctly uploaded to the trusted certificate list.

    A certificate chain consists of multiple certificates linked together. The end user's certificate can be issued by a root CA or a non-root CA (intermediate CA). If you have a non-root issuing CA (intermediate CA), both intermediate and root CA certificates must be uploaded to the Microsoft Entra CA trusted store.

2. Check the SKI value of your certificate and confirm if the AKI value matches any intermediate or root CA certificate that's uploaded to the trusted store.

    If there is no match, your certificate or the missing CA certificate should be changed accordingly. To do this, [configure certificate authorities by using the Microsoft Entra admin center](/entra/identity/authentication/how-to-certificate-based-authentication#configure-certificate-authorities-by-using-the-microsoft-entra-admin-center).

    To get the SKI and AKI values, check the details of your certificate and uploaded issuing CA certificates.

     :::image type="content" source="media/error-code-aadsts50017-certificate-based-authentication-failed/certificate-chain-ski-aki-value.png" alt-text="Screenshot that shows a certificate chain." lightbox="media/error-code-aadsts50017-certificate-based-authentication-failed/certificate-chain-ski-aki-value.png":::

    |Certificate type|Characteristic|
    |---|---|
    |Root CA certificate|It has its own SKI. It can issue the intermediate certificates when applicable. It doesn't contain the AKI field.|
    |Issuing or intermediate CA certificate (when applicable)|Its AKI points to the Root CA certificate's SKI. It has its own SKI that matches the AKI on a user certificate. It can issue user certificates, and issue intermediate certificates when applicable. Multiple intermediate CA certificates can exist.|
    |End-Entity (User or Client) certificate|It has its own SKI. Its AKI points to the issuing CA certificate's SKI.|

## Cause 2: Invalid certificates

If any certificates in the certificate chain are missing valid extension identifiers, such as certificate policy extensions, the AADSTS50017 error might occur.

To resolve this error, validate the certificate policy extensions for all certificates within the certificate chain, including user certificates, intermediate CA certificates, and the root CA certificate. Ensure that the certificate policy extension and its Object Identifiers (OIDs) are consistent and valid across the entire chain.

To verify the policy OIDs for consistency and validity, retrieve the relevant certificates in chain and validate them as follows: 

:::image type="content" source="media/error-code-aadsts50017-certificate-based-authentication-failed/certificate-policies.png" alt-text="Screenshot that shows certificate policies." lightbox="media/error-code-aadsts50017-certificate-based-authentication-failed/certificate-policies.png":::

If any certificates are missing certificate policy extensions, reissue the CA certificate or end user certificate with the appropriate certificate policy extensions embedded.  

For more information about policy extension and other supported extensions, see [Supported Extensions](/windows/win32/seccertenroll/supported-extensions).

## AADSTS error code reference

For a full list of authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/entra/identity-platform/reference-error-codes). To investigate individual errors, search at https://login.microsoftonline.com/error.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
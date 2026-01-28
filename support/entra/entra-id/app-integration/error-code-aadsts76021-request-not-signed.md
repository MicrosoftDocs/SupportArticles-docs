---
title: "Error AADSTS76021 (ApplicationRequiresSignedRequests) with SAML authentication: The request sent by client is not signed"
description: Describes a problem in which a user receives the error AADSTS76021 when trying to sign-in
ms.author: jarrettr
author: JarrettRenshaw
ms.topic: troubleshooting
ms.service: entra-id
ms.date:     01/14/2026
ms.custom: sap:Issues Signing In to Applications
---
# Error AADSTS76021 (ApplicationRequiresSignedRequests) with SAML authentication: The request sent by client is not signed

## Summary

The error **AADSTS76021** occurs during federated authentication with Microsoft Entra ID when using SAML-based Single Sign-On (SSO). This error indicates that the request sent by the client isn't signed while the application requires signed requests. Even if the request is signed, the signature might not be placed according to the SAML binding configuration.

According to [SAML specifications](https://docs.oasis-open.org/security/saml/v2.0/saml-bindings-2.0-os.pdf), two primary and most commonly used binding types exist:

- **HTTP-Redirect** [urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect]: For HTTP get method (GET) requests, the signature is included as a query parameter in the URL.
- **HTTP-POST** [urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST]: For HTTP POST requests, the signature is embedded within the XML payload of the SAML message.

If the application expects the signature in one location but the request uses another binding type, Microsoft Entra ID rejects the request, resulting in the **AADSTS76021** error.

## Resolution

1. **Verify SAML binding type**

Check whether the application expects HTTP-Redirect or HTTP-POST.

2. **Ensure configuration matches**

Confirm that the Identity Provider (IdP) and Service Provider (SP) configurations align.

3. **Validate signature placement**
   
- For HTTP-Redirect: Signature must be in the query string.
- For HTTP-POST: Signature must be inside the XML `<Signature>` element.

4. **Update application or IdP configuration**
   
- Align binding type and signature placement.
- In Microsoft Entra ID, confirm SAML settings under **Enterprise Applications > Single Sign-On**.

## Examples

### Example 1: HTTP-Redirect binding (GET)

The signed request includes query parameters like the following example:

```
https://contoso.com?
SAMLRequest=<Base64EncodedRequest>&RelayState=<StateValue>&SigAlg=http://www.w3.org/2000/09/xmldsig#rsa-sha256&Signature=<Base64Signature>
```

### Example 2: HTTP-POST binding (POST)

The signed request includes a signature inside XML like the following example:

```xml
<samlp:AuthnRequest>
    <ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
        <ds:SignedInfo>
            <!-- Canonicalization and signature details -->
        </ds:SignedInfo>
        <ds:SignatureValue>Base64SignatureValue</ds:SignatureValue>
        <ds:KeyInfo>
            <ds:X509Data>
                <ds:X509Certificate>...</ds:X509Certificate>
            </ds:X509Data>
        </ds:KeyInfo>
    </ds:Signature>
</samlp:AuthnRequest>
```

### SAML 2.0 bindings

SAML 2.0 defines several protocol bindings that map SAML request and response message exchanges onto standard communication protocols. These bindings specify rules for message encoding, signature placement, and transport security.

#### HTTP-Redirect binding 

- **Description**: Uses HTTP GET requests where SAML messages are transmitted as query parameters.
- **Use case**: Common for initiating authentication requests.

#### HTTP-POST binding

- **Description**: Uses HTTP POST requests where SAML messages are embedded in the body as XML.
- **Use case**: Common for sending signed assertions securely.

#### HTTP-Artifact binding

- **Description**: Exchanges small artifacts through HTTP which are later resolved into full SAML messages.
- **Use case**: Reduces message size in front-channel communication.

#### Simple Object Access Protocol (SOAP) binding

- **Description**: Uses SOAP over HTTP for back-channel communication.
- **Use Ccase**: Common for artifact resolution and management operations.

#### Reverse SOAP (PAOS) binding

- **Description**: Reverse HTTP binding used for Enhanced Client or Proxy (ECP) profiles.
- **Use case**: Enables advanced client interactions. 

[SAML Bindings Specification](https://docs.oasis-open.org/security/saml/v2.0/saml-bindings-2.0-os.pdf)

## Resources
  
For a full list of Active Directory Authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).
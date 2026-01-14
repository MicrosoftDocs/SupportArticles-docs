---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title: 'Error AADSTS76021 (ApplicationRequiresSignedRequests) with SAML authentication: The request sent by client is not signed'
description: Describes a problem in which a user receives the error AADSTS76021 when trying to sign-in
author:      custorod # GitHub alias
ms.author: custorod
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution
ms.date:     01/14/2026
ms.subservice: authentication
---
# Error AADSTS76021 (ApplicationRequiresSignedRequests) with SAML authentication: The request sent by client is not signed

## Overview
The error **AADSTS76021** occurs during federated authentication with Microsoft Entra ID when using SAML-based Single Sign-On (SSO). This error indicates that the request sent by the client is not signed while the application requires signed requests. Even if the request is signed, the signature might not be placed according to the SAML binding configuration.

According to [SAML specifications](https://docs.oasis-open.org/security/saml/v2.0/saml-bindings-2.0-os.pdf), two primary and most commonly used binding types exist:

- **HTTP-Redirect** [urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect]: For HTTP GET requests, the signature is included as a query parameter in the URL.
- **HTTP-POST** [urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST]: For HTTP POST requests, the signature is embedded within the XML payload of the SAML message.

If the application expects the signature in one location but the request uses another binding type, Microsoft Entra ID will reject the request, resulting in **AADSTS76021**.

---

## Resolution Steps
1. **Verify SAML Binding Type**
   - Check whether the application expects HTTP-Redirect or HTTP-POST.

2. **Ensure Configuration Matches**
   - Confirm that the Identity Provider (IdP) and Service Provider (SP) configurations align.

3. **Validate Signature Placement**
   - For HTTP-Redirect: Signature must be in the query string.
   - For HTTP-POST: Signature must be inside the XML `<Signature>` element.

4. **Update Application or IdP Configuration**
   - Align binding type and signature placement.
   - In Microsoft Entra ID, confirm SAML settings under **Enterprise Applications > Single Sign-On**.

---

## Examples

### Example 1: HTTP-Redirect Binding (GET)
Signed request includes query parameters:
```
https://contoso.com?
SAMLRequest=<Base64EncodedRequest>&RelayState=<StateValue>&SigAlg=http://www.w3.org/2000/09/xmldsig#rsa-sha256&Signature=<Base64Signature>
```

### Example 2: HTTP-POST Binding (POST)
Signed request includes signature inside XML:
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

---

## More Information 

### SAML 2.0 Bindings
SAML 2.0 defines several protocol bindings that map SAML request and response message exchanges onto standard communication protocols. These bindings specify rules for message encoding, signature placement, and transport security.

### 1. HTTP-Redirect Binding
- **Description**: Uses HTTP GET requests where SAML messages are transmitted as query parameters.
- **Use Case**: Common for initiating authentication requests.

### 2. HTTP-POST Binding
- **Description**: Uses HTTP POST requests where SAML messages are embedded in the body as XML.
- **Use Case**: Common for sending signed assertions securely.

### 3. HTTP-Artifact Binding
- **Description**: Exchanges small artifacts via HTTP, which are later resolved into full SAML messages.
- **Use Case**: Reduces message size in front-channel communication.

### 4. SOAP Binding
- **Description**: Uses SOAP over HTTP for back-channel communication.
- **Use Case**: Common for artifact resolution and management operations.

### 5. PAOS Binding
- **Description**: Reverse HTTP binding used for Enhanced Client or Proxy (ECP) profiles.
- **Use Case**: Enables advanced client interactions. 

[SAML Bindings Specification](https://docs.oasis-open.org/security/saml/v2.0/saml-bindings-2.0-os.pdf)

--- 
  
For a full list of Active Directory Authentication and authorization error codes, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

---

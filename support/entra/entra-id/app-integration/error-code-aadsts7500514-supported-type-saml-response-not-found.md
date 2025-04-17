---
title: AADSTS7500514 - A supported type of SAML response was not found with PingFederate 
description: Describes an error code `AADSTS7500514` that's returned if a federated account tries to authenticate with Microsoft Entra ID.
ms.date: 04/17/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Issues Signing In to Applications, has-azure-ad-ps-ref
keywords: AADSTS50020
---

# AADSTS7500514 - A supported type of SAML response was not found with PingFederate

This article helps you troubleshoot error code `AADSTS7500514` that's returned if a PingFederate federated account tries to authenticate with Microsoft Entra ID (formerly Azure Active Directory).

## Symptoms

When a federated account tries to authenticate with Microsoft Entra ID from a Microsoft Authentication Library (MSAL) or Active Directory Authentication Library (ADAL) based application, the sign-in fails. The following error message is displayed:

```output
{
     error: "invalid_request",
     error_description: "AADSTS7500514: A supported type of SAML response was not found. The supported response types are 'Response' (in XML namespace 'urn:oasis:names:tc:SAML:2.0:protocol') or 'Assertion' (in XML namespace 'urn:oasis:names:tc:SAML:2.0:assertion').
     ....
     error_uri: "https://login.microsoftonline.com/error?code=7500514"
}
```

The error typically occurs in the following environment:

- A federated account that uses [PingFederate](https://www.pingidentity.com/) as the identity provider.  
- The identity provider is configured to issue a SAML 1.1 token by using the WS-Trust protocol.
- The application uses one of the following APIs for authentication:
    - MSAL `AcquireTokenByUserNamePassword` method.  
    - ADAL `AcquireToken`(string resource, string clientId, UserCredential userCredential) method.  
    - Any PowerShell module that uses the MSAL or ADAL methods listed earlier.

## Cause

Since [ADAL has been deprecated](/entra/identity/monitoring-health/recommendation-migrate-from-adal-to-msal), this article focuses on the MSAL.

This issue occurs if the SAML response from PingFederate does not contain the SAML version or uses a format that MSAL cannot recognize. This typically results from a misconfiguration on the PingFederate side for Microsoft Entra ID.

### Root cause analysis: SAML token version detection

When authenticating a federated account, MSAL determines whether the account is a managed account or a federated account.

For managed accounts, MSAL uses the [Resource Owner Password Credentials grant flow](/entra/identity-platform/v2-oauth-ropc). For federated accounts, it uses the [SAML Assertion Grant flow](/azure/active-directory/develop/v2-saml-bearer-assertion) for authentication.

There are two steps involved in the SAML Assertion Grant flow:

1. The client application authenticates to the federated identity provider to obtain a SAML token.  
2. The client then uses the obtained SAML token to get an OAuth 2.0 JWT token from Microsoft Entra ID.

The issue typically occurs in step 1, where the client application needs to parse the SAML response from the identity provider to determine the SAML version. MSAL looks for the following attribute values in the identity provider's SAML response to determine the version of the SAML token:

- `<saml:Assertion>` node  
- `<TokenType>` node

The following is an example AD FS  SAML response from the `/UserNameMixed` endpoint:

- **SAML Assertion**: major version = 1, minor version = 1  
- **TokenType**: `urn:oasis:names:tc:SAML:1.0:assertion`

:::image type="content" source="media/error-code-aadsts7500514-supported-type-saml-response-not-found/adfs-saml-response.png" alt-text="Screenshot of ADFS SAML Response." lightbox="media/error-code-aadsts7500514-supported-type-saml-response-not-found/adfs-saml-response.png":::

Example of PingFederate SAML response (SAML Assertion Grant flow step 1):

:::image type="content" source="media/error-code-aadsts7500514-supported-type-saml-response-not-found/pingid-saml-response.png" alt-text="A screenshot of PingFederate SAML Response for SAML Assertion Grant flow step 1" lightbox="media/error-code-aadsts7500514-supported-type-saml-response-not-found/pingid-saml-response.png":::

After you compare these two responses, you will find PingFederate returns a different TokenType value: `http://docs.oasis-open.org/wss/oasis-wss-saml-token-profile-1.1#SAMLV1.1` for the same SAML 1.1 token. However, MSAL does not support any TokenType value other than `urn:oasis:names:tc:SAML:1.0:assertion`.

When the identity provider returns a different or unexpected value in the SAML response, MSAL may incorrectly interpret the token as SAML 2.0. As a result, it uses the corresponding `grant_type` value during step 2 of the SAML Assertion Grant flow.

Example of the request sent from MSAL application with PingFederate (SAML Assertion Grant flow step 2):

:::image type="content" source="media/error-code-aadsts7500514-supported-type-saml-response-not-found/pingid-saml-response-2.png" alt-text="A screenshot of request sent from MSAL application with PingFederate in SAML Assertion Grant flow step 2." lightbox="media/error-code-aadsts7500514-supported-type-saml-response-not-found/pingid-saml-response-2.png":::

Example of the request sent from MSAL application with AD FS :

:::image type="content" source="media/error-code-aadsts7500514-supported-type-saml-response-not-found/pingid-saml-response-3.png" alt-text="A screenshot of request sent from MSAL application with AD FS in SAML Assertion Grant flow step 2." lightbox="media/error-code-aadsts7500514-supported-type-saml-response-not-found/pingid-saml-response-3.png":::

In this step, the value of the `grant_type` parameter must align with the actual version of the SAML token. The following values are used:

- urn:ietf:params:oauth:grant-type:saml2-bearer - for SAML 2.0 tokens
- urn:ietf:params:oauth:grant-type:saml1_1-bearer - for SAML 1.1 tokens

In the case of a PingFederate account, MSAL uses the `saml2-bearer` as the `grant_type` based on its misinterpretation of the SAML version. This results in a version mismatch between the `grant_type` parameter and the SAML token included in the assertion that causes the authentication error.

## Solution

To resolve this issue, ensure that PingFederate is configured to align with Microsoft Entra ID requirements. For step-by-step instructions, review the following articles.

- [Creating a connection to Microsoft Entra ID](https://docs.pingidentity.com/integrations/azure/azure_ad_and_office_365_integration_guide/pf_azuread_office365_integration_creating_a_connection_to_azure_active_directory.html).

    During Microsoft Entra ID connection setup, pay special attention to the following settings:

    1. Configure the connection protocols.
    2. On the **Connection Template** tab, select **Do not use a template for this connection**. Click **Next**.
    3. On the **Connection Type** tab select **Browser SSO Profiles**.
    4. In the Protocol list, select WS-Federation.
    5. In the **WS-Federation Token Type list**, select **SAML 1.1**.
    6. If you want to support active federation, select the **WS-Trust STS** check box.

- [Configuring WS-Trust STS](https://docs.pingidentity.com/integrations/azure/azure_ad_and_office_365_integration_guide/pf_azuread_office365_integration_configuring_ws_trust_sts.html)

    When you configure WS-Trust STS, make sure that you select **SAML 1.1 for Office 365** as the Default Token Type.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

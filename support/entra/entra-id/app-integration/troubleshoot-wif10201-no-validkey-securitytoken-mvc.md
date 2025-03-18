---
title: ASP.NET MVC Application Error WIF10201 No Valid Key Mapping Found for SecurityToken
description: This article provides guidance for troubleshooting the error, WIF10201- No valid key mapping found for securityToken.
author: genlin
ms.author: bachoang
ms.service: entra-id
ms.topic: troubleshooting-problem-resolution 
ms.date: 02/05/2025
ms.custom: sap:Issues Signing In to Applications
---

# WIF10201: No valid key mapping found for securityToken error in ASP.NET application

This article provides guidance for troubleshooting an authentication issue that occurs in an ASP.NET MVC application that uses both [WS-Federation](https://github.com/Azure-Samples/active-directory-dotnet-webapp-wsfederation) OWIN middleware and [Windows Identity Foundation](../../../windows-server/user-profiles-and-logon/windows-identity-foundation.md) (WIF) to authenticate to Microsoft Entra ID.

## Symptoms

The ASP.NET MVC application that was previously working generates the following error message although no changes were made to the application:

```output
Error Details:
Server Error in '/' Application.
WIF10201: No valid key mapping found for securityToken: 'System.IdentityModel.Tokens.X509SecurityToken' and issuer: 'https://sts.windows.net/<Directory ID>/'.

Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.

Exception Details: System.IdentityModel.Tokens.SecurityTokenValidationException: WIF10201: No valid key mapping found for securityToken: 'System.IdentityModel.Tokens.X509SecurityToken' and issuer: 'https://sts.windows.net/<Directory ID>/'.
```

## Cause

To validate the signature of the token that's returned by the Entra ID after a successful sign-in, WIF uses the certificate thumbprints that are in the **Web.config** file, as shown in the following example:

```web.config
<issuerNameRegistry type="System.IdentityModel.Tokens.ValidatingIssuerNameRegistry, 
System.IdentityModel.Tokens.ValidatingIssuerNameRegistry">
<authority name="https://sts.windows.net/<Directory ID>/">
    <keys>
    <add thumbprint="C142E..." />
    <add thumbprint="8BA94..." />
    <add thumbprint="D92E1..." />
    </keys>
    <validIssuers>
    <add name="https://sts.windows.net/<Directory ID>/" />
    </validIssuers>
</authority>
</issuerNameRegistry>
```

The "WIF10201" error occurs if none of these certificate thumbprints match the one that's used by Entra ID to sign the token.

The Entra ID uses a [signing key rollover mechanism](/entra/identity-platform/signing-key-rollover) to update the certificate that's used to sign authentication tokens periodically. This key rollover causes the initial certificate thumbprints that are configured in the **Web.config** file to become invalid.

## Solution

You can either manually update the certificate thumbprints that are in the **Web.config** file or automate the process through code. For more information, see [Best practices for keys metadata caching and validation](/entra/identity-platform/signing-key-rollover#best-practices-for-keys-metadata-caching-and-validation).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)] 


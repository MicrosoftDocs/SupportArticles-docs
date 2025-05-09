---
title: Microsoft Entra Applications Using TLS 1.0/1.1 Fail to Authenticate
description: Provides solutions to authentication errors that occur with Microsoft Entra applications using TLS version 1.0 or 1.1.
ms.reviewer: bachoang, v-weizhu
ms.service: entra-id
ms.date: 05/09/2025
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---
# Microsoft Entra applications using TLS 1.0/1.1 fail to authenticate

This article provides solutions to authentication errors that occur with Microsoft Entra-integrated applications targeting versions earlier than Microsoft .NET Framework 4.7.

## Symptoms

Applications using an older version of the .NET Framework might encounter authentication failures with one of the following error messages:

- > AADSTS1002016: You are using TLS version 1.0, 1.1 and/or 3DES cipher which are deprecated to improve the security posture of Azure AD

- > IDX20804: Unable to retrieve document from: '[PII is hidden]'

- > IDX20803: Unable to obtain configuration from: '[PII is hidden]'

- > IDX10803: Unable to create to obtain configuration from: 'https://login.microsoftonline.com/{Tenant-ID}/.well-known/openid-configuration'

- > IDX20807: Unable to retrieve document from: 'System.String'

- > System.Net.Http.Headers.HttpResponseHeaders RequestMessage {Method: POST, RequestUri: '\<request-uri>', Version: 1.1, Content: System.Net.Http.FormUrlEncodedContent, Headers: { Content-Type: application/x-www-form-urlencoded Content-Length: 970 }} System.Net.Http.HttpRequestMessage StatusCode UpgradeRequired This service requires use of the TLS-1.2 protocol

## Cause

Starting January 31, 2022, Microsoft enforced the use of the TLS 1.2 protocol for client applications connecting to Microsoft Entra services on the Microsoft Identity Platform to ensure compliance with security and industry standards. For more information about this change, see [Enable support for TLS 1.2 in your environment for Microsoft Entra TLS 1.1 and 1.0 deprecation](../ad-dmn-services/enable-support-tls-environment.md) and [Act fast to secure your infrastructure by moving to TLS 1.2!](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/act-fast-to-secure-your-infrastructure-by-moving-to-tls-1-2/2967457)

Applications running on older platforms or using older .NET Framework versions might not have TLS 1.2 enabled. Therefore, they can't retrieve the OpenID Connect metadata document, resulting in failed authentication.

## Solution 1: Upgrade the .NET Framework

Upgrade the application to use .NET Framework 4.7 or later, where TLS 1.2 is enabled by default.

## Solution 2: Enable TLS 1.2 programmatically

If upgrading the .NET Framework isn't feasible, you can enable TLS 1.2 by adding the following code to the **Global.asax.cs** file in your application:

```csharp
using System.Net;

protected void Application_Start()
{
ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Ssl3; // only allow TLS 1.2 and SSL 3
// The rest of your startup code goes here
}
```

## Solution 3: Change web.config to enable TLS 1.2

If .NET Framework 4.7.2 is available, you can enable TLS 1.2 by adding the following configuration to the **web.config** file:

```json
<system.web>
    <httpRuntime targetFramework="4.7.2" />
</system.web>
```

> [!NOTE]
> If using .NET Framework 4.7.2 causes breaking changes to your app, this solution might not work.

## Solution 4: Enable TLS 1.2 before running PowerShell commands

If you encounter the AADSTS1002016 error while running the PowerShell command `Connect-MSolService`, `Connect-AzureAD`, or `Connect-MSGraph` (from the Microsoft Intune PowerShell SDK module), set the security protocol to TLS 1.2 before executing the commands:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

## References

[Transport Layer Security (TLS) best practices with .NET Framework](/dotnet/framework/network-programming/tls)

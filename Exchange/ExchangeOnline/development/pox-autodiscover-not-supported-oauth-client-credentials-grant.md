---
title: POX Autodiscover not supported with OAuth client credentials grant
description: Resolves error 500 when you try to use the Plain Old XML (POX) Autodiscover service together with the OAuth 2.0 client credentials grant.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CI
  - CSSTroubleshoot
ms.reviewer: mhaque, meerak, desingh, danab, v-kwaddo, danba, dechiang, v-lianna
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# POX Autodiscover not supported with OAuth client credentials grant

## Symptoms

When you use the Plain Old XML (POX) Autodiscover service together with the [OAuth 2.0 client credentials grant](/azure/active-directory/develop/v2-oauth2-client-creds-grant-flow), you receive an "email address can't be found" error message that indicates error code 500 and resembles the following example:

```xml
POST : https://outlook.office365.com/autodiscover/autodiscover.xml
Request Body :
<?xml version="1.0" encoding="utf-8"?>
<Autodiscover xmlns="http://schemas.microsoft.com/exchange/autodiscover/outlook/requestschema/2006">
<Request>
<EMailAddress>recipient@domain</EMailAddress>
<AcceptableResponseSchema>http://schemas.microsoft.com/exchange/autodiscover/outlook/responseschema/2006a</AcceptableResponseSchema>
</Request>
</Autodiscover>
```

**Note**: "recipient@domain" is a user-provided parameter.

```xml
Response : The email address can't be found
<?xml version="1.0" encoding="utf-8"?>
<Autodiscover xmlns="http://schemas.microsoft.com/exchange/autodiscover/responseschema/2006">
<Response>
<Error Time="22:32:50.1642866" Id="2945626231">
<ErrorCode>500</ErrorCode>
<Message>The email address can't be found.</Message>
<DebugData />
</Error>
</Response>
</Autodiscover>
```

## Cause

This issue occurs because the POX Autodiscover service is not supported for use together with the client credentials grant in this scenario.

Autodiscover depends on user identity for routing. When you use the POX Autodiscover service together with the client credentials grant, the received [app-only token](/azure/active-directory/develop/access-tokens#:~:text=These%20app-only%20tokens%20indicate%20that%20this%20call%20is,been%20granted%20to%20the%20subject%20of%20the%20token) indicates that the call comes from an application and does not have a user backing it. In this case, the POX Autodiscover payload cannot specify the users to impersonate.

## Resolution

To resolve this issue, use the [SOAP Autodiscover service](/exchange/client-developer/web-service-reference/soap-autodiscover-web-service-reference-for-exchange) instead.

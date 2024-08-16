---
title: Skype for Business and Exchange integration fails
description: Provide a solution when Skype for Business and Exchange integration fails.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business server 2015
  - Exchange Server 2013
  - Exchange Server 2016
ms.date: 03/31/2022
---

# Skype for Business and Exchange integration fails if wildcards used in AcceptedDomains entries

## Symptoms

Consider the following scenario:

- You have a Microsoft Lync 2013 or Skype for Business server, and you configure integration with Microsoft Exchange 2013 or 2016.
- At least some of the users have `contoso.com` as primary SMTP.
- On the Exchange server, you change the AcceptedDomains settings so that instead of contoso.com you have \*.contoso.com, as described in [Procedures for accepted domains in Exchange 2016](/Exchange/mail-flow/accepted-domains/accepted-domain-procedures).

After this change, Skype for Business and Exchange integration starts failing. The following error message is reported in the Lync server log:

```adoc
Log Name:      Lync Server
Source:        LS Storage Service
Date:          dd/mm/yyyy hh:mm:ss 
Event ID:      32054
Task Category: (4006)
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      FE01.contoso.com
Description:
Storage Service had an EWS Autodiscovery failure.
UnsupportedStoreException: code=ErrorIncorrectExchangeServerVersion, reason=GetUserSettings failed, smtpAddress=bob@contoso.com, Autodiscover Uri=https://autodiscover.contoso.com/autodiscover/autodiscover.svc, Autodiscover WebProxy=<NULL> ---> Microsoft.Exchange.WebServices.Data.ServiceRequestException: The request failed. The remote server returned an error: (401) Unauthorized. ---> System.Net.WebException: The remote server returned an error: (401) Unauthorized.
```

Also, the following details are reported if you run the command Test-CsExStorageConnectivity -SipUri "sip:bob@contoso.com" -Verbose:

```adoc
HTTP/1.1 401 Unauthorizedrequest-id: 33086db3-69f9-4cdf-8ffe-ee364539e113
request-id: 33086db3-69f9-4cdf-8ffe-ee364539e113x-ms-diagnostics: 2000004;reason="The tenant for tenant guid 'contoso.com' does not exist.";error_category="invalid_tenant"Server: Microsoft-IIS/8.5WWW-Authenticate: Bearer client_id="00000002-0000-0ff1-ce00-000000000000", trusted_issuers="00000004-0000-0ff1-ce00-000000000000@contoso.com", token_types="app_asserted_user_v1service_asserted_app_v1", error="invalid_token",Negotiate,NTLM,Basic realm="autodiscover.contoso.com"
```

## Cause

Wildcard domains aren't supported for server-to-server communication under AcceptedDomains.

## Resolution

The only solution is to explicitly define all accepted domains on the Exchange server and not use any wildcards.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

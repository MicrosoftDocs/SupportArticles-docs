---
title: Suppress AutoDiscover mismatch warning in Outlook
description: Provides information about how to suppress the AutoDiscover mismatch warning in Outlook 2007 and later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Autodiscover
  - Outlook for Windows
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: aruiz, grtaylor
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
ms.date: 03/31/2025
---
# Suppress AutoDiscover mismatch warning in Outlook

_Original KB number:_ &nbsp; 2783881

## Symptoms

When Microsoft Outlook performs an AutoDiscover operation and tries to connect to a service endpoint where the expected name isn't present on the server's Secure Sockets Layer (SSL) certificate, you might receive a warning that resembles the following message:

> The name on the security certificate is invalid or does not match the name of the site.  
> Do you want to proceed?

When this warning message occurs, you can select **Yes** to proceed. However, it might reappear the next time the AutoDiscover service runs.

## Cause

You receive the warning when all of the following conditions are true:

- DNS and IIS are installed on the same server, for example `DC1.contoso.com`.
- A Name Server (NS) record is created for the server.
- IIS  is configured to use Secure Sockets Layer (SSL).

Outlook uses the domain name part of the user's SMTP address to query DNS. In this example, the domain name is `contoso.com`. Outlook resolves `contoso.com` to an NS record for the DNS server. On the DNS server, IIS is configured to use an SSL certificate. The subject of the SSL certificate is `DC1.contoso.com`. However, Outlook tries to connect to `https://contoso.com/autodiscover/autodiscover.xml`. When it detects the certificate name mismatch, it displays the warning.

## Workarounds

You can use one of the following workarounds that best suit your environment.

## Workaround 1

Reissue a certificate that includes the domain name (`contoso.com`) as the Subject Alternative Name. This solution may be appropriate if you can't implement client-side registry keys, or only have a limited number of domains.

## Workaround 2

Install IIS and DNS on separate servers.

## Workaround 3

Don't install or bind the SSL certificate on the DNS server that's running IIS. If the IIS site doesn't require SSL, you can remove the certificate. Or, you can unbind TCP 443 (SSL port) from the default website.

## Workaround 4

Configure Outlook to ignore the domain name mismatch and [connect to a specific HTTP endpoint](how-to-suppress-autodiscover-redirect-warning.md#configure-outlook-to-allow-connection-to-a-specific-endpoint).

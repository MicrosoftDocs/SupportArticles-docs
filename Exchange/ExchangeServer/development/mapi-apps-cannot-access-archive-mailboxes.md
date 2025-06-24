---
title: MAPI applications can't access archive mailboxes in Exchange Server 2016 and later versions
description: Provides a resolution for an issue in which MAPI applications can't access archive mailboxes in Exchange Server 2016 and later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Issue with autodiscover
  - Exchange Server
  - CSSTroubleshoot
  - CI 177580
ms.reviewer: liantan, lusassl, sfellman, nasira, sgriffin, terrya, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# MAPI applications can't access archive mailboxes in Exchange Server 2016 and later versions

## Symptoms

You have an in-house app that uses [MAPI](/office/client-developer/outlook/mapi/mapi-programming-overview) to access archive mailboxes in Microsoft Exchange Server 2013. However, you can't use the same MAPI application to access archive mailboxes in Exchange Server 2016 and later versions.

## Cause

There was a product design change between Exchange Server 2013 and Exchange Server 2016. Your MAPI application accesses archive mailboxes in Exchange Server 2013 by using the X500 (LegacyExchangeDn) address of each mailbox. However, archive mailboxes in Exchange Server 2016 and later versions can be accessed only by their SMTP address. To get the SMTP address of an archive mailbox in Exchange Server 2016 and later versions, your application must use [Autodiscover](/exchange/client-developer/exchange-web-services/autodiscover-for-exchange). The Autodiscover response contains the SMTP address of the archive mailbox.

Because MAPI doesn't support Autodiscover, applications that use only MAPI can't access archive mailboxes in Exchange Server 2016 and later versions.

## Resolution

[Configure](/exchange/client-developer/exchange-web-services/autodiscover-for-exchange#options-for-using-autodiscover) your in-house app to support Autodiscover by using one of the following non-MAPI interfaces:

- [SOAP Autodiscover web service](/exchange/client-developer/web-service-reference/soap-autodiscover-web-service-reference-for-exchange)

- [POX Autodiscover web service](/exchange/client-developer/web-service-reference/pox-autodiscover-web-service-reference-for-exchange)

- [EWS Managed API](/exchange/client-developer/exchange-web-services/get-started-with-ews-managed-api-client-applications)

Select the one that best suits your requirements. For the richest feature set, we recommend the SOAP web service.

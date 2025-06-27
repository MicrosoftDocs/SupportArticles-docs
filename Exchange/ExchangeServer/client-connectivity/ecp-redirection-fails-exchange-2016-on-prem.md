---
title: ECP redirection fails in Exchange 2016 On-prem
description: Describes an issue that you get error (The length of the query string for this request exceeds the configured maxQueryStringLength value) when accessing ECP from a remote site in Exchange Server 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: helmutk, v-six
appliesto: 
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---
# Active Directory site redirection fails when accessing ECP from a remote site in Exchange Server 2016

_Original KB number:_ &nbsp;4056664

## Symptoms

Consider the following scenarios:

- You have more than one Active Directory site.
- You configure the redirection for Exchange Control Panel (ECP) for those sites by adding the `ExternalURL` property for the /ECP virtual directories.

In this scenario, redirection fails when you try to access ECP from a remote site, and you receive the following error message:

> Error 400: The length of the query string for this request exceeds the configured maxQueryStringLength value.

## Cause

The virtual directory in the 302 response that's created by the Microsoft Exchange server on the local Active Directory site contains incorrect data. This causes the browser to enter a loop that eventually ends with the local Exchange Server issuing the Error 400 message.

## Workaround

To work around this issue, remove the `ExternalURL` property from the ECP. Then, when a user accesses the ECP from the remote site, the user will be proxied to the ECP in the targeted Active Directory site. For more information, see [Understanding Proxying and Redirection](/previous-versions/office/exchange-server-2010/bb310763(v=exchg.141)).

## Status

Microsoft is working to resolve this problem and will post more information in this article when the information becomes available.

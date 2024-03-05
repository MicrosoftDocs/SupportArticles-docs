---
title: Printers list blank in PMC
description: Provides a solution to an issue that the list of printers will be blank when you view the printers on a remote server through the Print Mangagement Console (PMC).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, raackley
ms.custom: sap:errors-and-troubleshooting:-print-spooler, csstroubleshoot
---
# Printers list blank in Print Management Console

This article provides a solution to an issue that the list of printers will be blank when you view the printers on a remote server through the Print Management Console (PMC).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2253813

## Symptoms

When viewing the printers on a remote server through the Print Management Console (PMC) the list of printers will be blank, but the list of drivers and/or ports may display correctly.

Pinging the client **FQDN** (for example, `client.subdomain.domain.com`) from the print server results in a name resolution error.

## Cause

Client system (the system running PMC) does not have a DNS **A Record** (forward lookup) or the record is incorrect.

## Resolution

Add a DNS **A Record** for the system running PMC or correct the existing record.

## More information

You may see the following `request / response` in a network trace. The reason this may or may not be in the network trace is because if the name resolution was previously attempted, the response will be cached on the server. To clear the cache, use `ipconfig /flushdns` and then capture the trace.

> **RpcRemoteFindFirstPrinterChangeNotificationEx** Request, Local Machine = `\\servername.company.com`, Printer Local = nnnnnn  
 **RpcRemoteFindFirstPrinterChangeNotificationEx** Response, Status = **RPC_S_SERVER_UNAVAILABLE**  

In a network trace from the print server, you may see a DNS query initiated then a response received:

> DNS:QueryId = 0xB19B, QUERY (Standard query), Query for `servername.company.com` of type Host Addr on class Internet  
  DNS:QueryId = 0xB19B, QUERY (Standard query), Response - Name Error

> [!NOTE]
> Short name resolution for the client name may work, either through the DNS suffix search lists (if the DNS record is in the wrong domain) or WINS. Try to look up the fully qualified domain name of the client on the print server. Internally, spooler uses the FQDN to call back to the client, so if the FQDN does not resolve, the callback will fail.

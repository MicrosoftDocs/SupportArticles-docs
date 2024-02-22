---
title: Outlook can't connect via firewall or proxy server
description: Explains that Outlook can't connect through a firewall or a proxy server performing NAT between public and private networks since the IP packets lose the RPC connectivity information.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Outlook
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Outlook can't connect through a firewall or a proxy server that is performing Network Address Translation (NAT) between public and private networks

_Original KB number:_ &nbsp; 291615

## Symptoms

Outlook clients can't connect through a firewall or proxy server that is performing NAT between public and private networks.

## Cause

When the IP packets that contain the remote procedure call (RPC) information are edited during translation, the IP packets lose the RPC connectivity information. This causes the client not to connect to the server. Additionally, Outlook can have problems resolving the name of the Microsoft Exchange Server computer behind the firewall or proxy server.

## Workaround

A work-around for firewalls or proxy servers that aren't based on Microsoft Windows NT is to perform a one-to-one translation between the two networks. This is also called *opening a pipe or tunnel* between the public and private networks. This takes all requests for a specific address on the public network and passes them directly to the private network. For additional information on about how to configure a one-to-one translation, please refer to your manufacturer's documentation.

A one-to-one translation or pipe does not work for Windows NT-based firewalls and proxy servers because the Outlook client attempts to bind to the end-point mapper port (EPM), port 135, on the firewall. This server does not return the correct Exchange Server connectivity information to the Outlook client.

Another possible work-around is to use Outlook Web App. This only requires allowing HTTP traffic through the firewall or proxy server.

## More information

For more information, please see the following Requests for Comments (RFCs):

- RFC 1631 - The IP Network Address Translator (NAT)
- RFC 1918 - Address Allocation for Private Internet

These RFCs can be found [here](https://www.rfc-editor.org).

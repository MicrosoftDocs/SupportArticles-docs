---
title: Use nslookup to get DNS records for SMTP domain
description: This article shows how to obtain Internet mail exchanger records for the Simple Mail Transfer Protocol (SMTP) domain by using nslookup.exe.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Obtain internet mail exchanger records with the nslookup.exe utility

_Original KB number:_ &nbsp; 203204

## Summary

When you troubleshoot SMTP problems, you may want to obtain the Domain Name System (DNS) records for the SMTP domain in question. You can use the nslookup.exe utility to collect this information.

## Requirements

DNS must be configured properly on the computer running the nslookup.exe utility. If DNS isn't configured, an error message is displayed when the nslookup.exe utility starts.

## Steps to use nslookup.exe

1. Open a command prompt.
2. Type `nslookup`.
3. Type `set q=mx`.

    This sets a filter to only collect MX records and related information.

4. Type *<domain_name>.com*.

    where <domain_name> is the domain that you want to obtain the DNS records for, for example, `microsoft.com` or `msn.com`. An output like the following is displayed:

    ```console
    Server: [157.178.72.30]
    Address: 157.178.72.30

    microsoft.com MX preference = 10, mail exchanger = mail1.microsoft.com
    microsoft.com MX preference = 10, mail exchanger = mail2.microsoft.com
    microsoft.com MX preference = 10, mail exchanger = mail3.microsoft.com
    microsoft.com MX preference = 10, mail exchanger = mail4.microsoft.com
    microsoft.com MX preference = 10, mail exchanger = mail5.microsoft.com
    mail1.microsoft.com internet address = 131.107.3.125
    mail2.microsoft.com internet address = 131.107.3.124
    mail3.microsoft.com internet address = 131.107.3.123
    mail4.microsoft.com internet address = 131.107.3.122
    mail5.microsoft.com internet address = 131.107.3.121
    ```

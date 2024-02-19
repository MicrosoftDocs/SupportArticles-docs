---
title: Use WHOIS to research Internet domains
description: Describes how to use WHOIS to research Internet domains.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Use WHOIS to research Internet domains

This article describes how to use WHOIS to research Internet domains.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 151710

## Summary

WHOIS is a service provided by the InterNIC that provides information on second-level domains including contact e-mail addresses, postal addresses, and telephone numbers of those who have registered with the InterNIC. WHOIS can also help determine whether a domain name is already in use that can be helpful for new site administrators.

WHOIS can be accessed through WHOIS clients, interactive telnet sessions, e-mail, and the World Wide Web. The InterNIC database provides information about COM, .EDU, .NET, .ORG, and .GOV domains.

## More information

This WHOIS service involves an online database that contains information about networks, networking organizations, domains, sites, and the contacts associated with them. This database is known as the InterNIC database.

The names of the administrative and technical contacts for registered domains are entered into the database when domain or IP number applications are processed by the InterNIC.

The information contained in the InterNIC database can be especially valuable if there is a problem with internetworking between two domains. For example, WHOIS can help determine who to contact if there is a problem with Internet mail that cannot be resolved through e-mail. WHOIS can show the Exchange Server administrator the name and phone number of the administrator at a destination host.

## Access WHOIS

- WHOIS client:

    The WHOIS client program accesses the InterNIC database directly and is included with UNIX systems. There are also clients available for other platforms including Windows and Windows NT.

    If you have shell account access to the Internet that includes the WHOIS client, type `whois domain.com`.

    domain.com is the name of the Internet domain of the host that you are interested in. The InterNIC registers secondary domain names only. For best results DO NOT include Fully Qualified Domain Name (FQDN) on the query. FQDNs include the higher-level domains associated with an Internet site. Only secondary domain names will return contact information.

    Example:

    Wrong: `www.microsoft.com`  
    Correct: `microsoft.com`

- Direct Telnet session

    All systems that have access to the Internet should have the ability to use a standard telnet client to connect to the InterNIC to run the WHOIS client from their system. Networks that restrict access to the Internet through use of a firewall will not be able to use this method if tcp port 23 (standard telnet port) access is blocked.

    Exchange Server administrators may run the Windows NT Telnet client from the computer that is running the IMC. Any telnet client from any host connected to the Internet should work.

    In telnet, connect to `internic.net`. Once connected you may run WHOIS commands as listed in the client instructions above.

- World Wide Web

    The Web Interface to WHOIS is a searchable database through a Web page. To access WHOIS using any World Wide Web (WWW) client, connect to [InterNIC WHOIS](https://www.internic.net/whois.html) Electronic Mail.

    If you cannot access the previous methods, but you have access to Internet mail, you can send your query to `mailserv@internic.net`. Enter your command in the subject line or as the first line of the body of the message. All other text is ignored. You must prefix your command with the word WHOIS just like the client examples above. Requests through electronic mail are processed automatically once per day.

- Other top level domains:

    The InterNIC provides registration information for COM, .EDU, .NET, .ORG, and .GOV domains only. However, the WHOIS client works with other top-level domains. Top-level domains that do not provide compatibility with WHOIS may provide other tools to research domains.

Other registries:

- [.US Domain Registry - Internet Assigned Numbers Authority (IANA)](https://www.iana.org/numbers.htm)
- [.CA Domain - CA*net Canadian IP Address Registry and the Canadian Domain Name Registry.](https://www.cadns.ca/)
- [NIC-Mexico - Mexico Registration Mexico](https://www.nicmexico.mx/)
- [RIPE NCC Europe Registration](https://www.ripe.net/)
- [APNIC (Asia Pacific Network Information Center)](https://www.apnic.net/)

Some information above was provided by Network Solutions, Inc., the sponsor of InterNIC registration services. Additional information is available on the [InterNIC web page](https://www.internic.net) and [RFC 1400 - "Transition and Modernization of the Internet Registration Service"](https://tools.ietf.org/html/rfc1400).

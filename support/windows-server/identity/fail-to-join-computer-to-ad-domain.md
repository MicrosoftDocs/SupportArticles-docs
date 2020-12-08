---
title: 
description: 
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Windows 7 or Windows Server 2008 R2 domain join displays error "Changing the Primary Domain DNS name of this computer to "" failed...."

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 2018583

## Symptoms

Using the domain join User Interface (UI) to join a Windows 7 or Windows Server 2008 R2 workgroup computer to an Active Directory domain by specifying the target DNS domain name fails with the following on-screen error:
 Changing the Primary Domain DNS name of this computer to "" failed. The name will
remain "<DNS domain>.<top level domain>".
The error was:

The specified server cannot perform the required operation.
The NETSETUP.LOG on the computer being joined contains the following text
<date> <time> NetpSetDnsHostNameAndSpn: NetpLdapBind failed: 0x3a
where 0x3a maps to:

| **UI Error**| **Symbolic Error String**| **Hex Error #**| **Decimal Error #** |
|---|---|---|---|
|The specified server cannot perform the operation|ERROR_BAD_NET_RESP|0x3a|58|
|||||

Cases where the "Changing the Primary Domain DNS name.." error appear in conjunction with extended errors other than "the specified server cannot perform the required operation", including those listed in the table below, are NOT related to the symptom, cause or resolution text discussed in this article.
The Extended errors that make the "Changing the Primary DNS name..." error unrelated to this KB include:

| **Extended Error** |
|---|
|A security package specific error occurred|
|The remote procedure call failed and did not execute|
||

## Cause

When a computer is joined to the domain, it attempts to register a Service Principal Name to ensure that its DNS suffix is allowed in the target domain. The domain join UI queries information from the Local Security Authority (LSA) policy database for the short (NetBIOS) and long (DNS) names of the target domain.

The error described in the symptoms section occurs because a function in the domain join UI improperly performs an LDAP bind to a Domain Controller in the target domain by its short name, which fails in the following conditions:


1. The "Disable NetBIOS over TCP/IP" checkbox has been disabled in the IPv4 properties of the computer being joined

OR

2. Connectivity over UDP port 137 is blocked between client and the helper DC servicing the join operation in the target domain

OR

3. The TCP/IPv4 protocol has been disabled so that the client being joined or the DC in the destination domain targeted by the LDAP BIND is running TCP/IPv6 only

## Resolution

Despite the appearance of the on-screen error described in the symptoms section, the domain join operation completes as evidenced by the status in the NETSETUP.LOG
NetpCompleteOfflineDomainJoin SUCCESS: Requested a reboot :0x0
NetpDoDomainJoin: status: 0x0 
To eliminate the error, either:
1. Verify that NetBIOS over TCP/IP is enabled.

a) Click Start , click Run , type ncpa.cpl , and then click OK .
b) In Network Connections , right-click Local Area Connection , and then click Properties .
c) Click Internet Protocol Version 4 (TCP/IPv4), and then click Properties .
d) In the Internet Protocol Version 4 (TCP/IPv4) Properties dialog box, click Advanced .
e) On the WINS tab, verify Enable NetBIOS Over TCP/IP is enabled, and then click OK three times.

OR

2. Verify end-to-end network connectivity over UDP port 137 over the network path connecting the client being and the helper DC serving the join operation.

OR

3. If the error occurred in an IPv6 only environment OR you require a fix to resolve the error, open a support incident with Microsoft Customer Service and Support requesting a post RTM fix for Windows 7 and / or Windows Server 2008 R2.
           OR

4.      Add Domain DNS Suffix in the TCP/IP Properties.  
           a) Click Start , click Run , type ncpa.cpl , and then click OK .
           b) In Network Connections , right-click Local Area Connection , and then click Properties .
           c) Click Internet Protocol Version 4 (TCP/IPv4), and then click Properties .
           d) In the Internet Protocol Version 4 (TCP/IPv4) Properties dialog box, click Advanced .
           e) On the DNS tab, select these DNS Suffixes, click Add, type the FQDN of the domain in the DNS Server Dialogbox, Click Add, and then click OK three 
               times

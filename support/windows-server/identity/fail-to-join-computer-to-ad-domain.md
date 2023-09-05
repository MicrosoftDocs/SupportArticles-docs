---
title: Using domain join UI to join a workgroup computer to an AD domain by specifying the target DNS domain name fails
description: Provides a solution to an error that occurs when you use the domain join User Interface (UI) to join a Windows 7 or Windows Server 2008 R2 workgroup computer to an Active Directory domain by specifying the target DNS domain name.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-join-issues, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Windows 7 or Windows Server 2008 R2 domain join displays error (Changing the Primary Domain DNS name of this computer to "" failed....)

This article provides a solution to an error that occurs when you use the domain join User Interface (UI) to join a Windows 7 or Windows Server 2008 R2 workgroup computer to an Active Directory domain by specifying the target DNS domain name.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2018583

## Symptoms

Using the domain join UI to join a Windows 7 or Windows Server 2008 R2 workgroup computer to an Active Directory domain by specifying the target DNS domain name fails with the following on-screen error:

> Changing the Primary Domain DNS name of this computer to "" failed. The name will remain "\<DNS domain>.\<top level domain>".  
The error was:  
>
> The specified server cannot perform the required operation.

The NETSETUP.LOG on the computer being joined contains the following text:

> \<date> \<time> NetpSetDnsHostNameAndSpn: NetpLdapBind failed: 0x3a

where 0x3a maps to:

|UI Error|Symbolic Error String|Hex Error #|Decimal Error #|
|---|---|---|---|
|The specified server cannot perform the operation|ERROR_BAD_NET_RESP|0x3a|58|
  
Cases where the "Changing the Primary Domain DNS name.." error appears in conjunction with extended errors other than "the specified server cannot perform the required operation", including those listed in the table below, are NOT related to the symptom, cause, or resolution text discussed in this article.

The Extended errors that make the "Changing the Primary DNS name..." error unrelated to this KB include:

|Extended Error|
|---|
|A security package specific error occurred|
|The remote procedure call failed and did not execute|
||

## Cause

When a computer is joined to the domain, it attempts to register a Service Principal Name to ensure that its DNS suffix is allowed in the target domain. The domain join UI queries information from the Local Security Authority (LSA) policy database for the short (NetBIOS) and long (DNS) names of the target domain.

The error described in the [Symptoms](#symptoms) section occurs because a function in the domain join UI improperly performs a LDAP bind to a Domain Controller in the target domain by its short name, which fails in one of the following conditions:

- The **Disable NetBIOS over TCP/IP** checkbox has been disabled in the IPv4 properties of the computer being joined.
- Connectivity over UDP port 137 is blocked between client and the helper DC servicing the join operation in the target domain.
- The TCP/IPv4 protocol has been disabled so that the client being joined or the DC in the destination domain targeted by the LDAP BIND is running TCP/IPv6 only.

## Resolution

Despite the appearance of the on-screen error described in the [Symptoms](#symptoms) section, the domain join operation completes as evidenced by the status in the NETSETUP.LOG.

> NetpCompleteOfflineDomainJoin SUCCESS: Requested a reboot :0x0  
NetpDoDomainJoin: status: 0x0

To eliminate the error, use one of the following methods:

- Verify that NetBIOS over TCP/IP is enabled.

    1. Click **Start**, click **Run**, type _ncpa.cpl_, and then click **OK**.
    2. In **Network Connections**, right-click **Local Area Connection**, and then click **Properties**.
    3. Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.
    4. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, click **Advanced**.
    5. On the **WINS** tab, verify **Enable NetBIOS Over TCP/IP** is enabled, and then click **OK** three times.

- Verify end-to-end network connectivity over UDP port 137 over the network path connecting the client being and the helper DC serving the join operation.

- If the error occurred in an IPv6 only environment or you require a fix to resolve the error, open a support incident with Microsoft Customer Service and Support requesting a post RTM fix for Windows 7/Windows Server 2008 R2.

- Add Domain DNS Suffix in the TCP/IP Properties.

    1. Click **Start**, click **Run**, type _ncpa.cpl_, and then click **OK**.
    2. In **Network Connections**, right-click **Local Area Connection**, and then click **Properties**.
    3. Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.
    4. In the **Internet Protocol Version 4 (TCP/IPv4) Properties** dialog box, click **Advanced**.
    5. On the **DNS** tab, select these DNS Suffixes, click **Add**, type the FQDN of the domain in the **DNS Server** dialog box, **click Add**, and then click **OK three times**.

---
title: Firewall profile doesn't switch to Domain when you use a third-party VPN
description: Fixes an issue in which Windows Firewall profile doesn't switch to Domain when you connect to domain network by using a third-party VPN client.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: winciccore, heigen, kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
---
# Windows Firewall profile doesn't always switch to Domain when you use a third-party VPN client

This article addresses an issue in which Windows Firewall profile doesn't switch from Public or Private to Domain when you connect to domain network by using a third-party VPN client.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4550028

## Symptoms

You use a third-party virtual private network (VPN) client to connect to a domain network. In this scenario, Windows Firewall doesn't always switch from the Public or Private profile to the Domain profile as expected.

## Cause

A time lag in some third-party VPN clients sometimes causes this issue. The lag occurs when the client adds the necessary routes to the domain network.  

## Resolution

To fix this issue, we recommend that you contact the VPN provider for a solution to reduce the time lag caused by adding domain routes.

For VPN providers, you can use callback APIs to add routes as soon as the VPN adapter arrives at Windows. For example:

- **NotifyUnicastIpAddressChange**: Alerts callers of any changes to any IP address, including changes in DAD state.  
- **NotifyIpInterfaceChange**: Registers a callback for notification of changes to all IP interfaces.  

In user mode, there are IpHelper APIs. For example:  

- **NotifyAddrChanget**: Notifies the user about address changes.  

## Workaround  

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, disable negative cache to help the Network Location Awareness (NLA) service when it retries domain detection. To do so, use the following methods.

- First, disable Domain Discovery negative cache by adding the **NegativeCachePeriod** registry key to following subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters`  

    Name: **NegativeCachePeriod**  
    Type: **REG_DWORD**  
    Value Data: **0** (default value: **45** seconds; set to **0** to disable caching)  
- If issue doesn't resolve, further disable DNS negative cache by adding the **MaxNegativeCacheTtl**  registry key to the following subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters`  

    Name: **MaxNegativeCacheTtl**  
    Type: **REG_DWORD**  
    Value Data: **0** (default value: **5** seconds; set to **0** to disable caching)

## More information

When the issue occurs, the flow of events is as follows:

- The user connects to the VPN.
- During VPN tunnel setup, the VPN interface is created and assigned an IP address, and necessary routes are added to the interface. The following conditions apply:
  - TCP/IP immediately adds a host route and on-link subnet routes in one of the following situations:
  
    - The address is of a certain type, such as DHCP, IPv6 link local, and IPv6 temporary.
    - Optimistic Duplicate Address Detection (DAD) is enabled for that address.

    Otherwise, TCP/IP adds those routes after the DAD is successfully completed.
  - The VPN client is responsible for the necessary routes for the VPN networks, such as making the VPN interface routable to the VPN DNS server.
- The first route change triggers Network Connection Status Indicator (NCSI) detection. And the Network Location Awareness (NLA) service tries to authenticate to the domain controller to assign the correct profile to the firewall.
- The authentication starts by having the NLA service call the **DsGetDcName** function to retrieve the DC name. It's done by a DNS name resolution for the name, such as_ldap._tcp.CNNDC._sites.dc._msdcs.\<domainname>.
- If this name resolution occurs before the necessary VPN routes to the VPN DNS server are added to the VPN interface, this DNS name resolution fails. And it returns "DsGetDcName function Failed with ERROR_NO_SUCH_DOMAIN." Then, this result is cached.
- The DNS name resolution failure might also create a negative DNS cache. The negative cache causes additional failure when the NLA service retries the domain detection.

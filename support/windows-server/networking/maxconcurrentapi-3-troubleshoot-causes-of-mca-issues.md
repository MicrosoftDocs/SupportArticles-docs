---
title: Troubleshoot the underlying causes of an MCA issue
description: Discusses how to determine the cause of an MCA issue.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
keywords: MaxConcurrentApi, MCA, authentication slowdown, authentication performance
---

# Remediating MCA issues, part 3: Troubleshoot the underlying causes of an MCA issue

This article discusses how to determine the cause of an MCA issue.

_Applies to:_ &nbsp; Windows Server 2012 and newer versions, Windows 8 and newer versions

## Summary

When a user opens an application, the application typically authenticates the user in less than one second. Slow authentication performance indicates that underlying issues exist in your infrastructure. [Part 2 of this series ("Calculate and change the MCA value")](maxconcurrentapi-2-calculate-and-change-mca.md) provides a process to increase the capacity for managing simultaneous authentication requests. This approach might relieve the symptoms, but only temporarily. The underlying issues remain.

Tuned `MaxConcurrentApi` values can improve your environment's authentication performance. However, using nondefault values might exacerbate other issues. Additionally, if your topology or load changes, you might have to recalculate the `MaxConcurrentApi` values. Generally, the best approach is to use the tuned values until you can identify and fix the underlying issues. 

This article provides guidance about where to look for those issues. There are various factors that can cause authentication time-out issues to occur.

## Continue to monitor performance

[Calculate and change the MCA value](maxconcurrentapi-2-calculate-and-change-mca.md) discusses the minimum performance parameters that you should monitor. The resulting data can help you troubleshoot your environment and track the effects of any changes that you make.

## Reduce the overall demand for the Netlogon service

The most direct way to reduce the need for `MaxConcurrentApi` adjustments is to reduce the load on the Netlogon service on the application servers and domain controllers.

### Update legacy applications

Kerberos authentication puts significantly less load on the Netlogon service than do older methods, such as NTLM authentication. If you have applications that rely on older authentication methods, consider replacing them with applications that can use Kerberos.

> [!NOTE]  
> If you have a heavily used line-of-business application that can't use Kerberos authentication, you might have to use `MaxConcurrentApi` to relieve performance issues until a replacement is available.

### Check for unauthorized or unknown clients or services

Review the Netlogon logs for unauthorized or unknown clients or services that continually and repeatedly send authentication requests. By identifying and, if appropriate, blocking or reconfiguring such clients or services, you can reduce the load on the Netlogon service.

### Make sure that cross-forest authentication requests include the user domain name

If your topology includes multiple forest trusts, check the Netlogon logs of the domain controllers that receive authentication requests directly from application servers. Look for log entries in which authentication requests contain `<null>\<username>` instead of `<domainname>\<username>`. Wherever possible, make sure that applications use the `<domainname>\<username>` format. If this approach isn't feasible, see [The Lsass.exe process might stop responding if you have many external trusts on an Active Directory domain controller](https://support.microsoft.com/topic/the-lsass-exe-process-may-stop-responding-if-you-have-many-external-trusts-on-an-active-directory-domain-controller-7ccefcf9-e65a-c9bc-ff96-ecf9a78c195e) for additional information.

## Check server health

Make sure that the application servers and domain controllers are healthy and have plenty of available resources (RAM, CPU, winsock ports, and so on.)

## Check the network

### Check the network for traffic blockages

Check for issues that might block network traffic, such as incorrect firewall settings or incorrect router permissions.

### Check for network latency

Network latency can play a major part in causing MCA issues. If network latency is set too high, authentication requests can time out before they reach their destination.

Common techniques to reduce latency include the following:

- Wherever feasible, group application servers and domain controllers that hold user accounts in the same physical location.
- If possible, eliminate slow WAN connections.
- Adjust your topology so that authentication paths are as short as possible.
- Make sure that all routers have sufficient bandwidth.

## Review the Active Directory Domain Services and DNS topology

Your Active Directory Domain Services (AD DS) and DNS topology control how traffic passes from server to server in your environment. You analyzed your current flow when you looked for servers that had MCA issues (discussed in [Part 1](maxconcurrentapi-1-identify-computers-that-have-mca-issues.md) of this series). Now, you can use this information to redistribute the authentication load, or route requests more efficiently. For example, you find that an application server sends authentication requests to a domain controller over a slow WAN link, while another domain controller that has a faster connection is available. In this situation, you can configure an Active Directory site to direct the requests over the faster connection.

Factors to consider:

- Can you use sites to group application servers and domain controllers? Are the servers assigned to the correct sites?
- Are your sites configured correctly? Are sites and subnets paired correctly?
- If authentication requests have to pass from one forest to another forest over a trust, have you configured sites that have the same name in each forest?
- If authentication requests have to travel from one child domain to another child domain in the same forest, can you use a shortcut trust to reduce the authentication path and directly connect the domains?

For more information about how domain controllers communicate and how to implement sites, see the following articles:

- [Understanding Active Directory Site Topology](/windows-server/identity/ad-ds/plan/understanding-active-directory-site-topology)
- [Domain Locator Across a Forest Trust](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/domain-locator-across-a-forest-trust/ba-p/395689)
- [Domain Controller Location](/windows-server/identity/ad-ds/plan/domain-controller-location)
- [How to optimize the location of a domain controller or global catalog that resides outside of a client's site](../active-directory/optimize-dc-location-global-catalog.md)

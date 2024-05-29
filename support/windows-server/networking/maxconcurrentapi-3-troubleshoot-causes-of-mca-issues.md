---
title: Troubleshoot the underlying causes of an MCA issue
description: Describes how to determine the cause of your MCA issue.
ms.date: 05/29/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
keywords: 
---

# Remediating MCA issues, part 3: Troubleshoot the underlying causes of an MCA issue

This article describes how to determine the cause of your MCA issue.

_Applies to:_ &nbsp; Windows Server 2012 and newer versions, Windows 8 and newer versions

## Summary

When a user opens an application, the application typically can authenticate the user in less than a second. Slow authentication performance indicates that there are underlying issues in your infrastructure. [Remediating MCA issues, part 2: Calculate and change the MCA value](maxconcurrentapi-2-calculate-and-change-mca.md) provides a way to increase the capacity for managing simultaneous authentication requests. This approach may alleviate the symptoms, but it's just a band-aid. The underlying problems are still there.

Tuned `MaxConcurrentApi` values can improve your environment's authentication performance. However, using non-default values might exacerbate other issues. Additionally, if your topology or load changes, you might have to recalculate the `MaxConcurrentApi` values. Generally, the best approach is to use the tuned values until you can identify and fix the underlying problems. 

This article provides guidance about where to look for those problems. There are a variety of factors that can cause authentication timeout issues.

## Continue monitoring performance

[Remediating MCA issues, part 2: Calculate and change the MCA value](maxconcurrentapi-2-calculate-and-change-mca.md) describes the minimum performance parameters that you should be monitoring. The resulting data can help you troubleshoot your environment and track the impact of any changes you make.

## Reduce the overall demand for the Netlogon service

The most direct way to reduce the need for `MaxConcurrentApi` adjustments is to reduce the load on the Netlogon service on the application servers and domain controllers.

### Update legacy applications

Kerberos authentication places significantly less load on the Netlogon service than older methods such as NTLM authentication. If you have applications that rely on older authentication methods, consider replacing them with applications that can use Kerberos.

> [!NOTE]  
> If you have a heavily used line-of-business application that can't use Kerberos authentication, you might have to use `MaxConcurrentApi` to alleviate performance issues until a replacement is available.

### Check for unauthorized or unknown clients or services

Review the Netlogon logs for unauthorized or unknown clients or services that continually and repeatedly send authentication requests. Identifying and, if appropriate, blocking or reconfiguring such clients or services can reduce the load on the Netlogon service.

### Make sure that cross-forest authentication requests include the user domain name

If your topology includes multiple forest trusts, check the Netlogon logs of the domain controllers that receive authentication requests directly from application servers. Look for log entries that authentication requests contain `<null>\<username>` instead of `<domainname>\<username>`. Wherever possible, make sure that applications use the `<domainname>\<username>` format. If this approach isn't feasible, see [The Lsass.exe process may stop responding if you have many external trusts on an Active Directory domain controller](https://support.microsoft.com/topic/the-lsass-exe-process-may-stop-responding-if-you-have-many-external-trusts-on-an-active-directory-domain-controller-7ccefcf9-e65a-c9bc-ff96-ecf9a78c195e) for additional information.

## Check server health

Make sure that the application servers and domain controllers are healthy and have plenty of available resources (RAM, CPU, winsock ports, and so forth.)

## Check the network

### Check the network for traffic blockages

Check for issues that might block network traffic, such as incorrect firewall settings or incorrect router permissions.

### Check for network latency

Network latency can play a major part in causing MCA issues. If network latency is too high, authentication requests can time out before they reach their destination.

Common techniques to use to reduce latency include the following:

- Put servers&mdash;for example, application servers and the domain controllers that hold user accounts&mdash;in the same physical location.
- If possible, eliminate slow WAN connections.
- Adjust your topology so that authentication paths are as short as possible.
- Make sure that all routers have sufficient bandwidth.

## Review the Active Directory Domain Service (AD DS) and DNS topology

Your AD DS and DNS topology controls how traffic passes from server to server in your environment. You analyzed your current flow when you looked for servers that had MCA issues (described in [Part 1](maxconcurrentapi-1-identify-computers-that-have-mca-issues.md) of this series). Now you can use this information to redistribute the authentication load, or route requests more efficiently. For example, if you found that an application server sent authentication requests to a domain controller over a slow WAN link when another domain controller that has a faster connection was available, you can configure an Active Directory site to direct the requests over the faster connection.

Factors to consider include the following:

- Can you use sites to group application servers and domain controllers? Have the servers been assigned to the correct sites?
- Are your sites configured correctly? Are sites and subnets paired correctly?
- If authentication requests have to pass from one forest to another forest over a trust, have you configured sites that have the same name in each forest?
- If authentication requests have to travel from one child domain to another child domain in the same forest, can you use a shortcut trust to reduce the authentication path and sdirectly connect the domains?

For more information about how domain controllers communicate and how to implement sites, see the following articles:

- [Understanding Active Directory Site Topology](/windows-server/identity/ad-ds/plan/understanding-active-directory-site-topology)
- [Domain Locator Across a Forest Trust](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/domain-locator-across-a-forest-trust/ba-p/395689)
- [Domain Controller Location](/windows-server/identity/ad-ds/plan/domain-controller-location)
- [How to optimize the location of a domain controller or global catalog that resides outside of a client's site](./windows-server/active-directory/optimize-dc-location-global-catalog.md)

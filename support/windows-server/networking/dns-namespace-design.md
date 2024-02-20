---
title: DNS namespace planning
description: Describes the design of the DNS namespace in an Active Directory environment.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# DNS namespace planning

This article describes the design of the DNS namespace in an Active Directory environment.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 254680

## Summary

The resolution of names through the use of Domain Name System (DNS) is central to Windows operation. Without proper name resolution, users can't locate resources on the network. It's critical that the design of the DNS namespace is created with Active Directory in mind and that the namespace that exists on the Internet not conflict with an organization's internal namespace.

## More information

The recommended approach to DNS design in an Active Directory environment is to design the Active Directory environment first and then support that design with the DNS structure. However, in some cases, the DNS namespace may already be in place. In such a configuration, the Active Directory environment should be designed independently and then implemented either as a separate namespace or as a subdomain of the existing namespace. If the namespace you choose already exists on the Internet, it may cause name resolution problems for internal clients.

Consider the following items:

- Identify the DNS namespace that you'll be using for your domain. Identify the name that your organization has registered for use on the Internet (for example, **company**.com). If your company doesn't have a registered name, but you'll be connected to the Internet, you may want to register a name on the Internet. Make sure if you choose not to register a name that you choose a name that is unique. You can review existing names at [network solutions](http://www.networksolutions.com).
- Use different internal and external namespaces. Internally, you could use **comp**.com or a subdomain of the external name such as
 **corp**. **company**.com. The subdomain structure could be useful if you already have an existing DNS namespace. Different locations or organizations can be named with different subdomains such as
 **nameone**. **corp**. **company**.com or
 **nametwo**. **corp**. **company**.com to ease administration.
- Make Active Directory child domains immediately subordinate to their parent domains in the DNS namespace. You can choose to create subdomains for organizations within your company or locations. For example,
 **leveltwo**. **levelone**. **corp**. **company**.com
- Separate internal and external names on separate servers. External servers should include only those names that you want to be visible to the Internet. Internal servers should contain names that are for internal use. You can set your internal DNS servers to forward requests that they can't resolve to external servers for resolution. Different types of clients require different kinds of name resolution. Web proxy clients, for example, don't require external name resolution because the proxy server does this on their behalf. Overlapping internal and external namespaces aren't recommended. In most cases, the end result of this configuration is that computers will be unable to locate needed resources because of receiving incorrect IP addresses from DNS. This is particularly a concern when Network Address Translation (NAT) is involved and the external IP address is in an unreachable range for internal clients.
- Make sure that root servers aren't created unintentionally. Root servers may be created by the Dcpromo Wizard, resulting in internal clients being able to reach external clients or to reach parent domains. If the "." zone exists, a root server has been created. It may be necessary to remove this for proper name resolution to work.

